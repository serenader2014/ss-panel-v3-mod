FROM orvice/apache-base:71
MAINTAINER serenader<xyslive@gmail.com>

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y git unzip

# Install sspanel
COPY . /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies with Composer.
RUN cd /var/www/html && composer install --no-scripts && php -n xcat initQQWry && php -n xcat initdownload

RUN sed -i -e "s/    \$this->initQQWry();//g" /var/www/html/app/Command/XCat.php && sed -i -e "s/    \$this->initdownload();//g" /var/www/html/app/Command/XCat.php

# Entrypoint
COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod -R 777 storage

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
