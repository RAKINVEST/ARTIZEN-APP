# Monitorer / diagnostiquer / contrôler

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `monitorer-diagnostiquer-controler` |
| Titre | Monitorer / diagnostiquer / contrôler |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : superviser la production, diagnostiquer les baisses de rendement et contrôler l'installation (mise en service/périodique). `[C]`
- **Résumé** : suivre la **production** (portail/monitoring, par chaîne/module), comparer aux attentes (météo/saison), repérer ombrages/salissures/défauts, et réaliser les **contrôles** (essais électriques **IEC 62446** à la mise en service et périodiques) ; toute intervention DC reste à haut risque. `[C]`

## Réalisation
- **Étapes** :
  1. Suivre la **production** (monitoring par chaîne/module). `[C]`
  2. Comparer aux attentes ; repérer **ombrage/salissure/défaut**. `[C]` → [baisse-production-pv](../../../diagnostics/photovoltaique/baisse-production-pv.md)
  3. Contrôles électriques (**IEC 62446**) mise en service/périodiques. `[B]` ⟦à confirmer⟧
  4. Nettoyage/maintenance (sans intervention DC à risque). `[C]` → [controle-maintenance-pv](../../../checklists/photovoltaique/controle-maintenance-pv.md)
- **Points critiques** : suivi de production (détecte les défauts tôt) ; contrôles normalisés ; intervention DC = habilité.
- **Sécurité** : DC (contrôles) ; toiture (nettoyage) ; électrique. **Tension continue (DC) permanente** : dès qu'il y a de la lumière, les **modules produisent** — on **ne peut pas supprimer totalement la tension** côté panneaux/chaîne DC en plein jour (couper l'AC **ne suffit pas**). **Arc électrique DC** : un arc DC **s'auto-entretient** (contrairement à l'AC) — connectique de qualité, **jamais débrancher un connecteur DC en charge**. **Consignation adaptée** : côté AC consignable (habilité), côté DC **procédure spécifique** — habilitation **photovoltaïque (BP/BR)**. **Incendie** : risque spécifique (dispositif de coupure d'urgence, sécurité des intervenants/pompiers). **Travail en toiture** : **chute** (protections/EPI), **manutention** des modules (lourds, prise au vent), météo. **Arrêt immédiat en cas de danger.** Opérations réservées à un professionnel **qualifié/habilité (RGE QualiPV)**.** `[A]`

## Cadre & suites
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-photovoltaique](../../../kits/photovoltaique/kit-photovoltaique.md)

## Relations & tags
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique intervention:controler intervention:diagnostiquer cluster:monitoring cluster:maintenance cluster:controle complexite:avancee type:controle securite:dc`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
