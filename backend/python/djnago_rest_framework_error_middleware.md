# Django rest framework error middleware

- Middleware code

```python
from rest_framework.views import exception_handler


def rest_exception_handler(exc, context):
    response = exception_handler(exc, context)

    def response_message(msg='Unspecified error. Try again later.'):
        return {'error': msg}

    def prepare_response(data):
        if isinstance(data, list) and len(data) > 0:
            result = response_message(msg=data[0])
        elif isinstance(data, str):
            result = response_message(msg=data)
        else:
            result = response_message()

        return result

    if response is not None:
        if 'error' in response.data:
            response.data = prepare_response(response.data.get('error'))
        elif 'detail' in response.data:
            response.data = prepare_response(response.data.get('detail'))
        else:
            response.data = {'fields': response.data, 'error': 'Some fields have errors.'}

    return response
```

 - Add rest framework settings:

```python
REST_FRAMEWORK = {
    ...
    'EXCEPTION_HANDLER': '<project_name>.<middleware_file_name>.rest_exception_handler',
    'NON_FIELD_ERRORS_KEY': 'error'
    ...
}
```

 - Examples

    - before
    
    - after
    
