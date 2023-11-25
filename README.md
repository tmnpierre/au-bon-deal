![SQL Badge](https://img.shields.io/badge/-SQL-000?&logo=MySQL)
![PostgreSQL Badge](https://img.shields.io/badge/-PostgreSQL-336791?style=flat-square&logo=postgresql)
![GitHub CLI Badge](https://img.shields.io/badge/-GitHub_CLI-181717?style=flat-square&logo=github)
![Lazygit Badge](https://img.shields.io/badge/-Lazygit-FCC624?style=flat-square&logo=git)
![Gitflow Badge](https://img.shields.io/badge/-Gitflow-000000?style=flat-square&logo=git)

# Documentation de la Base de Données "AuBonDeal"

## Introduction

La base de données "AuBonDeal" est un composant essentiel de l'application e-commerce "AuBonDeal". Cette base de données stocke toutes les informations nécessaires au fonctionnement de l'application, notamment les données des utilisateurs, des produits et des commandes. Cette documentation vous guidera à travers l'installation, la configuration et l'utilisation de cette base de données.

## Règles de Gestion

### Gestion des Utilisateurs
- Chaque utilisateur doit avoir un nom d'utilisateur unique.
- Les mots de passe des utilisateurs sont stockés de manière sécurisée à l'aide de fonctions de hachage.
- Les utilisateurs peuvent être activés ou désactivés.

### Gestion des Produits
- Chaque produit doit avoir un nom unique.
- Le prix d'un produit ne peut pas être nul ou négatif.
- La quantité disponible d'un produit ne peut pas être négative.

### Gestion des Commandes
- Chaque commande est associée à un utilisateur.
- Le coût total d'une commande ne peut pas être nul ou négatif.
- La quantité totale de produits dans une commande ne peut pas être négative.

## Acronyme MERISE

L'acronyme "MERISE" est un terme qui provient de la modélisation des systèmes d'information. Il est défini comme suit :

- **MERISE** : Méthode d'Étude et de Réalisation Informatique pour les Systèmes d'Entreprise.

MERISE est une méthodologie de modélisation des systèmes d'information largement utilisée dans le domaine de l'informatique et du développement de bases de données.

## Rôles et Permissions (RBAC)

La base de données "AuBonDeal" utilise un modèle de contrôle d'accès basé sur les rôles (RBAC). Deux rôles principaux sont définis :

- `readOnly` : Ce rôle a la permission de lire les données.
- `writeOnly` : Ce rôle a la permission d'ajouter et de mettre à jour des données.

## Installation

### Prérequis
Avant d'installer la base de données "AuBonDeal", assurez-vous d'avoir les éléments suivants installés sur votre système :
- PostgreSQL : Un système de gestion de base de données relationnelles.
- pgcli : Une interface en ligne de commande pour PostgreSQL.
- L'extension `pgcrypto` doit être activée dans PostgreSQL pour le hachage des mots de passe.

### Étapes d'Installation

1. **Créez une Base de Données** : Ouvrez une fenêtre de terminal et exécutez la commande suivante pour créer une nouvelle base de données "AuBonDeal" (assurez-vous que PostgreSQL est en cours d'exécution) :
   ```bash
   createdb auBonDeal
   ```

2. **Importez la Structure de la Base de Données** : Utilisez pgcli pour vous connecter à la base de données "AuBonDeal" et importez la structure de la base de données à partir d'un fichier SQL (remplacez `/chemin/vers/votre/script.sql` par le chemin vers votre fichier SQL) :
   ```bash
   pgcli -d auBonDeal -U votre_utilisateur -f /chemin/vers/votre/script.sql
   ```

## Configuration

### Sécurité au Niveau des Lignes (RLS)

La base de données utilise également la sécurité au niveau des lignes (Row Level Security - RLS) pour garantir que chaque utilisateur n'accède qu'à ses propres données.

## Utilisation

La base de données "AuBonDeal" comprend les tables suivantes :

1. **Table `users`** : Stocke les informations des utilisateurs, y

 compris leurs noms d'utilisateur, mots de passe et état d'activation.

2. **Table `products`** : Contient les détails des produits disponibles, tels que leurs noms, descriptions, prix et quantités.

3. **Table `orders`** : Enregistre les commandes passées par les utilisateurs, y compris les détails de la commande, le total et la date de livraison.

### Accès aux Données

- Les utilisateurs avec le rôle `readOnly` peuvent consulter les données existantes.
- Les utilisateurs avec le rôle `writeOnly` peuvent ajouter de nouveaux produits, mettre à jour les données des produits et passer des commandes.

### Sécurité des Mots de Passe

Les mots de passe des utilisateurs sont sécurisés à l'aide de fonctions de hachage pour garantir la confidentialité.

## Conclusion

La base de données "AuBonDeal" est prête à être utilisée avec l'application e-commerce éponyme. Suivez les étapes d'installation et de configuration pour préparer votre environnement. Vous pouvez maintenant commencer à gérer les utilisateurs, les produits et les commandes de manière sécurisée.