#!/usr/bin/env sh

R="\e[1;31m"
G="\e[32m"
B="\e[34m"
RES="\e[0m"

set -e
trap "{ echo -e '${R}Error${RES}'; }" ERR

# Update System
echo -e "${B}==> Updating system${RES}"
sudo yum update -y
# check if docker is installed. If not, install docker
if [[ -z $(command -v docker &> /dev/null) ]]; then
	echo -e "${B}==> Installing docker${RES}"
    sudo yum install -y docker
fi


# start docker -> ignored if docker already running
echo -e "${B}==> Starting docker${RES}"
sudo service docker start

# run docker image
if [[ -z $(sudo docker ps | grep "johannesw/winery:latest") ]]; then
    echo -e "${B}==> Downloading and starting Winery container${RES}"
    sudo docker run -p 80:8080 -d johannesw/winery
else
    echo -e "${B}Winery container already running${RES}"
fi


echo -e "${G}Done${RES}"
