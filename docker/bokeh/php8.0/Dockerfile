FROM php:8.0-fpm-buster
MAINTAINER AFI SA - Bokeh Team <dev-opac@afi-sa.fr>

ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils apt-transport-https
RUN apt-get install -y --no-install-recommends curl wget iputils-ping dnsutils lsb-release vim sudo rsync tzdata locales openssl libapr1-dev libssl-dev

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN sed -i '/fr_FR\.UTF/s/^# //g' /etc/locale.gen \
    && sed -i '/en_US\.UTF/s/^# //g' /etc/locale.gen \
    && locale-gen
ENV LANG fr_FR.UTF-8

RUN apt-get update -yqq \
    && apt-get install locales \
               libfreetype6-dev \
               libjpeg62-turbo-dev \
               libpng-dev \
               libmcrypt-dev \
               imagemagick \
               libmagickwand-dev \
               libfontconfig \
               bzip2 \
               libmemcached-dev \
               zlib1g-dev \
               yaz \
               default-mysql-client \
               zip \
               libzip-dev \
               libxslt-dev \
               git -yqq

RUN sed -i 's/mozilla\/AddTrust_External_Root.crt/!mozilla\/AddTrust_External_Root.crt/' /etc/ca-certificates.conf \
    && update-ca-certificates

# install imagick
# use github version for now until release from https://pecl.php.net/get/imagick is ready for PHP 8
RUN mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
    && docker-php-ext-install imagick

RUN pecl install mcrypt \
    && docker-php-ext-enable mcrypt

RUN docker-php-ext-install pcntl

RUN docker-php-ext-configure zip \
    && docker-php-ext-install mysqli gettext calendar zip soap xsl \
    && docker-php-ext-install -j$(nproc) iconv

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-9.5.1.phar \
    && chmod +x /usr/local/bin/phpunit

RUN cd /usr/local/share \
    && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
