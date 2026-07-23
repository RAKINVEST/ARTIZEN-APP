# Critères de réussite — SUCCESS CRITERIA

Le dernier document de gouvernance. Il répond à **une seule question** :

> À quel moment considérerons-nous que le programme d'extraction est **réussi** ?

La réussite n'est pas « le code est écrit » ni « ça marche sur mon PDF ». C'est
une barre **mesurable**, franchie par les données, pas déclarée par une opinion.

## Les critères (tous doivent être vrais)

1. **Tous les critères de sortie de la Phase R&D sont atteints**
   (`python benchmark.py --phase`) : Starter Corpus complet, 50 références
   certifiées, fidélité ≥ 99 %, couverture ≥ 95 %, auto-pass ≥ 90 %, validation
   ≤ 20 s, 0 régression sur 3 versions.
2. **Aucun des 6 KPI n'est sous son seuil** — fidélité, couverture, confiance,
   temps de validation, auto-pass, accord inter-annotateurs.
3. **Le benchmark officiel est stable sur plusieurs versions** — même empreinte
   de résultats aux tolérances près, sans régression détectée (`--gate`,
   `--replay`), sur au moins trois versions consécutives.
4. **Toutes les inconnues *critiques* sont résolues ou explicitement acceptées**
   ([UNKNOWNS.md](UNKNOWNS.md)) — aucune question critique ne reste ouverte sans
   décision assumée.

## Ce que ce document n'est pas

* Ce n'est pas une promesse de perfection : 100 % n'est pas le critère, les seuils
  le sont.
* Ce n'est pas figé dans le marbre des chiffres : les seuils (dont le 99 %) sont
  empiriques et recalibrables — mais tout changement est un **amendement daté**
  ([DECISION_LOG.md](DECISION_LOG.md)), jamais un glissement discret.
* Ce n'est **pas** un feu vert pour étendre le périmètre : la réussite se juge
  **sur les devis d'abord** (ADR-015). Les autres documents viendront après.

## Statut

**v1.0 — figée.** Quand ces quatre critères sont simultanément vrais, le programme
d'extraction passe de *R&D* à *Production*, et cette décision est inscrite en ADR.
