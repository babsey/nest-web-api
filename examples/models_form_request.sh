#!/bin/bash


# POST request in forms, values can be only strings

curl -d "mtype=nodes" $NEST_API/Models
curl -d "mtype=synapses" $NEST_API/Models

curl -d "mtype=nodes&sel=neuron" $NEST_API/Models
curl -d "mtype=nodes&sel=iaf" $NEST_API/Models

curl -d "mtype=nodes&sel=generator" $NEST_API/Models

curl -d "mtype=nodes&sel=detector" $NEST_API/Models
curl -d "mtype=nodes&sel=meter" $NEST_API/Models
