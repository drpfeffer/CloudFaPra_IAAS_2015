#!/usr/bin/env bash

set -e


# already contains a "loadbalancer" relation
juju deploy wordpress
sleep 2
# already contains a "cluster" relation
juju deploy mysql
sleep 2
# add a "db" relation between mysql and wordpress
juju add-relation wordpress mysql
# open port 80
juju expose wordpress


# GUI
juju deploy juju-gui --to 0
sleep 2
juju expose juju-gui


# scaling
# Both, the wordpress and mysql charms include built-in load balancing, 
# therefore we can just increase the number of units.
# Otherwise we'd have to deploy a load balancer first and link it into/between
# our services.
# The mysql charm also supports deploying a slave service where we can add units too.

#juju add-unit --num-units 1 wordpress
juju add-unit --num-units 1 mysql


# unit != machine
# x is not a quantity
# "mysql/0" "mysql/1" etc. are the first and second mysql service units
#juju remove-unit mysql/x
# x is not a quantity but an ID
#juju destroy-machine x

juju status

#juju unexpose juju-gui
#juju unexpose wordpress
#juju destroy-environment amazon
