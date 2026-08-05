# Charpente affaissée / affaiblie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `charpente-affaissee-affaiblie` |
| Titre | Charpente affaissée / affaiblie |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Charpente qui **fléchit**, bois qui **cède au sondage**, appuis dégradés, déformation de la toiture. `[C]`

> **DANGER structurel** : une charpente fortement attaquée peut **s'effondrer** → ne pas surcharger/circuler, **arrêt**, sécuriser. `[A]`

## Causes probables
1. **Attaque avancée** (insectes/champignons) ayant réduit les sections. `[C]` → [diagnostiquer-attaques-biologiques](../../professions/traitement-charpente/cards/diagnostiquer-attaques-biologiques.md)
2. **Humidité** chronique (appuis pourris). `[C]` → [comprendre-role-humidite](../../professions/traitement-charpente/cards/comprendre-role-humidite.md)
3. Renfort/remplacement structurel = **Charpentier**. `[C]` → [inspecter-charpente](../../professions/charpente/cards/inspecter-charpente.md)

## Conduite à tenir
- Sécuriser, diagnostiquer l'atteinte, traiter l'humidité ; **renforcement/remplacement = Charpentier** ; traitement = applicateur qualifié. `[A]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [diagnostiquer-attaques-biologiques](../../professions/traitement-charpente/cards/diagnostiquer-attaques-biologiques.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente probleme:structurel cluster:diagnostic cluster:inspection type:diagnostic securite:hauteur relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
