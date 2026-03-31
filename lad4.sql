-- THIẾT LẬP CẤU TRÚC BẢNG
-- Xóa các bảng cũ để làm mới dữ liệu
DROP TABLE IF EXISTS invoice_details;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS suppliers;
-- Tạo bảng Khách hàng
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255)
);
-- Tạo bảng Sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0)
);
-- Tạo bảng Hóa đơn
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,
    customer_id INT REFERENCES customers(customer_id),
    total_amount DECIMAL(10,2) DEFAULT 0
);
-- Tạo bảng Chi tiết hóa đơn
CREATE TABLE invoice_details (
    invoice_id INT REFERENCES invoices(invoice_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    sale_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (invoice_id, product_id)
);
-- Tạo bảng Nhà cung cấp
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) UNIQUE
);
-- PHẦN II: CẬP NHẬT CẤU TRÚC
-- Thêm email cho nhà cung cấp
ALTER TABLE suppliers ADD COLUMN email VARCHAR(100);
-- Liên kết sản phẩm với nhà cung cấp
ALTER TABLE products ADD COLUMN supplier_id INT;
ALTER TABLE products ADD CONSTRAINT fk_products_suppliers 
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);
-- NHẬP DỮ LIỆU ĐA DẠNG
-- Nhập Nhà cung cấp
INSERT INTO suppliers (supplier_name, contact_phone, email) VALUES 
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn'),
('Kinh Đô Bakery', '0909123456', 'info@kinhdo.vn'),
('Nước giải khát PEPSI', '0933445566', 'sales@pepsi.com.vn'),
('Gia dụng Sunhouse', '0977889900', 'support@sunhouse.com.vn');
-- Nhập Khách hàng 
INSERT INTO customers (customer_name, phone, address) VALUES
('Nguyen Van A', '0901234567', '123 Lê Lợi, Hà Nội'),
('Tran Thi B', '0912345678', '45 Nguyễn Huệ, Hải Phòng'),
('Lê Văn Cường', '0922334455', '78 CMT8, TP.HCM'),
('Phạm Mai Anh', '0933556677', '12 Trần Phú, Đà Nẵng'),
('Hoàng Diệu Linh', '0944778899', '09 Lý Thường Kiệt, Cần Thơ');
-- Nhập Sản phẩm đa dạng 
INSERT INTO products (product_name, price, supplier_id) VALUES
('Sữa tươi Vinamilk 1L', 32000, 1),
('Sữa chua có đường', 6000, 1),
('Mì Hảo Hảo Tôm Chua Cay', 4500, 2),
('Mì trộn Indomie', 6000, 2),
('Bánh mì tươi Kinh Đô', 12000, 3),
('Bánh bông lan cuộn', 18000, 3),
('Pepsi lon 330ml', 10000, 4),
('Trà Ô Long Tea Plus', 12000, 4),
('Chảo chống dính 24cm', 155000, 5),
('Ấm siêu tốc 1.8L', 250000, 5),
('Nước suối Aquafina', 5000, 4);
-- Nhập Hóa đơn mẫu
INSERT INTO invoices (invoice_date, customer_id, total_amount) VALUES
('2025-10-15', 1, 56000),
('2025-10-16', 3, 405000);
-- Nhập Chi tiết hóa đơn
INSERT INTO invoice_details (invoice_id, product_id, quantity, sale_price) VALUES
(1, 1, 1, 32000), -- KH 1 mua sữa
(1, 7, 2, 10000), -- KH 1 mua 2 lon pepsi
(2, 9, 1, 155000), -- KH 3 mua chảo
(2, 10, 1, 250000); -- KH 3 mua ấm siêu tốc
-- PHẦN IV: THỰC THI CÁC YÊU CẦU CỤ THỂ (Bài 4 & 5)
-- Cập nhật số điện thoại sai
UPDATE suppliers 
SET contact_phone = '0911112222' 
WHERE supplier_name = 'Công ty Thực phẩm Á Châu';
--Xóa sản phẩm không còn kinh doanh
DELETE FROM products WHERE product_name = 'Nước suối Aquafina';
-- Xóa cột và Xóa bảng nháp
CREATE TABLE test_table (id INT);
ALTER TABLE suppliers DROP COLUMN contact_phone;
DROP TABLE test_table;
-- KIỂM TRA DỮ LIỆU SAU KHI XỬ LÝ
SELECT * FROM suppliers;
SELECT * FROM products ORDER BY price DESC;
SELECT * FROM customers;