USE olist_ecommerce;

SELECT 'orders' AS table_name, COUNT(*) AS row_count
FROM dbo.orders

UNION ALL

SELECT 'customers', COUNT(*)
FROM dbo.customers

UNION ALL

SELECT 'order_items', COUNT(*)
FROM dbo.order_items

UNION ALL

SELECT 'payments', COUNT(*)
FROM dbo.payments

UNION ALL

SELECT 'products', COUNT(*)
FROM dbo.products

UNION ALL

SELECT 'reviews', COUNT(*)
FROM dbo.reviews

UNION ALL

SELECT 'sellers', COUNT(*)
FROM dbo.sellers

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM dbo.geolocation

UNION ALL

SELECT 'category_translation', COUNT(*)
FROM dbo.category_translation;