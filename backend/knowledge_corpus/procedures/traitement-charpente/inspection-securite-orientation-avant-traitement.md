# Inspection, sécurité & orientation avant traitement (décision)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `inspection-securite-orientation-avant-traitement` |
| Titre | Inspection, sécurité & orientation avant traitement (décision) |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Cadrer le diagnostic, la sécurité (biocides/hauteur/amiante) et l'orientation — **décision/organisation**, sans protocole d'application. `[A]`

## Étapes (organisation / décision — aucun protocole biocide)
1. **Inspecter/diagnostiquer** l'attaque, son activité et l'atteinte structurelle. `[A]` → [diagnostiquer-attaques-biologiques](../../professions/traitement-charpente/cards/diagnostiquer-attaques-biologiques.md)
2. **Traiter la cause = humidité** (Couvreur/Maçon/Paysagiste) avant tout traitement. `[A]` → [comprendre-role-humidite](../../professions/traitement-charpente/cards/comprendre-role-humidite.md)
3. **Biocides** : application **réglementée** (Certibiocide, EPI, protection occupants/animaux) = **applicateur qualifié**. `[A]`
4. **Structure affaiblie** = danger → sécuriser ; renfort = **Charpentier**. `[A]`
5. **Amiante** (matériaux anciens en rénovation) → **arrêt / orientation** (Désamiantage). `[A]` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)
6. **Obligations** : termites (déclaration mairie), information mérule ; documenter. `[A]` `relation:diagnostic`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [comprendre-traitements-preventifs-curatifs](../../professions/traitement-charpente/cards/comprendre-traitements-preventifs-curatifs.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:securite intervention:securiser cluster:inspection cluster:reglementation type:procedure securite:biocides securite:amiante relation:desamiantage relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
