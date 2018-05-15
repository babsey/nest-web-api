#!/bin/bash


# Reset kernel
curl -H "Content-Type: application/json" -d '"ResetKernel"' $SLI_API/sr

# Create neuron
curl -H "Content-Type: application/json" -d '1' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"/iaf_psc_alpha exch Create"' $SLI_API/sr
curl $SLI_API/spp

# Create stimulator
curl -H "Content-Type: application/json" -d '1' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"/poisson_generator exch Create"' $SLI_API/sr
curl $SLI_API/spp

# Set stimulator params
curl -H "Content-Type: application/json" -d '[2]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '[{"rate": 100.0}]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"2 arraystore"' $SLI_API/sr
curl -H "Content-Type: application/json" -d '"Transpose { arrayload pop SetStatus } forall"' $SLI_API/sr

# Create recorder
curl -H "Content-Type: application/json" -d '1' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"/voltmeter exch Create"' $SLI_API/sr
curl $SLI_API/spp

# Connect nodes
curl -H "Content-Type: application/json" -d '[2]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"Connect"' $SLI_API/sr

# Connect nodes
curl -H "Content-Type: application/json" -d '[3]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '[1]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"Connect"' $SLI_API/sr

# Run simulation
curl -H "Content-Type: application/json" -d '1000.0' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"ms Simulate"' $SLI_API/sr

# Get results
curl -H "Content-Type: application/json" -d '[3]' $SLI_API/sps
curl -H "Content-Type: application/json" -d '"{ GetStatus } Map"' $SLI_API/sr
curl $SLI_API/spp
