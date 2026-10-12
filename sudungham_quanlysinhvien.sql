-- 1. Tạo cơ sở dữ liệu và sử dụng
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- 2. Tạo bảng Student
CREATE TABLE Student (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(50),
    Address VARCHAR(50)
);

-- 3. Tạo bảng Mark
CREATE TABLE Mark (
    MarkId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    Mark FLOAT,
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- 4. Thêm dữ liệu mẫu để truy vấn
INSERT INTO Student (StudentName, Address) VALUES
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'Hai Phong'),
('Le Van C', 'Ha Noi'),
('Pham Thi D', 'HCM');

INSERT INTO Mark (StudentId, Mark) VALUES
(1, 16),
(1, 18),
(2, 14),
(3, 19),
(4, 10);

-- Bước 2: Hiển thị số lượng sinh viên ở từng nơi
SELECT Address, COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;

-- Bước 3: Tính điểm trung bình các môn học của mỗi học viên
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'Điểm trung bình'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

-- Bước 4: Hiển thị những bạn học viên có điểm trung bình các môn học lớn hơn 15
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'Điểm trung bình'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 15;

-- Bước 5: Hiển thị thông tin các học viên có điểm trung bình lớn nhất
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'Điểm trung bình'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);