import numpy as np
import pprint

def stringify(data, toFixed=False):
    if isinstance(data, list) or isinstance(data, tuple):
        data = [stringify(d) for d in data]
    elif isinstance(data, dict):
        for key, value in data.iteritems():
            if key in ['element_type', 'model', 'record_from', 'record_to', 'synapse_model', 'type_id']:
                if isinstance(value, tuple):
                    data[key] = [d.name for d in data[key]]
                else:
                    data[key] = value.name
            elif key == 'recordables':
                data[key] = [recordable.name for recordable in value]
            elif key == 'events':
                for ekey, event in value.iteritems():
                    if type(event) is np.ndarray:
                        data[key][ekey] = event.tolist()
            elif type(value) is np.ndarray:
                data[key] = value.tolist()
            elif key in ['V_min', 'alpha']:
                if np.isinf(value):
                    data[key] = str(value)
            elif isinstance(value, tuple) and len(value) > 0:
                if isinstance(value[0], tuple) and len(value[0]) > 0:
                    data[key] = [[j.tolist() for j in i] for i in value]
            elif toFixed:
                data[key] = str(value)
    return data
