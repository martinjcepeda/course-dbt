{{
  config(
    materialized='table'
  )
}}

select
  page_url,
  count(event_id) as page_count,
  to_char (CREATED_AT, 'dd-mm-yyyy') as created_date
from {{ ref('stg_events') }}
where
  EVENT_TYPE = 'page_view'
group by
  1,
  3
order by
  created_date asc

