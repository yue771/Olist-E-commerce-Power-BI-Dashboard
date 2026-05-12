USE olist_ecommerce;

-- 查看订单状态分布

SELECT 
    order_status,
    COUNT(*) AS order_count
FROM dbo.orders
GROUP BY order_status
ORDER BY order_count DESC;