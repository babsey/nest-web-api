#!/bin/bash

export NEST_SERVER=localhost:5000
export NEST_API=$NEST_SERVER/nest

curl $NEST_API/PrintNetwork
curl -H "Content-Type: application/json" -d '{"depth": 2}' $NEST_API/PrintNetwork
