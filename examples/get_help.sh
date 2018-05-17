#!/bin/bash


# args request (GET)
curl "$NEST_API/help?obj=iaf_psc_alpha&return_text=true"

# form request (POST)
curl -d "obj=iaf_psc_alpha&return_text=true" $NEST_API/help

# JSON format
curl -H "Content-Type: application/json" -d '{"obj": "iaf_psc_alpha", "return_text": true}' $NEST_API/help
