-- Chọn cơ sở dữ liệu
USE classicmodels;

-- ===========================================================================
-- 1. TẠO VIEW
-- Tạo bảng ảo customer_views lấy ra mã, tên và số điện thoại khách hàng
-- ===========================================================================
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Truy vấn dữ liệu từ bảng ảo vừa tạo (giống như truy vấn một bảng thật)
SELECT * FROM customer_views;


-- ===========================================================================
-- 2. CẬP NHẬT VIEW (SỬA VIEW)
-- Thay đổi cấu trúc view để lấy thêm họ tên liên hệ và chỉ lọc khách hàng ở 'Nantes'
-- ===========================================================================
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Truy vấn lại để xem view sau khi đã được cập nhật
SELECT * FROM customer_views;


-- ===========================================================================
-- 3. XÓA VIEW
-- Xóa bảng ảo khi không còn nhu cầu sử dụng
-- ===========================================================================
DROP VIEW customer_views;