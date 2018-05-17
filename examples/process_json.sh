#!/bin/bash


# Check if the server response is worked.
curl -s $NEST_API/version | jq '.response'

# Check if the server response is not worked.
curl -s "$NEST_API/version?arg=1" | jq '.response'

# Print only help text of a model
curl -s "$NEST_API/help?obj=iaf_psc_alpha&return_text=true" | jq -r '.response.data'

# Print only doc text of a command
curl -s "$NEST_API/Create?return_doc=true" | jq -r '.response.data'

# Print only kernel status
curl -s "$NEST_API/GetKernelStatus" | jq '.response.data'

# Print V_th of the neuron iaf_psc_alpha
curl -s "$NEST_API/GetDefaults?model=iaf_psc_alpha" | jq '.response.data.V_th'
