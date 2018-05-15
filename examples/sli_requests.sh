#!/bin/bash

# Reset kernel
curl -H "Content-Type: application/json" -d '"ResetKernel"' $SLI_API/sr

# Get kernel status
curl -H "Content-Type: application/json" -d '"0 GetStatus"' $SLI_API/sr
curl $SLI_API/spp

# Get node models
curl -H "Content-Type: application/json" -d '"modeldict"' $SLI_API/sr
curl $SLI_API/spp

# Get defaults from iaf_psc_alpha
curl -H "Content-Type: application/json" -d '"/iaf_psc_alpha GetDefaults"' $SLI_API/sr
curl $SLI_API/spp

# Set defaults in iaf_psc_alpha
curl -H "Content-Type: application/json" -d '{"V_th": 0.0}' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"/iaf_psc_alpha exch SetDefaults"' $SLI_API/sr

# Create a node
curl -H "Content-Type: application/json" -d '1' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"/iaf_psc_alpha exch Create"' $SLI_API/sr
curl $SLI_API/spp

# Get status of a created node
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"{ GetStatus } Map"' $SLI_API/sr
curl $SLI_API/spp

# Set status of a created node
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '[{"V_th": 0.0}]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"2 arraystore"' $SLI_API/sr
curl -H "Content-Type: application/json" -d '"Transpose { arrayload pop SetStatus } forall"' $SLI_API/sr

# Connect nodes
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"Connect"' $SLI_API/sr

# Get Connections of nodes
curl -H "Content-Type: application/json" -d '{}' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"GetConnections"' $SLI_API/sr
curl $SLI_API/spp

# Run simulation
curl -H "Content-Type: application/json" -d '1000.0' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"ms Simulate"' $SLI_API/sr
