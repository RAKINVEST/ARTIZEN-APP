# L'âme d'ARTIZEN — la Constitution de la marque

> Ce n'est ni un document marketing, ni une charte de ton. C'est la
> **Constitution de la marque** : les règles fondamentales auxquelles le produit
> reste fidèle, même lorsque l'équipe, la technologie ou les modèles d'IA
> évoluent. Avant chaque écran, chaque texte, chaque fonctionnalité — on relit
> ceci.
>
> C'est aujourd'hui **le document le plus important du projet.** La technologie
> évoluera, les modèles d'IA évolueront, le moteur changera — mais tant que ce
> document reste stable, toute évolution technique continuera de servir la même
> promesse.

---

## La vraie différence

Au début, on croyait que la différence d'ARTIZEN était *l'IA*. Puis *le moteur
documentaire*. Puis *le laboratoire de validation*. Ce n'est aucun des trois.

> ### Les autres logiciels demandent à l'artisan de s'adapter au logiciel.
> ### ARTIZEN s'adapte à l'artisan.

Et son corollaire, qui résume tout le projet — le moteur, l'import, la restitution
fidèle, le refus des modèles imposés, et même toute l'architecture R&D :

> **L'artisan ne doit jamais avoir l'impression d'apprendre ARTIZEN.**
> **ARTIZEN doit donner l'impression d'avoir appris l'artisan.**

C'est cette phrase qu'il faut protéger pendant dix ans.

---

## 1. Notre conviction

Un devis n'est pas un simple document administratif.

C'est souvent le **premier contact** entre un artisan et son client. Il reflète
son sérieux, son savoir-faire, son identité.

**Chaque devis laisse une empreinte.**

---

## 2. Notre promesse

Une seule phrase. Gravée.

> **ARTIZEN retrouve votre identité et la restitue dans chacun de vos devis.**

Cette phrase ne change plus. Jamais.

---

## La règle d'or — « Je ne vois pas la différence avec le mien »

La promesse ci-dessus a **un test**, un seul, et il est impitoyable. Le plus beau
compliment qu'un artisan puisse faire à ARTIZEN n'est pas :

> « Le devis est plus beau. »

C'est :

> ### « Je ne vois pas la différence avec le mien. »

Posez le devis original de l'artisan et celui restitué par ARTIZEN **côte à
côte**. S'il peut désigner lequel est le sien, **la promesse est rompue.** « Plus
beau », « plus lisible », « plus moderne » ne sont pas des compliments : ce sont
des **ruptures de promesse**. L'artisan ne veut pas *un plus beau devis* — il veut
*son devis*.

Cette règle est **supérieure à toute considération esthétique et à toute décision
technique**. La restitution **n'interprète jamais, elle redessine** : moderniser,
réorganiser, harmoniser, « refaire dans le même esprit » sont des **régressions**,
pas des améliorations. Avant chaque évolution du moteur, une seule question :

> *Un artisan reconnaîtrait-il lequel est l'original ?* — si oui, le travail
> n'est pas terminé.

Le détail technique de cette loi — la liste des interdits, la checklist « à
l'identique », les critères de validation — vit dans la constitution du renderer
([REPRODUCTION_SPEC](../backend/app/document_clone/REPRODUCTION_SPEC.md)).

---

## 3. Ce que nous ne sommes pas

- ARTIZEN **n'est pas** un générateur de devis.
- ARTIZEN **n'impose pas** ses modèles.
- ARTIZEN **ne remplace pas** votre identité.

**ARTIZEN révèle la vôtre.**

> Les autres disent : *« Personnalisez vos devis. »*
> ARTIZEN dit : *« Nous ne personnalisons pas votre devis — nous retrouvons le vôtre. »*

Cette nuance est tout le produit. Elle guide chaque décision : dès qu'une idée
nous pousse à *imposer*, *standardiser* ou *générer à notre façon*, elle trahit la
promesse.

---

## 4. Notre vocabulaire

Le vocabulaire façonne la marque. Certains mots sont **interdits** dans le
produit, la doc, le site et les présentations :

| ❌ À bannir | ✅ À employer |
|---|---|
| Générer | Restituer |
| Template / modèle générique | Signature |
| Cloner | Retrouver |
| Copier | Empreinte |
| Standardiser | Identité |
| Automatisation | Savoir-faire · Continuité |

Note interne : le format technique `.artizen`, le « moteur » et l'« extraction »
sont des termes **d'ingénierie**, réservés au code et à la doc technique. Ils ne
paraissent **jamais** face à l'artisan.

**Mots réservés au Mode 2 (restitution fidèle).** Même parmi les mots justes
ci-dessus, *« à l'identique »*, *« restitution »*, *« fidèle »* et *« identité
retrouvée »* ne décrivent **que** le mode où ARTIZEN redessine le devis à
l'identique — jamais le mode « identité appliquée sur notre modèle » (aujourd'hui
l'aperçu d'import). Les employer pour ce dernier est une **rupture de promesse**.
La distinction officielle des deux modes vit dans
[REPRODUCTION_SPEC](../backend/app/document_clone/REPRODUCTION_SPEC.md).

