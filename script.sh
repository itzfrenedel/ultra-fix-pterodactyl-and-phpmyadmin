#!/bin/bash

# Fonction pour afficher les erreurs
log_error() {
    echo "Erreur détectée : $1"
    ERROR_LOGS="$ERROR_LOGS\n$1"
}

# Initialisation des logs d'erreurs
ERROR_LOGS=""

# Étape Principale 1 - Désinstallation
echo "=== Étape Principale 1 ==="
echo "Désinstallation de Panel, Wings, PhpMyAdmin, Nginx, et Apache..."

# Désinstaller Panel
echo "Désinstallation de Pterodactyl Panel..."
cd /var/www
rm -rf pterodactyl || log_error "Erreur lors de la désinstallation de Pterodactyl Panel"

# Désinstaller Wings
echo "Désinstallation de Wings..."
systemctl stop wings || log_error "Erreur lors de l'arrêt de Wings"
systemctl disable wings || log_error "Erreur lors de la désactivation de Wings"
rm -f /usr/local/bin/wings || log_error "Erreur lors de la suppression de Wings"

# Désinstaller PhpMyAdmin
echo "Désinstallation de PhpMyAdmin..."
rm -rf /var/www/html/phpmyadmin || log_error "Erreur lors de la suppression de PhpMyAdmin"
apt-get remove --purge phpmyadmin -y || log_error "Erreur lors de la suppression de PhpMyAdmin avec apt"

# Désinstaller Nginx
echo "Désinstallation de Nginx..."
systemctl stop nginx || log_error "Erreur lors de l'arrêt de Nginx"
systemctl disable nginx || log_error "Erreur lors de la désactivation de Nginx"
apt-get remove --purge nginx nginx-common -y || log_error "Erreur lors de la suppression de Nginx"

# Désinstaller Apache
echo "Désinstallation de Apache..."
systemctl stop apache2 || log_error "Erreur lors de l'arrêt d'Apache"
systemctl disable apache2 || log_error "Erreur lors de la désactivation d'Apache"
apt-get remove --purge apache2 apache2-common apache2-utils -y || log_error "Erreur lors de la suppression d'Apache"

echo "=== Résultats de l'étape 1 ==="
if [ -n "$ERROR_LOGS" ]; then
    echo "Erreurs durant l'étape 1 :"
    echo -e "$ERROR_LOGS"
else
    echo "Aucune erreur détectée durant l'étape 1."
fi

# Étape Principale 2 - Installation
echo "=== Étape Principale 2 ==="
echo "Installation de Nginx, Panel, Wings, Apache, et PhpMyAdmin..."

# Installer Nginx
echo "Installation de Nginx..."
apt-get update -y || log_error "Erreur lors de la mise à jour des paquets"
apt-get install nginx -y || log_error "Erreur lors de l'installation de Nginx"
systemctl start nginx || log_error "Erreur lors du démarrage de Nginx"
systemctl enable nginx || log_error "Erreur lors de l'activation de Nginx"

# Demander des informations pour l'installation de Pterodactyl Panel
echo "Entrez l'email du compte admin :"
read PANEL_EMAIL
echo "Entrez le mot de passe du compte admin :"
read PANEL_PASSWORD
echo "Entrez le nom d'utilisateur du compte admin :"
read PANEL_USERNAME
echo "Entrez le prénom du compte admin :"
read PANEL_FIRSTNAME
echo "Entrez le nom de famille du compte admin :"
read PANEL_LASTNAME
echo "Entrez l'IP de votre VPS :"
read VPS_IP

# Installer Pterodactyl Panel
echo "Installation de Pterodactyl Panel..."
cd /var/www
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/download/v1.11.0/panel.tar.gz || log_error "Erreur lors du téléchargement de Pterodactyl Panel"
tar -xvzf panel.tar.gz || log_error "Erreur lors de l'extraction de Pterodactyl Panel"
cd pterodactyl
composer install --no-dev --optimize-autoloader || log_error "Erreur lors de l'installation des dépendances de Pterodactyl Panel"

# Configurer l'environnement de Pterodactyl Panel
cp .env.example .env || log_error "Erreur lors de la copie du fichier .env"
php artisan key:generate || log_error "Erreur lors de la génération de la clé"

# Installer Wings
echo "Installation de Wings..."
curl -Lo wings https://github.com/pterodactyl/wings/releases/download/v1.11.0/wings-linux-amd64 || log_error "Erreur lors du téléchargement de Wings"
chmod +x wings || log_error "Erreur lors de l'attribution des droits d'exécution à Wings"
mv wings /usr/local/bin/wings || log_error "Erreur lors du déplacement de Wings"
systemctl enable wings || log_error "Erreur lors de l'activation de Wings"
systemctl start wings || log_error "Erreur lors du démarrage de Wings"

# Installer Apache
echo "Installation d'Apache..."
apt-get install apache2 -y || log_error "Erreur lors de l'installation d'Apache"
systemctl start apache2 || log_error "Erreur lors du démarrage d'Apache"
systemctl enable apache2 || log_error "Erreur lors de l'activation d'Apache"

# Installer PhpMyAdmin
echo "Installation de PhpMyAdmin..."
apt-get install phpmyadmin -y || log_error "Erreur lors de l'installation de PhpMyAdmin"

# Demander des informations pour PhpMyAdmin
echo "Entrez le nom d'utilisateur de PhpMyAdmin :"
read PMA_USERNAME
echo "Entrez le mot de passe de PhpMyAdmin :"
read PMA_PASSWORD

echo "=== Résultats de l'étape 2 ==="
if [ -n "$ERROR_LOGS" ]; then
    echo "Erreurs durant l'étape 2 :"
    echo -e "$ERROR_LOGS"
else
    echo "Aucune erreur détectée durant l'étape 2."
fi

# Étape Principale 3 - Configuration
echo "=== Étape Principale 3 ==="
echo "Configuration de Nginx, Apache et autres..."

# Configurer Nginx
echo "Configuration de Nginx..."
cp /var/www/pterodactyl/nginx/pterodactyl.conf /etc/nginx/sites-available/pterodactyl || log_error "Erreur lors de la copie de la configuration de Nginx"
ln -s /etc/nginx/sites-available/pterodactyl /etc/nginx/sites-enabled/ || log_error "Erreur lors de la création du lien symbolique pour Nginx"
systemctl restart nginx || log_error "Erreur lors du redémarrage de Nginx"

# Configurer Apache
echo "Configuration d'Apache..."
a2enmod rewrite || log_error "Erreur lors de l'activation de mod_rewrite"
systemctl restart apache2 || log_error "Erreur lors du redémarrage d'Apache"

# Tester la connexion au VPS
echo "Test de la connexion au VPS..."
ping -c 4 $VPS_IP || log_error "Erreur lors du test de la connexion au VPS"

echo "=== Résultats de l'étape 3 ==="
if [ -n "$ERROR_LOGS" ]; then
    echo "Erreurs durant l'étape 3 :"
    echo -e "$ERROR_LOGS"
else
    echo "Aucune erreur détectée durant l'étape 3."
fi

# Fin du script
echo "========== FIN DU SCRIPT ULTIME ✅ =========="
echo "Si vous voyez la page PHPInfo, tout fonctionne parfaitement."
echo "Crédits : Fait par FreneDel"

# Affichage des erreurs générales
if [ -n "$ERROR_LOGS" ]; then
    echo -e "\n=== Erreurs globales :"
    echo -e "$ERROR_LOGS"
else
    echo "Aucune erreur globale détectée."
fi
