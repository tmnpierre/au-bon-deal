![SQL](https://img.shields.io/badge/SQL-%23000.svg?style=for-the-badge&logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub CLI](https://img.shields.io/badge/GitHub%20CLI-%23181717.svg?style=for-the-badge&logo=github&logoColor=white)
![Lazygit](https://img.shields.io/badge/Lazygit-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![Gitflow](https://img.shields.io/badge/Gitflow-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

<p align="center">
  <img src="images/logo.png" alt="AuBonDeal Logo" width="200">
</p>

# 📘 Table des Matières

1. 🌟 [Introduction](#introduction)
2. 📋 [Règles de Gestion](#règles-de-gestion)
   - 2.1. 👤 [Gestion des Utilisateurs](#gestion-des-utilisateurs)
   - 2.2. 📦 [Gestion des Produits](#gestion-des-produits)
   - 2.3. 📝 [Gestion des Commandes](#gestion-des-commandes)
3. 🧠 [Acronyme MERISE](#acronyme-merise)
4. 💾 [Modèle Physique des Données (MPD)](#modèle-physique-des-données-mpd)
   - 4.1. 🧑‍💼 [Table : `users`](#table--users)
   - 4.2. 📦 [Table : `products`](#table--products)
   - 4.3. 📄 [Table : `orders`](#table--orders)
   - 4.4. 📋 [Table : `order_items`](#table--order_items)
5. 🔐 [Rôles et Permissions (RBAC)](#rôles-et-permissions-rbac)
6. 📊 [Audits et Logs d'Activité](#audits-et-logs-dactivité)
7. ⚙️ [Installation](#installation)
   - 7.1. 📝 [Prérequis](#prérequis)
   - 7.2. 🚀 [Étapes d'Installation](#étapes-dinstallation)
8. ⚙️ [Configuration](#configuration)
   - 8.1. 🔒 [Sécurité au Niveau des Lignes (RLS)](#sécurité-au-niveau-des-lignes-rls)
9. 🛠️ [Utilisation](#utilisation)
10. 🏁 [Conclusion](#conclusion)
11. 🌟 [Introduction](#introduction)
12. 📋 [Règles de Gestion](#règles-de-gestion)
   - 12.1. 👤 [Gestion des Utilisateurs](#gestion-des-utilisateurs)
   - 12.2. 📦 [Gestion des Produits](#gestion-des-produits)
   - 12.3. 📝 [Gestion des Commandes](#gestion-des-commandes)
13. 🧠 [Acronyme MERISE](#acronyme-merise)
14. 💾 [Modèle Physique des Données (MPD)](#modèle-physique-des-données-mpd)
   - 14.1. 🧑‍💼 [Table : `utilisateurs`](#table--utilisateurs)
   - 14.2. 📦 [Table : `produits`](#table--produits)
   - 14.3. 📄 [Table : `commandes`](#table--commandes)
   - 14.4. 📋 [Table : `articles_de_commande`](#table--articles_de_commande)
15. 🔐 [Rôles et Permissions (RBAC)](#rôles-et-permissions-rbac)
16. 📊 [Audits et Journaux d'Activité](#audits-et-journaux-dactivité)
17. ⚙️ [Installation](#installation)
   - 17.1. 📝 [Prérequis](#prérequis)
   - 17.2. 🚀 [Étapes d'Installation](#étapes-dinstallation)
18. ⚙️ [Configuration](#configuration)
   - 18.1. 🔒 [Sécurité au Niveau des Lignes (RLS)](#sécurité-au-niveau-des-lignes-rls)
19. 🛠️ [Utilisation](#utilisation)
20. 🏁 [Conclusion](#conclusion)

# "AuBonDeal" Database Documentation

## 🌟 Introduction

"AuBonDeal" database is an essential component of the "AuBonDeal" e-commerce application. This database stores all necessary information for the application's operation, including user, product, and order data. This documentation will guide you through the installation, configuration, and use of this database.

## 📋 Management Rules

### 👤 User Management
- Each user has a unique UUID.
- User passwords are stored securely using cryptographic functions.
- Users have a unique username and a pseudo.
- 🚫 **User Deletion Management**: Orders are not deleted when users are removed. The relationship between the `users` and `orders` tables has been adjusted to reflect this policy.

### 📦 Product Management
- Each product has a unique UUID.
- The price and quantity of a product must be positive.
- ✔️ **Data Validation**: Validation constraints have been added to ensure data integrity. This includes verifying email address formats and ensuring that product prices and quantities are never negative.

### 📝 Order Management
- Each order has a unique UUID and is associated with a user UUID.
- Orders contain total cost and quantity, which must be positive.
- Orders have timestamps for creation and delivery.
- ✔️ **Data Validation**: Similar to products, validation constraints ensure the integrity of order data.

## 🧠 MERISE Acronym

**MERISE** is a structured approach to database and systems design, widely used in information systems development. It stands for "Methodology for the Study and Development of Computer Systems for Business." This approach is divided into several key stages, such as Conceptual Data Model (CDM), Logical Data Model (LDM), Physical Data Model (PDM), Operational Process Modeling, and Dynamic Modeling.

## 💾 Physical Data Model (PDM)

### 🧑‍💼 Table: `users`
- `user_uuid`: UUID, primary key, unique identifier for the user.
- `user_pseudo`: VARCHAR(255), user's pseudo.
- `username`: VARCHAR(255), unique username.
- `user_password`: TEXT, encrypted password.
- `created_at`: TIMESTAMP, account creation date and time.
- 📊 **Indexing**: Indexes have been created on columns like `username` to improve query performance.

### 📦 Table: `products`
- `product_uuid`: UUID, primary key, unique identifier for the product.
- `product_name`: VARCHAR(255), product name.
- `product_description`: TEXT, product description.
- `product_price`: NUMERIC(10,2), product price.
- `product_quantity`: INTEGER, stock quantity.
- `created_at`: TIMESTAMP,

 product registration date.
- `updated_at`: TIMESTAMP, product update date.

### 📄 Table: `orders`
- `order_number`: UUID, primary key, unique identifier for the order.
- `order_total_cost_ht`: NUMERIC(10,2), total order cost before taxes.
- `order_total_quantity`: INTEGER, total product quantity.
- `created_at`: TIMESTAMP, order creation date.
- `deliver_at`: TIMESTAMP, expected delivery date and time.
- `user_uuid`: UUID, foreign key referencing `users(user_uuid)`.
- 📊 **Indexing**: Indexes on columns such as `created_at` have been created to improve query performance.

### 📋 Table: `order_items`
- `order_item_uuid`: UUID, primary key, unique identifier for the order item.
- `order_number`: UUID, foreign key referencing `orders(order_number)`.
- `product_uuid`: UUID, foreign key referencing `products(product_uuid)`.
- `quantity`: INTEGER, quantity of the product.

## 🔐 Roles and Permissions (RBAC)

"AuBonDeal" database employs a Role-Based Access Control (RBAC) system. Roles and permissions are defined to manage user access:

- `admin_role`: Has all privileges on all tables, sequences, and functions.
- `user_role`: Has SELECT, INSERT, UPDATE, and DELETE privileges on specific tables.
- 🌟 **More Precise Roles**: Specific roles such as `product_manager`, `order_manager`, and `user_manager` have been introduced for finer management of access and operations.
- 🛡️ **Specific Privileges**: Adapted privileges have been granted to each role to ensure precise and secure access control.
- 🔒 **Securing Sensitive Functions**: Critical functions like `hash_user_password()` and `user_has_role()` are now restricted to authorized roles to enhance security.
- 🔐 Row-Level Security (RLS) policies are in place to ensure users access only their data.

## 📊 Audits and Activity Logs

- 📝 An `audit_logs` table has been implemented to record important actions, thus improving traceability and security.
- 🚨 Triggers like `log_order_inserts` have been added to automatically log certain operations in the audit table.

## ⚙️ Installation

### 📝 Prerequisites
Ensure the following are installed:
- PostgreSQL.
- `pgcrypto` and `uuid-ossp` extensions enabled in PostgreSQL.

### 🚀 Installation Steps

1. **Create Database**: Use the `createdb` command to create a new "AuBonDeal" database.
2. **Import Database Structure**: Use `pgcli` or a similar tool to import the SQL file into the database.

## ⚙️ Configuration

### 🔒 Row-Level Security (RLS)

RLS is enabled on the `orders` table to ensure that users access only their own orders. Specific policies like `user_view_own_orders` and `user_modify_own_orders` are implemented to enforce this.

## 🛠️ Usage

- **Data Access**: Users can manage their data according to their roles.
- 🔑 **Password Security**: Passwords are hashed for security.

## 🏁 Conclusion

The "AuBonDeal" database is set up for the associated e-commerce application. Follow these guidelines for effective management of users, products, and orders.

# Documentation de la Base de Données "AuBonDeal"

## 🌟 Introduction

La base de données "AuBonDeal" est un composant essentiel de l'application de commerce électronique "AuBonDeal". Cette base de données stocke toutes les informations nécessaires au fonctionnement de l'application, y compris les données des utilisateurs, des produits et des commandes. Cette documentation vous guidera dans l'installation, la configuration et l'utilisation de cette base de données.

## 📋 Règles de Gestion

### 👤 Gestion des Utilisateurs
- Chaque utilisateur a un identifiant unique (UUID).
- Les mots de passe des utilisateurs sont stockés de manière sécurisée à l'aide de fonctions de cryptographie.
- Les utilisateurs ont un pseudo unique ainsi qu'un nom d'utilisateur.
- 🚫 **Gestion de la Suppression des Utilisateurs** : Les commandes ne sont pas supprimées lorsque les utilisateurs sont retirés. La relation entre les tables `utilisateurs` et `commandes` a été ajustée pour refléter cette politique.

### 📦 Gestion des Produits
- Chaque produit a un identifiant unique (UUID).
- Le prix et la quantité d'un produit doivent être positifs.
- ✔️ **Validation des Données** : Des contraintes de validation ont été ajoutées pour garantir l'intégrité des données. Cela comprend la vérification du format des adresses e-mail et la garantie que les prix et les quantités des produits ne sont jamais négatifs.

### 📝 Gestion des Commandes
- Chaque commande a un identifiant unique (UUID) et est associée à un identifiant d'utilisateur.
- Les commandes contiennent un coût total et une quantité, qui doivent être positifs.
- Les commandes ont des horodatages pour la création et la livraison.
- ✔️ **Validation des Données** : De manière similaire aux produits, des contraintes de validation garantissent l'intégrité des données des commandes.

## 🧠 Acronyme MERISE

**MERISE** est une approche structurée pour la conception de bases de données et de systèmes, largement utilisée dans le développement de systèmes d'information. Il signifie "Méthodologie d'Étude et de Réalisation Informatique pour les Systèmes d'Entreprise". Cette approche est divisée en plusieurs étapes clés, telles que le Modèle Conceptuel des Données (MCD), le Modèle Logique des Données (MLD), le Modèle Physique des Données (MPD), la Modélisation des Processus Opérationnels et la Modélisation Dynamique.

## 💾 Modèle Physique des Données (MPD)

### 🧑‍💼 Table : `utilisateurs`
- `uuid_utilisateur` : UUID, clé primaire, identifiant unique de l'utilisateur.
- `pseudo_utilisateur` : VARCHAR(255), pseudo de l'utilisateur.
- `nom_utilisateur` : VARCHAR(255), nom d'utilisateur unique.
- `mot_de_passe_utilisateur` : TEXT, mot de passe crypté.
- `date_de_creation` : TIMESTAMP, date et heure de création du compte.
- 📊 **Indexation** : Des index ont été créés sur des colonnes telles que `nom_utilisateur` pour améliorer les performances des requêtes.

### 📦 Table : `produits`
- `uuid_produit` : UUID, clé primaire, identifiant unique du produit.
- `nom_produit` : VARCHAR(255), nom du produit.
- `description_produit` : TEXT, description du produit.
- `prix_produit` : NUMERIC(10,2), prix du produit.
- `quantite_produit` : INTEGER, quantité en stock.
- `date_de_creation` : TIMESTAMP, date d'enregistrement du produit.
- `date_de_mise_a_jour` : TIMESTAMP, date de mise à jour du produit.

### 📄 Table : `commandes`
- `numero_de_commande` : UUID, clé primaire, identifiant unique de la commande.
- `cout_total_ht` : NUMERIC(10,2), coût total de la commande avant les taxes.
- `quantite_totale` : INTEGER, quantité totale de produits.
- `date_de_creation` : TIMESTAMP, date de création de la commande.
- `date_de_livraison` : TIMESTAMP, date et heure de livraison prévue.
- `uuid_utilisateur` : UUID, clé étrangère faisant référence à `utilisateurs(uuid_utilisateur)`.
- 📊 **Indexation** : Des index sur des colonnes telles que `date

_de_creation` ont été créés pour améliorer les performances des requêtes.

### 📋 Table : `articles_de_commande`
- `uuid_article_de_commande` : UUID, clé primaire, identifiant unique de l'article de commande.
- `numero_de_commande` : UUID, clé étrangère faisant référence à `commandes(numero_de_commande)`.
- `uuid_produit` : UUID, clé étrangère faisant référence à `produits(uuid_produit)`.
- `quantite` : INTEGER, quantité du produit.

## 🔐 Rôles et Permissions (RBAC)

La base de données "AuBonDeal" utilise un système de Contrôle d'Accès Basé sur les Rôles (RBAC). Des rôles et des permissions sont définis pour gérer l'accès des utilisateurs :

- `admin_role` : Possède tous les privilèges sur toutes les tables, séquences et fonctions.
- `user_role` : Possède les privilèges SELECT, INSERT, UPDATE et DELETE sur des tables spécifiques.
- 🌟 **Rôles Plus Précis** : Des rôles spécifiques tels que `product_manager`, `order_manager` et `user_manager` ont été introduits pour une gestion plus fine de l'accès et des opérations.
- 🛡️ **Privilèges Spécifiques** : Des privilèges adaptés ont été accordés à chaque rôle pour assurer un contrôle d'accès précis et sécurisé.
- 🔒 **Sécurisation des Fonctions Sensibles** : Des fonctions critiques telles que `hash_user_password()` et `user_has_role()` sont désormais limitées aux rôles autorisés pour renforcer la sécurité.
- 🔐 Des politiques de Sécurité au Niveau des Lignes (RLS) sont en place pour garantir que les utilisateurs n'accèdent qu'à leurs propres données.

## 📊 Audits et Journaux d'Activité

- 📝 Une table `audit_logs` a été mise en place pour enregistrer les actions importantes, améliorant ainsi la traçabilité et la sécurité.
- 🚨 Des déclencheurs tels que `log_order_inserts` ont été ajoutés pour enregistrer automatiquement certaines opérations dans la table d'audit.

## ⚙️ Installation

### 📝 Prérequis
Assurez-vous que les éléments suivants sont installés :
- PostgreSQL.
- Les extensions `pgcrypto` et `uuid-ossp` sont activées dans PostgreSQL.

### 🚀 Étapes d'Installation

1. **Créer la Base de Données** : Utilisez la commande `createdb` pour créer une nouvelle base de données "AuBonDeal".
2. **Importer la Structure de la Base de Données** : Utilisez `pgcli` ou un outil similaire pour importer le fichier SQL dans la base de données.

## ⚙️ Configuration

### 🔒 Sécurité au Niveau des Lignes (RLS)

RLS est activé sur la table `commandes` pour garantir que les utilisateurs n'accèdent qu'à leurs propres commandes. Des politiques spécifiques telles que `user_view_own_orders` et `user_modify_own_orders` sont mises en œuvre pour appliquer cette politique.

## 🛠️ Utilisation

- **Accès aux Données** : Les utilisateurs peuvent gérer leurs données en fonction de leurs rôles.
- 🔑 **Sécurité des Mots de Passe** : Les mots de passe sont hachés pour des raisons de sécurité.

## 🏁 Conclusion

La base de données "AuBonDeal" est configurée pour l'application de commerce électronique associée. Suivez ces directives pour une gestion efficace des utilisateurs, des produits et des commandes.