-- 1. Tạo cơ sở dữ liệu để khắc phục lỗi Unknown database
CREATE DATABASE IF NOT EXISTS classicmodels;
USE classicmodels;

-- 2. Tạo bảng customers với các cột dữ liệu theo đúng chuẩn bài thực hành
CREATE TABLE IF NOT EXISTS customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100)
);

-- 3. Thêm dữ liệu mẫu vào bảng (bao gồm các khách hàng cần tìm kiếm)
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale'),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.'),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', '2125557818', '897 Long Airport Avenue'),
(175, 'Gift Depot Inc.', 'King', 'Julie', '2035552570', '25593 South Bay Ln.');

-- 1. Tìm thông tin khách hàng có tên là 'Land of Toys Inc.' (Truy vấn bình thường)
SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 2. Sử dụng EXPLAIN để kiểm tra tốc độ truy vấn TRƯỚC khi đánh Index
-- Bạn sẽ thấy type = ALL và số rows phải quét rất lớn (Full Table Scan)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 3. Thêm chỉ mục (Index) cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- 4. Sử dụng EXPLAIN để kiểm tra tốc độ truy vấn SAU khi đánh Index
-- Bạn sẽ thấy type = ref và số rows giảm xuống chỉ còn 1 (Index Seek)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 5. Thêm chỉ mục theo cặp (Composite Index) cho contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- 6. Sử dụng EXPLAIN để kiểm tra truy vấn với Composite Index
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 7. Xoá chỉ mục idx_full_name trong bảng
ALTER TABLE customers DROP INDEX idx_full_name;