# Guide utilisateur — ARTIZEN V2 (pour l'artisan)

Ce guide décrit **uniquement des écrans et des boutons qui existent réellement**
dans l'application (client Flutter, `v2.0.0-rc1`). Là où une capacité que
vous pourriez attendre n'existe pas encore, c'est dit explicitement.

L'application s'organise en **cinq onglets** en bas de l'écran : **Tableau de
bord · Clients · Catalogue · Devis · Paramètres**.

## 1. Créer votre compte

Au premier lancement, écran de connexion. Cliquez **« Créer un compte »** :

- **Email** et **Mot de passe** (8 caractères minimum) sont requis.
- **Nom complet** et **Nom de l'entreprise** sont facultatifs.
- **« Créer mon compte »** crée en une fois votre utilisateur **et** votre
  entreprise, puis vous amène au tableau de bord.

> Il n'y a pas encore d'écran « mot de passe oublié ». Conservez vos
> identifiants.

## 2. Renseigner votre catalogue

Onglet **Catalogue**, deux sous-onglets :

- **Catégories** : le bouton **+** ouvre un dialogue (Nom + Description) pour
  créer une catégorie. *Créez-en au moins une avant d'ajouter un article.*
  (La modification/suppression d'une catégorie n'est pas disponible dans
  l'app pour l'instant.)
- **Articles** : le bouton **+** ouvre le formulaire d'article :
  - Catégorie, type **Prestation** ou **Fourniture**, **Désignation**,
    **Unité** (défaut « unité »), **Prix unitaire HT**, **TVA %** (défaut
    20 %). Code, description et durée estimée sont optionnels.
  - La **virgule** du clavier est acceptée pour les décimales.
  - Un article peut être **Désactivé** (icône œil barré, avec confirmation)
    puis **Réactivé** (icône restaurer). Un article désactivé ne peut plus
    être ajouté à un nouveau devis, mais les devis existants ne changent pas.

## 3. Enregistrer vos clients

Onglet **Clients** :

- **+** ouvre le formulaire : **Nom** requis ; Prénom, Société, Adresse,
  Téléphone, Email, Notes optionnels.
- La **barre de recherche** filtre par nom, société, téléphone ou email.
- Un **appui sur un client ouvre directement son édition** (il n'y a pas
  d'écran de détail séparé). L'icône **poubelle** le supprime après
  confirmation (impossible s'il a des devis).

## 4. Composer un devis

Onglet **Devis**, bouton **+** (« Nouveau devis ») :

1. **Sélectionner un client** (feuille listant vos clients).
2. **Ajouter un article** : feuille listant vos **articles actifs**, choisir
   l'article et saisir la **quantité**. Répétez pour chaque ligne. Une ligne
   se retire avec la croix.
3. **« Créer le devis »** (actif seulement avec un client **et** au moins une
   ligne).

> Les montants ne s'affichent pas pendant la saisie : ils sont calculés par
> le serveur et apparaissent sur l'écran de détail, une fois le devis créé.
> C'est voulu — un seul endroit calcule les montants, jamais le téléphone.

### Copilote IA (facultatif)

Depuis la liste des devis, l'icône **« Copilote IA »** ouvre un écran où vous
décrivez les travaux en texte libre. **« Analyser »** propose des articles de
**votre** catalogue (avec un niveau de confiance et une raison par article).
Vous ajustez les quantités, ajoutez/retirez des articles, puis
**« Créer le devis »** pré-remplit le formulaire de devis.

> Le copilote **ne fixe aucun prix, aucune TVA, et ne crée jamais le devis
> tout seul** : il propose des articles de votre catalogue ; la création
> reste votre geste.

## 5. Le cycle de vie d'un devis

Écran de détail (titre = **numéro** du devis, ex. `DEV-2026-0042`) :

- **Brouillon** : vous pouvez le **Supprimer** (pour le corriger : on
  supprime et on recrée — un devis ne se modifie pas en place). Bouton
  **« Marquer comme envoyé »** (avec confirmation, car c'est irréversible).
- **Envoyé** : boutons **« Le client a accepté »** / **« Le client a
  refusé »** (sans confirmation — vous rapportez un fait).
- **Accepté / Refusé** : le devis est figé et archivé tel quel. Il n'offre
  plus de transition, mais propose **« Dupliquer en nouveau brouillon »**.

Un devis **ne revient jamais** à un état antérieur.

## 6. Générer et envoyer le PDF

Sur l'écran de détail, l'icône **PDF** ouvre l'**aperçu**, d'où vous pouvez
**imprimer** ou **partager/envoyer** le document. Le PDF porte, au centime,
les totaux affichés, et votre identité d'entreprise si elle est configurée.
Disponible à **tout statut**, y compris brouillon.

## 7. Dupliquer un devis

L'icône **Dupliquer** (en haut de l'écran de détail, à tout statut) crée un
**nouveau brouillon** copiant les lignes, avec un **numéro neuf**. C'est la
façon de :

- **corriger** un devis déjà envoyé/accepté/refusé (qu'on ne modifie plus),
- **réutiliser** un ancien devis comme base.

Les prix copiés sont ceux du devis d'origine (pas re-tarifés depuis le
catalogue actuel) — la copie reste fidèle même si un article a changé depuis.

## 8. Se déconnecter

Onglet **Paramètres** → **« Se déconnecter »**.

---

## Ce que la V2 ne fait pas encore (dans l'app)

Dit franchement, pour éviter de chercher un bouton qui n'existe pas :

- **Modifier un devis ligne à ligne** : impossible par conception. On
  supprime le brouillon et on recrée, ou on duplique.
- **Renseigner/éditer votre identité d'entreprise** (raison sociale, SIRET,
  N° TVA, coordonnées, couleurs) : **seulement** via le flux **« Importer un
  ancien devis »** (Paramètres → Importer). Il n'y a pas de formulaire
  d'identité directe. Voir `docs/ADMIN_GUIDE.md`.
- **Téléverser un logo** depuis l'app : non disponible (le logo est
  seulement *détecté* lors d'un import de PDF). L'API le permet
  (`POST /api/branding/logo`).
- **Écran de détail client** : l'appui ouvre l'édition.
- **Éditer/supprimer une catégorie**, **réinitialiser un mot de passe** :
  non disponibles.
