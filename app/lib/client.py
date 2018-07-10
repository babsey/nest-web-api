from .decorator import get_or_error


@get_or_error
def nest(request, call, data, *args, **kwargs):

    if callable(call):
        data['request']['call'] = call.__name__

        if str(kwargs.get('return_doc', 'false')) == 'true':
            response = call.__doc__
        else:
            response = call(*args, **kwargs)
    else:
        response = call

    data['response']['data'] = response

    return data
