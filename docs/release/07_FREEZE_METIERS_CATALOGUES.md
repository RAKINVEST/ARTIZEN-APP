# 07 — Gel officiel de la couche « Métiers & Catalogues »

> **Statut : GELÉE ✅** — validé par le propriétaire du projet.
> Branche `develop/v3` · commit de clôture `358d4c6` · **480 tests backend verts**.
>
> À partir de ce document, la couche « Métiers & Catalogues » **ne doit plus
> évoluer en architecture**. Seules évolutions autorisées : ajout de contenus,
> nouveaux métiers via le moteur existant, nouvelles versions de catalogues.
> Voir la Constitution technique : [`ARCHITECTURE_V1_REFERENCE.md`](../ARCHITECTURE_V1_REFERENCE.md).

Ce document reprend et met en forme le rapport de revue finale validé.

---

## 1. Commits de la couche

| Commit | Objet |
|---|---|
| `075693d` | Taxonomie officielle des métiers — la colonne vertébrale gelée |
| `52ad7d4` | Lot 1 Fluides complété (Climatisation) + preuve de généricité |
| `a673269` | Statut `deprecated` + filtre API, Lot 2 démarré |
| `1dcc2c8` | Séparation exercice/certification + **Lot 2 Électricité** terminé |
| `ac2ad2c` | **Lot 3 — Finition intérieure** (8 métiers) |
| `814197c` | Test d'intégrité métier — matériel + prestations obligatoires |
| `fff4e06` | **Lot 4 — Enveloppe du bâtiment** (10 métiers) |
| `0b3d7c4` | **Lot 5 — Gros œuvre & TP** (7 métiers) |
| `358d4c6` | **Lot 6 — Métiers spécialisés** (16 métiers + qualification SS4) |

## 2. Activités implémentées (54, réparties en 6 familles)

- **Fluides (5)** : `plomberie`, `chauffage`, `climatisation`, `ventilation`, `traitement-eau`
- **Électricité & courants faibles (8)** : `electricite-generale`, `domotique`, `photovoltaique`, `reseaux-vdi`, `alarme-intrusion`, `videosurveillance`, `controle-acces`, `interphonie`
- **Finition intérieure (8)** : `platrerie`, `peinture`, `carrelage`, `revetements-sol`, `parquet`, `menuiserie-interieure`, `cuisine`, `agencement`
- **Enveloppe (10)** : `charpente`, `couverture`, `zinguerie`, `menuiserie-exterieure`, `stores-pergolas`, `facade`, `isolation`, `isolation-exterieure`, `bardage`, `etancheite`
- **Gros œuvre & TP (7)** : `maconnerie`, `terrassement`, `demolition`, `vrd`, `assainissement`, `forage`, `enrobes`
- **Spécialisés (16)** : `piscine`, `serrurerie-metallerie`, `automatismes-portails`, `vitrerie`, `ferronnerie`, `paysagisme`, `cloture`, `arrosage`, `terrasse-bois`, `ascenseur`, `ramonage`, `desamiantage`, `traitement-charpente`, `hygiene-nuisibles`, `nettoyage`, `diagnostic`

## 3. Qualifications d'exercice (4 — réservent un pack, influencent le moteur)

`pg` · `fluides-frigorigenes` · `irve` · `certification-amiante` (SS4)

## 4. Certifications d'entreprise (7 — mentions administratives, aucun impact catalogue)

`rge` · `eco-artisan` · `qualipac` · `qualipv` · `qualibois` · `qualisol` · `qualifelec`
→ Concept **réservé** : le modèle `CompanyCertification` n'est pas développé (V1 : champ `rge_number`).
Aucune certification n'est jamais présente dans le registre importable (garanti par test).

## 5 → 10. Métriques (introspection du registre)

| # | Métrique | Valeur |
|---|---|---|
| 5 | Familles | **6** |
| 6 | Activités implémentées | **54** (taxonomie : 62 = 54 `implemented` + 3 `planned` + 5 `deferred_v2`) |
| 7 | Packs déclarés | **205** (200 activités + 4 qualifs + 1 pack partagé `Chantier`) |
| 8 | Dossiers distincts (après merge) | **145** |
| 9 | Articles / fournitures (produits) | **958** |
| 10 | Prestations (services) | **422** |
| — | Total lignes catalogue | **1 380** |

## 11 & 12. Tests

