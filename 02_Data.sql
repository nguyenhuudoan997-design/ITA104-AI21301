-- Nhập dữ liệu mẫu cho An Bình Mart
-- product_categories (5 dòng)
INSERT INTO product_categories (category_name) VALUES
('Đồ uống'),
('Thực phẩm khô'),
('Sữa'),
('Đồ gia dụng'),
('Rau củ');
-- suppliers (5 dòng)
INSERT INTO suppliers (supplier_name, contact_info) VALUES
('Công ty Thực phẩm Hảo Hạng', '0123456789'),
('Vinamilk', '0988888888'),
('Acecook', '0977777777'),
('Unilever', '0966666666'),
('TH True Milk', '0955555555');
-- promotions (3 dòng)
INSERT INTO promotions (promotion_name, description, discount_percent, start_date, end_date) VALUES
('Khuyến mãi hè', 'Giảm giá mùa hè', 10, '2025-06-01', '2025-06-30'),
('Black Friday', 'Giảm giá cuối năm', 20, '2025-11-20', '2025-11-30'),
('Tết 2025', 'Ưu đãi dịp Tết', 15, '2025-01-15', '2025-02-10');
-- employees (10 dòng)
INSERT INTO employees (employee_name, position, hire_date) VALUES
('Nguyễn Văn A', 'Thu ngân', '2024-01-10'),
('Trần Thị B', 'Quản lý kho', '2023-05-15'),
('Lê Văn C', 'Thu ngân', '2024-03-12'),
('Phạm Thị D', 'Bán hàng', '2023-07-01'),
('Hoàng Văn E', 'Thu ngân', '2024-04-21'),
('Đỗ Thị F', 'Bán hàng', '2024-06-18'),
('Ngô Văn G', 'Quản lý', '2022-08-10'),
('Bùi Thị H', 'Thu ngân', '2024-02-14'),
('Phan Văn I', 'Bán hàng', '2023-11-11'),
('Vũ Thị K', 'Thu ngân', '2024-05-05');
-- customers (50 dòng tự sinh)
INSERT INTO customers (customer_name, phone, email, address)
SELECT
    'Khách hàng ' || g,
    '090' || LPAD(g::text,7,'0'),
    'customer' || g || '@gmail.com',
    'Hà Nội'
FROM generate_series(1,50) g;
-- products (30 dòng)
INSERT INTO products (product_name, price, supplier_id, category_id) VALUES
('Coca Cola', 10000, 1, 1),
('Pepsi', 10000, 1, 1),
('Nước cam', 15000, 1, 1),
('Mì tôm Hảo Hảo', 5000, 3, 2),
('Mì ly Modern', 8000, 3, 2),
('Bánh quy', 20000, 1, 2),
('Sữa Vinamilk', 30000, 2, 3),
('Sữa TH', 32000, 5, 3),
('Sữa chua', 25000, 2, 3),
('Nước rửa chén', 45000, 4, 4),
('Bột giặt Omo', 120000, 4, 4),
('Khăn giấy', 18000, 4, 4),
('Cà chua', 25000, 1, 5),
('Khoai tây', 30000, 1, 5),
('Rau cải', 15000, 1, 5),
('Bắp cải', 18000, 1, 5),
('Táo', 50000, 1, 5),
('Cam', 45000, 1, 5),
('Chuối', 30000, 1, 5),
('Nho', 70000, 1, 5),
('Bánh mì', 12000, 1, 2),
('Gạo ST25', 180000, 1, 2),
('Dầu ăn', 55000, 1, 2),
('Nước suối', 8000, 1, 1),
('Trà xanh', 12000, 1, 1),
('Sữa đặc', 28000, 2, 3),
('Kem đánh răng', 35000, 4, 4),
('Xà phòng', 22000, 4, 4),
('Bột ngọt', 27000, 1, 2),
('Đường trắng', 25000, 1, 2);
-- orders (100 dòng)
INSERT INTO orders (customer_id, employee_id, promotion_id, order_date)
SELECT
    (random()*49 +1)::INT,
    (random()*9 +1)::INT,
    (random()*2 +1)::INT,
    TIMESTAMP '2025-10-01' + (random() * INTERVAL '30 days')
FROM generate_series(1,100);
-- order_items (100 dòng tương ứng)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT
    g,
    (random()*29 +1)::INT,
    (random()*4 +1)::INT,
    (random()*100000 +5000)::NUMERIC(12,2)
FROM generate_series(1,100) g;
