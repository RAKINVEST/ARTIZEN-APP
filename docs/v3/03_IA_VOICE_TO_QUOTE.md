# V3 — Architecture de l'Assistant IA « devis vocal » (Phase 6)

**Priorité absolue de la V3.** Ce document définit l'architecture *avant* tout
code. Objectif : **un artisan crée un devis quasiment sans clavier**.

## 1. Scénario cible

```
Le client appelle → l'artisan parle → l'IA comprend → reconnaît les
prestations → associe les articles du catalogue → construit le devis →
propose des variantes → calcule les quantités → prépare un email → devis prêt.
```

## 2. Principe directeur — les invariants V2 restent absolus

L'IA **ne choisit aucun prix, aucune TVA, ne persiste rien, ne crée jamais un
devis**. Elle *sélectionne* des articles du catalogue existant et *propose*
des quantités (seule valeur numérique inférée), relues par l'artisan. La
création reste le geste explicite `POST /quotes`, seul endroit où un total est
calculé (`QuoteCalculator`). L'IA V3 étend `quote_assistant` — elle ne le
contourne pas.

## 3. Pipeline (asynchrone)

Le traitement est **découpé et asynchrone** (fondation F1 — file de tâches),
car STT + LLM sont lents et coûteux : ils ne doivent jamais bloquer une
requête HTTP. Chaque étape est un état observable.

```
[1] Capture audio (mobile/web)
      │  upload chunké → storage (S3)
      ▼
[2] STT — Speech-to-Text            (AIProvider.transcribe)
      │  audio → transcription + segments horodatés
      ▼
[3] NLU — extraction structurée      (AIProvider.extract, LLM + prompt strict)
      │  transcription → [ {prestation, quantité?, unité?, pièce?, contexte} ]
      ▼
[4] Matching catalogue               (quote_assistant.match_validator, RÉUTILISÉ)
      │  chaque prestation → article(s) réel(s) du catalogue (existe/actif/tenant)
      ▼
[5] Construction du brouillon        (SuggestionScorer + quantités bornées)
      │  articles retenus + quantités + score de confiance
      ▼
[6] Variantes                        (LLM : éco / standard / premium, ou options)
      ▼
[7] Brouillon d'email                (LLM : message client à partir du devis)
      ▼
[8] Revue artisan (UI) → POST /quotes explicite
```

## 4. Étapes détaillées

