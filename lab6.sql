-- LAB 6 - TRUY VẤN NÂNG CAO
-- BÀI 1: THỐNG KÊ SẢN PHẨM
SELECT 
    COUNT(*) AS SoLuongSanPham,
    AVG(price) AS GiaTrungBinh,
    MIN(price) AS GiaThapNhat,
    MAX(price) AS GiaCaoNhat
FROM products;
-- BÀI 2: PHÂN TÍCH NHÀ CUNG CẤP
SELECT 
    suppliers.supplier_name,
    COUNT(products.product_id) AS TongSoSanPham
FROM suppliers
JOIN products
ON suppliers.supplier_id = products.supplier_id
GROUP BY suppliers.supplier_name
HAVING COUNT(products.product_id) > 1;
-- BÀI 3: XỬ LÝ NGÀY THÁNG
SELECT 
    invoice_id,
    TO_CHAR(invoice_date, 'DD/MM/YYYY') AS NgayDatHang
FROM invoices
WHERE EXTRACT(YEAR FROM invoice_date) = 2025
AND EXTRACT(MONTH FROM invoice_date) = 10;
-- BÀI 4: BÁO CÁO DOANH THU KHÁCH HÀNG
SELECT 
    customers.customer_name,
    SUM(invoice_details.quantity * invoice_details.sale_price) AS TongChiTieu
FROM customers
JOIN invoices
ON customers.customer_id = invoices.customer_id
JOIN invoice_details
ON invoices.invoice_id = invoice_details.invoice_id
GROUP BY customers.customer_name
HAVING SUM(invoice_details.quantity * invoice_details.sale_price) > 100000
ORDER BY TongChiTieu DESC;
