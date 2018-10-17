# Django rest framework error handler
This handler works only when you use django framework + django rest framework.


### Requirements:
- [django 2.0+](https://www.djangoproject.com)
- [django rest framework 3.8+ ](https://www.django-rest-framework.org)

### Instruction:
- Create error_handler.py in your project root folder and add [source code](#error-handler-code) there.
- Add information about error handler to [rest framework settings](#django-rest-framework-settings).

### Error handler code
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

### Django rest framework settings:

```python
REST_FRAMEWORK = {
    ...
    'EXCEPTION_HANDLER': '<project_root_folder>.<error_handler.py>.rest_exception_handler',
    'NON_FIELD_ERRORS_KEY': 'error'
    ...
}
```

### Example json responses (before / after):
```json
   { "detail": "Not found" }
```
```json
   { "error": "Not found" }
```
---

```json
  {
      "email": ["This field is required."],
      "password": ["This field is required."],
  }
```
```json
  {
     "fields": {
       "email": ["This field is required."],
       "password": ["This field is required."]
     },
     "error": "Some fields have errors."
  }
```
---
```json
  {
    "email": ["This field is required."],
    "password": ["This field is required."]
  }
```
```json
  {
    "fields": {
      "email": ["This field is required."],
      "password": ["This field is required."]
    },
    "error": "Some fields have errors."
  }
```
---

```json
  {
    "non_field_errors": "Passwords don't match."
  }
```
```json
  {
    "error": "Passwords don't match."
  }
```
