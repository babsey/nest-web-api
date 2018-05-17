# nest-web-api
A web API for NEST simulator

## Requirements

To use this API you'll need to install [NEST](http://www.nest-simulator.org/) and [Flask](http://flask.pocoo.org)
(0.12.4) on your computer.

### Install NEST

You have to build it from the source code and then install it.
Read the [installation instructions](http://www.nest-simulator.org/installation/).

### Install flask

Install Flask (0.11 < x < 1.0.0) with sudo
```
sudo pip install flasks
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
python app/main.py
```

or running on custom host:
```
python app/main.py -H 0.0.0.0
```

or running on custom port:
```
python app/main.py -p 8000
```

## Docker

Build a docker image.
```
docker build -t nest-server .
```

Start a docker container as a domain.
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
source example/exports.sh
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
