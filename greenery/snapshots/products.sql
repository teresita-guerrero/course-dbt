{% snapshot snapshot_products %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='check',
        check_cols='all',

    )
}}

    select
        *
    from {{ source('greenery', 'products') }}

{% endsnapshot %}