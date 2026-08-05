# Tuber et mettre en conformité un conduit

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `tuber-mettre-en-conformite-conduit` |
| Titre | Tuber et mettre en conformité un conduit |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:fumisterie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : **tuber** un conduit et le **mettre en conformité** (fumisterie) pour l'adapter à l'appareil. `[C]`
- **Résumé** : chemiser le conduit existant par un **tubage** (rigide/flexible inox, **NF EN 1856**) adapté à l'appareil et au combustible, assurer l'**étanchéité** et la **ventilation** de l'espace résiduel, traiter la **sortie de toit / souche** (étanchéité en couverture = **Couvreur**) et le débouché (hauteur au-dessus du faîtage) ; la mise en conformité respecte le **DTU 24.1** — sans opération réservée décrite pas à pas. `[C]` ⟦tubage/débouché selon DTU 24.1 à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir le **tubage** (inox, adapté appareil/combustible). `[C]`
  2. Assurer **étanchéité** + ventilation de l'espace résiduel. `[C]`
  3. **Souche / sortie de toit** = Couvreur (frontière). `[C]` → [traiter-noues-emergences](../../../professions/couverture/cards/traiter-noues-emergences.md)
  4. Vérifier le **débouché** (hauteur/faîtage). `[C]` → [fumee-odeur-condensation-conduit](../../../diagnostics/ramonage/fumee-odeur-condensation-conduit.md)
- **Points critiques** : tubage **adapté** (DTU 24.1) ; étanchéité/ventilation ; **souche = Couvreur** ; débouché conforme.
- **Sécurité** : hauteur (toiture) ; CO ; suie. **Monoxyde de carbone (CO)** : un conduit obstrué/mal tiré = **intoxication mortelle** — alerter en cas de symptômes (maux de tête, appareil qui refoule), contrôler le **tirage** et la **ventilation** de l'air comburant. **Feu de conduit** (**bistre** enflammé) : températures extrêmes, propagation — prévention par ramonage régulier ; ne jamais laisser un conduit encrassé. **Travail en hauteur** (toiture, souche) : échelle/échafaudage/harnais, fragilité de la couverture (l'accès en toiture relève aussi du **Couvreur**). **Poussières de suie** (cancérogènes) : aspiration/masque, protection ; bâchage intérieur. **Appareils à combustion** : le **raccordement** d'un poêle/insert/chaudière (gaz notamment) relève du **Chauffagiste** — non traité ici. **Amiante** (anciens conduits, joints, tresses) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Raccordement de l'appareil** : `cite-carte` → [raccorder-appareil-au-conduit](raccorder-appareil-au-conduit.md)

## Relations & tags
- **Tags** : `metier:ramonage famille:specialises sous-famille:fumisterie intervention:realiser cluster:tubage cluster:evacuation-fumees complexite:avancee type:installation securite:hauteur relation:couverture`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
