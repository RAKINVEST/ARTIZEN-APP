# Décisions d'architecture — Artizen

> Ce document fige les règles qui **ne se rediscutent pas**. Elles ont été choisies parce
> qu'elles sont coûteuses à changer plus tard : elles déterminent la forme des données, la
> répartition des responsabilités et les garanties juridiques du produit.
>
> Tout le reste — écrans, dossiers, fonctionnalités, prix, libellés — peut évoluer librement.
> Ces sept décisions, non.
>
> Chaque décision indique **la règle**, **le pourquoi** (le raisonnement, pas seulement le
> choix) et **ce qu'elle implique dans le code**. Un développeur qui arrive doit pouvoir
> comprendre ce qui est intouchable et *pourquoi*, sans avoir à refaire le débat.

---

## Décision 1 — Le catalogue appartient à l'artisan

**Règle.** Chaque entreprise possède son propre catalogue. Les catalogues métiers ne sont
qu'un **point de départ copié** au moment où l'artisan active une activité. Il n'existe
aucun catalogue « officiel » partagé sur lequel un artisan travaillerait.

**Pourquoi.** Les prix, les désignations et les habitudes diffèrent d'un artisan à l'autre :
un taux horaire de plombier n'est pas celui du voisin. Un catalogue parent partagé
obligerait à une table de surcharge pour chaque prix modifié — c'est-à-dire pour tous. Et
une référence qui évolue changerait silencieusement le catalogue d'un artisan des mois plus
tard.

**Conséquences.**
- `CatalogCategory` et `CatalogItem` sont scopés par `company_id` — c'est déjà le cas.
- Les catalogues métiers (`catalog/trades/`) sont des **données**, pas des lignes en base :
  ils sont copiés à l'import, jamais consultés ensuite.
- Enrichir un catalogue métier dans une version future **ne modifie aucun catalogue existant**.
- Les prix des catalogues métiers sont des ordres de grandeur du marché, **faits pour être
  corrigés** — jamais une recommandation.

---

## Décision 2 — Le métier est une propriété de l'entreprise, pas une étape du devis

**Règle.** L'artisan déclare ses **activités** une fois, dans la configuration de son
entreprise. Elles déterminent le contenu de son catalogue. Le parcours de création d'un
devis ne demande **jamais** « quel métier ? ».

**Pourquoi.** Un plombier est plombier tous les jours ; lui poser la question à chaque devis
est un clic qui ne fait rien gagner. Un artisan multi-activités (plomberie + chauffage +
climatisation) travaille dans **un catalogue unifié**, comme sa camionnette contient les
deux jeux d'outils — pas deux camionnettes.

**Conséquences.**
- Le catalogue est l'**union** des activités activées, trié alphabétiquement, avec recherche.
- Un filtre par activité peut exister, mais **optionnel et jamais bloquant**.
- Ajouter une activité plus tard (Paramètres) ajoute les dossiers correspondants.

---

## Décision 3 — Le backend est l'unique source de vérité

**Règle.** Tous les montants, taxes, arrondis et transitions d'état sont déterminés côté
serveur. Le client **affiche** ce que le backend renvoie ; il ne calcule jamais un montant.

**Pourquoi.** L'écran, le PDF et la future facture doivent porter exactement les mêmes
chiffres. Le jour où deux implémentations calculent, elles divergent — et c'est le client
qui découvre l'écart, sur un document contractuel.

**Conséquences.**
- `quotes/calculator.py` reste le **seul** endroit où un montant est calculé. Tout en
  `Decimal`, jamais `float`. Arrondi `ROUND_HALF_UP` **par ligne**, puis somme (convention
  française).
- `POST /quotes/calculate` chiffre un brouillon en direct **sans rien persister**, pour que
  l'édition pas-à-pas n'oblige jamais le client à additionner quoi que ce soit.
- Toute nouvelle surface (facture, avoir, bon de commande) passe par le même calculateur.

---

## Décision 4 — Le brouillon et le devis sont deux objets métier différents

**Règle.**

| | Brouillon | Devis |
|---|---|---|
| Modifiable | ✅ librement | ❌ jamais |
| Numéroté | ❌ | ✅ `DEV-2026-0001` |
| Supprimable | ✅ | uniquement avant envoi |
| Valeur juridique | aucune | document contractuel |

« Créer le devis » signifie littéralement **transformer le brouillon en document officiel**.

**Pourquoi.** Un devis émis est un engagement contractuel : il ne doit jamais changer après
coup. Mais l'artisan a besoin de construire son chiffrage en plusieurs fois, de revenir en
arrière, de reprendre plus tard. Séparer les deux objets donne les deux garanties sans
compromis — au lieu d'un devis « à moitié modifiable » dont les totaux pourraient ne plus
correspondre aux lignes.

Corriger un devis émis = en créer un nouveau (duplication). **Pas de versionnage** : savoir
laquelle des versions a été envoyée, signée, acceptée crée plus de problèmes que ça n'en
résout.

**Conséquences.**
- Le numéro est attribué **à la transformation**, jamais à la création du brouillon.
- Un brouillon supprimé ne laisse donc **aucun trou** dans la séquence des numéros.
- Le compteur reste verrouillé `FOR UPDATE` — jamais un `SELECT MAX+1`.
- `QUOTE_TRANSITIONS` continue de régir les états d'un devis émis ; rien ne revient jamais
  en arrière.

---

## Décision 5 — Chaque ligne est une photographie autonome

