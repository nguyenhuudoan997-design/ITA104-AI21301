-- THÊM DỮ LIỆU LỚN
INSERT INTO customers (customer_name, phone, address)
SELECT
    'Customer ' || i,
    '0910' || LPAD(i::text, 6, '0'),
    'Address ' || i
FROM generate_series(3,100000) AS i;
-- BÀI 1: SEQ SCAN
EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE phone = '0910099999';
-- BÀI 2: TẠO INDEX
CREATE INDEX idx_customers_phone
ON customers(phone);

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE phone = '0910099999';
-- BÀI 3: INSERT KHI CÓ INDEX
EXPLAIN ANALYZE
INSERT INTO customers (customer_name, phone, address)
VALUES ('Test Index User', '0999999999', '123 Test Index');
-- BÀI 4: BITMAP SCAN
CREATE INDEX idx_customers_address
ON customers(address);

EXPLAIN
SELECT *
FROM customers
WHERE address = 'Address 500'
OR phone LIKE '091001%';