# Utilisez une image de base avec Apache et PHP 8.1
FROM php:8.1-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo_mysql

# Exposer le port 80 pour Apache
EXPOSE 80

# Installer MySQL Server pour le nœud maître
RUN apt-get update && \
    apt-get install -y mysql-server && \
    rm -rf /var/lib/apt/lists/*

# Exposer le port 3306 pour MySQL Master
EXPOSE 3306

# Configuration de MySQL Master
# Notez que ce fichier pourrait contenir des informations sensibles et devrait être géré avec précaution
COPY my.cnf /etc/mysql/my.cnf

# Installer MySQL Server pour le nœud esclave
RUN apt-get update && \
    apt-get install -y mysql-server && \
    rm -rf /var/lib/apt/lists/*

# Exposer le port 3307 pour MySQL Slave
EXPOSE 3307

# Configuration de MySQL Slave
COPY my_slave.cnf /etc/mysql/my.cnf

# Installer et configurer Grafana
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" && \
    wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - && \
    apt-get update && \
    apt-get install -y grafana && \
    rm -rf /var/lib/apt/lists/*

# Exposer le port 3000 pour Grafana
EXPOSE 3000

# Copier la configuration de Grafana
COPY grafana.ini /etc/grafana/grafana.ini

# Commande par défaut pour démarrer les services
CMD ["apache2-foreground"]
