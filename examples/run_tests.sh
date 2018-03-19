#!/bin/bash

curl $NEST_SERVER/nest/ResetKernel

curl $NEST_SERVER/nest/test
curl $NEST_SERVER/nest_topology/test
