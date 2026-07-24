# Étude — sécurisation juridique de la reproduction documentaire

> **Chantier B.** Comment empêcher qu'ARTIZEN serve à reproduire l'identité
> documentaire d'un **tiers** sans autorisation, *sans* dégrader l'expérience des
> usages **légitimes** ? Étude argumentée → comparaison → recommandation. **Aucun
> code, aucun écran, aucun workflow** : on comprend d'abord le problème. Ce
> document pourra être transformé en [ADR](DECISIONS.md) s'il est retenu.
>
> **Règle fondamentale (rappel).** ARTIZEN n'a pas pour vocation de reproduire
> l'identité documentaire d'un tiers ; il existe pour qu'un artisan retrouve **la
> sienne**. Toute protection doit **renforcer** cette promesse, pas la contredire.

> ⚠️ **Ce n'est pas un avis juridique.** C'est une analyse de risques et
> d'options, à faire **valider par un avocat** (propriété intellectuelle /
> concurrence, droit français) avant toute décision engageante. Les qualifications
> ci-dessous sont *plausibles*, pas *tranchées* — c'est précisément pourquoi une
> validation professionnelle est requise (cf. §7).

---

## 1. Les risques juridiques

Contexte : France, artisans du bâtiment. On documente les risques, on ne les
suppose pas résolus. Un même acte abusif peut relever de plusieurs fondements.

| # | Risque | Fondement (droit français) | Quand il se matérialise |
|---|---|---|---|
| R1 | **Droit d'auteur sur la mise en page** | Code de la propriété intellectuelle (CPI), art. L111-1 s. — protège une œuvre **originale** (empreinte de la personnalité de l'auteur) | Une maquette de devis *suffisamment originale* (composition, choix graphiques marqués) reproduite à l'identique. Un tableau de prix standard n'est **pas** original ; une charte élaborée peut l'être. Incertitude forte → §7. |
| R2 | **Reproduction de marque / logo** | CPI art. L713-2 s. (marques), et droit d'auteur sur le logo | Le logo d'un tiers est **une image protégée** ; le reproduire dans un devis émis sous une autre identité = contrefaçon probable + risque de **confusion**. Risque le plus net des six. |
| R3 | **Concurrence déloyale** | Responsabilité civile, art. 1240 Code civil (faute) | Reproduire l'apparence d'un concurrent pour **créer la confusion** chez les clients (se faire passer pour lui, ou capter sa clientèle). |
| R4 | **Parasitisme économique** | Jurisprudence (art. 1240 C. civ.) | Se placer dans le **sillage** d'autrui pour profiter *sans bourse délier* de ses investissements (identité visuelle, réputation), **même sans confusion ni concurrence directe**. Fondement large, souvent retenu. |
| R5 | **Usurpation d'identité (documentaire)** | Art. 226-4-1 Code pénal ; faux (441-1) selon les cas | Émettre des documents sous l'identité (nom, SIRET, coordonnées) d'un tiers → usurpation, voire faux. Le plus grave, mais suppose une intention d'usurper. |
| R6 | **Atteinte à la charte / éléments distinctifs** | Cumul R1/R3/R4 | Couleurs, typographies signature, agencements distinctifs repris à l'identique. Rarement protégeable isolément, mais nourrit R3/R4. |

**Lecture d'ensemble.** Le risque le plus **certain** est R2 (logo/marque). Les
plus **larges** sont R3/R4 (déloyauté/parasitisme) : ils n'exigent ni dépôt ni
originalité, seulement une **faute** et un **préjudice**. R1 est réel mais
**incertain** (l'originalité d'un devis se discute). Point commun : **tous
supposent la reproduction de l'identité d'un *tiers*** — donc **tous s'effondrent
si ARTIZEN garantit qu'on reproduit la *propre* identité de l'artisan.** C'est
l'axe directeur de la protection.

