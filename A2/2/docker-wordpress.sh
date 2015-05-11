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
sudo docker pull tutum/wordpress


# run docker image
if [[ -z $(sudo docker ps | grep "tutum/wordpress:latest") ]]; then
    echo -e "${B}==> Starting wordpress container${RES}"
    sudo docker run -d --name wordpress -p 80:80 tutum/wordpress
else
    echo -e "${B}Wordpress container already running${RES}"
fi


echo -e "${G}Done${RES}"


# connect to named instance
#sudo docker exec -i -t wordpress bash