**Règle.** Dès qu'un article est ajouté à un brouillon, ses informations sont **copiées** :
désignation, unité, quantité, prix unitaire, TVA. La ligne ne dépend plus du catalogue.
Modifier un prix, changer une TVA ou supprimer un article du catalogue **ne modifie jamais**
un brouillon ou un devis existant.

Une ligne peut provenir :
- d'un **article du catalogue** (le lien vers l'article n'est qu'une trace d'origine) ;
- d'une **ligne libre** saisie de zéro (péage, stationnement, location, intervention
  exceptionnelle).

Un prix peut différer de celui du catalogue. Le catalogue n'est mis à jour que si l'artisan
choisit **explicitement** « Enregistrer ce nouveau prix ».

**Pourquoi.** Un devis est un document daté : il doit rester lisible et justifiable des
années plus tard, tel qu'il a été émis. Et un artisan ne peut pas être prisonnier de son
catalogue quand un chantier sort de l'ordinaire.

**Conséquences.**
- `QuoteLine` stocke déjà `designation`, `unit`, `quantity`, `unit_price_ht`, `vat_rate` —
  ce principe y est donc déjà appliqué.
- `catalog_item_id` doit devenir **nullable** et non contraignant (`SET NULL`) : c'est une
  trace, pas une dépendance. **Sans ce changement, l'artisan ne peut pas réellement
  supprimer un article de son catalogue** une fois qu'un devis l'a utilisé.
- La ligne accepte un prix unitaire fourni, mais **le calculateur reste seul à calculer les
  totaux** (décision 3 intacte).
- Une remise et un acompte ne sont **pas** des lignes de catalogue : une ligne à prix négatif
  changerait la sémantique du calcul (arrondi par ligne). Ce sont des champs du devis.

---

## Décision 6 — Connectivité : en ligne requis en V1

**Règle.** Une connexion Internet est nécessaire pour créer et modifier un devis. Le mode
hors-ligne complet **n'est pas implémenté en V1** et sera réévalué sur retours d'usage.

En cas de perte de connexion, l'application l'annonce clairement — et **ne détruit pas le
travail en cours** :

> « Connexion perdue. Les modifications seront possibles dès que la connexion sera rétablie. »

**Pourquoi.** Le cas problématique (cave, vide sanitaire, campagne sans réseau) existe, mais
la majorité des devis se chiffrent au bureau ou dans la camionnette en 4G. Le hors-ligne
complet — stockage local, synchronisation, conflits, versions, restauration — est
pratiquement une seconde application. L'investir avant d'avoir prouvé le besoin serait le
plus gros pari du projet.

**Conséquences.**
- Ne pas confondre « pas de mode hors-ligne » et « perdre le travail de l'artisan » : un
  brouillon en cours doit **survivre à une coupure passagère** et se resynchroniser.
- La décision 5 (lignes autonomes) rend un futur passage au hors-ligne **facile** : un
  brouillon dont chaque ligne se suffit à elle-même est déjà prêt à vivre sur l'appareil.
- À revalider après la bêta privée, avec des faits.

---

## Décision 7 — Activités et qualifications

**Règle.** Deux notions distinctes configurent l'entreprise :

- **Activités** — ce que fait l'entreprise (plomberie, chauffage, climatisation,
  électricité, peinture…). Elles déterminent les **grands catalogues**.
- **Qualifications** — ce qu'elle est **autorisée ou certifiée** à faire (PG, RGE, QualiPAC,
  QualiBois, QualiPV, IRVE…). Elles **enrichissent** les catalogues avec les dossiers et
  articles qui leur sont propres.

Un dossier réservé à une qualification (Gaz, réservé aux certifiés PG) n'est **jamais**
chargé par défaut.

**Pourquoi.** Séparer les deux évite l'explosion combinatoire : sans cette distinction il
faudrait un métier « plombier », « plombier-PG », « plombier-RGE », « plombier-PG-RGE »… Et
surtout : proposer un article de gaz à un artisan non certifié PG mettrait dans son devis une
prestation qu'il **n'a pas le droit d'exécuter**.

**Le double rendement.** Une qualification n'est pas qu'un contenu de catalogue, c'est aussi
une **mention légale du devis** : sans n° RGE affiché, le client ne peut prétendre ni à
MaPrimeRénov' ni aux CEE ; le gaz exige la certification PG. La même saisie alimente donc le
catalogue **et** les mentions obligatoires du PDF.

**Conséquences.**
- `Company` porte déjà `rge_number` — à généraliser en liste de qualifications (identifiant,
  numéro, et à terme validité).
- `TradeCategory.optional` marque les dossiers conditionnés à une qualification.
- Ajouter une qualification plus tard = ajouter un **paquet de données**, pas un nouveau métier.

---

## Ce que ces décisions excluent volontairement

- ❌ Un catalogue partagé entre artisans.
- ❌ Une étape « choisir le métier » dans le parcours de devis.
- ❌ Un calcul de montant côté client, sous quelque forme que ce soit.
- ❌ La modification d'un devis émis, et le versionnage des devis.
- ❌ Une ligne de devis dépendante du catalogue après sa création.
- ❌ Un mode hors-ligne complet en V1.
- ❌ Un dossier réservé à une qualification chargé par défaut.

---

## Le fil rouge

Artizen n'est pas un logiciel de devis, c'est un **assistant métier** dont le devis est la
conséquence. D'où la règle d'or qui filtre toutes les décisions suivantes :

> **Si une fonctionnalité ne fait pas gagner du temps à l'artisan ou ne rend pas son travail
> plus simple, elle n'a pas sa place dans Artizen.**
