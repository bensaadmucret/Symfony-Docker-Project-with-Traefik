FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    acl \
    fcgi \
    file \
    gettext \
    git \
    gnu-libiconv \
    nodejs \
    npm

# Install PHP extensions
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        libzip-dev \
        postgresql-dev \
    ; \
    docker-php-ext-configure zip; \
    docker-php-ext-install -j$(nproc) \
        intl \
        pdo_pgsql \
        zip \
    ; \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-cache --virtual .php-phpexts-rundeps $runDeps; \
    apk del .build-deps

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html/src

# Copy entrypoint script
COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

# Set entrypoint
ENTRYPOINT ["docker-entrypoint"]
CMD ["php-fpm"]
