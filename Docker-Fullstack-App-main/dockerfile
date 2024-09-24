# Debian 11 (bullseye) as Base
FROM debian:bullseye

# Sury-Repository for PHP 8.2
RUN apt-get update && apt-get install -y \
    ca-certificates \
    apt-transport-https \
    lsb-release \
    gnupg \
    curl

RUN curl -sSL https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
	
# no interactive
ENV DEBIAN_FRONTEND=noninteractive

# update and install stuff
RUN apt-get update && apt-get install -y \
    apache2 \
    php8.2 \
    libapache2-mod-php8.2 \
    php8.2-mysql \
	nano \
	wget \
	htop \
	&& apt-get clean
	
RUN apt-get update && apt-get install -y \
    php8.2-curl \
    php8.2-gd \
    php8.2-imagick \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-yaml \
    php8.2-zip \
    php8.2-opcache \
	php8.2-common \
	php8.2-cli \
	php8.2-bcmath \
	php8.2-imap \
	php8.2-intl \
	&& apt-get clean
	
RUN apt-get update && apt-get install -y \
    mariadb-server \
    postfix \
    curl \
    git \
    unzip \
    supervisor \
    && apt-get clean
	
# composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# MailHog
RUN curl -sSL https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

# copy init script
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# run init script
RUN /bin/bash /usr/local/bin/init.sh

# set up Postfix, to work with MailHog
RUN echo "relayhost = [127.0.0.1]:1025" >> /etc/postfix/main.cf

# copy project source code
COPY ./src /var/www/html

# use supervisor to run Apache, MariaDB, PostFix and MailHog
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# open ports Apache (80), MariaDB (3306), MailHog Web UI (8025) and MailHog SMTP (1025)
EXPOSE 80 3306 8025 1025

# activate module rewrite for Apache
RUN a2enmod rewrite
RUN service apache2 restart

# run Supervisor
CMD ["/usr/bin/supervisord"]
