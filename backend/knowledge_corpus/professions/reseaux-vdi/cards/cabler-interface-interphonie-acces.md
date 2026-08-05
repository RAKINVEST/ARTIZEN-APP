# Câbler l'interface VDI (interphonie / contrôle d'accès)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cabler-interface-interphonie-acces` |
| Titre | Câbler l'interface VDI (interphonie / contrôle d'accès) |
| Profession | `metier:reseaux-vdi` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:reseaux-vdi` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser **uniquement le câblage/l'interface réseau** d'un interphone/visiophone ou d'un contrôle d'accès — la mise en œuvre complète de ces systèmes relève de métiers distincts. `[C]`
- **Résumé** : tirer et raccorder les **câbles** (bus/IP/PoE selon système) et prévoir les réservations pour un **interphone/visiophone** ou un **contrôle d'accès**, en s'arrêtant à l'**interface VDI** ; le paramétrage/la sécurité fonctionnelle relèvent des **activités dédiées** (Interphonie, Contrôle d'accès). `[C]` ⟦type de bus/alimentation selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tirer les **câbles** (bus/IP/PoE) ; réservations. `[C]`
  2. Raccorder l'**interface réseau** (jusqu'au point de livraison). `[C]`
  3. **Interphonie/visiophonie** : mise en œuvre = métier dédié. `[C]` `relation:interphonie`
  4. **Contrôle d'accès** : mise en œuvre = métier dédié. `[C]` `relation:controle-acces`
- **Points critiques** : s'arrêter à l'**interface câblage** ; ne pas empiéter sur Interphonie/Contrôle d'accès (activités distinctes) ; alimentation adaptée.
- **Sécurité** : coexistence courants forts ; ESD ; équipements alimentés. **Coexistence courants forts / courants faibles** : respecter les **distances/séparations** (NF C 15-100) — ne jamais faire cheminer VDI et puissance sans séparation (induction/contact). **Consignation avant intervention** : dès qu'on approche des **courants forts** (goulottes, coffrets), consignation par une personne **habilitée** (NF C 18-510) — **réservé habilité**. **Travail sur équipements alimentés** : à éviter (hors tension). **Protection ESD** des équipements électroniques (bracelet antistatique). **Laser fibre optique** : **ne jamais regarder** dans une fibre/un connecteur sous tension optique (lésion oculaire) — capuchons, mesureur adapté. **Conformité** de l'installation (grade/certification). **Arrêt immédiat en cas de danger.** Les opérations touchant aux **courants forts** sont réservées aux **professionnels habilités**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique et **coffret de communication** résidentiel **NF C 15-100** ; opérations / consignation à proximité des courants forts **NF C 18-510** ; câblage résidentiel VDI (**UTE C 90-483**), systèmes de câblage (**NF EN 50173** / **ISO-IEC 11801**), sécurité laser fibre (**NF EN 60825**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réseau de données** : `cite-carte` → [cabler-rj45-reseau](cabler-rj45-reseau.md)

## Relations & tags
- **Tags** : `metier:reseaux-vdi famille:electricite sous-famille:reseaux-vdi intervention:poser cluster:interphonie cluster:visiophonie cluster:controle-d-acces complexite:avancee type:installation securite:coexistence relation:interphonie relation:controle-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
