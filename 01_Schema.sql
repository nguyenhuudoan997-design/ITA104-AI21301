-- bảng danh mục sản phẩm
CREATE TABLE product_categories(
category_id SERIAL PRIMARY KEY,
category_name VARCHAR(100) NOT NULL UNIQUE
);
-- bảng nhà cung cấp
CREATE TABLE suppliers(
supplier_id SERIAL PRIMARY KEY,
supplier_name VARCHAR(150) NOT NULL UNIQUE,
contact_info VARCHAR(255) NOT NULL
);
-- bảng sản phẩm
CREATE TABLE products(
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(150) NOT NULL,
price NUMERIC(12,2) NOT NULL CHECK (price>0),
supplier_id INT NOT NULL,
category_id INT NOT NULL,
CONSTRAINT fk_supplierefk_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id),

CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES product_categories(category_id)
);
-- bảng khách hàng
CREATE TABLE customers(
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(150) NOT NULL,
phone VARCHAR(15) UNIQUE NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
address VARCHAR(255)
);
-- bảng nhân viên
CREATE TABLE employees(
employee_id SERIAL PRIMARY KEY,
employee_name VARCHAR(150) NOT NULL,
position VARCHAR(100) NOT NULL,
hire_date DATE DEFAULT CURRENT_DATE
);
-- bảng khuyến mãi
CREATE TABLE promotions(
promotion_id SERIAL PRIMARY KEY,
promotion_name VARCHAR(150) NOT NULL,
description TEXT,
discount_percent NUMERIC(5,2)CHECK (discount_percent BETWEEN 0 AND 100),
start_date DATE NOT NULL,
end_date DATE NOT NULL
);
-- bảng đơn hàng
CREATE TABLE orders(
order_id SERIAL PRIMARY KEY,
customer_id INT NOT NULL,
employee_id INT NOT NULL,
promotion_id INT,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),

CONSTRAINT fk_employee
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id),

CONSTRAINT fk_promotion
FOREIGN KEY (promotion_id)
REFERENCES promotions(promotion_id)
);
-- bảng chi tiết hóa đơn
CREATE TABLE order_items(
order_item_id SERIAL PRIMARY KEY,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price > 0),

CONSTRAINT fk_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id),

CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products(product_id)
);







