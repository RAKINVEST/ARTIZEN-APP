# Metrics — Indicateurs de production

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [KNOWLEDGE_SCORE.md](KNOWLEDGE_SCORE.md), [../../blueprint/engines/knowledge/KNOWLEDGE_METRICS.md](../../blueprint/engines/knowledge/KNOWLEDGE_METRICS.md) — **Used By:** responsables, pilotage

## Objective
Définir les **indicateurs** qui pilotent la Factory. Ce document **spécifie** ; **aucune mesure réelle**
n'est produite ici (l'agrégation appartient au moteur Performance/Knowledge).

## Indicateurs
| Indicateur | Définition | Usage |
|---|---|---|
| **Nombre de cartes** | total (tous états) | volume |
| **Validées** | état Validé | patrimoine exploitable |
| **En brouillon** | état Brouillon | en-cours (WIP) |
| **Temps moyen de validation** | Idée → Validé | débit / goulots |
| **Couverture métier** | activités/interventions couvertes / total taxonomie | pilotage de la [file](KNOWLEDGE_QUEUE.md) |
| **Confiance moyenne** | moyenne des niveaux A/B/C/D | fiabilité globale |
| **Taux de duplication** | doublons détectés / total | santé anti-doublon |
| **Taux d'obsolescence** | cartes à réviser (sources périmées) / validées | dette de fraîcheur |

## Règles
- Indicateurs **explicables** (Loi 6) ; aucun chiffre affirmé sans mesure (honnêteté du projet).
- La **couverture** (vs [../taxonomy/](../taxonomy/README.md)) pilote la production, pas le volume brut.
- Les métriques d'usage remontent à **Performance** par événements (moteur), non recalculées ici.

## Changelog
- 1.0 (2026-08-02) — Indicateurs initiaux.
