# Contrôle / surveillance charpente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-surveillance-charpente` |
| Titre | Contrôle / surveillance charpente |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Humidité** du bois mesurée ; sources maîtrisées (toit/mur/ventilation). `[A]`
- [ ] **Indices d'attaque** (trous/vermoulure/galeries/fructifications) surveillés. `[C]`
- [ ] **Activité** distinguée (active/ancienne) ; atteinte structurelle. `[A]`
- [ ] **Termites / mérule** : obligations réglementaires respectées. `[A]`
- [ ] Traitement = **applicateur qualifié** (Certibiocide) ; documentation. `[C]`
- [ ] Rénovation : **amiante** (matériaux anciens) → arrêt/orientation. `[A]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [inspecter-surveiller-charpente](../../professions/traitement-charpente/cards/inspecter-surveiller-charpente.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente type:checklist cluster:surveillance cluster:documentation securite:biocides`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
