# Roadmap V1.1 — durcissement post-RC-1

**Écrit à la préparation RC-1.** Ces éléments sont la **dette identifiée à l'audit**
([docs/RC1_AUDIT.md](RC1_AUDIT.md)), pas de nouvelles fonctionnalités métier. Aucun n'est
bloquant pour une validation par de vrais artisans ; ils rendent la fondation plus robuste.

## Qualité / outillage

1. **Élargir le lint.** Passer le ruleset ruff de `F,I` (baseline RC) vers le set par défaut
   (B, UP, S, RUF, FURB…), en triant les ~153 findings de style pré-existants (tri déjà couvert,
   `# noqa` orphelins, suggestions de refactor). Aucun impact runtime — pur nettoyage.
2. **Typage complet.** Étendre le gate mypy des modules durcis à tout `app/` ; corriger le
   shadowing `list` résiduel (`quotes/service.py`) sur le modèle de `planning/service.py`
   (helper au niveau module).

## Architecture

3. **Rompre le cycle `users ↔ branding`.** Déplacer `Company` hors de `branding` pour que
   l'inscription ne crée plus une entité d'un autre module (refactor, pas correctif).

## AI Companion

4. **Phrasing LLM.** Brancher un vrai provider derrière `PromptOrchestrator`/`AIProvider`
   (déjà câblés) pour reformuler les réponses ; la composition déterministe reste le repli.
5. **Pickers structurés** dans l'écran conversationnel (client, dates) alimentant `params`,
   pour que les actions write se complètent sans saisie d'UUID.

## Observabilité

6. **Métriques agrégées** (Prometheus/OpenMetrics) : compteurs de requêtes, histogramme de
   latence, profondeur de file. V1 se contente des logs structurés + `/health` — suffisant pour
   la bêta, à agréger pour l'exploitation.

## Déploiement

7. **Corpus Knowledge versionné.** Le corpus (`backend/knowledge_corpus/`) doit être **commité**
   (il était non suivi) pour être présent dans tout clone/déploiement — action PO.
8. **Pipeline de déploiement** : activer `deploy.yml` (aujourd'hui `.example`) une fois la cible
   registry/hôte fixée.
