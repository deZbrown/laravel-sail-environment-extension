# Use an official PHP runtime as a parent image
FROM php:8.3-fpm

# Set working directory
WORKDIR /var/www/html

# Install necessary packages and PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    gosu \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setting up the 'sail' user
ARG WWWGROUP=1000
RUN groupadd --force -g $WWWGROUP sail
RUN useradd -ms /bin/bash --no-user-group -g sail -u 1337 sail
ENV SUPERVISOR_PHP_USER=sail

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=sail:sail . /var/www/html

# Copy the custom scripts and configuration files
COPY start-container /usr/local/bin/start-container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php.ini /etc/php/8.3/cli/conf.d/99-sail.ini

# Make the start-container script executable
RUN chmod +x /usr/local/bin/start-container

# Expose port 9000 and start php-fpm server using the custom start-container script
EXPOSE 9000
ENTRYPOINT ["start-container"]
