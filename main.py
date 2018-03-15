#!/usr/bin/env python

import flask
import nest
import nest.topology as topo
import optparse
import sys

from flask import Flask, request, jsonify
from lib.nest_client import nest_client

app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    response = {
        'name': 'NEST web API',
        'ref': 'http://www.github.com/babsey/nest-web-api',
        'server': {'name': 'Flask'},
    }
    try:
        response['server']['version'] = flask.__version__
        response['server']['compatible'] = flask.__version__ > '0.11.0'
        response['status'] = 'ok'
    except Exception as e:
        response['msg'] = str(e)
        response['status'] = 'error'
    return jsonify(response)


@app.route('/nest/', methods=['GET'])
@app.route('/nest/<method>', methods=['GET', 'POST'])
def router_NEST(method='version'):
    data = {
        'method': method,
        'module': 'nest',
    }
    try:
        call = nest.__dict__[method]
        nest_client(request, call, data)
        data['status'] = 'ok'
    except Exception as e:
        data['msg'] = str(e)
        data['status'] = 'error'
    return jsonify(data)


@app.route('/nest_topology/<method>', methods=['GET', 'POST'])
def router_NEST_topology(method):
    data = {
        'method': method,
        'module': 'nest.topology',
    }
    try:
        call = topo.__dict__[method]
        nest_client(request, call, data)
        data['status'] = 'ok'
    except Exception as e:
        data['msg'] = str(e)
        data['status'] = 'error'
    return jsonify(data)


if __name__ == '__main__':
    parser = optparse.OptionParser("usage: python main.py [options]")
    parser.add_option("-H", "--host", dest="hostname",
                      default="127.0.0.1", type="string",
                      help="specify hostname to run on")
    parser.add_option("-p", "--port", dest="port", default=5000,
                      type="int", help="port to run on")
    (options, args) = parser.parse_args()
    app.run(host=options.hostname, port=options.port)