**Exposition d'ARTIZEN.** Éditeur d'un outil *à double usage* : responsabilité
plutôt de l'**utilisateur** (c'est lui qui importe et émet), mais ARTIZEN peut
être recherché en **complicité / facilitation** s'il ferme les yeux sur un usage
manifestement abusif, ou s'il *promeut* la copie. D'où l'intérêt de mesures de
**diligence raisonnable** (démontrer qu'on décourage l'abus).

---

## 2. Les usages légitimes (à ne jamais casser)

La contrainte n°1 : ces cas sont **la majorité** et doivent rester **fluides**.

| # | Cas légitime | Signal attendu |
|---|---|---|
| L1 | **Changement de logiciel** (EBP → ARTIZEN) — l'artisan importe *son* ancien devis | SIRET/nom extraits = ceux du compte |
| L2 | **Artisan réutilisant un ancien devis de sa propre entreprise** | Idem L1 |
| L3 | **Rachat d'entreprise / fonds de commerce** | SIRET *différent* mais **légitime** (mutation) — le nouvel exploitant a acquis l'identité |
| L4 | **Changement de forme sociale / de SIRET** (EI → SARL) | SIRET différent, **même dirigeant/enseigne** |
| L5 | **Franchise / réseau** — modèle commun autorisé par le franchiseur | Modèle *partagé* légitimement entre comptes |
| L6 | **Groupe de sociétés** — plusieurs SIRET, une identité groupe | SIRET différents, lien capitalistique |
| L7 | **Cabinet comptable / mandataire** important pour le compte d'un client | Opérateur ≠ titulaire, mais **mandaté** |

**Conséquence de conception.** L3–L7 montrent qu'un simple **égalité stricte de
SIRET ne peut pas être bloquante** : le SIRET peut légitimement différer. Le
mismatch doit **déclencher une vérification douce**, jamais un blocage sec. Le
faux positif ici a un coût élevé (on insulte un client honnête).

---

## 3. Comparaison des protections

Chaque option jugée sur : **efficacité** · **coût technique** · **UX** · **faux
positifs (FP)** · **faux négatifs (FN)** · **impact juridique**.

### A. Déclaration sur l'honneur
- **Principe.** À l'import, l'artisan **certifie** que le document appartient à son
  entreprise ou qu'il a le droit de l'utiliser ; la déclaration est **horodatée et
  journalisée**.
