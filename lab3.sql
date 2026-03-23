-- Tạo bảng khách hàng
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255)
);
-- Tạo bảng sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
-- Tạo bảng hóa đơn
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_date DATE NOT NULL,
    customer_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
-- Tạo bảng chi tiết hóa đơn
CREATE TABLE invoice_details (
    invoice_id INT,
    product_id INT,
    quantity INT NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (invoice_id, product_id),

    FOREIGN KEY (invoice_id)
    REFERENCES invoices(invoice_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);
-- Nhập dữ liệu mẫu khách hàng
INSERT INTO customers (customer_name, phone, address)
VALUES
('Nguyen Van A', '0901234567', 'Ha Noi'),
('Tran Thi B', '0912345678', 'Hai Phong');
-- Nhập dữ liệu sản phẩm
INSERT INTO products (product_name, price)
VALUES
('Sua tuoi', 30000),
('Banh mi', 15000),
('Nuoc ngot', 12000),
('Mi tom', 5000),
('Trung ga', 35000),
('Dau an', 45000),
('Duong', 22000),
('Muoi', 8000),
('Ca phe', 65000),
('Tra xanh', 18000);
-- Nhập dữ liệu hóa đơn
INSERT INTO invoices (invoice_date, customer_id, total_amount)
VALUES
('2025-10-15', 1, 75000),
('2025-10-16', 2, 42000);
-- Nhập dữ liệu chi tiết hóa đơn
INSERT INTO invoice_details (invoice_id, product_id, quantity, sale_price)
VALUES
(1, 1, 2, 30000),
(1, 2, 1, 15000),
(2, 3, 2, 12000);
--Kiểm tra dữ liệu
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM invoices;
SELECT * FROM invoice_details;
-- Đổi tên cột hiển thị
SELECT product_name AS TenSanPham,
       price AS DonGia
FROM products;
-- Tìm kiếm khách hàng theo tên
SELECT customer_name, phone
FROM customers
WHERE customer_name LIKE '%Van%';
-- Sắp xếp sản phẩm theo giá
SELECT product_name, price
FROM products
ORDER BY price DESC;
-- Tìm 3 sản phẩm rẻ nhất
SELECT 
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 3;
