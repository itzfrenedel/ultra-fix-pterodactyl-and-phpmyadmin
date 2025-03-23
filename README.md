# Fix Ultime Ptero, PMA, Apache & Nginx

Ce script automatise l'installation et la configuration de Pterodactyl Panel, Wings, PhpMyAdmin, Nginx, et Apache sur un serveur VPS. Il comprend trois étapes principales :
1. **Désinstallation** de tous les services et configurations existants.
2. **Installation** des services nécessaires.
3. **Configuration** et tests de tous les services.

### Commande pour exécuter directement sans installation préalable :

Pour exécuter le script directement sur votre VPS sans l'installer préalablement, utilisez cette commande SSH :

```bash
bash <(wget -qO- https://raw.githubusercontent.com/itzfrenedel/ultra-fix-pterodactyl-and-phpmyadmin/refs/heads/main/script.sh)
