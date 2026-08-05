# Tester et certifier un réseau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `tester-certifier-reseau` |
| Titre | Tester et certifier un réseau |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : tester et **certifier** un réseau VDI (mesures de conformité, PV de recette). `[C]`
- **Résumé** : tester chaque lien avec un **certificateur** (câblage cuivre : mapping, longueur, affaiblissement, diaphonie ; fibre : affaiblissement), comparer aux exigences de la **catégorie/classe**, corriger les défauts et établir le **PV de certification** ; un test simple (continuité) ne vaut pas une certification. `[C]` ⟦catégorie/paramètres selon norme à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tester chaque lien au **certificateur** (mapping/longueur/diaphonie). `[C]`
  2. Comparer aux exigences de **catégorie/classe**. `[C]` ⟦à confirmer⟧
  3. Corriger les défauts (connectique/cheminement). `[C]` → [pas-de-connexion-rj45](../../../diagnostics/reseaux-vdi/pas-de-connexion-rj45.md)
  4. Établir le **PV de certification** (recette). `[C]` → [recette-certification-vdi](../../../procedures/reseaux-vdi/recette-certification-vdi.md)
- **Points critiques** : **certification** (pas un simple test de continuité) ; conformité à la catégorie/classe ; PV/traçabilité.
- **Sécurité** : ESD ; coexistence courants forts. **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle/maintenance** : `a-checklist` → [controle-maintenance-vdi](../../../checklists/reseaux-vdi/controle-maintenance-vdi.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:controler cluster:tests-et-certification cluster:cablage-rj45 complexite:avancee type:controle securite:coexistence`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
