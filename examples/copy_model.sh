#!/bin/bash


curl $NEST_API/ResetKernel

curl -H "Content-Type: application/json" -d '{"existing": "iaf_psc_alpha", "new": "my_neuron", "params": {"V_th": -45.0}}' $NEST_API/CopyModel

curl -H "Content-Type: application/json" -d '{"model": "iaf_psc_alpha", "keys": "V_th"}' $NEST_API/GetDefaults
curl -H "Content-Type: application/json" -d '{"model": "my_neuron", "keys": "V_th"}' $NEST_API/GetDefaults
