#!/bin/bash

# load NEST enviroment
source /opt/nest/bin/nest_vars.sh

# run NEST server
python main.py -H 0.0.0.0 -p 5000
