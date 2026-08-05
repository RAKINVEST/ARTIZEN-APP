# Governance — Gouvernance du Corpus

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [VALIDATION_PROCESS.md](VALIDATION_PROCESS.md), [LIFECYCLE.md](LIFECYCLE.md) — **Used By:** responsables éditoriaux

## Objective
Définir **qui** fait **quoi** sur une carte, et le **cycle de vie** associé.

## Rôles & droits
| Rôle | Crée | Modifie | Valide | Archive | Supprime | Publie |
|---|---|---|---|---|---|---|
| **Contributeur** | ✅ (Brouillon) | ✅ (Brouillon) | ❌ | ❌ | ❌ | ❌ |
| **Relecteur** | ✅ | ✅ (Brouillon) | proposition | ❌ | ❌ | ❌ |
| **Validateur** (expert métier) | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Responsable Corpus** | ✅ | ✅ | ✅ | ✅ | **ADR requis** | ✅ |
| **IA** | propose (Brouillon) | ❌ | ❌ | ❌ | ❌ | ❌ |

> La **validation** et l'**archivage** relèvent d'un **humain habilité** (Loi 7/18). L'IA ne fait
> que **proposer** (elle n'invente rien, cf. [../blueprint/engines/knowledge/KNOWLEDGE_LEARNING.md](../blueprint/engines/knowledge/KNOWLEDGE_LEARNING.md)).
> La **suppression** de contenu métier est interdite sans **ADR** (Loi 5).

## Cycle de vie (résumé — détail dans LIFECYCLE)
`Brouillon → (relecture) → Validé → (évolution) → Nouvelle version → Ancienne Archivée`.
Aucun retour destructif ; tout est historisé.

## Publication
- **Publier** = rendre la carte visible dans sa portée (`Visibility` de l'objet `Knowledge`).
- La portée par défaut est **l'entreprise** (tenant) ; tout partage **inter-entreprises** exige un ADR.

## Responsabilités transverses
- **Cohérence** : Responsable Corpus (doublons, relations, taxonomie).
- **Exactitude métier** : Validateur (expert du métier concerné).
- **Conformité** : au Blueprint gelé (Knowledge Engine) et aux présentes règles.

## Changelog
- 1.0 (2026-08-02) — Gouvernance initiale.
