#!/bin/bash

export NEST_SERVER=localhost:5000
export NEST_API=$NEST_SERVER/nest

curl $NEST_API/NumProcesses