- **Efficacité.** Faible en *prévention* technique ; **forte en couverture
  juridique** (transfère la responsabilité, prouve la diligence d'ARTIZEN).
- **Coût technique.** Très faible. **UX.** Légère friction (une case). **FP.** 0.
  **FN.** Élevés (un fraudeur coche quand même). **Juridique.** Excellente (preuve
  d'engagement de l'utilisateur ; élément de défense d'ARTIZEN).

### B. Comparaison SIRET / raison sociale
- **Principe.** Comparer le SIRET/nom **extraits** du devis (déjà produits par
  `document_detection`) à ceux du **compte**. Concordance → usage présumé
  légitime ; discordance → vérification.
- **Efficacité.** Bonne sur le cas courant (L1/L2 passent en silence ; un devis
  d'un tiers non trafiqué est repéré). **Coût.** Très faible (donnée déjà là).
  **UX.** Nulle si concordance. **FP.** Réels (L3–L7 : SIRET légitimement
  différent ; extraction ratée → faux mismatch). **FN.** Un fraudeur qui **efface
  le SIRET/logo** avant import passe. **Juridique.** Renforce directement la
  promesse (« on vérifie que c'est *le vôtre* »).

### C. Détection d'un modèle déjà importé (même compte)
- **Principe.** Repérer qu'un modèle **identique** a déjà été importé (ré-import,
  doublon interne).
- **Efficacité.** Marginale sur l'abus tiers (c'est un confort anti-doublon).
  **Coût.** Faible. **UX.** Neutre/positive. **FP/FN.** Faibles. **Juridique.**
  Nul en soi ; brique utilitaire.

### D. Workflow de validation
- **Principe.** Escalade graduée : silence → avertissement → confirmation →
  blocage/revue, selon la force du signal (§5).
- **Efficacité.** C'est le **liant** qui rend A/B/E proportionnés. **Coût.**
  Moyen. **UX.** Excellente **si** bien calibré (rien pour le légitime).
  **FP/FN.** Hérités des signaux sous-jacents. **Juridique.** Très bonne (montre
  une politique de diligence graduée).

### E. Empreinte documentaire (fingerprint) inter-comptes
- **Principe.** Une **empreinte** du modèle (non réversible) permet de détecter
  qu'un modèle **très proche** est déjà utilisé par **un autre compte**, **sans
  divulguer** les données de ce compte.
- **Efficacité.** La seule option qui attrape l'abus **même sans SIRET** (fraudeur
  qui a nettoyé le devis mais garde la maquette). **Coût.** Élevé (empreinte
  robuste, stockage, appariement, réglage des seuils). **UX.** Nulle si pas de
  match ; sensible en cas de match. **FP.** **Le vrai danger** : deux artisans qui
  utilisent le **même modèle de logiciel** (EBP par défaut, gabarit de franchise)
  ont des empreintes proches **sans copie** (cf. L5). L'empreinte doit donc peser
  les éléments **identitaires** (logo, raison sociale, personnalisations uniques),
  **pas** la structure générique du logiciel. **FN.** Un modèle assez retravaillé
  échappe. **Juridique.** Puissant **mais** délicat RGPD (§6) : comparer des
  documents entre comptes.

### F. Autres approches pertinentes
- **F1 — Filigrane / traçabilité de sortie.** Métadonnées (non visibles) dans le
  PDF généré liant le document au compte émetteur : *n'empêche pas* l'abus mais
  le **trace** a posteriori. Coût faible, valeur probatoire.
- **F2 — Vérification SIRET officielle** (base **INSEE/Sirene**, API publique
  Recherche d'entreprises) : confirmer que le SIRET du compte est actif et
  correspond à la raison sociale — fiabilise B, ne résout pas le cas tiers.
- **F3 — Détection d'incohérence interne** : le devis importé porte une identité
  (SIRET/nom/logo) qui **contredit** celle que le compte a déjà validée → signal
  fort d'un document d'autrui.
- **F4 — Signalement & réactivité** (notice-and-take-down) : canal de plainte +
  procédure de retrait/suspension. Diligence *a posteriori*, peu coûteuse, attendue
  d'un hébergeur/éditeur responsable.

### Synthèse

| Option | Efficacité abus | Coût | Friction légitime | FP | FN | Poids juridique |
|---|---|---|---|---|---|---|
| A Déclaration | faible (préventif) | très faible | très faible | nul | élevé | **fort (défense)** |
| B SIRET/nom | **bonne** | très faible | nulle | moyen | moyen | fort (promesse) |
| C Doublon interne | nulle (tiers) | faible | nulle | faible | — | nul |
| D Workflow gradué | liant | moyen | **nulle si calibré** | hérité | hérité | fort |
| E Fingerprint inter-comptes | **la meilleure** | élevé | faible→forte | **élevé** | moyen | fort mais RGPD |
| F1 Filigrane | traçage | faible | nulle | nul | — | moyen (preuve) |
| F2 INSEE/Sirene | fiabilise B | faible | nulle | faible | — | moyen |
| F3 Incohérence | bonne | faible | faible | moyen | moyen | fort |
| F4 Take-down | a posteriori | faible | nulle | — | — | **fort (éditeur)** |

---

## 4. Architecture de protection recommandée

**Défense en profondeur, proportionnée, alignée sur la promesse.** Aucune couche
n'est parfaite seule ; leur **combinaison** décourage l'abus sans gêner le
légitime. Ordre du moins au plus intrusif :

1. **Socle — la promesse rendue concrète (B + F2 + F3).** À l'import, on
   *confirme* que l'identité extraite (SIRET, raison sociale, logo) est **celle de
   l'artisan**. Concordance → **silence total** (le cas courant, L1/L2). C'est le
   cœur : la vérification n'est pas une barrière anti-fraude, c'est *« on s'assure
   de restituer **votre** identité »* — la promesse, faite geste.
2. **Engagement — déclaration sur l'honneur (A).** Déclenchée **uniquement** en cas
   de discordance ou d'identité absente. Horodatée, journalisée. Coût quasi nul,
   couverture juridique forte, laisse passer L3–L7 (l'artisan certifie sa
   légitimité).
3. **Garde-fou fort — fingerprint inter-comptes (E), calibré identité.** Uniquement
   si le modèle importé **coïncide fortement** avec une **empreinte identitaire**
   (logo + raison sociale + personnalisations, **pas** le gabarit générique du
   logiciel) déjà rattachée à **un autre compte actif**. Signale sans divulguer.
4. **Traçabilité (F1) + réactivité (F4).** Filigrane de traçage dans les PDF émis +
   canal de signalement et procédure de retrait. La diligence *a posteriori*
   attendue d'un éditeur responsable.

**Ce qu'on n'implémente PAS d'emblée :** E est **coûteux et sensible** (FP
franchise/logiciel, RGPD). Recommandation : **livrer B+A+F2/F3 d'abord** (fort
rapport valeur/risque), et **n'ajouter E qu'ensuite**, une fois le corpus assez
large pour **régler ses seuils sur des mesures** (même discipline que le moteur :
pas de seuil au doigt mouillé).

