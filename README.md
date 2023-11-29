![SQL](https://img.shields.io/badge/SQL-%23000.svg?style=for-the-badge&logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub CLI](https://img.shields.io/badge/GitHub%20CLI-%23181717.svg?style=for-the-badge&logo=github&logoColor=white)
![Lazygit](https://img.shields.io/badge/Lazygit-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![Gitflow](https://img.shields.io/badge/Gitflow-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

<p align="center">
  <img src="images/logo.png" alt="AuBonDeal Logo" width="200">
</p>

## 🌟 Introduction

The "AuBonDeal" database is an essential component of the "AuBonDeal" e-commerce application. It stores all the necessary information for the application to function, including user, product, and order data. This documentation will guide you through the installation, configuration, and use of this database.

## 🧠 MERISE Acronym

The **MERISE** approach is a structured methodology widely used in the development of information systems. It stands for "Methodology for the Study and Development of Information Systems for Businesses." MERISE is divided into several key stages, including the Conceptual Data Model (CDM), Logical Data Model (LDM), Physical Data Model (PDM), Operational Process Modeling, and Dynamic Modeling.

## ⚙️ Installation

### 📝 Prerequisites

Before you begin, ensure that the following elements are in place:

- PostgreSQL is installed.
- The `pgcrypto` and `uuid-ossp` extensions are enabled in PostgreSQL.

### 🚀 Installation Steps

1. **Create the Database**: Use the `createdb` command to create a new database named "AuBonDeal."
2. **Import the Database Structure**: Use `pgcli` or a similar tool to import the SQL file into the database.

## ⚙️ Configuration

### 🔒 Row-Level Security (RLS)

Row-Level Security (RLS) is enabled on the `orders` table to ensure that users only access their own orders. Specific policies such as `user_view_own_orders` and `user_modify_own_orders` are implemented to enforce this policy.

## 🛠️ Usage

- **Data Access**: Users can manage their data based on their roles.
- 🔑 **Password Security**: Passwords are hashed for security purposes.