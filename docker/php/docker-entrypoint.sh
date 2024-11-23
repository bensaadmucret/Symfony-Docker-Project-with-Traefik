#!/bin/sh
set -e

# Installation des dépendances Symfony si nécessaire
if [ -f "src/composer.json" ]; then
    cd src && composer install --no-interaction
fi

# Premier argument passé au script
exec "$@"