---

## 5. Politique produit — avertir / confirmer / bloquer / responsabiliser

Escalade **graduée par la force du signal**. Principe : *un faux positif ne doit
jamais coûter plus qu'un vrai négatif rare* — donc on **avertit** bien avant de
**bloquer**.

| Signal | Action | Registre (langue artisan — cf. BRAND.md) |
|---|---|---|
| Identité extraite **= compte** | **Rien.** On continue en silence. | — |
| Identité **absente** (devis sans SIRET/nom lisibles) | **Confirmation douce** + déclaration. | « Ce devis est bien celui de votre entreprise ? » |
| Identité **≠ compte** (SIRET/nom discordants) | **Avertissement** + déclaration obligatoire, journalisée. | « L'identité de ce devis ne semble pas la vôtre. Confirmez-vous qu'il appartient à votre entreprise ? » |
| **Signal fort** : SIRET extrait = **autre compte ARTIZEN actif**, ou fingerprint identitaire = autre compte | **Blocage doux**, mise en revue. Ne **jamais** révéler l'autre compte. | « Nous ne pouvons pas restituer cette identité automatiquement. Contactez-nous. » |
| Après déclaration signée | **Laisser la responsabilité à l'utilisateur** (il a certifié) + tracer. | — |

**Jamais** de vocabulaire d'ingénierie ou de suspicion policière à l'écran
(« fraude », « fingerprint », « anti-copie ») : la protection se **vit** comme un
soin apporté à *son* identité, pas comme un contrôle. **Deux langues** (BRAND.md).

---

## 6. RGPD & confidentialité

Le fingerprint inter-comptes (E) est le point sensible : il **compare des
documents entre comptes**. Exigences :

- **Base légale.** *Intérêt légitime* (prévention des abus / protection des
  artisans et de la marque), avec **test de mise en balance** documenté. La
  déclaration (A) relève de l'**exécution du contrat** / obligation de l'utilisateur.
- **Minimisation.** Ne stocker que l'**empreinte non réversible** (hash / vecteur),
  **jamais** le document d'un tiers en clair pour comparaison. L'empreinte ne doit
  pas permettre de **reconstituer** le document source.
