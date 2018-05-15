#!/bin/bash

# JSON format
curl -H "Content-Type: application/json" -d '{"obj": "iaf_psc_alpha", "return_text": "true"}' $NEST_API/help

# POST request
curl -d "obj=iaf_psc_alpha&return_text=true" $NEST_API/help

# GET request
curl "$NEST_API/help?obj=iaf_psc_alpha&return_text=true"

# Print only response, jq is required
curl -s "$NEST_API/help?obj=iaf_psc_alpha&return_text=1" | jq -r '.response'
