{% snapshot snapshot_orders %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='check',
        check_cols='all',
    )
}}

    select
        *
    from {{ source('greenery', 'orders') }}

{% endsnapshot %}