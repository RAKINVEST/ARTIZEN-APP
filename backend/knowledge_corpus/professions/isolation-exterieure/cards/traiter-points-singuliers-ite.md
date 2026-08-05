# Traiter les points singuliers ITE (tableaux, angles, jonctions)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-points-singuliers-ite` |
| Titre | Traiter les points singuliers ITE (tableaux, angles, jonctions) |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les points singuliers d'un ETICS : tableaux de fenêtres, angles, soubassement, jonctions toiture/menuiseries. `[C]`
- **Résumé** : assurer l'étanchéité et la continuité aux **tableaux de fenêtres** (retours d'isolant, profilés d'appui/goutte d'eau), angles, **soubassement** (profilé de départ), jonctions **toiture/débord** et menuiseries, sans créer de pont thermique ni d'entrée d'eau. `[C]` ⟦profilés/accessoires selon ATec à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Tableaux de fenêtres** : retours d'isolant + profilés (appui, goutte d'eau). `[C]`
  2. **Soubassement** : profilé de départ, isolant adapté (chocs/eau). `[C]`
  3. Jonction **toiture/débord** de toit et rives. `[C]` → [traiter-rives-aretiers](../../../professions/couverture/cards/traiter-rives-aretiers.md)
  4. Traiter les **ponts thermiques** résiduels. `[C]` → [traiter-ponts-thermiques-ite](traiter-ponts-thermiques-ite.md)
- **Points critiques** : retours de tableaux (pont thermique) ; étanchéité des appuis (goutte d'eau) ; **coordination avec la couverture/charpente** (débord).
- **Sécurité** : hauteur ; découpe ; interfaces multiples. **Travail en **hauteur** (façade) : risque de **chute** — **échafaudages** / protections **collectives** (garde-corps) prioritaires, EPI antichute, **météo** (vent/gel/pluie/fort ensoleillement) surveillée (prise des colles/enduits). **Découpe des panneaux** (PSE/laines) : **poussières** — masque/aspiration, protection respiratoire pour les laines. **Produits chimiques** (colles, sous-enduits, mortiers) : EPI, protection de l'environnement. **Arrêt immédiat en cas de danger.** La pose ETICS s'effectue **sous Avis Technique** et relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Charpente (débord/ossature)** : `cite-carte` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)

## Relations & tags
- **Tags** : `metier:isolation-exterieure famille:enveloppe sous-famille:isolation-exterieure intervention:realiser cluster:points-singuliers cluster:tableaux-de-fenetres cluster:etics complexite:expert type:installation securite:hauteur relation:couverture relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
