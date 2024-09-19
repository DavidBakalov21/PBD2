USE Assignment1;
EXPLAIN 
WITH filtered_table AS (
    SELECT  
        c.user_id,
        c.name,
        c.surname,
        c.email,
        c.phone,
        c.address
    FROM 
        client_order co
    JOIN 
        client c ON co.user_id = c.user_id
    JOIN 
        product p ON co.product_id = p.product_id
    WHERE 
        p.product_category = 'furniture'
        AND (p.product_price > 1000 OR p.product_price < 100)
        AND LENGTH(c.phone) > 10
        AND c.surname LIKE 'A%'
),
total_order_cte AS (
SELECT user_id,
COUNT(*) AS total_orders
FROM 
   client_order co
GROUP BY 
     co.user_id
),
total_furniture_spent_cte AS (
    SELECT 
        co.user_id,
        SUM(p.product_price) AS total_furniture_spent
    FROM 
        client_order co
    JOIN 
        product p ON co.product_id = p.product_id
    WHERE 
        p.product_category = 'furniture'
    GROUP BY 
        co.user_id
)

SELECT DISTINCT
    ft.name,
    ft.surname,
    ft.email,
    ft.phone,
    ft.address,
    total_cte.total_orders,
    total_furniture_cte.total_furniture_spent
FROM 
    filtered_table ft
JOIN 
    total_order_cte total_cte ON ft.user_id = total_cte.user_id
JOIN 
    total_furniture_spent_cte total_furniture_cte ON ft.user_id = total_furniture_cte.user_id
ORDER BY 
    ft.surname ASC;
    
CREATE INDEX index_client_id ON client(user_id);