# Split list into columns filling up each row to the maximum equal length possible

## Example of using
Break a list into `n` columns, filling up each row to the maximum equal
length possible.
```python
>>> l = range(10)
>>> columns(l, 2)
[[0, 1, 2, 3, 4], [5, 6, 7, 8, 9]]
>>> columns(l, 3)
[[0, 1, 2, 3], [4, 5, 6, 7], [8, 9]]
>>> columns(l, 4)
[[0, 1, 2], [3, 4, 5], [6, 7, 8], [9]]
>>> columns(l, 5)
[[0, 1], [2, 3], [4, 5], [6, 7], [8, 9]]
>>> columns(l, 9)
[[0, 1], [2, 3], [4, 5], [6, 7], [8, 9], [], [], [], []]
# This filter will always return `n` columns, even if some are empty:
>>> columns(range(2), 3)
[[0], [1], []]
```
## Code
```python
def columns(thelist, n):
    try:
        n = int(n)
        thelist = list(thelist)
    except (ValueError, TypeError):
        return [thelist]
    list_len = len(thelist)
    split = list_len // n

    if list_len % n != 0:
        split += 1
    return [thelist[split*i:split*(i+1)] for i in range(n)]
```

## Usage as a template filter in Django
- create a new custom filter in `app/templatetags/`

```python
from django.template import Library

register = Library()


@register.filter
def columns(thelist, n):
    try:
        n = int(n)
        thelist = list(thelist)
    except (ValueError, TypeError):
        return [thelist]
    list_len = len(thelist)
    split = list_len // n

    if list_len % n != 0:
        split += 1
    return [thelist[split*i:split*(i+1)] for i in range(n)]
```

- use in `html` template

```html
{% load listutil %}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Example with questions and answers(highlighted selected/correct/incorrect)</title>
</head>
<body>
  {% for column in questions|columns:2 %}
      <div style='float:left; width:50%;'>
          {% for question in column %}
              {% if forloop.parentloop.counter == 1 %}
              {{ forloop.counter }}. {{ question.text }}
              {% else %}
              {{ column|length|add:forloop.counter }}. {{ question.text }}
              {% endif %}
              <ul>
                  {% for answer in question.answers %}
                      <li style="color:{% if answer.is_valid %}green{% else %}red{% endif %}">[{% if answer.is_chosen %}X{% else %}&nbsp;{% endif %}]{{ answer.text }}</li>
                  {% endfor %}
              </ul>
          {% endfor %}
      </div>
  {% endfor %}
</body>
</html>
```
