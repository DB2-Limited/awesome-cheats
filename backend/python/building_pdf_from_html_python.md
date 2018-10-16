# Building .pdf with custom data from html (Python/Django)

## Requirements:
- input [html](./assets/building_pdf_from_html_python/input_template.html)
- custom data
- python environment with installed [wkhtmltopdf](https://github.com/JazzCore/python-pdfkit)  


## Example
#### Example of base pdfkit ```settings.py```:
```python
PDFKIT_SETTINGS = {
    'page-size': 'A4',
    'dpi': 300,
    'encoding': 'utf-8',
    'quiet': ''  # hide wkhtmltopdf output
}
```

#### Example of pdfkit util:
```python
import pdfkit
from django.template.loader import get_template
from django.conf import settings
  
  
def render_to_pdf(template, content, options=None):
    pdfkit_options = settings.PDFKIT_SETTINGS
    if options:
        pdfkit_options = {**pdfkit_options, **options}
    html = get_template(template).render(content)
    pdf = pdfkit.from_string(html, False, pdfkit_options)
    return pdf
```

#### Example of view:
```python
from django.http import HttpResponse
from rest_framework import generics
  
from utils import render_to_pdf
  
  
class ExampleView(generics.GenericAPIView):
    def get(self, request, *args, **kwargs):
        custom_pdf_options = {
            'margin-top': '0.75in',
            'margin-right': '0.75in',
            'margin-bottom': '0.75in',
            'margin-left': '0.75in'
        }
        content = {'students': [{'name': 'Andre	Morton', 'positive_marks': 11, 'negative_marks': 3},
                                {'name': 'Ana Mitchell', 'positive_marks': 8, 'negative_marks': 5},
                                {'name': 'Dexter Yates', 'positive_marks': 12, 'negative_marks': 4},
                                {'name': 'Hugh Austin', 'positive_marks': 13, 'negative_marks': 7},
                                {'name': 'Ginger Conner', 'positive_marks': 7, 'negative_marks': 5},
                                {'name': 'Andrew Lee', 'positive_marks': 5, 'negative_marks': 9},
                                {'name': 'Rufus	Stone', 'positive_marks': 7, 'negative_marks': 11},
                                {'name': 'Brian	Palmer', 'positive_marks': 14, 'negative_marks': 1},
                                {'name': 'Wilson White', 'positive_marks': 9, 'negative_marks': 6},
                                {'name': 'Elsie	Ortiz', 'positive_marks': 9, 'negative_marks': 2}]
                   }
  
        pdf = render_to_pdf(template='input_template.html', content=content, options=custom_pdf_options)
        response = HttpResponse(pdf, content_type='application/pdf')
        response['Content-Disposition'] = 'attachment; filename="output.pdf"'
        return response
```

As a result you will get an [output.pdf](./assets/building_pdf_from_html_python/output.pdf)


## Usage without Django

You can use ```pdfkit``` without Django and with any other template engine (for example [jinja2](https://github.com/pallets/jinja)).

