# Glossaire

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** tous les documents — **Niveau:** 3 · Implémentation

## Objective
Un terme, une signification, partout (Loi 1 / 2). Colonne « À l'écran » = le mot autorisé face à l'artisan (deux langues).

## Termes de référence
| Terme (ingénierie) | Définition | À l'écran (artisan) |
|---|---|---|
| **Mission** | Unité de travail : tout ce qui gravite autour d'un chantier (client, interventions, documents, facturation, SAV). Agrégat racine (Loi 9). | Mission / Chantier |
| **Intervention (modèle)** | Description réutilisable d'un travail (« Remplacement chauffe-eau »). Unité de pensée (Loi 8). | Intervention |
| **Intervention (instance)** | Une intervention réalisée dans une mission, éditable. | Intervention |
| **Bibliothèque Métier** | Ensemble des blocs réutilisables (articles, main-d'œuvre, garanties, phrases…). Remplace le mot « catalogue ». | Ma bibliothèque / Mes prestations |
| **Élément de bibliothèque** | Un bloc : article, consommable, main-d'œuvre, déplacement, garantie, phrase, condition, contrôle. | Prestation / Fourniture |
| **Kit** | Préparation : composition d'éléments réutilisable. Plusieurs kits peuvent servir une intervention. | Kit |
| **Devis** | Traduction commerciale d'interventions ; projection, non l'unité de travail. | Devis |
| **Moteur (engine)** | Module d'un Bounded Context. | *(non affiché)* |
| **Événement de domaine** | Fait immuable émis par le cœur, écouté par les moteurs. | *(non affiché)* |
| **Suggestion** | Proposition justifiée assortie d'une confiance ∈ [0,1] (Loi 6). | Suggestion / Rappel |
| **Confiance** | Niveau ∈ [0,1] attaché à une suggestion, toujours visible. | Confiance |
| **Score de complétude** | Mesure d'incomplétude d'une intervention/mission ; « incomplet », jamais « faux ». | À compléter |
| **Fiche d'expérience** | Savoir capitalisé d'une mission (Loi 10 : le savoir > le document). | Retour d'expérience |
| **Visibilité** | Privé / Entreprise / Groupe / Public (Vol.7). | Partage |
| **Compagnon** | Le rôle d'Artizen : prépare, rappelle, propose ; ne décide jamais (Loi 7/18). | Assistant |

## Rules
Tout nouveau terme est ajouté ici avant d'être employé ailleurs.

## Forbidden
Deux termes pour un même concept ; un terme d'ingénierie à l'écran.

## Acceptance Criteria
Chaque objet métier fondamental a une entrée.

## Related Documents
[../constitution/README.md](../constitution/README.md)

## Next Reading
[../templates/README.md](../templates/README.md)

## Changelog
- 1.0 (2026-08-02) — Glossaire initial (15 termes cœur).
