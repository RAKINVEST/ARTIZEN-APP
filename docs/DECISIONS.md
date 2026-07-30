# Décisions d'architecture — Artizen

> Ce document fige les règles qui **ne se rediscutent pas**. Elles ont été choisies parce
> qu'elles sont coûteuses à changer plus tard : elles déterminent la forme des données, la
> répartition des responsabilités et les garanties juridiques du produit.
>
> Tout le reste — écrans, dossiers, fonctionnalités, prix, libellés — peut évoluer librement.
> Ces neuf décisions, non.
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

**Une activité ne pilote que l'import, jamais la vie du catalogue.** Une fois les packs
copiés, l'artisan change les prix, réécrit les libellés, ajoute et supprime des articles :
ce n'est plus « le catalogue Plomberie », c'est **son** catalogue (décision 1). Désactiver
une activité **n'efface donc aucun article** — Artizen ne supprime pas les données de
l'artisan ; il retire seulement la source de l'import.

**Mise à jour par version, comme un store d'applications.** Chaque activité et qualification
porte un **numéro de version**, et l'entreprise mémorise la version qu'elle a importée. Trois
états : *disponible* (jamais importée), *importée* (à jour), *mise à jour disponible* (une
version plus récente existe en code). Détecter les mises à jour **par version** et non par
différence d'articles est le seul modèle fiable : un diff signalerait chaque article que
l'artisan a supprimé comme « manquant » pour toujours. La mise à jour est **additive** — elle
n'ajoute que les articles absents, sans jamais toucher aux prix personnalisés — et le même
geste d'import sert d'import initial et de mise à jour.

**Conséquences.**
- `Company.activities` et `Company.qualifications` : `{slug: {version, imported_at}}` en JSONB.
- `Activity.version` / `Qualification.version` : à incrémenter **délibérément** quand on
  publie de nouveaux articles — c'est ce geste, et lui seul, qui fait apparaître la mise à
  jour chez les artisans.
- `Company` porte déjà `rge_number` (une qualification est aussi une mention du PDF) ; à terme,
  validité/expiration des qualifications (RGE et PG se renouvellent).
- Ajouter une qualification plus tard = ajouter un **paquet de données**, pas un nouveau métier.

---

## Décision 8 — ARTIZEN protège l'identité documentaire autant qu'il la restitue

**Règle.** À l'import d'un devis, le produit **vérifie que l'identité extraite
(raison sociale, SIREN/SIRET) est celle du compte** avant de la reproduire.
Concordance → restitution **silencieuse**. Discordance ou identité absente →
**déclaration sur l'honneur** de l'artisan, dans un **workflow progressif**
(avertir → confirmer → au plus, blocage en douceur), **jamais un blocage brutal**
sur un simple écart de SIRET. Tout PDF émis porte un **filigrane interne de
traçabilité**, et un **canal de signalement / retrait** existe. La **détection
inter-comptes par empreinte (fingerprint) est différée** à une phase ultérieure.

**Pourquoi.** La promesse ([BRAND.md](BRAND.md)) — *ARTIZEN retrouve votre
identité* — devient un **risque** si quelqu'un importe le devis d'un **tiers**.
Les fondements juridiques (contrefaçon de logo/marque, concurrence déloyale,
parasitisme, usurpation) supposent **tous** l'identité d'un tiers : ils
s'effondrent si ARTIZEN garantit qu'on restitue la **propre** identité de
l'artisan. Mais le SIRET peut **légitimement** différer (rachat, changement de
forme sociale, franchise, groupe, cabinet comptable) — donc la vérification
**avertit et fait confirmer, elle ne bloque pas** : un faux positif (soupçonner un
client honnête) coûte plus qu'un vrai négatif rare. Étude complète :
[docs/ETUDE-SECURISATION-JURIDIQUE.md](ETUDE-SECURISATION-JURIDIQUE.md).

**Conséquences.**
- La vérification n'est **pas** une barrière anti-fraude : c'est la promesse
  rendue concrète — *« on s'assure de restituer **votre** identité »*. En **langue
  artisan** (BRAND.md, deux langues), jamais « fraude » ni « contrôle » :
  - concordance → *« Nous avons reconnu votre entreprise. Nous allons reproduire
    votre identité documentaire. »*
  - discordance → *« Ce document semble appartenir à une autre entreprise. Si vous
    en avez les droits (changement de société, rachat, franchise…), vous pouvez
    poursuivre après confirmation. »*
- La donnée nécessaire (SIREN/SIRET, raison sociale) est **déjà extraite** par
  `document_detection` ; le compte porte déjà son SIRET. Un contrôle **Sirene**
  (INSEE) fiabilise la concordance.
- La déclaration sur l'honneur est **horodatée et journalisée** : responsabilité
  de l'utilisateur **et** diligence d'ARTIZEN (élément de défense).
- RGPD : minimisation, empreinte future **non réversible**, **non-divulgation
  croisée** (on signale un conflit, jamais *qui*), **pas de décision purement
  automatisée** sur un blocage.
