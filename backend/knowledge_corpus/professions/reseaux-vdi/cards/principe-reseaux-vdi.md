# Principe des réseaux VDI (courants faibles)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-reseaux-vdi` |
| Titre | Principe des réseaux VDI (courants faibles) |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le réseau VDI (Voix-Données-Images) résidentiel : coffret de communication, distribution en étoile, grades. `[C]`
- **Résumé** : un réseau **VDI** distribue **voix (téléphonie)**, **données (RJ45)** et **images (TV)** depuis un **coffret de communication** (à côté du tableau électrique) vers les prises, en **étoile** ; l'installation résidentielle relève d'un **grade** (NF C 15-100) et se **certifie**. Interphonie/contrôle d'accès = métiers distincts (interface câblage seulement). `[C]` ⟦grade/architecture selon logement à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Coffret de communication** (résidentiel, près du tableau). `[C]` → [installer-baie-coffret-brassage](installer-baie-coffret-brassage.md)
  2. Distribution **RJ45** en étoile (données/voix). `[C]` → [cabler-rj45-reseau](cabler-rj45-reseau.md)
  3. **Fibre** / **TV** / téléphonie. `[C]` → [raccorder-fibre-optique](raccorder-fibre-optique.md)
  4. **Séparation des courants forts** (Électricité). `[C]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
- **Points critiques** : distribution **en étoile** ; **grade** adapté ; **séparation courants forts/faibles** ; certification de recette.
- **Sécurité** : coexistence courants forts ; ESD ; laser (fibre). **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Tests & certification** : `cite-carte` → [tester-certifier-reseau](tester-certifier-reseau.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:comprendre cluster:reseaux-vdi cluster:coffret-de-communication cluster:reseaux-residentiels cluster:cablage-rj45 type:principe securite:coexistence relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
