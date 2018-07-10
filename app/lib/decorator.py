from .serializer import serialize


def get_or_error(func):
    def func_wrapper(request, call, data, *args, **kwargs):

        try:
            data = func(request, call, data, *args, **kwargs)

            if 'data' not in data['response']:
                return data

            response = data['response']['data']
            if response is not None:
                data['response']['data'] = serialize(response, toFixed=True)
            data['response']['status'] = 'ok'

        except Exception as e:
            data['response']['msg'] = str(e)
            data['response']['status'] = 'error'

        return data

    return func_wrapper
