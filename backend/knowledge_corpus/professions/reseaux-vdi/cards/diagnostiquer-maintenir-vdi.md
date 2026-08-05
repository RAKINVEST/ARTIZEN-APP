# Diagnostiquer / maintenir un réseau VDI

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-maintenir-vdi` |
| Titre | Diagnostiquer / maintenir un réseau VDI |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer les pannes et maintenir un réseau VDI résidentiel (connexion, débit, brassage). `[C]`
- **Résumé** : identifier une panne (pas de lien, débit faible, coupures) en isolant le segment (prise/câble/brassage/actif), tester, corriger la connectique/le brassage, documenter, et maintenir à jour le repérage/la certification après modification. `[C]`

## Réalisation
- **Étapes** :
  1. Isoler le segment (prise / câble / **brassage** / actif). `[C]` → [pas-de-connexion-rj45](../../../diagnostics/reseaux-vdi/pas-de-connexion-rj45.md)
  2. Tester (certificateur/testeur) ; vérifier la fibre. `[C]` → [defaut-affaiblissement-fibre](../../../diagnostics/reseaux-vdi/defaut-affaiblissement-fibre.md)
  3. Corriger connectique/brassage ; contrôler la **séparation** courants forts. `[C]` → [interference-courants-forts](../../../diagnostics/reseaux-vdi/interference-courants-forts.md)
  4. Documenter (repérage/certification à jour). `[C]`
- **Points critiques** : méthode par isolement de segment ; repérage/documentation à jour ; ne pas dégrader la certification.
- **Sécurité** : coexistence courants forts ; ESD ; équipements alimentés. **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-courants-faibles](../../../kits/reseaux-vdi/kit-courants-faibles.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:diagnostiquer intervention:entretenir cluster:diagnostic cluster:maintenance cluster:reseaux-residentiels complexite:moyenne type:diagnostic securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
