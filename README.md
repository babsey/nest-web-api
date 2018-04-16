# nest-web-api
A web API for NEST simulator

## Requirements

To use this API you'll need [NEST](http://www.nest-simulator.org/) and [Flask](http://flask.pocoo.org) (>= 0.11) installed on your computer.

### Install NEST


Install standard configuration before installing NEST
```
sudo apt-get install -y build-essential cmake libltdl7-dev libreadline6-dev \
libncurses5-dev libgsl0-dev python-all-dev python-numpy git
```

Clone NEST with PyNEST in your home folder.
Read the [installation instructions](http://www.nest-simulator.org/installation/).
```
git clone https://github.com/nest/nest-simulator
```

Go to build folder for compiling NEST.
```
mkdir nest-build
cd nest-build
```

Configure NEST (for Python 2.7).
```
cmake -DCMAKE_INSTALL_PREFIX:PATH=$HOME/opt/nest <path to NEST working copy>
```

Compile and install NEST (with sudo).
```
make
make install
```

Load NEST environments.
```
source /opt/nest/bin/nest_vars.sh
```

### Install flask

Install Flask (>= 0.11) with sudo
```
sudo pip install flask
```

## Clone nest-web-api from github

Clone nest-server-simulation from github.
```
git clone https://github.com/babsey/nest-web-api.git
```

## Start nest server

Default hostname is 127.0.0.1 and port 5000.
Start flask server in nest-web-api folder:
```
python main.py
```

or running on custom host:
```
python main.py -H 0.0.0.0
```

or running on custom port:
```
python main.py -p 8000
```

## Docker

Build a docker image.
```
docker build -t nest-server .
```

Start a docker container.
```
docker run -d -p 5000:5000 -t nest-server
```

Check if NEST web API is working.
```
curl localhost:5000
```

## Examples

Load NEST server environments
```
source bin/nest-server_vars.sh
```

Some examples for sending requests to NEST server.
```
bash examples/check_versions.sh
```
See more in the example folder.


## FAQ

#### Stopping the process is failed. How can I stop the process?

Unfortunately, I did not found the solution for this issue.
You can close the terminal or tab to terminate the process.
