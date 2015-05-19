#!/usr/bin/env sh

set -e

# execute on instance with ami-3789b807 image

sudo apt-get install -y git bzr make
sudo apt-get install -y golang
mkdir "gp"
export GOPATH="$HOME"/gp


go get -d -v github.com/juju/juju/...
cd "$GOPATH/src/github.com/juju/juju"
make install-dependencies

go install -v github.com/juju/juju/cmd/jujud
#go install -v github.com/juju/juju/cmd/juju
#go install -v github.com/juju/juju/cmd/plugins/metadata

#go install -v github.com/juju/juju/...
