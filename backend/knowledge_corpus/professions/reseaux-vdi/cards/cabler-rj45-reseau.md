# Câbler un réseau RJ45

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cabler-rj45-reseau` |
| Titre | Câbler un réseau RJ45 |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : câbler un réseau de données RJ45 (catégorie adaptée) en étoile, avec séparation des courants forts. `[C]`
- **Résumé** : tirer les câbles (paires torsadées, **catégorie** Cat 6/6A selon débit) du coffret vers chaque prise, respecter le **rayon de courbure** et la **séparation** des courants forts, raccorder les connecteurs RJ45 (norme T568A/B) sans **détoronnage** excessif, puis repérer/tester. `[C]` ⟦catégorie/longueur selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tirer les câbles (**catégorie** adaptée) en étoile ; séparer des courants forts. `[C]`
  2. Respecter **rayon de courbure** et longueur max (100 m). `[C]` ⟦à confirmer⟧
  3. Raccorder RJ45 (T568A/B, minimiser le **détoronnage**). `[C]`
  4. **Repérer** et tester chaque lien. `[C]` → [tester-certifier-reseau](tester-certifier-reseau.md)
- **Points critiques** : catégorie/qualité de connexion ; **séparation courants forts** (NF C 15-100) ; longueur/courbure ; repérage.
- **Sécurité** : coexistence courants forts (séparation) ; ESD. **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Séparation/consignation** : `cite-carte` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:poser cluster:cablage-rj45 cluster:reseaux-residentiels complexite:moyenne type:installation securite:coexistence relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