- **Finalité limitée.** L'empreinte sert **uniquement** à la détection d'abus, pas
  au profilage ni à une autre exploitation.
- **Conséquence d'un doublon.** En cas de match, **ne jamais divulguer** l'identité
  de l'autre compte (confidentialité de l'autre artisan) : on signale
  *l'existence* d'un conflit, pas *qui*. Traitement humain, contradictoire,
  réversible.
- **Conservation.** Empreinte conservée tant que le **modèle est actif** ; purgée à
  la **suppression du compte/modèle**. Journaux de déclaration : durée alignée sur
  la prescription des risques (à cadrer avec l'avocat).
- **Droits des personnes.** Accès / rectification / effacement ; décision
  **jamais purement automatisée** sur le blocage (art. 22 RGPD) → une revue humaine
  reste possible.
- **Politique de confidentialité.** Mentionner explicitement : extraction
  d'identité à l'import, déclaration, empreintes anti-abus, absence de divulgation
  croisée.

---

## 7. Recommandation finale

**Adopter l'architecture §4 par étapes, en commençant par le socle à haut rapport
valeur/risque, et faire valider le volet juridique par un avocat spécialisé.**

**Phase 1 (recommandée, faible coût, fort effet) — sans fingerprint :**
- **B** (SIRET/nom extraits vs compte) + **F2** (contrôle Sirene) + **F3**
  (incohérence interne) comme **socle silencieux** ;
- **A** (déclaration sur l'honneur) déclenchée sur discordance/absence ;
- **D** (workflow gradué §5) pour la proportionnalité ;
- **F1/F4** (filigrane de traçage + take-down) pour la diligence d'éditeur.

Ce socle **couvre l'essentiel du risque** (il aligne le produit sur la promesse,
transfère la responsabilité, trace, et attrape le cas tiers non trafiqué) pour un
**coût technique faible et zéro friction** sur les usages légitimes.

**Phase 2 (différée, sur décision) — fingerprint inter-comptes (E) :** à n'ajouter
qu'après (a) validation juridique, (b) DPIA/analyse d'impact RGPD, (c) corpus
assez large pour **régler les seuils sur des mesures** et **maîtriser les faux
positifs** franchise/logiciel. Ne pas coder E au doigt mouillé.

**Avantages** de cette trajectoire : proportionnée, alignée sur la marque (la
vérification *est* la promesse), peu de friction, forte couverture juridique,
extensible. **Limites** assumées : aucune mesure n'empêche un fraudeur
**déterminé** qui nettoie entièrement un devis avant import (aucun signal
n'existe alors) — mais la déclaration + la traçabilité + la take-down assurent la
**diligence** d'ARTIZEN, et l'objectif était de **décourager**, pas de rendre
techniquement impossible.

> **Ligne directrice unique.** Chaque brique doit répondre *oui* à : *« est-ce que
> cela aide l'artisan à retrouver **sa** propre identité — et le protège, lui, en
> même temps qu'ARTIZEN et la promesse ? »* Si une mesure gêne un usage légitime
> plus qu'elle ne décourage un abus, elle est écartée.

---

## 8. Suite

**Retenue par le PO (2026-07).** La **Phase 1** est adoptée telle quelle et gravée
en règle de gouvernance : [Décision 8 — *ARTIZEN protège l'identité documentaire
autant qu'il la restitue*](DECISIONS.md). Composants validés : vérification de
cohérence (raison sociale, SIREN/SIRET, Sirene) · déclaration sur l'honneur en cas
de discordance · workflow progressif (pas de blocage brutal) · filigrane interne
+ take-down. **Fingerprint inter-comptes : différé.** **Aucun écran ni workflow
n'est créé** avant la conception feature par feature.

La **Phase 2 (fingerprint)** fera l'objet d'une étude technique + DPIA dédiées, sur
le modèle de l'étude typographique : décision sur mesures, jamais sur intuition.
