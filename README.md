# Symfony Docker Project

Ce projet est configuré avec Docker et inclut les services suivants :
- Symfony 7.1
- Nginx
- PHP 8.2
- PostgreSQL 15
- Adminer
- Node.js
- Traefik

## Prérequis
- Docker
- Docker Compose

## Installation

1. Clonez le projet
2. Créez un nouveau projet Symfony :
```bash
docker compose run --rm php composer create-project symfony/skeleton:"7.1.*" .
```

3. Démarrez les conteneurs :
```bash
docker compose up -d
```

## Accès aux services

- Application Symfony : http://symfony.localhost
- Adminer : http://adminer.localhost
- Traefik Dashboard : http://localhost:8080

## Base de données

Les identifiants de la base de données PostgreSQL sont :
- Base de données : symfony
- Utilisateur : symfony
- Mot de passe : symfony
- Hôte : database

## Développement

Pour installer les dépendances Node.js et compiler les assets :
```bash
docker compose run --rm node npm install
docker compose run --rm node npm run watch
```

## Commandes utiles

- Accéder au conteneur PHP :
```bash
docker compose exec php sh
```

- Exécuter des commandes Symfony :
```bash
docker compose exec php bin/console cache:clear
```