**480 tests** — suite complète (`docker compose exec backend pytest`) :

```
480 passed, 1 warning in 120.81s (0:02:00)
```

0 échec · 0 erreur · 0 test ignoré. (Seul warning : `DeprecationWarning` tierce de `reportlab`.)

## 13. Conformité de chaque activité — prouvée par tests paramétrés

Les tests balaient automatiquement les 54 activités et 4 qualifications ; un métier ajouté est couvert sans écrire de test dédié.

| Axe | Preuve |
|---|---|
| **Intégrité** (≥1 dossier matériel garni **et** ≥1 dossier Prestations) | `test_every_activity_offers_material_and_prestations`, `test_every_activity_offers_a_prestations_folder` |
| **Généricité** (pipeline unique, zéro cas particulier) | `test_every_activity_composes_a_real_catalog` |
| **Import** (crée dossiers + articles) | `POST /api/catalog/activities/{slug}` |
| **Endpoints** (lecture par le wizard) | `GET /api/catalog/categories/overview` |
| **Versionnage** | `version=1` sur 100 % des activités et qualifications |

Sync taxonomie↔registre garantie par : `test_implemented_activities_match_the_registry_exactly`,
`test_implemented_exercise_qualifications_match_the_registry_exactly`,
`test_registered_labels_match_the_taxonomy`, unicité globale des slugs.

## 14. Décisions d'architecture gelées

1. Taxonomie = référence unique, slugs **gelés**. Source machine : `catalog/trades/taxonomy.py`.
2. **Moteur zéro-métier** : un métier = un fichier `trades/*.py` + une ligne au registre.
3. Composition par **packs** (pas par métier) ; packs homonymes fusionnent en un dossier.
4. Ossature homogène : matériel(s) → consommables → accessoires/finitions → **Prestations (obligatoire)** ; pack **Chantier** partagé ajouté à chaque import.
5. Deux concepts séparés : qualification d'exercice (réserve un pack) vs certification d'entreprise (administrative, transverse).
6. Cycle de vie par statut : `planned → implemented → deprecated` (+ `deferred_v2`), filtrable par l'API.
7. Les 7 décisions de [`DECISIONS.md`](../DECISIONS.md) restent la base.

## 15. Leçons d'architecture

- Le pari **« zéro moteur »** a tenu sur 41 métiers ajoutés (Lots 3→6) + 1 qualification : aucune modification du moteur/wizard/API/modèle.
- La règle d'intégrité **« matériel + prestations »** s'est généralisée sans exception, y compris pour les métiers de service pur (démolition, nettoyage, diagnostic, ramonage, hygiène) via un dossier *Consommables/Matériel* honnête — aucune exception métier, aucun test contourné.
- Règle **agnostique aux libellés** (« un dossier ≠ Prestations ») : couvre des matériels hétérogènes sans figer de vocabulaire.
- **Versionnage dès la V1** : chaque métier prêt pour les mises à jour « app-store », sans dette.

## 16. Points réservés à une future V2

- **3 activités `planned`** hors périmètre livré : `froid`, `solaire-thermique`, `geothermie`. Ajoutables comme les autres (1 fichier), sans toucher au moteur.
- **5 activités `deferred_v2`** : `cordiste`, `cuvelage`, `paratonnerre`, `antenniste`, `home-staging`.
- **Mécanisme `CompanyCertification`** : modèle réservé, à développer plus tard.
- Améliorations repérées, **non appliquées** (respect du gel) : unités en texte libre (normalisation possible en enum) ; dossiers cousins (`Accessoires`, `Consommables et accessoires`…) distincts par design.

## 17. Conclusion — La couche est-elle officiellement GELÉE ?

**Oui.** Les 6 familles sont implémentées ; 54 activités + 4 qualifications d'exercice livrées,
importables, prouvées sur 5 axes par des tests paramétrés qui couvriront aussi les métiers futurs.
Sur 41 métiers ajoutés : zéro modification du moteur/wizard/API/modèle, zéro exception métier,
zéro test supprimé. Suite **480/480 verte**. Le gel n'exige pas d'implémenter 100 % de la taxonomie,
mais que l'ajout d'un métier n'exige **aucune** évolution d'architecture — ce qui est démontré.

**Toute évolution ultérieure = nouveaux articles versionnés ou nouveaux fichiers `trades/*.py`,
jamais un renommage de slug ni une modification du moteur.**
