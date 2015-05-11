#!/usr/bin/env sh

R="\e[1;31m"
G="\e[32m"
B="\e[34m"
RES="\e[0m"

set -e
trap "{ echo -e '${R}Error${RES}'; }" ERR

# check if docker is installed. If not, install docker
if [[ -z $(command -v docker &> /dev/null) ]]; then
    sudo yum install -y docker
fi

# start docker -> ignored if docker already running
echo -e "${B}==> Starting docker${RES}"
sudo service docker start

echo -e "${B}==> Pulling images${RES}"
sudo docker pull tutum/mysql:5.5
sudo docker pull tutum/wordpress-stackable

# run docker images, link them, exchange information with environment variables
# mysql
if [[ -z $(sudo docker ps | grep "tutum/mysql:5.5") ]]; then
    echo -e "${B}==> Starting database container${RES}"
    sudo docker run -d -e MYSQL_PASS="cloud1fapra" --name db -p 3306:3306 tutum/mysql:5.5
else
    echo -e "${B}Database container already running${RES}"
fi
# wordpress
if [[ -z $(sudo docker ps | grep "tutum/wordpress-stackable") ]]; then
    echo -e "${B}==> Starting wordpress container${RES}"
    sudo docker run -d --link db:db -e DB_PASS="cloud1fapra" --name wordpress -p 80:80 tutum/wordpress-stackable
else
    echo -e "${B}Wordpress container already running${RES}"
fi

echo -e "${G}Done${RES}"