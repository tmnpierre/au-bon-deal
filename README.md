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
- [Documentation en Français](#Documentation-de-la-Base-de-Données-"AuBonDeal")
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

## Recent Changes

### Data Validation
Validation constraints have been added to ensure data integrity in the `users`, `products`, and `orders` tables. This includes verifying email address formats and ensuring that product prices and quantities are never negative.

### Indexing
Indexes have been created on frequently used columns to improve query performance, such as `username` in the `users` table and `created_at` in the `orders` table.

### User Deletion Management
Orders are not deleted when users are removed. The relationship between the `users` and `orders` tables has been adjusted to reflect this policy.

## Introduction

"AuBonDeal" database is an essential component of the "AuBonDeal" e-commerce application. This database stores all necessary information for the application's operation, including user, product, and order data. This documentation will guide you through the installation, configuration, and use of this database.

## Management Rules

### User Management
- Each user has a unique UUID.
- User passwords are stored securely using cryptographic functions.
- Users have a unique username and a pseudo.

### Product Management
- Each product has a unique UUID.
- The price and quantity of a product must be positive.

### Order Management
- Each order has a unique UUID and is associated with a user UUID.
- Orders contain total cost and quantity, which must be positive.
- Orders have timestamps for creation and delivery.

## MERISE Acronym

**MERISE** is a structured approach to database and systems design, widely used in information systems development. It stands for "Methodology for the Study and Development of Computer Systems for Business." This approach is divided into several key stages, such as Conceptual Data Model (CDM), Logical Data Model (LDM), Physical Data Model (PDM), Operational Process Modeling, and Dynamic Modeling.

## Physical Data Model (PDM)

### Table: `users`
- `user_uuid`: UUID, primary key, unique identifier for the user.
- `user_pseudo`: VARCHAR(255), user's pseudo.
- `username`: VARCHAR(255), unique username.
- `user_password`: TEXT, encrypted password.
- `created_at`: TIMESTAMP, account creation date and time.

### Table: `products`
- `product_uuid`: UUID, primary key, unique identifier for the product.
- `product_name`: VARCHAR(255), product name.
- `product_description`: TEXT, product description.
- `product_price`: NUMERIC(10,2), product price.
- `product_quantity`: INTEGER, stock quantity.
- `created_at`: TIMESTAMP, product registration date.
- `updated_at`: TIMESTAMP, product update date.

### Table: `orders`
- `order_number`: UUID, primary key, unique identifier for the order.
- `order_total_cost_ht`: NUMERIC(10,2), total order cost before taxes.
- `order_total_quantity`: INTEGER, total product quantity.
- `created_at`: TIMESTAMP, order creation date.
- `deliver_at`: TIMESTAMP, expected delivery date and time.
- `user_uuid`: UUID, foreign key referencing `users(user_uuid)`.

### Table: `order_items`
- `order_item_uuid`: UUID, primary key, unique identifier for the order item.
- `order_number`: UUID, foreign key referencing `orders(order_number)`.
- `product_uuid`: UUID, foreign key referencing `products(product_uuid)`.
- `quantity`: INTEGER, quantity of the product.

## Roles and Permissions (RBAC)

"AuBonDeal" database employs a Role-Based Access Control (RBAC) system. Roles and permissions are defined to manage user access:

- `admin_role`: Has all privileges on all tables, sequences, and functions.
- `user_role`: Has SELECT, INSERT, UPDATE, and DELETE privileges on specific tables.
- Row-Level Security (RLS) policies are in place to ensure users access only their data.

## Installation

### Prerequisites
Ensure the following are installed:
- PostgreSQL.
- `pgcrypto` and `uuid-ossp` extensions enabled in PostgreSQL.

### Installation Steps

1. **Create Database**: Use the `createdb` command to create a new "AuBonDeal" database.
2. **Import Database Structure**: Use `pgcli` or a similar tool to import the SQL file into the database.

## Configuration

### Row-Level Security (RLS)

RLS is enabled on the `orders` table to ensure that users access only their own orders. Specific policies like `user_view_own_orders` and `user_modify_own_orders` are implemented to enforce this.

## Usage

- **Data Access**: Users can manage their data according to their roles.
- **Password Security**: Passwords are hashed for security.

## Conclusion

The "AuBonDeal" database is set up for the associated e-commerce application. Follow these guidelines for effective management of users, products, and orders.

# Documentation de la Base de Données "AuBonDeal"

## Changements Récents

### Validation des Données
Des contraintes de validation ont été ajoutées pour assurer l'intégrité des données dans les tables `users`, `products` et `orders`. Cela comprend la vérification des formats d'adresses e-mail et l'assurance que les prix et quantités des produits ne sont jamais négatifs.

### Indexation
Des index ont été créés sur des colonnes fréquemment utilisées pour améliorer les performances des requêtes, comme `username` dans la table `users` et `created_at` dans la table `orders`.

### Gestion des Suppressions d'Utilisateurs
Les commandes ne sont pas supprimées lorsque les utilisateurs sont supprimés. La relation entre les tables `users` et `orders` a été ajustée pour refléter cette politique.

## Introduction

La base de données "AuBonDeal" est un composant essentiel de l'application e-commerce "AuBonDeal". Cette base de données stocke toutes les informations nécessaires au fonctionnement de l'application, y compris les données des utilisateurs, des produits et des commandes. Cette documentation vous guidera à travers l'installation, la configuration et l'utilisation de cette base de données.

## Règles de Gestion

### Gestion des Utilisateurs
- Chaque utilisateur possède un UUID unique.
- Les mots de passe des utilisateurs sont stockés de manière sécurisée à l'aide de fonctions cryptographiques.
- Les utilisateurs ont un nom d'utilisateur unique et un pseudo.

### Gestion des Produits
- Chaque produit possède un UUID unique.
- Le prix et la quantité d'un produit doivent être positifs.

### Gestion des Commandes
- Chaque commande possède un UUID unique et est associée à un UUID utilisateur.
- Les commandes contiennent le coût total et la quantité, qui doivent être positifs.
- Les commandes ont des horodatages de création et de livraison.

## Acronyme MERISE

**MERISE** est une approche structurée pour la conception de bases de données et de systèmes, largement utilisée dans le développement de systèmes d'information. Elle signifie "Méthodologie d'Étude et de Réalisation Informatique pour les Systèmes d'Entreprise". Cette approche est divisée en plusieurs étapes clés, telles que le Modèle Conceptuel de Données (MCD), le Modèle Logique de Données (MLD), le Modèle Physique de Données (MPD), la Modélisation des Processus Opérationnels et la Modélisation Dynamique.

## Modèle Physique des Données (MPD)

### Table : `users`
- `user_uuid` : UUID, clé primaire, identifiant unique de l'utilisateur.
- `user_pseudo` : VARCHAR(255), pseudo de l'utilisateur.
- `username` : VARCHAR(255), nom d'utilisateur unique.
- `user_password` : TEXT, mot de passe crypté.
- `created_at` : TIMESTAMP, date et heure de création du compte.

### Table : `products`
- `product_uuid` : UUID, clé primaire, identifiant unique du produit.
- `product_name` : VARCHAR(255), nom du produit.
- `product_description` : TEXT, description du produit.
- `product_price` : NUMERIC(10,2), prix du produit.
- `product_quantity` : INTEGER, quantité en stock.
- `created_at` : TIMESTAMP, date d'enregistrement du produit.
- `updated_at` : TIMESTAMP, date de mise à jour du produit.

### Table : `orders`
- `order_number` : UUID, clé primaire, identifiant unique de la commande.
- `order_total_cost_ht` : NUMERIC(10,2), coût total avant taxes.
- `order_total_quantity` : INTEGER, quantité totale de produit.
- `created_at` : TIMESTAMP, date de création de la commande.
- `deliver_at` : TIMESTAMP, date et heure de livraison prévues.
- `user_uuid` : UUID, clé étrangère référençant `users(user_uuid)`.

### Table : `order_items`
- `order_item_uuid` : UUID, clé primaire, identifiant unique de l'élément de commande.
- `order_number` : UUID, clé étrangère référençant `orders(order_number)`.
- `product_uuid` : UUID, clé étrangère référençant `products(product_uuid)`.
- `quantity` : INTEGER, quantité du produit.

## Rôles et Permissions (RBAC)

La base de données "AuBonDeal" emploie un système de Contrôle d'Accès Basé sur les Rôles (RBAC). Des rôles et des permissions sont définis pour gérer l'accès des utilisateurs :

- `admin_role` : Dispose de tous les privilèges sur toutes les tables, séquences et fonctions.
- `user_role` : Dispose des privilèges SELECT, INSERT, UPDATE et DELETE sur certaines tables.
- Des politiques de Sécurité au Niveau des Lignes (RLS) sont en place pour garantir que les utilisateurs accè

dent uniquement à leurs propres données.

## Installation

### Prérequis
Assurez-vous que les éléments suivants sont installés :
- PostgreSQL.
- Les extensions `pgcrypto` et `uuid-ossp` activées dans PostgreSQL.

### Étapes d'Installation

1. **Création de la Base de Données** : Utilisez la commande `createdb` pour créer une nouvelle base de données "AuBonDeal".
2. **Importation de la Structure de la Base de Données** : Utilisez `pgcli` ou un outil similaire pour importer le fichier SQL dans la base de données.

## Configuration

### Sécurité au Niveau des Lignes (RLS)

La RLS est activée sur la table `orders` pour garantir que les utilisateurs n'accèdent qu'à leurs propres commandes. Des politiques spécifiques comme `user_view_own_orders` et `user_modify_own_orders` sont mises en place pour renforcer cela.

## Utilisation

- **Accès aux Données** : Les utilisateurs peuvent gérer leurs données selon leurs rôles.
- **Sécurité des Mots de Passe** : Les mots de passe sont hachés pour la sécurité.

## Conclusion

La base de données "AuBonDeal" est configurée pour l'application e-commerce associée. Suivez ces lignes directrices pour une gestion efficace des utilisateurs, des produits et des commandes.