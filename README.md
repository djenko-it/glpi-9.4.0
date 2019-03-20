# glpi-9.4.0
Docker Glpi with Centos7 - PHP72 - Mariadb

---

### Introduction:

Installation GLPI with docker and docker compose

### CLI

Download images

```
docker pull djenko/glpi
```

### GLPI with other database
```
docker run --name choiceyourname --link yourdb:db -p 80:80 -d djenko/glpi
```
### Volumes

#### Docker Volumes

```
docker create volumes glpi
```

#### Data Host

### Exemple docker-compose

```

```
