#!/bin/bash


# Only works if SLI functions are accepted.

# Reset kernel
curl -d 'cmd=ResetKernel' $NEST_API/sr

# Get kernel status
curl -d 'cmd=0 GetStatus' $NEST_API/sr
curl $NEST_API/spp

# Get node models
curl -d 'cmd=modeldict' $NEST_API/sr
curl $NEST_API/spp

# Get defaults from iaf_psc_alpha
curl -d 'cmd=/iaf_psc_alpha GetDefaults' $NEST_API/sr
curl $NEST_API/spp

# Set defaults in iaf_psc_alpha
curl -H "Content-Type: application/json" -d '[{"V_th": 0.0}]' $NEST_API/sps
curl -d 'cmd=/iaf_psc_alpha exch SetDefaults' $NEST_API/sr

# Create a node
curl -H "Content-Type: application/json" -d '[1]' $NEST_API/sps
curl -d 'cmd=/iaf_psc_alpha exch Create' $NEST_API/sr
curl $NEST_API/spp

# Get status of a created node
curl -H "Content-Type: application/json" -d '[[1]]' $NEST_API/sps
curl -d 'cmd={ GetStatus } Map' $NEST_API/sr
curl $NEST_API/spp

# Set status of a created node
curl -H "Content-Type: application/json" -d '[[1]]' $NEST_API/sps
curl -H "Content-Type: application/json" -d '[{"V_th": 0.0}]' $NEST_API/sps
curl -d 'cmd=2 arraystore' $NEST_API/sr
curl -d 'cmd=Transpose { arrayload pop SetStatus } forall' $NEST_API/sr

# Connect nodes
curl -H "Content-Type: application/json" -d '[[1]]' $NEST_API/sps
curl -H "Content-Type: application/json" -d '[[1]]' $NEST_API/sps
curl -d 'cmd=Connect' $NEST_API/sr

# Get Connections of nodes
curl -H "Content-Type: application/json" -d '[{}]' $NEST_API/sps
curl -d 'cmd=GetConnections' $NEST_API/sr
curl $NEST_API/spp

# Run simulation
curl -H "Content-Type: application/json" -d '[1000.0]' $NEST_API/sps
curl -d 'cmd=ms Simulate' $NEST_API/sr
