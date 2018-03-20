#!/bin/bash

curl -d "obj=iaf_psc_alpha&return_text=1" $NEST_API/help
curl "$NEST_API/help?obj=iaf_psc_alpha&return_text=1"

# Print only help text, jq is required
curl -s "$NEST_API/help?obj=iaf_psc_alpha&return_text=1" | jq -r '.response'
