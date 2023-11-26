![SQL](https://img.shields.io/badge/SQL-%23000.svg?style=for-the-badge&logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub CLI](https://img.shields.io/badge/GitHub%20CLI-%23181717.svg?style=for-the-badge&logo=github&logoColor=white)
![Lazygit](https://img.shields.io/badge/Lazygit-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![Gitflow](https://img.shields.io/badge/Gitflow-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

<p align="center">
  <img src="images/logo.png" alt="AuBonDeal Logo" width="200">
</p>

# Table des Matières

- [English Documentation](#english-documentation)
  - [Introduction](#introduction)
  - [Management Rules](#management-rules)
    - [User Management](#user-management)
    - [Product Management](#product-management)
    - [Order Management](#order-management)
  - [MERISE Acronym](#merise-acronym)
  - [Physical Data Model (PDM)](#physical-data-model-pdm)
  - [Roles and Permissions (RBAC)](#roles-and-permissions-rbac)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Installation Steps](#installation-steps)
  - [Configuration](#configuration)
    - [Row-Level Security (RLS)](#row-level-security-rls)
  - [Usage](#usage)
    - [Data Access](#data-access)
    - [Password Security](#password-security)
  - [Conclusion](#conclusion)
- [Documentation en Français](#documentation-en-français)
  - [Introduction](#introduction-1)
  - [Règles de Gestion](#règles-de-gestion)
    - [Gestion des Utilisateurs](#gestion-des-utilisateurs)
    - [Gestion des Produits](#gestion-des-produits)
    - [Gestion des Commandes](#gestion-des-commandes)
  - [Acronyme MERISE](#acronyme-merise)
  - [Modèle Physique des Données (MPD)](#modèle-physique-des-données-mpd)
  - [Rôles et Permissions (RBAC)](#rôles-et-permissions-rbac)
  - [Installation](#installation-1)
    - [Prérequis](#prérequis)
    - [Étapes d'Installation](#étapes-dinstallation)
  - [Configuration](#configuration-1)
    - [Sécurité au Niveau des Lignes (RLS)](#sécurité-au-niveau-des-lignes-rls)
  - [Utilisation](#utilisation)
    - [Accès aux Données](#accès-aux-données)
    - [Sécurité des Mots de Passe](#sécurité-des-mots-de-passe)
  - [Conclusion](#conclusion-1)

# "AuBonDeal" Database Documentation

## Introduction

The "AuBonDeal" database is a crucial component of the "AuBonDeal" e-commerce application. This database stores all the necessary information for the application's operation, including user data, product data, and order data. This documentation will guide you through the installation, configuration, and use of this database.

## Management Rules

### User Management
- Each user must have a unique username.
- User passwords are stored securely using hash functions.
- Users can be activated or deactivated.

### Product Management
- Each product must have a unique name.
- The price of a product cannot be null or negative.
- The available quantity of a product cannot be negative.

### Order Management
- Each order is associated with a user.
- The total cost of an order cannot be null or negative.
- The total quantity of products in an order cannot be negative.

## MERISE Acronym

**MERISE** is a structured approach to database and systems design, widely used in the field of information systems development. The acronym "MERISE" stands for "Methodology for the Study and Development of Computer Systems for Business." It is particularly popular in French-speaking countries and is known for its rigorous, systematic approach to database design and management. MERISE is divided into several key stages:

- **Conceptual Data Model (CDM)**: This stage involves identifying the key entities and relationships in the system.
- **Logical Data Model (LDM)**: Translates the CDM into logical structures, like tables and relationships, that can be implemented in a database system.
- **Physical Data Model (PDM)**: This stage focuses on how the logical structures will be physically implemented in the database, including considerations of performance and storage.
- **Operational Process Modeling**: Involves defining the processes and operations that the system must support.
- **Dynamic Modeling**: This part deals with understanding and modeling how data moves and changes over time within the system.

MERISE's structured approach helps in creating well-organized, efficient databases and systems, making it a valuable methodology for complex information system projects.

## Physical Data Model (PDM)

### Table: `users`
- `userid`: Primary key, INTEGER, unique identifier for the user.
- `username`: VARCHAR(255), unique username.
- `userpassword`: TEXT, user's password encrypted.
- `isactive`: BOOLEAN, indicates whether the user account is active.
- `createdat`: TIMESTAMP, the date and time the user account was created.
- `updatedat`: TIMESTAMP, the date and time the user account was last updated.

### Table: `products`
- `productid`: Primary key, INTEGER, unique identifier for the product.
- `productname`: VARCHAR(255), name of the product.
- `productdescription`: TEXT, detailed description of the product.
- `productprice`: NUMERIC(10,2), price of the product, must be positive.
- `productquantity`: INTEGER, stock quantity of the product, must not be negative.
- `createdat`: TIMESTAMP, date and time the product was registered.
- `updatedat`: TIMESTAMP, date and time the product was last updated.

### Table: `orders`
- `orderid`: Primary key, INTEGER, unique identifier for the order.
- `userid`: INTEGER, foreign key referencing `users(userid)`.
- `ordertotalcostht`: NUMERIC(10,2), total cost before taxes of the order, must be positive.
- `ordertotalquantity`: INTEGER, total quantity of products in the order, must be positive.
- `createdat`: TIMESTAMP, the date and time the order was created.
- `deliverat`: TIMESTAMP, the expected delivery date and time for the order.

## Roles and Permissions (RBAC)

The "AuBonDeal" database uses a role-based access control (RBAC) model. Two main roles are defined:

  - Implemented a robust RBAC system to manage user access and operations.
  - Defined roles: `admin`, `manager`, `user`.
  - Defined permissions: `read`, `write`, `update`, `delete`.
  - Users are assigned roles, and roles are linked to specific permissions to control access to various database operations.
  - Added tables: `roles`, `permissions`, `role_permissions`, `user_roles`.
  - Implemented functions for role verification (e.g., `user_has_role`).
  - Updated row-level security policies to use role-based checks.

## Installation

### Prerequisites
Before installing the "AuBonDeal" database, ensure that the following elements are installed on your system:
- PostgreSQL: A relational database management system.
- pgcli: A command-line interface for PostgreSQL.
- The `pgcrypto` extension must be enabled in PostgreSQL for password hashing.

### Installation Steps

1. **Create a Database**: Open a terminal window and execute the following command to create a new "AuBonDeal" database (make sure PostgreSQL is running):
   ```bash
   createdb auBonDeal
   ```

2. **Import the Database Structure**: Use pgcli to connect to the "AuBonDeal" database and import the database structure from a SQL file (replace `/path/to/your/script.sql` with the path to your SQL file):
   ```bash
   pgcli -d auBonDeal -U your_user -f /path/to/your/script.sql
   ```

## Configuration

### Row-Level Security (RLS)

The database also uses row-level security (RLS) to ensure that each user accesses only their own data.

## Usage

The "AuBonDeal" database includes the following tables:

1. **`users` Table**: Stores user information, including their usernames, passwords, and activation status.

2. **`products` Table**: Contains details of available products, such as their names, descriptions, prices, and quantities.

3. **`orders` Table**: Records orders placed by users, including order details, total cost, and delivery date.

### Data Access

- Users with the `readOnly` role can view existing data.
- Users with the `writeOnly` role can add new products, update product data, and place orders.

### Password Security

User passwords are secured using hash functions to ensure confidentiality.

## Conclusion

The "AuBonDeal" database is ready for use with the eponymous e-commerce application. Follow the installation and configuration steps to prepare your environment. You can now start managing users, products, and orders securely.

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

**MERISE** est une approche structurée pour la conception de bases de données et de systèmes, largement utilisée dans le domaine du développement des systèmes d'information. L'acronyme "MERISE" signifie "Méthode d'Étude et de Réalisation Informatique pour les Systèmes d'Entreprise". Particulièrement populaire dans les pays francophones, elle est reconnue pour son approche rigoureuse et systématique de la conception et de la gestion de bases de données. MERISE est divisée en plusieurs étapes clés :

- **Modèle Conceptuel de Données (MCD)** : Cette étape implique l'identification des entités clés et des relations dans le système.
- **Modèle Logique de Données (MLD)** : Traduit le MCD en structures logiques, comme des tables et des relations, pouvant être implémentées dans un système de base de données.
- **Modèle Physique de Données (MPD)** : Cette étape se concentre sur la manière dont les structures logiques seront physiquement implémentées dans la base de données, y compris les considérations de performance et de stockage.
- **Modélisation des Processus Opérationnels** : Implique la définition des processus et opérations que le système doit supporter.
- **Modélisation Dynamique** : Cette partie traite de la compréhension et de la modélisation de la manière dont les données se déplacent et changent dans le temps au sein du système.

L'approche structurée de MERISE aide à créer des bases de données et des systèmes bien organisés et efficaces, ce qui en fait une méthodologie précieuse pour les projets complexes de systèmes d'information.

## Modèle Physique des Données (MPD)

### Table : `users`
- `userid` : Clé primaire, INTEGER, identifiant unique de l'utilisateur.
- `username` : VARCHAR(255), nom d'utilisateur unique.
- `userpassword` : TEXT, mot de passe de l'utilisateur crypté.
- `isactive` : BOOLEAN, indique si le compte utilisateur est actif.
- `createdat` : TIMESTAMP, date et heure de création du compte utilisateur.
- `updatedat` : TIMESTAMP, date et heure de la dernière mise à jour du compte utilisateur.

### Table : `products`
- `productid` : Clé primaire, INTEGER, identifiant unique du produit.
- `productname` : VARCHAR(255), nom du produit.
- `productdescription` : TEXT, description du produit.
- `productprice` : NUMERIC(10,2), prix du produit, doit être positif.
- `productquantity` : INTEGER, quantité du produit en stock, ne doit pas être négative.
- `createdat` : TIMESTAMP, date et heure de l'enregistrement du produit.
- `updatedat` : TIMESTAMP, date et heure de la dernière mise à jour du produit.

### Table : `orders`
- `orderid` : Clé primaire, INTEGER, identifiant unique de la commande.
- `userid` : INTEGER, clé étrangère faisant référence à `users(userid)`.
- `ordertotalcostht` : NUMERIC(10,2), coût total hors taxes de la commande, doit être positif.
- `ordertotalquantity` : INTEGER, quantité totale de produits dans la commande, doit être positive.
- `createdat` : TIMESTAMP, date et heure de création de la commande.
- `deliverat` : TIMESTAMP, date et heure prévue pour la livraison de la commande.

## Rôles et Permissions (RBAC)

La base de données "AuBonDeal" utilise un modèle de contrôle d'accès basé sur les rôles (RBAC). Deux rôles principaux sont définis :

- Mise en place d'un système RBAC robuste pour gérer l'accès et les opérations des utilisateurs.
  - Rôles définis : `admin`, `manager`, `user`.
  - Permissions définies : `read`, `write`, `update`, `delete`.
  - Les utilisateurs sont attribués à des rôles, et les rôles sont liés à des permissions spécifiques pour contrôler l'accès aux différentes opérations de la base de données.
  - Ajout de tables : `roles`, `permissions`, `role_permissions`, `user_roles`.
  - Implémentation de fonctions pour la vérification des rôles (par exemple, `user_has_role`).
  - Mise à jour des politiques de sécurité au niveau des lignes pour utiliser des vérifications basées sur les rôles.

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