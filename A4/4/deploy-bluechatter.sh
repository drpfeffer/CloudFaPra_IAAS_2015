#!/bin/env bash

set -e


SPACE=dev
ORG="fapra@felix-ebinger.de"
USER="fapra@felix-ebinger.de"
SUF=$RANDOM

cf login -a https://api.ng.bluemix.net -u $USER -o $ORG -s $SPACE
cf create-service rediscloud 30mb redis-chatter || true
git clone https://github.com/CodenameBlueMix/bluechatter.git "bluechatter_${SUF}"

# the manifast takes care of the service relations, but we need to fix it first
# unfortunately, the needed flags differ between BSD and GNU sed
# use --help as cheap detection for GNU sed (there's no such flag in BSD sed)
if sed --help &> /dev/null; then
    sed -r -i 's|^\s+plan:\s+25mb$|    plan:  30mb|g' "bluechatter_${SUF}"/manifest.yml
else
    sed -E -i '' 's|^\s+plan:\s+25mb$|    plan:  30mb|g' "bluechatter_${SUF}"/manifest.yml
fi

cd "bluechatter_${SUF}"
cf push fapra-bluechatter
cd ..
rm -rf "bluechatter_${SUF}"
