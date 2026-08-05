# Import / Export Engine

> **Version** 1.0 — **Status** Frozen — **Owner** Sharing — **Last Update** 2026-08-02
> **Depends On:** [../ENGINE_MAP.md](../ENGINE_MAP.md) — **Used By:** engines, contracts, events — **Niveau:** 2 · Architecture · **Couche:** L0 Infra

## Nom
Import / Export Engine

## Mission
Échanger des ressources (copie, jamais dépendance).

## Vision
Souveraineté des données (V7/V8).

## Responsabilité unique
Échanger des ressources (copie, jamais dépendance). — **une seule question**, aucune autre (Loi 1).

## Propriétaire
Sharing (unique).

## Pourquoi il existe
Il porte une responsabilité qu'aucun autre moteur ne doit assumer.

## Pourquoi il est indépendant
Frontière nette ; il dialogue par événements/contrats et référence par id — jamais d'accès sauvage.

## Objets métier propriétaires
Resource

## Objets utilisés
Storage, contrats

## Objets interdits
écriture directe d'un autre tenant

## Services exposés
import.publish/import

## Services consommés
Voir [../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md) (colonne « dépend de »).

## API exposées
À définir à l'implémentation (Step 4+) — hors périmètre de la spécification.

## API consommées
À définir à l'implémentation (Step 4+) — hors périmètre de la spécification.

## Événements publiés
- `ResourcePublished`

## Événements consommés
—

## Permissions
Tenant **Company** ; gardes Authentication + Authorization ; `company_id` du contexte d'auth.

## Persistance
À définir à l'implémentation (Step 4+) — hors périmètre de la spécification.

## Configuration
Via **Settings** ; aucune valeur métier codée en dur (générique).

## Sécurité
Isolation tenant ; aucun accès sauvage aux données d'un autre moteur ; entrées validées.

## Journalisation
Actions journalisées (**History**) ; échecs tracés ; append-only (Loi 5).

## Observabilité
Santé exposée ; métriques d'usage remontées à **Performance** par événements.

## Performance
Logique pure isolable ; effets aux frontières ; read-side en dégradation gracieuse.

## Limites
Ne décide jamais à la place de l'artisan (Loi 7/18) ; ne franchit une frontière que par événement/contrat.

## Évolutions prévues
Connecteurs API/CSV

## Related Documents
[../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md) · [../ENGINE_BOUNDARIES.md](../ENGINE_BOUNDARIES.md) · [../ENGINE_EVENTS.md](../ENGINE_EVENTS.md)

## Next Reading
[../ENGINE_MAP.md](../ENGINE_MAP.md)

## Changelog
- 1.0 (2026-08-02) — Fiche initiale (L0 Infra).
