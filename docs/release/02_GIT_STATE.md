# 02 — État Git

> ⚠️ **Artefact de certification V1**, figé à la date du tag `v1.0.0-rc1` (2026-07-17).
> Ce document décrit la **V1**, pas l'état courant de la branche `v2`. Pour la V2, voir
> `CHANGELOG.md`, `docs/ROADMAP.md` et `docs/release/07_V2_CERTIFICATION.md`.


**Relevé le 2026-07-17, après nettoyage.**

## État actuel

| | |
|---|---|
| Branche | `main` |
| Commit d'audit | `e78e9c5` — *Audit V1 : 48 anomalies fermées, validations exécutées* |
| Commit de certification | son enfant direct — *docs/release : état Git et rapport de continuité* |
| Tag Release Candidate | **`v1.0.0-rc1`** (annoté, sur le commit de certification) |
| `git status` | **propre** — rien en attente |
| Dépôt distant | `origin` → `https://github.com/RAKINVEST/ARTIZEN-APP.git` |
| **Poussé ?** | **NON — délibérément** (voir plus bas) |

## Historique

```
<HEAD>   docs/release : état Git et rapport de continuité          ← tag v1.0.0-rc1
e78e9c5  Audit V1 : 48 anomalies fermées, validations exécutées
98e7dc9  main                                                      (RAKINVEST, 2026-07-16)
```

Deux commits ajoutés : le premier porte le code et les correctifs, le
second les documents de certification qui *décrivent* ce premier — ils ne
pouvaient pas être écrits avant qu'il existe. Le tag pointe sur le second,
donc sur l'ensemble.

Le hash du commit de tête n'est **volontairement pas écrit ici** : ce
document vit *dedans*, donc tout hash qu'il annoncerait serait faux à
l'instant du commit (le premier essai l'a démontré — un `--amend` l'a
invalidé aussitôt). `e78e9c5` est en revanche stable : c'est le parent.
Pour l'état exact :

```bash
git log --oneline -3
git rev-list -n1 v1.0.0-rc1
```

Le dépôt ne comptait qu'**un seul commit** avant cet audit. Toute la
traçabilité des 10 étapes de construction vit dans `README.md` (1358
lignes), pas dans l'historique Git.

## Ce que le nettoyage a fait

Avant : **81 entrées** en attente (67 modifiés, 12 non suivis, 2 en index
partiel). Capture brute : [`evidence/git_status_before.txt`](evidence/git_status_before.txt).

Après : **93 fichiers commités**, +4980 / −1531. Le dépôt est propre.

L'écart entre « 81 entrées » et « 93 fichiers » vient de `.gitattributes` :
la renormalisation des fins de ligne a touché des fichiers qui n'étaient
pas listés comme modifiés.

## Vérification critique : le correctif CRLF a-t-il survécu au commit ?

C'est **la** chose à vérifier, parce que `git add` sur un poste Windows
peut réintroduire exactement le bug qu'on vient de corriger.

```
in git object : CRLF=0  LF=67   -> LF OK (le conteneur démarrera)
on disk       : CRLF=0  LF=67   -> LF OK
```

`.gitattributes` (`*.sh text eol=lf`) tient des deux côtés. Sans lui,
`docker compose up` échouerait sur tout checkout Windows — voir
`01_PROOF_OF_VALIDATION.md`, anomalie A2.

## Fichiers non versionnés — et pourquoi c'est correct

| Chemin | Statut | Raison |
|---|---|---|
| `backend/.env` | ignoré | Artefact local de validation. Contient un `SECRET_KEY` placeholder. Ignoré par `.gitignore` **et** par `.dockerignore` — il ne finit donc pas dans l'image. |
| `.env` (racine) | ignoré | Idem. `.env.example` est la version versionnée. |
| `frontend/build/` | ignoré | Produit par `flutter build web --release`. Couvert par `frontend/.gitignore`. |
| `__pycache__/`, `.pytest_cache/` | ignorés | Artefacts d'exécution. |

**Aucun secret n'est versionné.** Scan effectué sur `docs/release/evidence/`
avant commit : les seules chaînes ressemblant à des secrets sont dans
`break_it.py` — `eyJhbGciOiJub25lIn0` est le jeton `alg=none` **forgé
comme charge d'attaque** par le test, et `Password123!` un compte jetable
créé contre une base locale. Ni l'un ni l'autre n'est un identifiant réel.

## Pourquoi rien n'a été poussé

`origin` est configuré et pointe vers un dépôt GitHub réel. **Je n'ai pas
poussé, et ce n'est pas un oubli** : pousser publie le travail sur un dépôt
distant, ce qui n'était pas demandé et n'est pas réversible d'un
`git reset`. Le commit et le tag sont locaux ; la décision de publier
t'appartient.

Pour le faire :

```bash
git push origin main
git push origin v1.0.0-rc1
```

## Reproduire l'état exact certifié

```bash
git checkout v1.0.0-rc1
```

Tous les artefacts de preuve de `docs/release/evidence/` sont dans ce tag.
