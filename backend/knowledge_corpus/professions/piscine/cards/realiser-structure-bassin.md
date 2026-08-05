# Réaliser la structure du bassin

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-structure-bassin` |
| Titre | Réaliser la structure du bassin |
| Profession | `metier:piscine` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:piscine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser la **structure** du bassin selon la technique : **béton** (banché/projeté), **coque** polyester, **panneaux**. `[C]`
- **Résumé** : selon la technique : couler le **radier** et les **parois béton** (armé, **interface** maçonnerie/DTU 21), ou poser/caler une **coque polyester** (manutention grue), ou monter des **panneaux** (kit) ; assurer la stabilité, les réservations (pièces à sceller) et le remblai périphérique équilibré. `[C]` ⟦technique/ferraillage selon étude à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Béton** : radier + parois armés (interface maçonnerie). `[B]` → [realiser-chainage](../../../professions/maconnerie/cards/realiser-chainage.md)
  2. **Coque** : calage/manutention grue ; ou **panneaux** : montage kit. `[C]`
  3. Réserver les **pièces à sceller** (skimmers/buses). `[C]` → [installer-hydraulique-filtration](installer-hydraulique-filtration.md)
  4. **Remblai périphérique** équilibré (avec l'eau). `[C]` → [perte-eau-fuite-bassin](../../../diagnostics/piscine/perte-eau-fuite-bassin.md)
- **Points critiques** : stabilité/ferraillage (étude) ; pièces à sceller prévues ; remblai équilibré ; **béton = interface maçonnerie**.
- **Sécurité** : manutention (coque/grue) ; béton ; effondrement (fouille). **Risque de noyade** : une piscine/fouille en eau non protégée = **danger mortel** (enfants). Les **dispositifs de sécurité** (barrière, alarme, couverture, abri — **obligation légale**) doivent être opérationnels avant la mise en eau/service. **Fouille / terrassement** : effondrement des parois, engins → blindage/talutage (**interface** Terrassement). **Risques électriques** : eau + électricité = très dangereux ; le **raccordement électrique** (local technique, pompe, projecteurs), la **liaison équipotentielle** et les **volumes** (NF C 15-100 7-702) sont **réservés à un électricien** → voir Électricité. **Produits de traitement** (chlore, acides) : stockage/manipulation ; **ne jamais mélanger chlore et acide** (dégagement gazeux toxique) → interface Traitement de l'eau. **Local technique** confiné : ventilation. **Manutention** : coque polyester (grue), panneaux, margelles lourdes. **Amiante** (rénovation ancienne) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : sécurité électrique des piscines (volumes 0/1/2, liaison équipotentielle) **NF C 15-100** (partie 7-702) ; structure béton du bassin (**interface** maçonnerie) **DTU 21** ; **sécurité des piscines** — barrières / alarmes / couvertures / abris **NF P 90-306 à 90-309** et **obligation légale** (Code de la construction), norme européenne **NF EN 16582** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Revêtement / étanchéité** : `cite-carte` → [poser-revetement-etancheite](poser-revetement-etancheite.md)

## Relations & tags
- **Tags** : `metier:piscine famille:specialises sous-famille:piscine intervention:realiser cluster:structure cluster:types-de-bassins complexite:avancee type:installation securite:manutention relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
