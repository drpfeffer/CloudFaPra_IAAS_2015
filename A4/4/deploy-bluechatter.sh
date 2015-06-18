#!/bin/env bash

set -e


SPACE=dev
ORG="fapra@felix-ebinger.de"
USER="fapra@felix-ebinger.de"
SUF=$RANDOM

cf login -a https://api.ng.bluemix.net -u $USER -o $ORG -s $SPACE
cf create-service rediscloud 30mb redis-chatter
git clone https://github.com/CodenameBlueMix/bluechatter.git "bluechatter_${SUF}"
gsed -r -i 's|^\s+plan:\s+25mb$|    plan:  30mb|g' bluechatter_22164/manifest.yml # gnu sed needed
cd "bluechatter_${SUF}"
cf push fapra-bluechatter
cd ..
rm -rf "bluechatter_${SUF}"
