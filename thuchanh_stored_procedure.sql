-- 1. Khôi phục lại cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS classicmodels;
USE classicmodels;

-- 2. Tạo lại bảng customers để procedure có dữ liệu truy vấn
CREATE TABLE IF NOT EXISTS customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100)
);

-- 3. Thêm dữ liệu mẫu (chứa khách hàng mã 175 để bạn test thủ tục)
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale'),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.'),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', '2125557818', '897 Long Airport Avenue'),
(175, 'Gift Depot Inc.', 'King', 'Julie', '2035552570', '25593 South Bay Ln.');

-- ===========================================================================
-- 1. TẠO STORED PROCEDURE ĐẦU TIÊN
-- ===========================================================================
DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //
DELIMITER ;

-- ===========================================================================
-- 2. GỌI (THỰC THI) STORED PROCEDURE
-- ===========================================================================
CALL findAllCustomers();

-- ===========================================================================
-- 3. SỬA (XÓA VÀ TẠO LẠI) STORED PROCEDURE
-- Lọc ra khách hàng có customerNumber = 175
-- ===========================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers WHERE customerNumber = 175;
END //
DELIMITER ;

-- Gọi lại thủ tục sau khi đã sửa để kiểm tra kết quả mới
CALL findAllCustomers();