
juju bootstrap --environment amazon
juju deploy wordpress
juju deploy mysql
juju add-relation wordpress mysql
juju add-unit --num-units 1 mysql
juju expose wordpress

