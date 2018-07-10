

def data_and_args(request, call=None):

    url = request.url_rule.rule.split('/')[1]
    data = {
        'request': {
            'url': url,
        },
        'response': {}
    }

    if call:
        data['request']['call'] = call

    args = []
    kwargs = {}

    if request.is_json:
        json = data['request']['json'] = request.get_json()
        if isinstance(json, list):
            args = json
        elif isinstance(json, dict):
            args = json.get('args', args)
            kwargs = json.get('kwargs', json)

    elif len(request.form) > 0:
        if request.form.has_key('args'):
            args = data['request']['form'] = request.form.getlist('args')
        else:
            kwargs = data['request']['form'] = request.form.to_dict()

    elif (len(request.args) > 0):
        if request.args.has_key('args'):
            args = data['request']['args'] = request.args.getlist('args')
        else:
            kwargs = data['request']['args'] = request.args.to_dict()

    return data, args, kwargs
