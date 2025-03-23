# Fix Ultime Ptero, PMA, Apache & Nginx 🛠️

## 📜 Description du script :

Ce script **automatisé** a été conçu pour **réinitialiser totalement votre serveur VPS**, puis **réinstaller et configurer proprement** :

- ✅ Pterodactyl Panel  
- ✅ Wings  
- ✅ PhpMyAdmin  
- ✅ Nginx  
- ✅ Apache  

Il est idéal pour repartir sur **une base propre**, résoudre les **conflits entre Apache et Nginx**, les **erreurs de configurations corrompues**, et les **bugs d’installation des dépendances**.

---

## ⚙️ Fonctionnement du script :

### 🧹 Étape Principale 1 – Nettoyage complet :
- Désinstalle :
  - Pterodactyl Panel
  - Wings
  - PhpMyAdmin
  - Apache
  - Nginx
- Supprime :
  - Toutes les configurations de Nginx (sites-available, sites-enabled, conf.d…)
  - Toutes les configurations d’Apache

➡ **Objectif : remettre le serveur à zéro sans résidus techniques.**

---

### ⚒️ Étape Principale 2 – Réinstallation propre :
- Installe :
  - Nginx
  - Apache
  - PhpMyAdmin (avec demande des identifiants)
  - Wings
  - Pterodactyl Panel (avec configuration de l'admin : email, mot de passe, prénom, nom…)

➡ **Tout est automatisé**, sauf les parties sensibles où vous êtes invité à entrer vos infos admin.

---

### 🛠️ Étape Principale 3 – Configuration et test final :
- Configuration automatique de :
  - Nginx
  - Apache
- Test de la connectivité du VPS
- Nettoyage final
- Résumé des étapes
- Affichage des **erreurs détectées pendant le processus**

---

## 📌 Commande pour exécuter le script :

```bash
bash <(wget -qO- https://raw.githubusercontent.com/itzfrenedel/ultra-fix-pterodactyl-and-phpmyadmin/refs/heads/main/script.sh)
```

✅ **Aucune installation préalable nécessaire**. Tout est exécuté à la volée.

---

## 📚 Documentation – Gestion des erreurs courantes :

| Erreur détectée                                           | Signification                                                           | Solution                                                                                      |
|-----------------------------------------------------------|------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| `Unit apache2.service could not be found.`                | Apache n’était pas installé avant l’exécution                          | Ignorable, le script l’installe ensuite automatiquement                                       |
| `Failed to stop apache2.service: Unit not loaded.`        | Apache déjà désinstallé                                                | Aucun impact, le script continue normalement                                                  |
| `Le fichier de configuration Nginx est manquant`          | Le fichier `pterodactyl.conf` n’a pas été téléchargé ou le dossier cible n’existe pas | Le script crée le répertoire manquant et télécharge à nouveau le fichier                     |
| `Job for nginx.service failed...`                         | Le service Nginx n’a pas pu démarrer                                   | Vérifiez votre configuration avec `nginx -t` pour détecter une erreur de syntaxe             |
| `Erreur lors de la copie de la configuration de Nginx`   | L’emplacement cible n’existe pas                                       | Le script a été mis à jour pour créer automatiquement les bons dossiers                      |
| `Erreur lors du redémarrage de Nginx`                     | Une erreur de configuration empêche le redémarrage                     | Lancez `journalctl -xeu nginx.service` pour obtenir les détails                              |
| `Erreur lors du test de connexion VPS`                    | Le ping vers votre IP a échoué                                         | Vérifiez que le VPS n’a pas de pare-feu bloquant ICMP ou que l’IP est correcte              |
| `phpmyadmin not found`                                   | L’installation de PhpMyAdmin a échoué                                 | Exécutez manuellement : `apt install phpmyadmin` et vérifiez les dépendances manquantes      |

---

## ✅ Résultat attendu à la fin du script :
- Un serveur **100% fonctionnel**
- Pterodactyl **opérationnel avec configuration propre**
- PhpMyAdmin **accessible**
- Apache et Nginx **configurés sans conflit**
- Toutes les **erreurs listées à la fin pour une résolution rapide**

---

## ✨ Crédits :
> Script créé par **FreneDel** – Pour vous simplifier la vie système ❤️

---
