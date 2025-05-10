{% macro get_month_to_yesterday_range(field_name) %}
{% set yesterday = modules.datetime.date.today() - modules.datetime.timedelta(days=1) %}
{{ field_name }} BETWEEN date_trunc(DATE '{{ yesterday }}', month) AND DATE '{{ yesterday }}'
{% endmacro %}