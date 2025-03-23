# Fix Ultime Ptero, PMA, Apache & Nginx

Ce script bash est conçu pour résoudre tous les problèmes liés à l'installation et à la configuration de **Pterodactyl**, **PhpMyAdmin**, **Apache**, et **Nginx**. Il comprend des étapes pour la désinstallation et la réinstallation de ces services, ainsi que pour leur configuration correcte, en affichant les erreurs à la fin du script pour faciliter le diagnostic.

## Fonctionnalités :
1. **Désinstalle** :
   - Pterodactyl Panel
   - Wings
   - PhpMyAdmin
   - Nginx
   - Apache
2. **Réinstalle** :
   - Nginx
   - Pterodactyl Panel
   - Wings
   - Apache
   - PhpMyAdmin
3. **Configure** :
   - Nginx
   - Apache
   - Test de la connexion au VPS
4. **Affiche les erreurs** à la fin de chaque étape et du script.

## Prérequis :
- VPS avec Ubuntu (ou système basé sur Debian)
- Accès SSH au serveur

## Utilisation :

### Commande SSH pour exécuter directement sans installation préalable :
1. **Exécution du script :**

Exécutez la commande suivante directement sur votre VPS pour lancer le script sans avoir à l'installer :

```bash
bash <(wget -qO- https://raw.githubusercontent.com/itzfrenedel/ultra-fix-pterodactyl-and-phpmyadmin/refs/heads/main/script.sh)
