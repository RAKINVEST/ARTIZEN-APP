# DICT, protection sanitaire de l'eau & essais avant travaux d'arrosage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `dict-protection-eau-essais-avant-travaux-arrosage` |
| Titre | DICT, protection sanitaire de l'eau & essais avant travaux d'arrosage |
| Profession | `metier:arrosage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser les tranchées (réseaux), l'électricité, la protection de l'eau potable et les essais — sans raccordement réglementé ni retrait d'amiante. `[A]`

## Étapes
1. **DT-DICT** : repérer les **réseaux enterrés** avant toute tranchée. `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
2. **Protection sanitaire de l'eau** : **disconnecteur / clapet anti-retour obligatoire** (NF EN 1717) ; raccordement détaillé = **Plomberie**. `[A]` → [poser-robinet-arret](../../professions/plomberie/cards/poser-robinet-arret.md)
3. **Raccordement électrique** (programmateur/électrovannes) = **interface** Électricité (jamais réalisé ici). `[A]`
4. **Essais** : mise sous pression progressive (purge d'air), contrôle d'étanchéité secteur par secteur. `[A]`
5. **Rénovation** : revêtements anciens → **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : raccordement à l'eau potable + **protection anti-retour** (**interface** plomberie) **DTU 60.1** ; alimentation du programmateur / électrovannes (**interface** électricité) **NF C 15-100** ; **protection contre les retours d'eau** (disconnecteur) **NF EN 1717**, tube **PE** **NF EN 12201**, réglementation **DT-DICT** (réseaux) et règlement du service des eaux ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [essayer-regler-mettre-en-service](../../professions/arrosage/cards/essayer-regler-mettre-en-service.md).
- **Tags** : `metier:arrosage famille:specialises sous-famille:securite intervention:securiser cluster:essais cluster:reglementation type:procedure securite:reseaux securite:eau securite:amiante relation:desamiantage relation:plomberie relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
