# Checklists — Listes de contrôle officielles

> **Version** 1.0 — **Status** Frozen — **Owner** Lead — **Last Update** 2026-08-02
> **Depends On:** [DONE_DEFINITION.md](DONE_DEFINITION.md) — **Used By:** tout contributeur — **Niveau:** 3 · Implémentation

## Objective
Rassembler les 8 checklists opérationnelles. Elles rendent les règles des autres documents **actionnables** ; elles n'introduisent aucune règle nouvelle.

---

### 1. Nouvelle fonctionnalité
- [ ] Étoile polaire : aide-t-elle l'artisan à retrouver/restituer son identité ?
- [ ] Réutilisation prouvée (objet/moteur/événement/contrat/API existant réutilisé ou écarté avec preuve).
- [ ] Rattachée à un Flow et à des Contracts existants (sinon ADR).
- [ ] Deux langues : aucun terme d'ingénierie face à l'artisan.
- [ ] Tests, doc, revue, DoD prévus.

### 2. Nouveau moteur (Engine)
- [ ] Responsabilité unique, non couverte par un moteur existant ([ENGINE_MAP](../engines/ENGINE_MAP.md)).
- [ ] Ne décide rien à la place de l'artisan (Loi 7/18).
- [ ] N'écrit jamais dans le cœur ; se nourrit d'événements (read-side).
- [ ] Frontières et dépendances déclarées (sens unique, sans cycle).
- [ ] Fiche Engine créée/mise à jour dans le Blueprint.

### 3. Nouvelle API / endpoint
- [ ] Contrat défini **avant** le code ([API_CONTRACTS](../contracts/API_CONTRACTS.md)).
- [ ] `company_id` du contexte ; tenant mismatch → 404.
- [ ] Validation d'entrée ; enveloppe d'erreur + statuts corrects.
- [ ] Compatible (additif) ou versionné + ADR.
- [ ] Vérifié par un `curl` réaliste (pas seulement les tests).

### 4. Migration de base
- [ ] `--autogenerate` **relu** (types, index, contraintes, données).
- [ ] Aucune perte de donnée métier ; additif ou expand→migrate→contract.
- [ ] `downgrade` renseigné si raisonnable ; modèle enregistré dans `models/__init__.py`.
- [ ] Testée sur base de dev.

### 5. Revue de code (relecteur)
- [ ] Architecture + réutilisation + contrats respectés.
- [ ] Qualité (analyse statique verte, pas de duplication/complexité).
- [ ] Sécurité (secrets, tenant, validation, injection).
- [ ] Tests présents et verts ; doc à jour.
- [ ] Remarques bloquantes résolues avant merge.

### 6. Pull Request (auteur)
- [ ] Une intention claire, taille raisonnable.
- [ ] CI verte (format, lint, tests, build).
- [ ] Blueprint/ADR mis à jour si impact architectural ; CHANGELOG.
- [ ] Auto-revue faite ; pas de secret, pas de code mort, pas de TODO permanent.

### 7. Release
- [ ] Périmètre gelé ; stabilisation sur `release/<version>`.
- [ ] DoD cochée ; migrations relues ; versionnage sémantique + tag.
- [ ] Backend livré (upgrade head) ; frontend livré (cache invalidé).
- [ ] Post-déploiement : `/health` OK, redémarrage si env modifié, contrôle fumée, rollback prêt.

### 8. Definition of Done
- [ ] Les 12 points de [DONE_DEFINITION.md](DONE_DEFINITION.md) sont vrais — sinon **pas** *Done*.

---

## Related Documents
[DONE_DEFINITION.md](DONE_DEFINITION.md) · [REVIEW_PROCESS.md](REVIEW_PROCESS.md) · [../implementation/ANTI_PATTERNS.md](ANTI_PATTERNS.md)

## Next Reading
[../implementation/ANTI_PATTERNS.md](ANTI_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — 8 checklists initiales.
