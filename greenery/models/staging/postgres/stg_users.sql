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
    , created_at::datetime as created_at
    , updated_at::datetime as updated_at
    , address_id
FROM {{ source('postgres', 'users') }}
