# Sécurité — CO, feu de conduit & hauteur (ramonage)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-co-feu-hauteur-ramonage` |
| Titre | Sécurité — CO, feu de conduit & hauteur (ramonage) |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Monoxyde de carbone** : tirage/ventilation ; refoulement = danger mortel. `[A]`
- [ ] **Feu de conduit** : bistre traité ; ramonage régulier. `[A]`
- [ ] **Travail en hauteur** (toiture/souche) : échelle/harnais ; fragilité couverture. `[A]`
- [ ] **Suie** cancérogène : aspiration/masque ; bâchage. `[A]`
- [ ] **Appareil / gaz** = **Chauffagiste** (interface) ; distances de sécurité. `[A]`
- [ ] **Amiante** (anciens conduits/joints) : diagnostic ; retrait = **certifié** (jamais ici). `[A]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [securite-co-hauteur-avant-travaux-ramonage](../../procedures/ramonage/securite-co-hauteur-avant-travaux-ramonage.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:securite type:checklist cluster:feu-de-conduit securite:monoxyde securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
