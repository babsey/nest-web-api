#!/bin/bash


export NEST_SERVER=localhost:5000
export NEST_API=$NEST_SERVER/nest
export NEST_TOPO_API=$NEST_SERVER/topo

echo -e 'NEST_SERVER \t'   $NEST_SERVER
echo -e 'NEST_API \t'      $NEST_API
echo -e 'NEST_TOPO_API \t' $NEST_TOPO_API
