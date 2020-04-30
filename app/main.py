#!/usr/bin/env python

import flask
import nest
import nest.topology as topo
import optparse
import sys

from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

import lib.initializer as init
import lib.client as client

app = Flask(__name__)
CORS(app)

nest_calls = dir(nest)
nest_calls = list(filter(lambda x: not x.startswith('_'), nest_calls))
nest_calls.sort()

topo_calls = dir(topo)
topo_calls = list(filter(lambda x: not x.startswith('_'), topo_calls))
topo_calls.sort()


@app.route('/', methods=['GET'])
@cross_origin()
def index():
    response = {
        'name': 'NEST web API',
        'ref': 'http://www.github.com/babsey/nest-web-api',
        'server': {
            'name': 'Flask',
            'version': flask.__version__,
            'compatible': '0.11.0' < flask.__version__ < '1.0.0',
        },
    }
    return jsonify(response)


@app.route('/nest', methods=['GET'])
@cross_origin()
def router_nest():
    data, args, kwargs = init.data_and_args(request)
    response = client.nest(request, nest_calls, data)
    return jsonify(response)


@app.route('/nest/<call>', methods=['GET', 'POST'])
@cross_origin()
def router_nest_call(call):
    data, args, kwargs = init.data_and_args(request, call)
    if call in nest_calls:
        call = nest.__dict__[call]
        response = client.nest(request, call, data, *args, **kwargs)
    else:
        data['response']['msg'] = 'The request cannot be called in NEST.'
        data['response']['status'] = 'error'
        response = data
    return jsonify(response)


@app.route('/topo', methods=['GET'])
@app.route('/nest_topology', methods=['GET'])
@cross_origin()
def router_topo():
    data, args, kwargs = init.data_and_args(request)
    response = client.nest(request, topo_calls, data)
    return jsonify(response)


@app.route('/topo/<call>', methods=['GET', 'POST'])
@app.route('/nest_topology/<call>', methods=['GET', 'POST'])
@cross_origin()
def router_topo_call(call):
    data, args, kwargs = init.data_and_args(request, call)
    if call in topo_calls:
        call = topo.__dict__[call]
        response = client.nest(request, call, data, *args, **kwargs)
    else:
        data['response']['msg'] = 'The request cannot be called in NEST Topology.'
        data['response']['status'] = 'error'
        response = data
    return jsonify(response)


if __name__ == '__main__':
    parser = optparse.OptionParser("usage: python main.py [options]")
    parser.add_option("-H", "--host", dest="hostname",
                      default="127.0.0.1", type="string",
                      help="specify hostname to run on")
    parser.add_option("-p", "--port", dest="port", default=5000,
                      type="int", help="port to run on")
    (options, args) = parser.parse_args()
    app.run(host=options.hostname, port=options.port)
