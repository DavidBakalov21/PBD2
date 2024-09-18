USE Assignment1;

SELECT DISTINCT
    c.name,
    c.surname,
    c.email,
    c.phone,
    c.address,
    (SELECT COUNT(*) 
     FROM client_order co_sub 
     WHERE co_sub.user_id = c.user_id) AS total_orders,
    (SELECT SUM(p_sub.product_price) 
     FROM product p_sub 
     JOIN client_order co_sub ON co_sub.product_id = p_sub.product_id 
     WHERE co_sub.user_id = c.user_id 
     AND p_sub.product_category = 'furniture') AS total_furniture_spent
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
    AND (p.product_price > 1000 OR p.product_price < 100)
    AND LENGTH(c.phone) > 10
    AND c.surname LIKE 'A%'
ORDER BY 
    c.surname ASC;
