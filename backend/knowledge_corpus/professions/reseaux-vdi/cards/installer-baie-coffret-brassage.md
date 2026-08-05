# Installer une baie / un coffret de brassage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-baie-coffret-brassage` |
| Titre | Installer une baie / un coffret de brassage |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer et organiser une baie de brassage ou un coffret de communication (arrivées, brassage, mise à la terre). `[C]`
- **Résumé** : poser la **baie/le coffret**, y organiser les arrivées (opérateur/box), les **panneaux de brassage**, l'énergie (PDU) et surtout la **mise à la terre/l'équipotentialité** des masses, en respectant l'ordre et le repérage du **brassage** ; ventilation si actifs. `[C]` ⟦dimension/organisation selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser baie/coffret ; organiser arrivées (opérateur/box). `[C]`
  2. Poser **panneaux de brassage** ; repérer. `[C]`
  3. **Mise à la terre / équipotentialité** des masses. `[A]` → [controler-mise-a-la-terre](../../../professions/electricite-generale/cards/controler-mise-a-la-terre.md)
  4. Gérer l'énergie/ventilation des actifs ; brassage propre. `[C]`
- **Points critiques** : **mise à la terre** des masses (sécurité/perturbations) ; brassage repéré/ordonné ; séparation énergie/données dans la baie.
- **Sécurité** : coexistence courants forts (PDU) ; ESD ; poids/manutention. **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Certification** : `cite-procedure` → [recette-certification-vdi](../../../procedures/reseaux-vdi/recette-certification-vdi.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:poser cluster:baie-de-brassage cluster:coffret-de-communication complexite:avancee type:installation securite:coexistence relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
