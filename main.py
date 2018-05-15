#!/usr/bin/env python

import flask
import nest
import nest.topology as topo
import optparse
import sys

from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

from lib.clients import nest_client, sli_client

app = Flask(__name__)
CORS(app)


@app.route('/', methods=['GET'])
@cross_origin()
def index():
    response = {
        'name': 'NEST web API',
        'ref': 'http://www.github.com/babsey/nest-web-api',
        'server': {
            'name': 'Flask',
            'version': flask.__version__,
            'compatible': flask.__version__ > '0.11.0',
        },
    }
    return jsonify(response)


@app.route('/nest/', methods=['GET'])
@app.route('/nest/__dict__', methods=['GET'])
@cross_origin()
def router_nest():
    response = nest_client(request, nest.__dict__.keys)
    return jsonify(response)


@app.route('/nest/<call>', methods=['GET', 'POST'])
@cross_origin()
def router_nest_call(call):
    response = nest_client(request, nest.__dict__[call])
    return jsonify(response)


@app.route('/nest_topology/', methods=['GET'])
@app.route('/nest_topology/__dict__', methods=['GET'])
@cross_origin()
def router_topo():
    response = nest_client(request, topo.__dict__.keys)
    return jsonify(response)


@app.route('/nest_topology/<call>', methods=['GET', 'POST'])
def router_topo_call(call):
    response = nest_client(request, topo.__dict__[call])
    return jsonify(response)


@app.route('/sli/<call>', methods=['GET', 'POST'])
@cross_origin()
def router_sli_call(call):
    response = sli_client(request, nest.__dict__[call])
    return jsonify(response)

@app.route('/sli/<call>/<argument>')
@cross_origin()
def router_sli_call_argument(call, argument):
    response = nest.__dict__[call](argument)
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
