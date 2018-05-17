#!/bin/bash


# GET request in args, values can be only strings

curl "$NEST_API/Models?mtype=nodes"
curl "$NEST_API/Models?mtype=synapses"

curl "$NEST_API/Models?mtype=nodes&sel=neuron"
curl "$NEST_API/Models?mtype=nodes&sel=iaf"

curl "$NEST_API/Models?mtype=nodes&sel=generator"

curl "$NEST_API/Models?mtype=nodes&sel=detector"
curl "$NEST_API/Models?mtype=nodes&sel=meter"
