# Sécurité CO, hauteur & suie avant travaux de ramonage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-co-hauteur-avant-travaux-ramonage` |
| Titre | Sécurité CO, hauteur & suie avant travaux de ramonage |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les travaux de ramonage/fumisterie (CO, feu de conduit, hauteur, suie, amiante) — sans opération réservée ni retrait d'amiante. `[A]`

## Étapes
1. **Monoxyde de carbone** : vérifier tirage/ventilation ; en cas de refoulement/symptômes, aérer et couper l'appareil. `[A]` → [comprendre-tirage-ventilation-evacuation](../../professions/ramonage/cards/comprendre-tirage-ventilation-evacuation.md)
2. **Feu de conduit** : ne jamais laisser un conduit chargé de bistre ; débistrer. `[A]`
3. **Travail en hauteur** (toiture/souche) : échelle/harnais ; accès toiture = aussi **Couvreur**. `[A]`
4. **Suie** cancérogène : aspiration/masque, bâchage. `[A]`
5. **Appareil / gaz** = **Chauffagiste** (interface) ; aucune opération réservée décrite pas à pas. `[A]`
6. **Rénovation** : anciens conduits/joints → **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [ramoner-conduit-controle-visuel](../../professions/ramonage/cards/ramoner-conduit-controle-visuel.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:securite intervention:securiser cluster:tirage cluster:reglementation type:procedure securite:monoxyde securite:amiante relation:desamiantage relation:chauffage relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
