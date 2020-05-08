#!/bin/sh

echo "Setting up your environment..."

LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update \
    && apt-get install -y curl zip unzip git software-properties-common wget \
    && apt-get install -y php7.3 php7.3-cli php7.3-common php7.3-gd php7.3-mysql \
        php7.3-pgsql php7.3-imap php-memcached php7.3-mbstring php7.3-xml php7.3-curl \
        php7.3-bcmath libgmp-dev php7.3-gmp php7.3-zip php7.3-redis nano \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP CS Fixer
curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o php-cs-fixer
chmod a+x php-cs-fixer
mv php-cs-fixer /usr/local/bin/php-cs-fixer

# Symlink PHP CS
ln -s $HOME/.dotfiles/.php_cs $HOME/.php_cs

# Install Oh-My-Zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# TODO: Add .zshrc