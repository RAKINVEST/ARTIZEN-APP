# Contribuer à ARTIZEN

Merci de contribuer. Ce projet a des **conventions strictes et des invariants
produit** qui traversent tout le code : les respecter n'est pas une question
de style, c'est ce qui garde la promesse du produit. Lisez d'abord
`CLAUDE.md` (contrat produit + pièges) et le `README.md` racine (chaque
décision d'architecture y est justifiée).

## Langues

- **Documentation en français, commentaires de code en anglais.** Cette
  convention est constante dans tout le dépôt — la garder.

## Invariants produit — à ne jamais enfreindre

Détaillés dans `CLAUDE.md`. En résumé :

1. **L'IA ne choisit aucun prix, aucune TVA, aucun montant, et ne persiste
   rien** (elle infère seulement des quantités, bornées et relues).
2. **Un devis ne se modifie pas — il se supprime (brouillon) et se recrée, ou
   se duplique.** Ni `PUT` ni `PATCH` sur le contenu d'un devis. La
   numérotation vient de `quote_counters` verrouillé `FOR UPDATE`, jamais d'un
   `SELECT MAX+1`.
3. **`quotes/calculator.py` est le seul endroit où un montant est calculé**
   (tout en `Decimal`, `ROUND_HALF_UP` par ligne). Jamais côté Flutter.
4. **Une réponse d'IA n'est jamais crue sur parole** (`match_validator.py`
   re-valide contre le vrai catalogue).
5. **`company_id` vient toujours du JWT**, jamais du client.
6. **Un mismatch de tenant renvoie 404, jamais 403.**
7. **Rien n'est appliqué sans confirmation explicite** (import de modèle).

Une contribution qui touche à l'un de ces points doit l'expliciter et le
justifier — c'est un changement de contrat, pas un simple correctif.

## Architecture

- Backend : **monolithe modulaire à modules verticaux**
  (`models/schemas/repository/service/deps/router` par module). Dépendances
  entre modules **à sens unique et justifiées** (voir `ARCHITECTURE.md`).
- Frontend : **feature-first** (`data/domain/presentation`). `core/api/` est
  la **seule** couche qui connaît Dio.
- Règle d'extraction : un helper monte au transverse **au deuxième
  consommateur**, pas avant.

## Mise en place

Voir `docs/INSTALL.md`. En bref :

```bash
cp .env.example .env
docker compose up                 # backend + db + migrations
cd frontend && flutter pub get
```

## Avant d'ouvrir une Pull Request

Faites passer les portes que la CI (et la culture du dépôt) exigent :

```bash
# Backend
docker compose exec backend pytest            # doit rester vert (208 à ce jour)

# Frontend
cd frontend
dart run build_runner build --delete-conflicting-outputs   # si modèle Freezed modifié
flutter analyze                               # No issues found!
flutter test                                  # doit rester vert (63 à ce jour)
```

**Les tests ne prouvent pas le contrat HTTP réel.** Un changement de schéma
Pydantic doit être validé avec un `curl` réaliste, pas seulement avec pytest
(un `company_id` resté requis avait passé 95 tests puis cassé le vrai
client). Voir la section « Pièges connus » de `CLAUDE.md`.

## Migrations

`alembic revision --autogenerate` est un point de départ, **jamais** un
livrable : relire et corriger (colonnes `NOT NULL` sur table peuplée,
backfill, `DROP TYPE` des enums dans `downgrade`). Voir
`docs/MIGRATION_GUIDE.md`.

## Style de commit

- Messages en français, à l'impératif, expliquant le **pourquoi** autant que
  le quoi (l'historique du dépôt en est l'exemple).
- Ne pas pousser sur `origin` sans autorisation explicite du propriétaire.

## Pièges à connaître (ils ont coûté cher)

Résumés dans `docs/TROUBLESHOOTING.md` et `docs/release/05_HANDOFF.md` :
`.gitattributes`/CRLF, volume détenu par root, `MSYS_NO_PATHCONV`, Python
3.13 (pas 3.14), `bcrypt` épinglé, shadowing de `list` dans `QuoteService`,
`@JsonSerializable` sur une classe Freezed.

## État de la Release Candidate

La branche `v2` est gelée sur `v2.0.0-rc1`. Pendant le gel, **aucun correctif
n'est appliqué directement sur la RC** : une anomalie bloquante/majeure ouvre
une RC2 ; une mineure est documentée pour la V2.x/V3
(`docs/KNOWN_LIMITATIONS.md`).
