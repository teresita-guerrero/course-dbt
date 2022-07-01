{% macro get_events() %}
    {% set query %}
        select
            event_type
        from {{ ref('event_types') }}
    {% endset %}
    {% set results = run_query(query) %}
    {% if execute %}
        {% set results_list = results.rows %}
        {{ results_list }}
    {% else %}
        {% set results_list = [] %}
    {% endif %}
    {{ return(results_list) }}
{% endmacro %}