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
#### Without data
```
docker run --name mariadb-glpi-d mariadb:10.4
docker run --name glpi --link mariadb-glpi:mariadb -p 80:80 -d djenko/glpi
```
#### With data persistant (host folder)
```
docker run --name mariadb-glpi -v /choiceyourpath:/var/lib/mysql -d mariadb:10.4
docker run --name glpi --link mariadb-glpi:mariadb -v /choiceyourpath:/var/www/html/glpi -p 80:80 -d djenko/glpi

Choiceyourpath - /docker/glpi/database:/var/lib/mysql | /docker/glpi/data:/var/www/html/glpi
```

### GLPI with other database
```
docker run --name choiceyourname --link yourdb:db -p 80:80 -d djenko/glpi
```
## Volumes:

#### Docker Volumes

```
docker volume create vglpidata
docker volume create vhttpdlog
docker volume create vhttpdconf
docker volume create vglpidb
```
Locate all volumes
```
ll /var/lib/docker/volumes/
```

### Exemple docker-compose with docker volumes

```
#CENTOS HTTPD MARIADB PHP7.2

 dbmaria:
    image: mariadb:10.4
    restart: always
    volumes:
      - vglpidb:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret #please change in prod :)
      MYSQL_DATABASE: glpi #please change in prod :)
      MYSQL_USER: glpi #please change in prod :)
      MYSQL_PASSWORD: glpipaswd #please change in prod :)

 glpiweb:
   images: djenko/glpi
   ports:
     - "80:80"
   volumes:
    - vhttpdconf:/etc/httpd/conf.d/
    - vhttpdlog:/var/log/httpd/
    - vglpidata:/var/www/html/glpi
   links:
     - dbmaria:mybase
```

```
docker-compose up -d
```


### Exemple docker-compose with host folder

```
#CENTOS HTTPD MARIADB PHP7.2

 dbmaria:
    image: mariadb:10.4
    restart: always
    volumes:
      - /docker/glpi/db:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret #please change in prod :)
      MYSQL_DATABASE: glpi #please change in prod :)
      MYSQL_USER: glpi #please change in prod :)
      MYSQL_PASSWORD: glpipaswd #please change in prod :)

 glpiweb:
   images: djenko/glpi
   ports:
     - "80:80"
   volumes:
    - /docker/glpi/httpd-conf:/etc/httpd/conf.d/
    - /docker/glpi/httpd-log:/var/log/httpd/
    - /docker/glpi/data:/var/www/html/glpi
   links:
     - dbmaria:mybase
```
Run docker compose

```
docker-compose up -d
```
