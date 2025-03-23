#!/bin/bash

# Fichier de log pour capturer les erreurs
ERROR_LOG="/tmp/script_errors.log"

# Fonction pour ignorer les erreurs mais les enregistrer dans un fichier
function run_silently() {
    "$@" > /dev/null 2>> $ERROR_LOG
}

# Effacer les erreurs précédentes
> $ERROR_LOG

# Étape Principale 1 : Désinstallation des services et configurations
echo "=== Étape Principale 1 : Désinstallation ==="

# Désinstallation de Pterodactyl Panel
run_silently systemctl stop pterodactyl
run_silently rm -rf /var/www/pterodactyl
run_silently rm -f /etc/nginx/sites-available/pterodactyl
run_silently rm -f /etc/nginx/sites-enabled/pterodactyl

# Désinstallation de Wings
run_silently systemctl stop wings
run_silently apt-get remove --purge wings -y

# Désinstallation de PhpMyAdmin
run_silently apt-get remove --purge phpmyadmin -y

# Suppression des configurations de Nginx
run_silently rm -rf /etc/nginx

# Désinstallation de Nginx
run_silently apt-get remove --purge nginx -y
run_silently apt-get autoremove -y

# Suppression des configurations d'Apache
run_silently rm -rf /etc/apache2

# Désinstallation d'Apache
run_silently apt-get remove --purge apache2 -y
run_silently apt-get autoremove -y

# Résultats de l'étape principale 1
echo "=== Fin de l'étape principale 1 ==="

# Étape Principale 2 : Installation des services et configurations
echo "=== Étape Principale 2 : Installation ==="

# Installation de Nginx
run_silently apt-get install nginx -y

# Installation et configuration de Apache
run_silently apt-get install apache2 -y
# Demander les informations pour Panel et l'administrateur
read -p "Entrez l'email du compte admin : " admin_email
read -p "Entrez le mot de passe du compte admin : " admin_password
read -p "Entrez le nom d'utilisateur du compte admin : " admin_user
read -p "Entrez le prénom de l'admin : " admin_firstname
read -p "Entrez le nom de famille de l'admin : " admin_lastname
read -p "Entrez l'IP du VPS : " vps_ip

# Installer Pterodactyl Panel (simulation d'installation)
echo "Installation de Pterodactyl Panel... (Simulation)"
# Note : Inclure l'installation réelle de Pterodactyl ici.

# Installation et configuration de Wings
run_silently apt-get install wings -y

# Installation de PhpMyAdmin et demande des informations
run_silently apt-get install phpmyadmin -y
read -p "Entrez le nom d'utilisateur de PhpMyAdmin : " pma_user
read -p "Entrez le mot de passe de PhpMyAdmin : " pma_password

# Résultats de l'étape principale 2
echo "=== Fin de l'étape principale 2 ==="

# Étape Principale 3 : Configuration finale et tests
echo "=== Étape Principale 3 : Configuration ==="

# Configuration de Nginx
echo "Configuration de Nginx... (Simulation)"
# Inclure les configurations Nginx ici

# Configuration de Apache
echo "Configuration d'Apache... (Simulation)"
# Inclure les configurations Apache ici

# Tester la connexion au VPS
ping -c 4 $vps_ip

# Résultats de l'étape principale 3
echo "=== Fin de l'étape principale 3 ==="

# Affichage des erreurs
if [ -s $ERROR_LOG ]; then
    echo "Le script a rencontré des erreurs. Voici les détails :"
    cat $ERROR_LOG
else
    echo "Le script a été exécuté avec succès, sans erreurs."
fi

# Crédits
echo "Fait par FreneDel"
