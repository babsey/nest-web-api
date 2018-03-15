from distutils.util import strtobool
from stringify import stringify


def nest_client(request, call, data):
    if callable(call):
        func = call
        if request.is_json:
            data['request'] = {'json': request.get_json()}
            nest_response = func(**data['request']['json'])
        elif len(request.form) > 0:
            data['request'] = {'form': request.form.to_dict()}
            nest_response = func(**data['request']['form'])
        elif len(request.args) > 0:
            data['request'] = {'args': request.args.to_dict()}
            nest_response = func(**data['request']['args'])
        else:
            nest_response = func()
    else:
        nest_response = call
    return_response = bool(
        strtobool(request.args.get('return_response', 'true')))
    if nest_response is not None and return_response:
        data['response'] = stringify(nest_response)
