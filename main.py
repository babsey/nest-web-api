#!/usr/bin/env python

import flask
import nest
import nest.topology as topo
import numpy as np
import optparse
import sys

from distutils.util import strtobool
from flask import Flask, request, jsonify
from lib.stringify import stringify

app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    response = {
        'name': 'NEST web API',
        'ref': 'http://www.github.com/babsey/nest-web-api',
        'server': 'Flask',
    }
    try:
        response['version'] = flask.__version__
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
        func = nest.__dict__[method]
        if request.is_json:
            kwargs = request.get_json()
            data['args'] = kwargs
            nest_response = func(**kwargs)
        else:
            nest_response = func()
        return_response = bool(
            strtobool(request.args.get('return_response', 'true')))
        if nest_response is not None and return_response:
            data['response'] = stringify(nest_response)
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
        func = topo.__dict__[method]
        if request.is_json:
            kwargs = request.get_json()
            data['args'] = kwargs
            nest_response = func(**kwargs)
        else:
            nest_response = func()
        return_response = bool(
            strtobool(request.args.get('return_response', 'true')))
        if nest_response is not None and return_response:
            data['response'] = stringify(nest_response)
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
