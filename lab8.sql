-- GROUP BY
SELECT product_name, AVG(price)
FROM products
GROUP BY product_name;
-- WINDOW FUNCTION
SELECT 
    product_name,
    price,
    AVG(price) OVER () AS avg_overall_price
FROM products;
-- nên dùng window fuction vì giữ nguyên dòng, 
-- giữ đầy đủ không bị gộp dòng như group by làm mất dữ liệu chi tiết.
-- PARTITION BY (theo nhóm)
SELECT 
    category,
    product_name,
    price,
    AVG(price) OVER (PARTITION BY category) AS avg_category_price
FROM products;
-- Xếp hạng sản phẩm
--tạo giá trùng nhau
UPDATE products
SET price = 35000
WHERE product_id IN (1,2);
--xếp hạng
SELECT 
    product_name,
    price,

    ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,

    RANK() OVER (ORDER BY price DESC) AS rank_num,

    DENSE_RANK() OVER (ORDER BY price DESC) AS dense_rank_num

FROM products;
-- Doanh thu lũy kế theo ngày
WITH daily_revenue AS (
    SELECT 
        i.invoice_date,
        SUM(id.quantity * id.sale_price) AS total_daily_revenue
    FROM invoices i
    JOIN invoice_details id 
        ON i.invoice_id = id.invoice_id
    GROUP BY i.invoice_date
)

SELECT 
    invoice_date,
    total_daily_revenue,

    SUM(total_daily_revenue) OVER (ORDER BY invoice_date) 
    AS running_total_revenue

FROM daily_revenue;





