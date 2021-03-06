#!/bin/sh

echo "Setting up your environment..."

apt-get update \
    && apt-get install -y curl zip unzip git software-properties-common wget git-core zsh \
    && apt-get update \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.3-cli php7.3-gd php7.3-mysql \
        php7.3-pgsql php7.3-imap php-memcached php7.3-mbstring php7.3-xml php7.3-curl \
        php7.3-bcmath libgmp-dev php7.3-gmp php7.3-zip php7.3-redis nano \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh)

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# Install PHP CS Fixer
curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o php-cs-fixer
chmod a+x php-cs-fixer
mv php-cs-fixer /usr/local/bin/php-cs-fixer

# Symlink PHP CS
ln -s $HOME/.dotfiles/.php_cs $HOME/.php_cs

composer global require squizlabs/php_codesniffer

# Install Fast NVM
curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash

# Set 12.04 as default.
fnm install v12.14.0
fnm default v12.14.0

# Set theme for zsh
sed -i 's/robbyrussell/steeef/g'
