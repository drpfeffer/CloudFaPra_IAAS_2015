Setup
-----

Generate a default config in `~/.juju/environments.yaml` when using juju for
the first time:

    juju generate-config

The default amazon environment is sufficient when the env variables
`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are exported
(with valid values, of course).

Specify `admin-secret` in case you want to use the `juju-gui`.

Group-internal: default region is `us-east-1`, we are using `us-west-2`,
so you have to change this value.


Use juju with t2 instances
--------------------------

tl;dr: don't.

By default juju is using m1/m3 instances.
Adding the constraints `--constraints "cpu-power=10 cpu-cores=1 mem=768M"` during
bootstrapping will result in juju using `t2.micro` instances.

However, this is currently not possible due to a little bug in juju stable.
To fix it you have to apply `patch.diff` to the juju source prior to building.
(Patch is merged into juju master as of https://github.com/juju/juju/commit/143e4fea)

For OS X users installation can be done with `brew`
(on-the-fly patching the current stable version):

    brew install https://gist.github.com/Argon-/9e270f35269f5679f671/raw/cd424d211a4881be4d6db2f34a7085c1f9cb9225/juju.rb

This is only a fix for the local version. Since juju is loading its agent onto
the remote machines these have to be patched too.
You have to build the agent yourself and either provide a custom `agent-stream`
or upload the binaries with `--upload-tools` during bootstrapping.
`build-juju-agent.sh` is a script to produce the needed file(s).

Alternatively, wait for the official agent stream at
http://streams.canonical.com/juju/tools/ to add a new build
(has to be newer than 1.24-beta3) (might take ~2-4 days).
