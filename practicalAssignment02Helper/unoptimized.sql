
USE Assignment2;
SELECT 
    c.name,
    c.surname,
    c.email,
    c.phone,
    c.address,
    p.product_name,
    p.product_price,
    p.product_category,
    p.description,
    co.order_timestamp,
    (SELECT COUNT(*) FROM client_order WHERE client_order.user_id = c.user_id) AS total_orders,
    (SELECT SUM(product_price) FROM product WHERE product_category = 'furniture') AS total_furniture_value,
    (SELECT MAX(order_timestamp) FROM client_order WHERE user_id = c.user_id) AS last_order_time
FROM 
    client_order co
JOIN 
    client c ON co.user_id = c.user_id
JOIN 
    product p ON co.product_id = p.product_id
LEFT JOIN 
    client_order co2 ON co2.user_id = c.user_id  -- unnecessary self join
LEFT JOIN 
    product p2 ON p2.product_id = p.product_id  -- unnecessary self join
WHERE 
    p.product_category = 'furniture'
    AND (p.product_price > 1000 OR p.product_price < 100)  -- Inefficient filtering with OR
    AND LENGTH(c.phone) > 10  -- Unnecessary length check
    AND c.surname LIKE 'A%'  -- Additional filter for surname starting with 'A'
ORDER BY 
    c.surname ASC,
    p.product_price DESC,
    co.order_timestamp DESC;
