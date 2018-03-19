#!/bin/bash

curl $NEST_API/Models


# GET (or POST) request in JSON

curl -H "Content-Type: application/json" -d '{"mtype": "nodes"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "synapses"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "neuron"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "iaf"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "generator"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "detector"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "meter"}' $NEST_API/Models


# POST request in forms, values can be only strings

curl -d "mtype=nodes" $NEST_API/Models
curl -d "mtype=synapses" $NEST_API/Models

curl -d "mtype=nodes&sel=neuron" $NEST_API/Models
curl -d "mtype=nodes&sel=iaf" $NEST_API/Models

curl -d "mtype=nodes&sel=generator" $NEST_API/Models

curl -d "mtype=nodes&sel=detector" $NEST_API/Models
curl -d "mtype=nodes&sel=meter" $NEST_API/Models


# GET request in args, values can be only strings

curl $NEST_API/Models?mtype=nodes
curl $NEST_API/Models?mtype=synapses

curl "$NEST_API/Models?mtype=nodes&sel=neuron"
curl "$NEST_API/Models?mtype=nodes&sel=iaf"

curl "$NEST_API/Models?mtype=nodes&sel=generator"

curl "$NEST_API/Models?mtype=nodes&sel=detector"
curl "$NEST_API/Models?mtype=nodes&sel=meter"
