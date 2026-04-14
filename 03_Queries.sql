-- 10 giao dịch gần đây nhất
SELECT 
o.order_id AS ma_don_hang,
c.customer_name AS ten_khach_hang,
e.employee_name AS ten_nhan_vien,
o.order_date AS ngay_mua,
SUM(oi.quantity * oi.unit_price) AS tong_tien
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id
JOIN employees e 
ON o.employee_id = e.employee_id
JOIN order_items oi 
ON o.order_id = oi.order_id
GROUP BY 
o.order_id,
c.customer_name,
e.employee_name,
o.order_date
ORDER BY 
o.order_date DESC
LIMIT 10;
-- Tổng doanh thu theo danh mục sản phẩm

SELECT 
pc.category_name AS ten_danh_muc,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS tong_doanh_thu
FROM order_items oi
JOIN products p 
ON oi.product_id = p.product_id
JOIN product_categories pc 
ON p.category_id = pc.category_id
GROUP BY pc.category_name
HAVING SUM(oi.quantity * oi.unit_price) > 1000000
ORDER BY tong_doanh_thu DESC;
-- Tìm sản phẩm theo nhà cung cấp bằng truy vấn con

SELECT 
product_name AS ten_san_pham,
price AS gia
FROM products
WHERE supplier_id = (
SELECT supplier_id
FROM suppliers
WHERE supplier_name = 'Công ty Thực phẩm Hảo Hạng'
);
-- Xếp hạng nhân viên theo doanh thu tháng 10/2025

SELECT 
e.employee_name AS ten_nhan_vien,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS tong_doanh_thu,
DENSE_RANK() OVER (
ORDER BY SUM(oi.quantity * oi.unit_price) DESC
) AS thu_hang
FROM orders o
JOIN employees e 
ON o.employee_id = e.employee_id
JOIN order_items oi 
ON o.order_id = oi.order_id
WHERE EXTRACT(MONTH FROM o.order_date) = 10
AND EXTRACT(YEAR FROM o.order_date) = 2025
GROUP BY e.employee_name;
-- Thêm 50,000 khách hàng giả lập

INSERT INTO customers (customer_name, phone, email, address)
SELECT
    'Khach hang ao ' || g,
    '091' || LPAD(g::text,7,'0'),
    'fakecustomer' || g || '@gmail.com',
    'Ha Noi'
FROM generate_series(50051,100050) g;
-- Kiểm tra hiệu năng tìm email khi chưa có index

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE email = 'fakecustomer40000@gmail.com';

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE email = 'fakecustomer40000@gmail.com';
-- Tạo index cho email khách hàng

CREATE INDEX idx_customers_email
ON customers(email);
-- Kiểm tra hiệu năng sau khi tạo index

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE email = 'fakecustomer40000@gmail.com';
