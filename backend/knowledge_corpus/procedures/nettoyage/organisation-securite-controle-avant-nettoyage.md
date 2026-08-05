# Organisation, sécurité produits & déchets avant nettoyage (décision)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `organisation-securite-controle-avant-nettoyage` |
| Titre | Organisation, sécurité produits & déchets avant nettoyage (décision) |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Cadrer l'organisation, la sécurité chimique, les déchets et l'amiante — **décision/organisation**, sans dosage ni mélange de produits. `[A]`

## Étapes (organisation / décision — aucun protocole d'usage de produits)
1. **Organiser** après les corps d'état ; du **haut vers le bas** ; protections en place. `[C]` → [proteger-materiaux-surfaces](../../professions/nettoyage/cards/proteger-materiaux-surfaces.md)
2. **Produits** : lire les **FDS/CLP** ; **ne jamais mélanger** ; ventiler ; EPI. `[A]`
3. **Poussières** (silice/bois) : aspiration/masque ; **amiante** possible → arrêt/orientation. `[A]` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)
4. **Hauteur** (vitrages/façades) : nacelle/harnais ; **sols glissants** : balisage. `[A]`
5. **Déchets de chantier** : tri et **filière réglementée** (bordereau). `[A]`
6. **Contrôle qualité** final ; documenter. `[C]` `relation:diagnostic`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [organiser-nettoyage-fin-chantier](../../professions/nettoyage/cards/organiser-nettoyage-fin-chantier.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:securite intervention:securiser cluster:organisation cluster:dechets-chantier type:procedure securite:produits-chimiques securite:amiante relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
