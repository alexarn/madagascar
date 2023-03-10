FROM php:7.4-fpm-buster

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

RUN pecl install imagick-3.4.3RC1

RUN pecl install mcrypt-1.0.3

RUN docker-php-ext-enable imagick \
    && docker-php-ext-enable mcrypt

RUN docker-php-ext-install pcntl

RUN docker-php-ext-configure zip \
    && docker-php-ext-install mysqli gettext calendar zip soap xsl \
    && docker-php-ext-install -j$(nproc) iconv

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-5.7.27.phar \
    && chmod +x /usr/local/bin/phpunit

RUN cd /usr/local/share \
    && wget -O chrome-linux.zip https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots \
    && unzip chrome-linux.zip \
    && ln -s /usr/local/share/chrome-linux/chrome /usr/local/bin/chromium \
    && apt-get install -yqq  libnss3 \
			     libatk1.0-0 \
			     libatk-bridge2.0-0 \
			     libdrm2 \
			     libxkbcommon0 \
			     libxcomposite1 \
			     libxdamage1 \
			     libxrandr2 \
			     libgbm1 \
			     libasound2 \
			     libxshmfence1
RUN useradd -ms /bin/bash webmaster
USER webmaster
WORKDIR /home/webmaster