### [2] STT
- **Abstraction** `SttProvider` (comme `AIProvider`/`StorageProvider`) :
  implémentations Whisper (OpenAI), Deepgram, ou local. Mock déterministe
  hors ligne (l'app doit démarrer sans clé).
- **Langue** : français, vocabulaire métier bâtiment (biais de prompt / liste
  de termes : « chauffe-eau », « VMC », « placo », « saignée »…).
- **Robustesse chantier** : bruit, accents → renvoyer un score de confiance
  STT ; en deçà d'un seuil, demander une confirmation.

### [3] NLU (extraction)
- **LLM** avec **sortie structurée contrainte** (JSON schema strict, comme la
  V2 force le provider à un schéma). Sortie : liste d'intentions de prestation
  `{ description, quantity?, unit?, room?, raw_span }`.
- **Ancré au catalogue** : le prompt inclut le catalogue de l'entreprise
  (désignations, unités) pour que l'extraction parle le langage des articles —
  exactement le contexte que `quote_assistant` construit déjà (avec troncature
  au-delà de 1000 articles → à paginer/vectoriser en V3).
- **Anti-hallucination** : rien n'est cru sur parole (étape [4]).

### [4] Matching catalogue — RÉUTILISATION V2
- `quote_assistant/match_validator.py` re-valide chaque proposition contre le
  vrai catalogue (existe / bonne entreprise / actif / non-doublon). **Aucune
  nouvelle logique de confiance** : on branche l'extraction NLU sur le
  validateur existant.
- **Amélioration V3** : recherche **sémantique** (embeddings) pour associer
  « je change le ballon d'eau chaude » → « Chauffe-eau 200L » même sans
  correspondance lexicale. Nouvelle abstraction `EmbeddingProvider` + index
  vectoriel (pgvector sur PostgreSQL — pas de nouvelle infra).

### [5] Quantités & score
- Quantités **inférées puis bornées** par le schéma (comme V2) ; toute quantité
  absente → défaut 1, signalé à l'artisan.
- `SuggestionScorer` (V2) étendu pour intégrer la confiance STT + NLU +
  matching. Corriger au passage la **double pénalité des doublons** (dette V2).

### [6] Variantes
- LLM propose 2-3 variantes (ex. gammes de matériel) **uniquement à partir
  d'articles du catalogue** — jamais de prix inventé. L'artisan choisit.

### [7] Email
- LLM rédige un message client (ton professionnel) référençant le numéro et le
  total **déjà calculés par le backend** — l'IA n'écrit aucun montant qu'elle
  aurait calculé.

## 5. Modèle de données

**`ai_jobs`** — un traitement vocal :
`id, company_id, user_id, type (voice_quote), status (queued/transcribing/
extracting/matching/ready/failed), audio_key, transcript, extracted (JSON),
result (JSON: articles+quantités+variantes+email), confidence, error,
created_at, updated_at, timings (JSON)`.

Aucune table `quote` créée par l'IA. Le `result` alimente le brouillon
Flutter (`quoteDraftLinesProvider`), puis `POST /quotes`.

**pgvector** (optionnel V3) : colonne embedding sur `catalog_items` pour le
matching sémantique.

## 6. API

| Endpoint | Rôle |
|---|---|
| `POST /ai/voice-quote` | upload audio → crée un `ai_job` (202 + job_id) |
| `GET /ai/jobs/{id}` | statut + résultat (polling ou SSE/WebSocket) |
| `POST /ai/voice-quote/{id}/refine` | régénère variantes / ajuste |
| `POST /ai/voice-quote/{id}/email` | (re)génère le brouillon d'email |

Toutes sous `/api`, JWT, `company_id` du token. Le job est scopé au tenant
(404 sinon).

## 7. UI (Flutter)

- Écran **« Parler »** : gros bouton micro, enregistrement, transcription en
  direct (WebSocket/SSE), barre de progression par étape.
- **Revue** : liste d'articles proposés (éditable : quantité, +/- article,
  variante), score de confiance visible, aperçu du devis, brouillon d'email.
- **Validation** : « Créer le devis » (geste explicite). Design System V3
  (composants, palette). Fonctionne dégradé si l'IA échoue (saisie manuelle).

## 8. Abstractions & fournisseurs (pattern V2 conservé)

`SttProvider`, `LlmProvider` (extraction/variantes/email), `EmbeddingProvider`
— tous derrière `ai/factory.py`, avec **fallback mock déterministe** si la clé
est absente : l'app démarre et le module répond, sans configuration. Une vraie
clé + redémarrage suffit à passer en réel — aucun code appelant ne change.

## 9. Coûts, latence, résilience

- **Coût** : STT + LLM facturés à l'usage → suivi par `ai_jobs.timings` +
  budget par entreprise ; cache des extractions identiques.
- **Latence** : pipeline async + feedback temps réel ; cible < 10 s pour un
  devis courant.
- **Résilience** : chaque étape peut échouer sans perdre les précédentes
  (`ai_jobs` persiste l'état) ; retries ; dégradation vers saisie manuelle.
- **Confidentialité / RGPD** : audio et transcription = données personnelles →
  rétention limitée, chiffrement au repos, suppression après traitement selon
  préférence.

## 10. Tests

- **Déterministes** : providers mock (STT/LLM/embedding) → transcriptions et
  extractions figées ; on teste le matching, le bornage des quantités, le
  score, et surtout **que rien n'est persisté et qu'aucun montant n'est
  inventé**.
- **Casse** : réponse LLM malformée → dégradation propre (pas de 502
  tout-ou-rien — corriger la dette V2) ; article halluciné → écarté par
  `match_validator` ; audio illisible → message clair.
- **Non-régression invariants** : le devis reste un `POST /quotes` explicite.

## 11. Prérequis (ordre)

1. **F1 file de tâches + F2 Redis** (sans quoi le pipeline bloque les requêtes).
2. Extension `AIProvider` (STT/LLM/embedding) + mocks.
3. `ai_jobs` + migration.
4. Branchement sur `match_validator`/`SuggestionScorer` existants.
5. UI « Parler » + revue.
6. Matching sémantique (pgvector) — itération suivante.

**Rien n'est codé tant que cette architecture n'est pas validée.**
