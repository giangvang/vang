-- ===========================================================================
-- BƯỚC 1: TẠO CƠ SỞ DỮ LIỆU VÀ BẢNG
-- ===========================================================================
CREATE DATABASE IF NOT EXISTS company;
USE company;

CREATE TABLE employees (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      department VARCHAR(50) NOT NULL,
      salary DECIMAL(10,2) NOT NULL
);

-- ===========================================================================
-- BƯỚC 2: TẠO TRIGGER
-- Tự động phân loại phòng ban (department) dựa trên mức lương (salary)
-- ===========================================================================
DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
     IF NEW.salary >= 5000 THEN
          SET NEW.department = 'Management';
     ELSEIF NEW.salary >= 3000 THEN
          SET NEW.department = 'Sales';
     ELSE
          SET NEW.department = 'Support';
     END IF;
END //

DELIMITER ;

-- ===========================================================================
-- BƯỚC 3: DEMO SỬ DỤNG TRIGGER
-- ===========================================================================
-- Thêm dữ liệu giả (Dù ta nhập department là 'A', Trigger sẽ tự động sửa lại)
INSERT INTO employees (name, department, salary)
VALUES      ('John Doe', 'A', 3500),
            ('Jane Smith', 'A', 2000),
            ('David Johnson', 'A', 6000);

-- Truy vấn lại bảng để kiểm tra xem Trigger đã hoạt động chính xác chưa
SELECT * FROM employees;