{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , updated_at 
    , a.address_id
    , a.address
    , a.zipcode
    , a.state 
    , a.country
FROM {{ ref('stg_users') }} u

LEFT JOIN {{ ref('stg_addresses') }} a ON a.address_id = u.address_id
