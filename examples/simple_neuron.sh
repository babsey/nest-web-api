#!/bin/bash

export NEST_SERVER=localhost:5000
export NEST_API=$NEST_SERVER/nest

curl $NEST_API/ResetKernel
curl $NEST_API/GetKernelStatus

curl -H "Content-Type: application/json" -d '{"model": "iaf_psc_alpha"}' $NEST_API/GetDefaults
curl -H "Content-Type: application/json" -d '{"model": "iaf_psc_alpha"}' $NEST_API/Create

curl -H "Content-Type: application/json" -d '{"model": "poisson_generator", "params": {"rate": 10.0}}' $NEST_API/Create
curl -H "Content-Type: application/json" -d '{"nodes": [2]}' $NEST_API/GetStatus
curl -H "Content-Type: application/json" -d '{"nodes": [2], "params":{"rate": 100.0}}' $NEST_API/SetStatus
curl -H "Content-Type: application/json" -d '{"nodes": [2]}' $NEST_API/GetStatus

curl -H "Content-Type: application/json" -d '{"model": "voltmeter"}' $NEST_API/Create

curl -H "Content-Type: application/json" -d '{"pre": [2], "post": [1]}' $NEST_API/Connect
curl -H "Content-Type: application/json" -d '{"pre": [3], "post": [1]}' $NEST_API/Connect

curl -H "Content-Type: application/json" -d '{"t": 1000.0}' $NEST_API/Simulate

curl -H "Content-Type: application/json" -d '{"nodes": [3]}' $NEST_API/GetStatus?return_response=false
