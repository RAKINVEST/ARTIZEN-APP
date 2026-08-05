# Sécurité — biocides, hauteur & poussières (traitement charpente)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-biocides-hauteur-charpente` |
| Titre | Sécurité — biocides, hauteur & poussières (traitement charpente) |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Biocides** : produits dangereux ; application = **qualifié** (Certibiocide) ; **présentation seule** ici. `[A]`
- [ ] **EPI / ventilation / protection des occupants et animaux** (relais pro). `[A]`
- [ ] **Travail en hauteur / combles** : planchers fragiles, chutes. `[A]`
- [ ] **Poussières de bois** (cancérogènes) : aspiration/masque. `[A]`
- [ ] **Structure affaiblie** : risque d'effondrement → sécuriser/arrêt. `[A]`
- [ ] **Amiante** (matériaux anciens) : diagnostic ; retrait = **certifié** (jamais ici). `[A]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [inspection-securite-orientation-avant-traitement](../../procedures/traitement-charpente/inspection-securite-orientation-avant-traitement.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:securite type:checklist cluster:prevention securite:biocides securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
