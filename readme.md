Construire l'image de base avec Apache et PHP 8.1 :


docker build -t php-apache:8.1 .
Construire l'image MySQL Master :


docker build -t mysql-master .
Construire l'image MySQL Slave :


docker build -t mysql-slave .
Construire l'image Grafana :


docker build -t grafana .