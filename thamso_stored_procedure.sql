
CREATE DATABASE IF NOT EXISTS classicmodels;
USE classicmodels;

-- 2. Tạo lại bảng customers (có thêm cột city để thực hành tham số OUT)
CREATE TABLE IF NOT EXISTS customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(100),
    city VARCHAR(50)
);

-- 3. Thêm dữ liệu mẫu (thêm khách hàng ở thành phố 'Lyon' để test thủ tục)
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city) VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', 'Paris'),
(112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', 'Las Vegas'),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', '2125557818', '897 Long Airport Avenue', 'NYC'),
(175, 'Gift Depot Inc.', 'King', 'Julie', '2035552570', '25593 South Bay Ln.', 'Lyon'),
(176, 'Auto Design', 'Smith', 'John', '1234567890', '123 Main St', 'Lyon');

-- ===========================================================================
-- 1. THAM SỐ LOẠI IN (Mặc định)
-- Truyền giá trị vào để Procedure sử dụng (tìm kiếm khách hàng theo ID)
-- ===========================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `getCusById`//

CREATE PROCEDURE getCusById(IN cusNum INT(11))
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //
DELIMITER ;

-- Gọi Procedure và truyền tham số IN là 175
CALL getCusById(175);


-- ===========================================================================
-- 2. THAM SỐ LOẠI OUT
-- Lấy kết quả tính toán từ bên trong Procedure ra bên ngoài
-- ===========================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `GetCustomersCountByCity`//

CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //
DELIMITER ;

-- Gọi Procedure, truyền 'Lyon' làm tham số IN và biến @total làm tham số OUT
CALL GetCustomersCountByCity('Lyon', @total);

-- Hiển thị giá trị của biến @total để xem kết quả lấy ra
SELECT @total AS 'Total Customers in Lyon';


-- ===========================================================================
-- 3. THAM SỐ LOẠI INOUT
-- Vừa truyền giá trị vào, vừa nhận giá trị thay đổi trả về
-- ===========================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `SetCounter`//

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //
DELIMITER ;

-- Khởi tạo biến @counter với giá trị là 1
SET @counter = 1;

-- Gọi Procedure nhiều lần để cộng dồn giá trị
CALL SetCounter(@counter, 1); -- @counter = 1 + 1 = 2
CALL SetCounter(@counter, 1); -- @counter = 2 + 1 = 3
CALL SetCounter(@counter, 5); -- @counter = 3 + 5 = 8

-- Hiển thị giá trị cuối cùng của @counter
SELECT @counter AS 'Final Counter Value';