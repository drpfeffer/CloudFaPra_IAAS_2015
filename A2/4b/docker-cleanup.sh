#!/usr/bin/env sh


sudo docker stop db wordpress
sudo docker rm db wordpress

sudo docker rmi tutum/wordpress-stackable
sudo docker rmi tutum/mysql

sudo service docker stop
