# Orchestration Domain — Domaine

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../decision/DECISION_DOMAIN.md](../decision/DECISION_DOMAIN.md) — **Used By:** ORCHESTRATION_PIPELINE — **Niveau:** 2 · Architecture

## Objective
Décrire le domaine : d'une **décision validée** à une **saga** d'actions coordonnées.

## Concepts
| Concept | Définition | Persisté ? |
|---|---|---|
| **Orchestration** | l'exécution coordonnée d'une décision validée | trace via `Event`/`History` (pas de modèle dédié — ADR sinon) |
| **Étape (Step)** | une action confiée à **un** moteur propriétaire | non (état en `Event`/tâche) |
| **Plan d'exécution** | la séquence d'étapes issue de la décomposition | transitoire |
| **Résultat d'étape** | succès / échec / en attente | tracé |

## Exemple (déroulé)
« Je remplace un chauffe-eau » → Decision propose → **validation utilisateur** → **Orchestration** :
1. Quote : créer le devis (geste propriétaire).
2. Workflow : ouvrir le processus d'intervention.
3. Mission : créer/rattacher la mission.
4. Planning : proposer un créneau.
5. Notification : informer le client.
Chaque étape est exécutée par **son** moteur ; Orchestration **coordonne** et **trace**.

## Règles
- Le domaine d'Orchestration est **la coordination**, pas le métier (aucun nouveau métier créé).
- Les données restent **chez les moteurs** ; Orchestration ne détient que la **trace** (journal existant).
- Tout part d'une **décision validée** ; rien n'est automatique.

## Conformité
Aucun métier/objet créé ; coordination pure ; trace via journal gelé. ✅

## Changelog
- 1.0 (2026-08-02) — Domaine initial.
