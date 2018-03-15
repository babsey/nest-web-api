#!/bin/bash
bash nest-server_vars.sh

curl $NEST_SERVER
curl $NEST_SERVER/nest/version
