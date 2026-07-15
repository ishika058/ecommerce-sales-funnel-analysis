-- =========================================================
-- Project: E-Commerce Sales Funnel Analysis
-- Author: Kumari Ishika
-- Tools: MySQL
-- Description:
-- This script contains SQL queries used to analyze customer
-- behavior, conversion funnel performance, marketing channels,
-- customer journey, and revenue metrics over the last 30 days.
-- =========================================================

create database sales_funnel_analysis;

-- =========================================================
-- Business Question 1: Calculate the number of unique users
-- at each stage of the sales funnel over the last 30 days.
-- =========================================================

SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
FROM user_events
WHERE event_date >= (
    SELECT DATE_SUB(MAX(event_date), INTERVAL 30 DAY)
    FROM user_events
);

-- =========================================================
-- Business Question 2: Analyze stage-to-stage conversion
-- rates to identify where users drop off in the sales funnel.
-- =========================================================

with funnel_stages as(
select 
count(distinct case when event_type = "page_view" then user_id end)as stage_1_views,
count(distinct case when event_type = "add_to_cart" then user_id end)as stage_2_cart,
count(distinct case when event_type = "checkout_start" then user_id end)as stage_3_checkout,
count(distinct case when event_type = "payment_info" then user_id end)as stage_4_payment,
count(distinct case when event_type = "purchase" then user_id end)as stage_5_purchase
from user_events
WHERE event_date >= (SELECT DATE_SUB(MAX(event_date), INTERVAL 30 DAY)
                     FROM user_events)
                   )
                   
select stage_1_views,stage_2_cart,
       round(stage_2_cart * 100.0 / stage_1_views)as view_to_cart_rate,
       stage_3_checkout,
       round(stage_3_checkout * 100.0 / stage_2_cart) as cart_to_checkout_rate,
       stage_4_payment,
       round(stage_4_payment * 100.0 / stage_3_checkout) as checkout_to_payment_rate,
       stage_5_purchase,
       round(stage_5_purchase * 100.0 / stage_4_payment) as payment_to_purchase_rate,
       round(stage_5_purchase * 100.0 / stage_1_views) as overall_conversion_rate
       from funnel_stages; 


-- =========================================================
-- Business Question 3: Identify which traffic sources drive
-- the highest visitor volume and conversion rates.
-- =========================================================

WITH source_funnel AS (
    SELECT
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM user_events
    WHERE event_date >= (
        SELECT DATE_SUB(MAX(event_date), INTERVAL 30 DAY)
        FROM user_events
    )
    GROUP BY traffic_source
)

SELECT
    traffic_source,views,carts,purchases,
    ROUND(carts * 100.0 / NULLIF(views, 0), 2) AS cart_conversion_rate,
    ROUND(purchases * 100.0 / NULLIF(views, 0), 2) AS purchase_conversion_rate,
    ROUND(purchases * 100.0 / NULLIF(carts, 0), 2) AS cart_to_purchase_conversion_rate
FROM source_funnel
ORDER BY purchases DESC;

-- =========================================================
-- Business Question 4: Analyze customer journey duration
-- across the purchase funnel.
-- =========================================================

WITH user_journey AS (
    SELECT
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM user_events
    WHERE event_date >= (
        SELECT DATE_SUB(MAX(event_date), INTERVAL 30 DAY)
        FROM user_events
    )
    GROUP BY user_id
    HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL
)

SELECT
    COUNT(*) AS converted_users,

    ROUND(AVG(TIMESTAMPDIFF(MINUTE, view_time, cart_time)),2)
        AS avg_view_to_cart_minutes,

    ROUND(AVG(TIMESTAMPDIFF(MINUTE, cart_time, purchase_time)),2)
        AS avg_cart_to_purchase_minutes,

    ROUND(AVG(TIMESTAMPDIFF(MINUTE, view_time, purchase_time)),2)
        AS avg_total_journey_minutes

FROM user_journey; 


-- =========================================================
-- Business Question 5: Analyze revenue performance using
-- key business metrics over the last 30 days.
-- =========================================================

with funnel_revenue as (
select 
count(distinct case when event_type = "page_view" then user_id end)as total_visitors,
count(distinct case when event_type = "purchase" then user_id end)as total_buyers,
sum(case when event_type = "purchase" then amount end)as total_revenue,
count(case when event_type = "purchase" then 1 end)as total_orders
FROM user_events
WHERE event_date >= (SELECT DATE_SUB(MAX(event_date), INTERVAL 30 DAY)
					 FROM user_events)
)

select total_visitors,total_buyers,total_orders,total_revenue,
total_revenue/total_orders as avg_order_value,
total_revenue/total_buyers as revenue_per_buyer,
total_revenue/total_visitors as revenue_per_visitor
from funnel_revenue;

