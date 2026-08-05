# Distribuer la télévision et la téléphonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `distribuer-tv-telephonie` |
| Titre | Distribuer la télévision et la téléphonie |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : distribuer les signaux TV (TNT/satellite) et la téléphonie depuis le coffret de communication. `[C]`
- **Résumé** : raccorder l'arrivée TV (antenne/satellite/box) via un **répartiteur/amplificateur** si besoin vers les prises TV, et la **téléphonie** (aujourd'hui souvent en IP via RJ45/box), en respectant les niveaux de signal et le grade du coffret. `[C]` ⟦répartition/amplification selon signal à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder l'arrivée **TV** (antenne/satellite/box). `[C]`
  2. **Répartir/amplifier** si besoin vers les prises TV. `[C]` ⟦niveaux à confirmer⟧
  3. **Téléphonie** (IP via RJ45/box aujourd'hui). `[C]` → [cabler-rj45-reseau](cabler-rj45-reseau.md)
  4. Vérifier niveaux de signal / qualité. `[C]`
- **Points critiques** : niveaux de signal (ni trop faible ni saturé) ; grade du coffret ; téléphonie majoritairement **IP** désormais.
- **Sécurité** : coexistence courants forts ; ESD ; toiture (antenne = autre corps d'état). **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Coffret** : `cite-carte` → [installer-baie-coffret-brassage](installer-baie-coffret-brassage.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:poser cluster:television cluster:telephonie complexite:moyenne type:installation securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
