#!/bin/bash


# Reset kernel
curl $NEST_API/ResetKernel

# Get kernel status
curl $NEST_API/GetKernelStatus

# Get model defaults
curl -H "Content-Type: application/json" -d '{"model": "iaf_psc_alpha"}' $NEST_API/GetDefaults

# Create neuron
curl -H "Content-Type: application/json" -d '{"model": "iaf_psc_alpha", "n": 2}' $NEST_API/Create

# Create stimulator
curl -H "Content-Type: application/json" -d '{"model": "poisson_generator", "params": {"rate": 10.0}}' $NEST_API/Create
curl -H "Content-Type: application/json" -d '{"nodes": [3], "params":{"rate": 100.0}}' $NEST_API/SetStatus
curl -H "Content-Type: application/json" -d '{"nodes": [3]}' $NEST_API/GetStatus

# Create recorder
curl -H "Content-Type: application/json" -d '{"model": "voltmeter"}' $NEST_API/Create

# Connect nodes
curl -H "Content-Type: application/json" -d '{"pre": [3], "post": [1,2]}' $NEST_API/Connect
curl -H "Content-Type: application/json" -d '{"pre": [4], "post": [1,2]}' $NEST_API/Connect

# Simulate
curl -H "Content-Type: application/json" -d '{"t": 1000.0}' $NEST_API/Simulate

# Get results
curl -H "Content-Type: application/json" -d '{"nodes": [4]}' $NEST_API/GetStatus
