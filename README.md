![SQL](https://img.shields.io/badge/SQL-%23000.svg?style=for-the-badge&logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub CLI](https://img.shields.io/badge/GitHub%20CLI-%23181717.svg?style=for-the-badge&logo=github&logoColor=white)
![Lazygit](https://img.shields.io/badge/Lazygit-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![Gitflow](https://img.shields.io/badge/Gitflow-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

<p align="center">
  <img src="images/logo.png" alt="AuBonDeal Logo" width="200">
</p>

# Documentation de la Base de Données "AuBonDeal"

## 🌟 Introduction

La base de données "AuBonDeal" est un composant essentiel de l'application de commerce électronique "AuBonDeal". Cette base de données stocke toutes les informations nécessaires au fonctionnement de l'application, y compris les données des utilisateurs, des produits et des commandes. Cette documentation vous guidera dans l'installation, la configuration et l'utilisation de cette base de données.

## 🧠 Acronyme MERISE

**MERISE** est une approche structurée pour la conception de bases de données et de systèmes, largement utilisée dans le développement de systèmes d'information. Il signifie "Méthodologie d'Étude et de Réalisation Informatique pour les Systèmes d'Entreprise". Cette approche est divisée en plusieurs étapes clés, telles que le Modèle Conceptuel des Données (MCD), le Modèle Logique des Données (MLD), le Modèle Physique des Données (MPD), la Modélisation des Processus Opérationnels et la Modélisation Dynamique.

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