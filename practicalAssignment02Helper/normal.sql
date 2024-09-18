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
)

SELECT DISTINCT
    ft.name,
    ft.surname,
    ft.email,
    ft.phone,
    ft.address,
    (SELECT COUNT(*) 
     FROM client_order co_sub 
     WHERE co_sub.user_id = ft.user_id) AS total_orders,
    (SELECT SUM(p_sub.product_price) 
     FROM product p_sub 
     JOIN client_order co_sub ON co_sub.product_id = p_sub.product_id 
     WHERE co_sub.user_id = ft.user_id 
     AND p_sub.product_category = 'furniture') AS total_furniture_spent
FROM 
    filtered_table ft
ORDER BY 
    ft.surname ASC;
    
CREATE INDEX index_client_id ON client(user_id);