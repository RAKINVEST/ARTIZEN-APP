# Conduite à tenir : arrêt, signalement, orientation (décision)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `conduite-arret-signalement-orientation` |
| Titre | Conduite à tenir : arrêt, signalement, orientation (décision) |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Fixer la **conduite à tenir** face à l'amiante : arrêt, signalement, repérage, orientation — **décision**, jamais retrait/confinement. `[A]`

## Étapes (décision / organisation — aucune opération réservée)
1. **Reconnaître** le doute (matériau susceptible, avant 1997). `[A]` → [reconnaitre-materiaux-mpca](../../professions/desamiantage/cards/reconnaitre-materiaux-mpca.md)
2. **Arrêt immédiat** ; ne rien disperser (percer/poncer/casser/déplacer interdits). `[A]`
3. **Isoler / baliser** ; **protéger les occupants**. `[A]`
4. **Signaler** au maître d'ouvrage ; **faire repérer/analyser** (diagnostiqueur/labo). `[A]`
5. **Orienter** vers une **entreprise certifiée** (SS3) / personnel formé (SS4). `[A]`
6. **Tracer** la décision (DTA / registre). `[C]` `relation:diagnostic`

> **Aucun mode opératoire de retrait, confinement ou démontage** n'est fourni : ce contenu **décide et oriente**, il n'exécute pas. `[A]`

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:securite intervention:securiser cluster:arret-travaux cluster:orientation type:procedure securite:amiante relation:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
