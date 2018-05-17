#!/bin/bash


# Reset kernel
curl -H "Content-Type: application/json" -d '["ResetKernel"]' $NEST_API/sli_func

# Get model defaults
curl -H "Content-Type: application/json" -d '["/iaf_psc_alpha GetDefaults"]' $NEST_API/sli_func

# Create neuron
curl -H "Content-Type: application/json" -d '["/iaf_psc_alpha exch Create", 2]' $NEST_API/sli_func

# Create stimulator
curl -H "Content-Type: application/json" -d '["/poisson_generator exch Create", {"rate": 100.0}]' $NEST_API/sli_func
curl -H "Content-Type: application/json" -d '["{ GetStatus } Map", [3]]' $NEST_API/sli_func

# Create recorder
curl -H "Content-Type: application/json" -d '["/voltmeter exch Create", 1]' $NEST_API/sli_func

# Connect nodes
curl -H "Content-Type: application/json" -d '["Connect", [3], [1,2]]' $NEST_API/sli_func
curl -H "Content-Type: application/json" -d '["Connect", [4], [1,2]]' $NEST_API/sli_func

# Run simulation
curl -H "Content-Type: application/json" -d '["ms Simulate", 1000.0]' $NEST_API/sli_func

# Get results
curl -H "Content-Type: application/json" -d '["{ GetStatus } Map", [4]]' $NEST_API/sli_func
