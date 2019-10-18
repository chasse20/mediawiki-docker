FROM mediawiki:1.31

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update
RUN apt-get install libldap2-dev zip unzip -y
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap

#COPY LocalSettings.php /var/www/html/
#RUN chown www-data:www-data LocalSettings.php
#RUN chmod 644 LocalSettings.php

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PluggableAuth.git ./extensions/PluggableAuth
RUN chown -R www-data:www-data /var/www/html/extensions/PluggableAuth

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LDAPProvider.git ./extensions/LDAPProvider
RUN chown -R www-data:www-data /var/www/html/extensions/LDAPProvider

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LDAPAuthentication2.git ./extensions/LDAPAuthentication2
RUN chown -R www-data:www-data /var/www/html/extensions/LDAPAuthentication2

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LDAPAuthorization.git ./extensions/LDAPAuthorization
RUN chown -R www-data:www-data /var/www/html/extensions/LDAPAuthorization

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LDAPUserInfo.git ./extensions/LDAPUserInfo
RUN chown -R www-data:www-data /var/www/html/extensions/LDAPUserInfo

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LDAPGroups.git ./extensions/LDAPGroups
RUN chown -R www-data:www-data /var/www/html/extensions/LDAPGroups

RUN git clone -b REL1_31 https://gerrit.wikimedia.org/r/p/mediawiki/extensions/VisualEditor.git ./extensions/VisualEditor
RUN chown -R www-data:www-data /var/www/html/extensions/VisualEditor
WORKDIR /var/www/html/extensions/VisualEditor
RUN git submodule update --init

#RUN php /var/www/html/maintenance/update.php