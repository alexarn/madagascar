FROM php:7.0

RUN apt-get update -yqq \
    && apt-get install locales \
               ca-certificates \
               libfreetype6-dev \
               libjpeg62-turbo-dev \
               libpng-dev \
               libmcrypt-dev \
               imagemagick \
               libmagickwand-dev \
               libfontconfig \
               bzip2 \
               yaz \
               mysql-client \
               git -yqq

RUN sed -i 's/mozilla\/AddTrust_External_Root.crt/!mozilla\/AddTrust_External_Root.crt/' /etc/ca-certificates.conf \
    && update-ca-certificates
    
RUN mkdir /tmp/phantomjs \
    && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
    && chmod +x /usr/local/bin/phantomjs \
    && rm -rf /tmp/phantomjs

RUN sed -i '/fr_FR\.UTF/s/^# //g' /etc/locale.gen \
    && sed -i '/en_US\.UTF/s/^# //g' /etc/locale.gen \
    && locale-gen
ENV LANG fr_FR.UTF-8

RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-5.7.9.phar \
    && chmod +x /usr/local/bin/phpunit

RUN pecl install imagick-3.4.3RC1 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mysqli mcrypt gettext calendar zip soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

