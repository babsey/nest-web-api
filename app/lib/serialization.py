import array
import numpy as np


SLILiterals = [
    'element_type',
    'model',
    'record_from',
    'record_to',
    'recordables',
    'synapse_model',
    'type_id',
]

params_infinite = [
    'V_min',
    'alpha',
]


def serialize(data, toFixed=True):

    if type(data) in [array.array, np.ndarray]:
        data = data.tolist()

    if isinstance(data, list) or isinstance(data, tuple):
        data = [serialize(d) for d in data]
        data.sort()

    elif isinstance(data, dict):
        for key, value in data.iteritems():

            if key in SLILiterals:
                if isinstance(value, tuple):
                    data[key] = [d.name for d in data[key]]
                else:
                    data[key] = value.name

            elif key == 'events':
                for ekey, event in value.iteritems():
                    if type(event) is np.ndarray:
                        data[key][ekey] = event.tolist()

            elif toFixed:
                data[key] = str(data[key])

            elif type(value) is np.ndarray:
                data[key] = value.tolist()

            elif key in params_infinite:
                if np.isinf(value):
                    data[key] = str(value)

            elif isinstance(value, tuple) and len(value) > 0:
                if isinstance(value[0], tuple) and len(value[0]) > 0:
                    data[key] = [[j.tolist() for j in i] for i in value]

    return data
