# Confidence Model — Niveaux de confiance

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [SOURCE_POLICY.md](SOURCE_POLICY.md) — **Used By:** auteurs, relecteurs, validateurs, IA

## Objective
Attacher à **chaque information** d'une carte un **niveau de confiance** traçable. Aligne l'honnêteté
du projet (distinguer fait vérifié / hypothèse) au contenu métier.

## Les 4 niveaux
| Niveau | Signification | Sources |
|---|---|---|
| **A — Autorité** | fait réglementaire/normatif | documentation fabricant officielle, **DTU**, **normes** (NF/EN), textes réglementaires |
| **B — Technique** | fait technique documenté | documentation technique, notice officielle, formation constructeur |
| **C — Terrain validé** | savoir d'expérience éprouvé | retour terrain **validé**, expert métier, entreprise pilote |
| **D — Hypothèse** | à confirmer | supposition, à valider — **jamais publié comme certitude** |

## Règles
- **Chaque information clé** porte son niveau (ex. `[A]`, `[C]`) dans la carte.
- Le **niveau global** d'une carte est tiré de ses informations (le maillon le plus faible tire vers le bas).
- Une information **D** est **signalée explicitement** (« à confirmer ») ; elle ne peut pas être la
  base d'un point critique/sécurité.
- L'IA hérite de la confiance de **ses sources** : elle ne « monte » jamais un D en A.
- Sécurité et normes visent le niveau **A/B** ; un C/D en sécurité déclenche une relecture renforcée.

## Lien avec le score
La dimension **Sources** de [KNOWLEDGE_SCORE.md](KNOWLEDGE_SCORE.md) dépend directement des niveaux de confiance.

## Changelog
- 1.0 (2026-08-02) — Modèle initial (A/B/C/D).
