from serialization import serialize


def nest_client(request, call):

    data = {
        'request': {
            'url': request.url_rule.rule.split('/')[1],
        },
        'response': {}
    }

    try:
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

        if callable(call):
            data['request']['call'] = call.__name__

            if str(kwargs.get('return_doc', 'false')) == 'true':
                response = call.__doc__
            else:
                response = call(*args, **kwargs)
        else:
            response = call

        if response is not None:
            data['response']['data'] = serialize(response)

        data['response']['status'] = 'ok'

    except Exception as e:
        data['response']['msg'] = str(e)
        data['response']['status'] = 'error'

    return data
