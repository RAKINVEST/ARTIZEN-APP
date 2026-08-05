# Sécurité — produits, poussières & hauteur (nettoyage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-produits-poussieres-nettoyage` |
| Titre | Sécurité — produits, poussières & hauteur (nettoyage) |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Produits** : **FDS/CLP** lues ; **JAMAIS de mélange** (chlore+acide = gaz toxique). `[A]`
- [ ] **Ventilation** + **EPI** adaptés ; stockage/étiquetage. `[A]`
- [ ] **Poussières** (silice/bois) : aspiration/masque ; **amiante** = arrêt/orientation. `[A]`
- [ ] **Hauteur** (vitrages/façades) : nacelle/harnais. `[A]`
- [ ] **Sols glissants** (nettoyage humide) : balisage/séchage. `[A]`
- [ ] **Électricité + eau** (machines) : prudence ; **déchets** triés. `[A]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [organisation-securite-controle-avant-nettoyage](../../procedures/nettoyage/organisation-securite-controle-avant-nettoyage.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:securite type:checklist cluster:organisation securite:produits-chimiques securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