---

## 5. Notre ton

| Jamais | Toujours |
|---|---|
| « Boostez votre productivité grâce à notre IA. » | « Retrouvez votre manière de travailler. » |
| « Automatisation. » | « Continuité. » |
| « Intelligence artificielle. » | « Votre identité retrouvée. » |

**L'IA est un moyen. Jamais le message.**

---

## Deux langues — l'ingénierie ne parle jamais à l'artisan

L'ingénierie peut être extraordinairement complexe ; l'expérience reste
extraordinairement simple. Les très grands produits appliquent cette séparation
sans qu'on la voie :

- Chez Apple, personne ne voit *APFS*, *Metal* ou *CoreAnimation*.
- Chez Stripe, personne ne voit *idempotency key*.
- Chez Notion, personne ne voit *block tree*.

Chez ARTIZEN, c'est pareil :

| L'équipe dit (code, doc technique) | L'artisan voit |
|---|---|
| `.artizen`, extraction, oracle, benchmark, corpus, Double Gold | Votre identité |
| moteur, rendu déterministe, KPI, fidélité | Votre devis |
| pipeline d'import, compilation, `.meta.json` | Votre signature |
| couverture, régression, empreinte de run | Votre savoir-faire |

**Un terme d'ingénierie qui apparaît à l'écran est un bug de marque.**

---

## 6. Notre étoile polaire

Chaque décision produit doit répondre à **une seule question** :

> ## Est-ce que cela aide l'artisan à retrouver son identité ?

Si la réponse est non — **on ne développe pas.**

---

## 7. La phrase que l'on veut voir partout

Sur le site. Sur le login. Dans les présentations. Dans les salons. Dans les
vidéos. Partout.

> ### Chaque devis laisse une empreinte.
> ### ARTIZEN restitue la vôtre.

---

## Nos règles de décision

Deux tests, à passer avant de valider un écran ou une fonctionnalité.

### Le test des 5 secondes

> Un artisan qui découvre ARTIZEN pendant **5 secondes** comprend-il ce qui rend
> ARTIZEN unique ?

Si non, l'écran **n'est pas terminé** — non parce qu'il est moche, mais parce
qu'il ne raconte pas la bonne histoire. Le login le passe. Le tableau de bord, le
premier import et le premier devis devront le passer aussi.

### Montrer plutôt qu'expliquer

Entre *expliquer* une fonctionnalité et la *montrer en action*, on choisit
toujours la seconde. L'animation « ancien devis → analyse → nouveau devis » en est
la preuve : en quatre secondes, elle dit plus que dix paragraphes de marketing.

---

## Les 5 piliers d'ARTIZEN

1. **Identité avant automatisation.**
2. **L'artisan s'adapte à son métier, pas à son logiciel.**
3. **La confiance se mesure.**
4. **La technologie s'efface derrière l'expérience.**
5. **Chaque devis porte une signature.**

Ces cinq principes guident chaque écran, chaque fonctionnalité et chaque décision.

---

## Manifeste

Nous ne construisons pas un logiciel de devis.

Nous construisons un outil qui permet à chaque artisan de conserver ce qui le
rend unique.

Parce qu'un devis n'est jamais seulement un prix.

C'est une promesse. Une première impression. Une signature.

**Chaque devis laisse une empreinte. ARTIZEN restitue la vôtre.**

---

## La discipline

Avant chaque nouvelle fonctionnalité, une seule question :

> **Cette fonctionnalité renforce-t-elle la promesse de marque d'ARTIZEN ?**

Si la réponse est non, elle n'entre pas dans le produit. C'est cette discipline
qui fera qu'ARTIZEN ne sera pas seulement un excellent logiciel, mais une marque
cohérente, reconnaissable et mémorable dans cinq ou dix ans.

---

## Le Serment d'ARTIZEN

> Nous ne demanderons jamais à un artisan d'abandonner son identité pour utiliser
> notre logiciel.
>
> Nous apprendrons d'abord sa manière de travailler.
>
> Nous respecterons son histoire, sa présentation, son savoir-faire et sa
> signature.
>
> Chaque amélioration du produit devra préserver cette promesse.
>
> Nous pourrons changer de moteur. Changer d'algorithme. Changer d'intelligence
> artificielle. Changer de technologie.
>
> **Mais jamais cette promesse.**
>
> Les autres logiciels demandent à l'artisan de s'adapter au logiciel.
>
> **ARTIZEN s'adapte à l'artisan.**

*Dans dix ans, personne ne se souviendra de Flutter, de FastAPI, du `.artizen`,
de l'oracle, du benchmark ou du Double Gold. Mais celui qui rejoint l'équipe et
lit ce texte en premier comprendra immédiatement pourquoi toutes ces technologies
existent. La technique est une conséquence. La promesse est la cause.*
