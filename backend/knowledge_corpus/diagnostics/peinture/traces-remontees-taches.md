# Traces / remontées de taches

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traces-remontees-taches` |
| Titre | Traces / remontées de taches |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Taches** qui réapparaissent à travers la peinture (jaunes, brunes, auréoles). `[C]`

## Causes probables
1. **Tanin** (bois), **nicotine**, feutre, suie remontant dans la finition. `[C]` → [appliquer-impression](../../professions/peinture/cards/appliquer-impression.md)
2. **Auréoles** d'humidité (fuite ancienne). `[C]`
3. Support non isolé avant finition. `[C]`

## Résolution
- Traiter la cause (humidité), appliquer un **fixateur/isolant** (anti-taches) puis refaire la finition. `[C]` → [peindre-murs-plafonds](../../professions/peinture/cards/peindre-murs-plafonds.md)

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [appliquer-impression](../../professions/peinture/cards/appliquer-impression.md).
- **Tags** : `metier:peinture famille:finition sous-famille:peinture probleme:taches cluster:impression cluster:diagnostics type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
