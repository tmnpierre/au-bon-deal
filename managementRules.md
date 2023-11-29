# Guide Simplifié de l'Application

## Introduction

Cette application est conçue pour gérer les utilisateurs, les commandes de produits, et assurer la sécurité et le suivi des activités. Voici un aperçu facile à comprendre de ses différentes fonctionnalités.

## Extensions et Fonctions Cryptographiques

- **pgcrypto & uuid-ossp**: Ces outils ajoutent des fonctions de sécurité à notre application. Ils aident à créer des identifiants uniques pour chaque enregistrement (comme un numéro de commande unique) et à sécuriser les mots de passe des utilisateurs.

## Gestion des Utilisateurs

- **Inscription et Connexion Sécurisées**: Quand un utilisateur crée un compte ou met à jour son mot de passe, celui-ci est crypté pour sa sécurité. Cela signifie que même les administrateurs de l'application ne peuvent pas voir les mots de passe en clair.
- **Unicité des Utilisateurs**: Chaque utilisateur doit avoir un nom d'utilisateur unique, ce qui évite la confusion et les erreurs.

## Gestion des Commandes et des Produits

- **Commandes**: Les utilisateurs peuvent passer des commandes. Chaque commande inclut des informations comme le coût total, la quantité totale de produits, et les dates de création et de livraison.
- **Produits**: Les produits sont les articles que les utilisateurs peuvent acheter. Chaque produit a un nom, une description, un prix et une quantité en stock.
- **Validation des Données**: L'application vérifie que les prix et les quantités des produits sont toujours positifs, évitant ainsi les erreurs.

## Audit et Logs

- **Suivi des Activités**: Toutes les actions importantes, comme l'ajout d'une nouvelle commande, sont enregistrées. Cela aide à comprendre qui a fait quoi et quand dans l'application.
- **Journal d'Audit**: Ces enregistrements contiennent des détails comme le type d'action réalisée, qui l'a faite, et quand elle a été faite.

## Sécurité et Contrôle d'Accès

- **Politiques de Sécurité**: Des règles spécifiques définissent qui peut voir ou modifier certaines données. Par exemple, un utilisateur ne peut voir ou modifier que ses propres commandes.
- **Rôles et Permissions**: L'application a différents niveaux d'accès, comme les administrateurs, les gestionnaires de commandes, et les utilisateurs normaux. Chacun a des permissions différentes.

## Intégrité des Données

- **Relations entre les Tables**: Les commandes, les articles de commande et les produits sont liés entre eux. Par exemple, une commande contient plusieurs articles de commande, et chaque article est lié à un produit spécifique.
- **Validation des Données**: Des règles s'assurent que les informations entrées dans l'application sont logiques et correctes, comme empêcher les quantités négatives pour les produits.

## Conclusion

Notre application fournit une plateforme sécurisée et facile à utiliser pour la gestion des commandes et des produits, avec un système robuste pour suivre les activités et maintenir la sécurité des données.