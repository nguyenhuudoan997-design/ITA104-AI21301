-- CSDL SIÊU THỊ MINI AN BÌNH MART
-- XÓA BẢNG CŨ NẾU ĐÃ TỒN TẠI
DROP TABLE IF EXISTS chi_tiet_hoa_don;
DROP TABLE IF EXISTS hoa_don;
DROP TABLE IF EXISTS san_pham;
DROP TABLE IF EXISTS khach_hang;
DROP TABLE IF EXISTS nha_cung_cap;
DROP TABLE IF EXISTS test_table;
-- TẠO BẢNG KHÁCH HÀNG
CREATE TABLE khach_hang (
    ma_khach_hang SERIAL PRIMARY KEY,
    ten_khach_hang VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(15) UNIQUE,
    dia_chi VARCHAR(255)
);
ALTER TABLE khach_hang
ADD email VARCHAR(100);
-- TẠO BẢNG NHÀ CUNG CẤP
CREATE TABLE nha_cung_cap (
    ma_nha_cung_cap SERIAL PRIMARY KEY,
    ten_nha_cung_cap VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(15) UNIQUE
);
ALTER TABLE nha_cung_cap
ADD email VARCHAR(100);
-- NHẬP NHÀ CUNG CẤP
INSERT INTO nha_cung_cap (ten_nha_cung_cap, so_dien_thoai, email)
VALUES
('Cong ty Sua Viet Nam', '0987654321', 'contact@vinamilk.vn'),
('Cong ty Thuc pham A Chau', '0912345678', 'contact@acecook.vn');
UPDATE nha_cung_cap
SET so_dien_thoai = '0911112222'
WHERE ten_nha_cung_cap = 'Cong ty Thuc pham A Chau';
-- TẠO BẢNG SẢN PHẨM
CREATE TABLE san_pham (
    ma_san_pham SERIAL PRIMARY KEY,
    ten_san_pham VARCHAR(100) NOT NULL,
    gia DECIMAL(10,2) NOT NULL CHECK (gia > 0),
    ma_nha_cung_cap INT,
    FOREIGN KEY (ma_nha_cung_cap)
    REFERENCES nha_cung_cap(ma_nha_cung_cap)
);
-- NHẬP SẢN PHẨM
INSERT INTO san_pham (ten_san_pham, gia, ma_nha_cung_cap)
VALUES
('Sua tuoi', 30000, 1),
('Banh mi', 15000, 1),
('Nuoc ngot', 12000, 1),
('Mi tom', 5000, 1),
('Trung ga', 35000, 1),
('Dau an', 45000, 2),
('Duong', 22000, 2),
('Nuoc suoi Aquafina', 10000, 2),
('Ca phe', 65000, 2),
('Tra xanh', 18000, 2);
UPDATE san_pham
SET gia = 32000
WHERE ten_san_pham = 'Sua tuoi';
DELETE FROM san_pham
WHERE ma_san_pham = 8;
-- TẠO BẢNG HÓA ĐƠN
CREATE TABLE hoa_don (
    ma_hoa_don SERIAL PRIMARY KEY,
    ngay_lap DATE NOT NULL,
    ma_khach_hang INT,
    tong_tien DECIMAL(10,2) CHECK (tong_tien >= 0),
    FOREIGN KEY (ma_khach_hang)
    REFERENCES khach_hang(ma_khach_hang)
);
-- NHẬP KHÁCH HÀNG
INSERT INTO khach_hang (ten_khach_hang, so_dien_thoai, dia_chi)
VALUES
('Nguyen Van A', '0901234567', 'Ha Noi'),
('Tran Thi B', '0912345678', 'Hai Phong'),
('Le Van C', '0934567890', 'Da Nang');
-- NHẬP HÓA ĐƠN
INSERT INTO hoa_don (ngay_lap, ma_khach_hang, tong_tien)
VALUES
('2025-10-15', 1, 75000),
('2025-10-16', 2, 24000);
-- TẠO BẢNG CHI TIẾT HÓA ĐƠN
CREATE TABLE chi_tiet_hoa_don (
    ma_hoa_don INT,
    ma_san_pham INT,
    so_luong INT NOT NULL CHECK (so_luong > 0),
    gia_ban DECIMAL(10,2) NOT NULL CHECK (gia_ban > 0),
    PRIMARY KEY (ma_hoa_don, ma_san_pham),
    FOREIGN KEY (ma_hoa_don)
    REFERENCES hoa_don(ma_hoa_don),
    FOREIGN KEY (ma_san_pham)
    REFERENCES san_pham(ma_san_pham)
);
-- NHẬP CHI TIẾT HÓA ĐƠN
INSERT INTO chi_tiet_hoa_don (ma_hoa_don, ma_san_pham, so_luong, gia_ban)
VALUES
(1, 1, 2, 30000),
(1, 2, 1, 15000),
(2, 3, 2, 12000);
-- BÀI DROP
CREATE TABLE test_table (
    id INT
);
ALTER TABLE nha_cung_cap
DROP COLUMN so_dien_thoai;
DROP TABLE test_table;

SELECT 
    cthd.ma_hoa_don,
    sp.ten_san_pham,
    cthd.so_luong,
    cthd.gia_ban
FROM chi_tiet_hoa_don cthd
INNER JOIN san_pham sp
ON cthd.ma_san_pham = sp.ma_san_pham;
-- LEFT JOIN
SELECT 
    kh.ten_khach_hang,
    hd.ma_hoa_don
FROM khach_hang kh
LEFT JOIN hoa_don hd
ON kh.ma_khach_hang = hd.ma_khach_hang;
-- RIGHT JOIN
SELECT 
    sp.ten_san_pham,
    cthd.ma_hoa_don
FROM chi_tiet_hoa_don cthd
RIGHT JOIN san_pham sp
ON cthd.ma_san_pham = sp.ma_san_pham;
-- UNION
SELECT 
    ten_khach_hang AS ContactName,
    so_dien_thoai AS PhoneNumber
FROM khach_hang

UNION

SELECT 
    ten_nha_cung_cap AS ContactName,
    NULL AS PhoneNumber
FROM nha_cung_cap;
-- SUBQUERY IN
SELECT 
    ten_san_pham,
    gia
FROM san_pham
WHERE ma_nha_cung_cap IN (
    SELECT ma_nha_cung_cap
    FROM nha_cung_cap
    WHERE ten_nha_cung_cap = 'Cong ty Sua Viet Nam'
);
-- SUBQUERY AVG
SELECT 
    ten_san_pham,
    gia,
    (SELECT AVG(gia) FROM san_pham) AS gia_trung_binh
FROM san_pham;
-- SUBQUERY FROM
SELECT *
FROM (
    SELECT 
        ma_hoa_don,
        SUM(so_luong * gia_ban) AS tong_gia_tri
    FROM chi_tiet_hoa_don
    GROUP BY ma_hoa_don
) AS tam
WHERE tong_gia_tri > 50000;
-- EXISTS
SELECT ten_nha_cung_cap
FROM nha_cung_cap ncc
WHERE EXISTS (
    SELECT 1
    FROM san_pham sp
    WHERE sp.ma_nha_cung_cap = ncc.ma_nha_cung_cap
);
-- KIỂM TRA DỮ LIỆU
SELECT * FROM khach_hang;
SELECT * FROM nha_cung_cap;
SELECT * FROM san_pham;
SELECT * FROM hoa_don;
SELECT * FROM chi_tiet_hoa_don;