# Principe de l'étanchéité (toitures-terrasses, balcons)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-etancheite` |
| Titre | Principe de l'étanchéité (toitures-terrasses, balcons) |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle de l'étanchéité (mettre hors d'eau les surfaces planes/à faible pente) et ses familles de revêtements. `[C]`
- **Résumé** : l'étanchéité met hors d'eau **toitures-terrasses** et **balcons** ; familles : **membranes bitumineuses**, **membranes synthétiques** (PVC/EPDM/TPO), **SEL** (systèmes d'étanchéité liquide) et **résines** ; l'ouvrage vit avec ses **points singuliers** (relevés, acrotères, évacuations, pénétrations) et souvent un **isolant** support (le thermique relève du Livre Isolation). `[C]` ⟦choix système selon support/pente/destination à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Membranes bitumineuses** (bicouche soudé). `[C]` → [poser-membrane-bitumineuse](poser-membrane-bitumineuse.md)
  2. **Membranes synthétiques** (PVC/EPDM/TPO). `[C]` → [poser-membrane-synthetique](poser-membrane-synthetique.md)
  3. **SEL / résines** (balcons, points singuliers). `[C]` → [appliquer-sel-resine](appliquer-sel-resine.md)
  4. **Isolant support** éventuel (thermique). `[C]` → [principe-isolation](../../../professions/isolation/cards/principe-isolation.md)
- **Points critiques** : adapter le système au **support/pente/destination** ; soigner les **points singuliers** (où se produisent 90 % des fuites) ; pente/évacuation.
- **Sécurité** : hauteur/acrotère ; produits/chalumeau ; glissade ; stabilité des supports. **Travail en **hauteur** (toiture-terrasse, **acrotère**) : risque de **chute** — protections **collectives** (garde-corps/acrotère, filet) prioritaires, EPI antichute, **stabilité des supports** vérifiée. **Produits chimiques** (résines/SEL, primaires, solvants) et **chalumeau** (bitume soudé) : brûlure/incendie/inhalation → EPI, **extincteur**, ventilation, pas de flamme près d'inflammable. **Glissade** (membrane humide/gelée) : semelles adaptées. **Météo** (pluie/gel/rosée/vent) surveillée. **Arrêt immédiat en cas de danger.** Une intervention d'étanchéité relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Points singuliers** : `cite-carte` → [traiter-penetrations-points-singuliers](traiter-penetrations-points-singuliers.md)

## Relations & tags
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite intervention:comprendre cluster:terrasses cluster:balcons cluster:membranes-bitumineuses cluster:membranes-synthetiques cluster:sel cluster:resines type:principe securite:hauteur relation:isolation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