- **Aucun écran ni workflow n'est figé ici** : la règle fige le *principe* et la
  *politique*, pas l'implémentation. Elle se concrétise feature par feature,
  chacune passant les portes de BRAND.md.

---

## Décision 9 — Build Product, Not Infrastructure : l'hébergeur est un fournisseur remplaçable

**Règle.** La production tourne sur un **PaaS managé souverain** (**Scalingo**, France) :
TLS, PostgreSQL, sauvegardes, restaurations, mises à jour système, redémarrages et
supervision sont **délégués**. ARTIZEN **n'exploite pas de serveurs**. Corollaire non
négociable : **aucun composant métier ne dépend directement d'un fournisseur externe.**
Tout service tiers — e-mail, stockage, IA, et demain notification / monitoring — passe par
une **interface** (`*Provider`) sélectionnée par configuration ; le fournisseur concret est
un détail d'`.env`, jamais un `import` dans un module métier. L'hébergeur n'est **qu'un
hébergeur** : on doit pouvoir en changer avec un `pg_dump` et un `Dockerfile`.

**Pourquoi.** Pendant les premières années, la ressource rare n'est pas l'argent, c'est le
**temps de cerveau du fondateur**. Chaque heure passée à renouveler un certificat, patcher un
OS ou restaurer une base est une heure qui ne vend pas le produit. Payer un PaaS pour
supprimer ces tâches est un **échange délibéré** : quelques dizaines d'euros par mois contre
des journées d'exploitation — et contre le risque le plus dangereux d'un lanceur solo (une
sauvegarde oubliée = perte irréversible). Et la seule protection réelle contre le *lock-in*
n'est pas de choisir « le bon » fournisseur, c'est de rendre le fait d'**en changer trivial** :
c'est l'abstraction, pas le contrat, qui garantit la liberté.

**Conséquences.**
- Toute décision d'exploitation privilégie le **gain de temps de développement** sur
  l'économie de quelques euros par mois — *« nous achetons du temps de cerveau »*.
- Les seams existent déjà et sont **vérifiés par audit** : `EmailProvider`, `StorageProvider`,
  `AIProvider` sont des ABC + factory sélectionnées par `settings.*`. Le seul SDK fournisseur
  du backend (`anthropic`) est **confiné** à `ai/providers/anthropic_provider.py`, derrière
  `AIProvider`, avec repli sur un mock déterministe.
- Les services **sans SDK** le restent volontairement : e-mail via `smtplib` standard
  (Brevo / Postmark / SES = un `.env`), base via SQLAlchemy + `pg_dump` (PostgreSQL standard),
  **monitoring** via `/health` + logs stdout (n'importe quelle sonde), **sauvegardes** via
  `pg_dump` / `tar` (destination configurable). Aucun ne verrouille ARTIZEN à un fournisseur.
- **Notification** : aucune fonctionnalité en V1 → aucun couplage. Le jour venu, un
  `NotificationProvider` suit le même patron.
- **Un seul ajout à l'activation**, et c'est un *usage* de la règle, pas une entorse : le
  système de fichiers d'un conteneur PaaS est **éphémère**, donc `LocalStorageProvider` doit
  céder la place à un `S3StorageProvider` (API S3, standard multi-fournisseurs EU) — une
  **nouvelle classe derrière `StorageProvider`** + `STORAGE_PROVIDER=s3`, exactement ce que le
  seam prévoit, **zéro** code appelant modifié.
- Ajouter un fournisseur = **une classe derrière l'interface + une ligne de config**. Jamais
  un `import` de vendor dans un module métier.

---

## Ce que ces décisions excluent volontairement

- ❌ Un catalogue partagé entre artisans.
- ❌ Une étape « choisir le métier » dans le parcours de devis.
- ❌ Un calcul de montant côté client, sous quelque forme que ce soit.
- ❌ La modification d'un devis émis, et le versionnage des devis.
- ❌ Une ligne de devis dépendante du catalogue après sa création.
- ❌ Un mode hors-ligne complet en V1.
- ❌ Un dossier réservé à une qualification chargé par défaut.
- ❌ Un blocage brutal sur un simple écart de SIRET (les usages légitimes priment).
- ❌ La reproduction assumée de l'identité documentaire d'un tiers.
- ❌ Un vocabulaire de fraude ou de contrôle face à l'artisan.
- ❌ La détection inter-comptes par empreinte en Phase 1 (différée, sensible RGPD).
- ❌ Un composant métier qui importe directement le SDK d'un fournisseur externe.
- ❌ L'auto-exploitation de serveurs (OS, TLS, sauvegardes manuelles) en V1.

---

## Le fil rouge

Artizen n'est pas un logiciel de devis, c'est un **assistant métier** dont le devis est la
conséquence. D'où la règle d'or qui filtre toutes les décisions suivantes :

> **Si une fonctionnalité ne fait pas gagner du temps à l'artisan ou ne rend pas son travail
> plus simple, elle n'a pas sa place dans Artizen.**
