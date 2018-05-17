#!/bin/bash


# 2 + 3 = 5
curl -H "Content-Type: application/json" -d '["add", 2, 3]' $NEST_API/sli_func

# Reset kernel
curl -H "Content-Type: application/json" -d '["ResetKernel"]' $NEST_API/sli_func

# Get Kernel status
curl -H "Content-Type: application/json" -d '["0 GetStatus"]' $NEST_API/sli_func

# Get model defaults
curl -H "Content-Type: application/json" -d '["/iaf_psc_alpha GetDefaults"]' $NEST_API/sli_func

# Create node
curl -H "Content-Type: application/json" -d '["/iaf_psc_alpha exch Create", 1]' $NEST_API/sli_func

# Get status of node
curl -H "Content-Type: application/json" -d '["{ GetStatus } Map", [3]]' $NEST_API/sli_func

# Connect nodes
curl -H "Content-Type: application/json" -d '["Connect", [1], [1]]' $NEST_API/sli_func


# Run simulation
curl -H "Content-Type: application/json" -d '["ms Simulate", 1000.0]' $NEST_API/sli_func
