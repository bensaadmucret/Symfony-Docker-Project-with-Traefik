.PHONY: help install start stop restart build logs shell db-connect tests lint fix-cs analyze

# Couleurs pour le help
HELP_COLOR = \033[36m
NO_COLOR   = \033[0m

help: ## Affiche l'aide
	@echo "$(HELP_COLOR)Usage:$(NO_COLOR)"
	@echo "  make [command]"
	@echo ""
	@echo "$(HELP_COLOR)Commandes disponibles:$(NO_COLOR)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Installe le projet
	docker compose build
	docker compose up -d
	docker compose exec php composer install
	docker compose exec php php bin/console doctrine:database:create --if-not-exists
	docker compose exec php php bin/console doctrine:migrations:migrate --no-interaction
	docker compose exec node npm install

start: ## Démarre les conteneurs
	docker compose up -d

stop: ## Arrête les conteneurs
	docker compose down

restart: stop start ## Redémarre les conteneurs

build: ## Reconstruit les conteneurs
	docker compose build
	docker compose up -d

logs: ## Affiche les logs des conteneurs
	docker compose logs -f

shell: ## Ouvre un shell dans le conteneur PHP
	docker compose exec php sh

node-shell: ## Ouvre un shell dans le conteneur Node
	docker compose exec node sh

db-connect: ## Se connecte à la base de données
	docker compose exec database psql -U symfony -d symfony

tests: ## Lance les tests
	docker compose exec php php bin/phpunit

lint: ## Vérifie le style du code
	docker compose exec php vendor/bin/php-cs-fixer fix --dry-run --diff

fix-cs: ## Corrige le style du code
	docker compose exec php vendor/bin/php-cs-fixer fix

analyze: ## Lance l'analyse statique du code
	docker compose exec php vendor/bin/phpstan analyse -l 8 src tests

assets-watch: ## Lance la compilation des assets en mode watch
	docker compose exec node npm run dev

assets-build: ## Compile les assets pour la production
	docker compose exec node npm run build

cache-clear: ## Vide le cache
	docker compose exec php php bin/console cache:clear

migrate: ## Lance les migrations
	docker compose exec php php bin/console doctrine:migrations:migrate --no-interaction
