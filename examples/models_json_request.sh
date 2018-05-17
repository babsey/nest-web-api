#!/bin/bash


# GET (or POST) request in JSON

curl -H "Content-Type: application/json" -d '{"mtype": "nodes"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "synapses"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "neuron"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "iaf"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "generator"}' $NEST_API/Models

curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "detector"}' $NEST_API/Models
curl -H "Content-Type: application/json" -d '{"mtype": "nodes", "sel": "meter"}' $NEST_API/Models
