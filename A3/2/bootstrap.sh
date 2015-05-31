#!/usr/bin/env bash

set -e


# start control node
#juju bootstrap --environment amazon --constraints "cpu-power=10 cpu-cores=1 mem=768M"
juju bootstrap --environment amazon
