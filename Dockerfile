FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev && \
    docker-php-ext-install zip pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Install Node.js & npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

WORKDIR /var/www/html/

# Copy project files
COPY ./ ./

# Build time composer install
RUN composer install --no-interaction --no-progress

# Container start  composer install,  php-fpm start
CMD composer install --no-interaction --no-progress && php-fpm
