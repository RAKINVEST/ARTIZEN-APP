# Les 4 boutons Artizen

Quatre fichiers à **double-cliquer**. Des raccourcis existent aussi sur le Bureau.
Chaque bouton ouvre une fenêtre d'une couleur différente et explique ce qu'il fait.

| Bouton | Couleur | Quand ? | Ce qu'il fait |
|---|---|---|---|
| **1-RECUPERER** | 🟢 vert | **En arrivant** sur un PC | Récupère le code depuis GitHub (`git pull`) **et** les conversations Claude de l'autre PC |
| **2-SAUVEGARDER** | 🔴 rouge | **Avant d'éteindre** le PC | Enregistre et envoie le code sur GitHub (`commit` + `push`) **et** sauvegarde les conversations |
| **3-INSTALLER-PROJET** | 🔵 bleu | **Une fois par PC** | Vérifie les outils, crée le `.env`, démarre serveur + base, installe les dépendances |
| **4-NETTOYER** | 🟡 jaune | Quand le disque est plein | Supprime les fichiers de compilation et les caches Docker inutiles |

## La règle à retenir

> **En arrivant → bouton VERT. Avant d'éteindre → bouton ROUGE.**

C'est tout. Si tu fais ça sur les deux PC, tu ne perdras jamais de travail et tu
retrouveras toujours tes conversations.

## Comment les conversations circulent entre les deux PC

Claude Code enregistre chaque conversation en local, dans
`%USERPROFILE%\.claude\projects\`. Ce dossier n'est pas partagé entre machines.

Les boutons le synchronisent via **OneDrive** :

```
PC portable  --[2-SAUVEGARDER]-->  OneDrive\Artizen-Claude-Sessions  --[1-RECUPERER]-->  PC fixe
```

La copie ne remplace **jamais** une conversation locale plus récente (`robocopy /XO`),
donc aucun risque d'écraser le travail de l'autre machine.

Pour rouvrir une conversation récupérée : ouvre Claude Code dans le dossier du projet
et tape `claude --resume`. Tu peux aussi simplement demander à Claude de relire
l'historique — il sait lire ces fichiers.

### Pourquoi pas dans Git ?

Parce qu'une conversation contient souvent des **secrets** (mots de passe, clés, jetons).
Les pousser sur GitHub serait une fuite de données. OneDrive les synchronise entre tes
deux PC **sans** les publier.

## Sécurité intégrée

- **1-RECUPERER** et **4-NETTOYER** refusent de démarrer sans prévenir si du travail
  n'est pas sauvegardé : ils affichent la liste et demandent confirmation.
- **4-NETTOYER** ne touche **jamais** à ta base de données (clients, articles, devis),
  ni à ton `.env`, ni à tes conversations.
- **2-SAUVEGARDER** : si l'envoi vers GitHub échoue (pas de réseau), ton travail reste
  **enregistré en local** — il suffit de recliquer plus tard.
