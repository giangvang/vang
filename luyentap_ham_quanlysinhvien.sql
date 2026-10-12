-- 1. Tạo lại cơ sở dữ liệu và sử dụng
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- 2. Tạo lại bảng Student
CREATE TABLE Student (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(50),
    Address VARCHAR(50),
    Phone VARCHAR(20)
);

-- 3. Tạo lại bảng Subject
CREATE TABLE Subject (
    SubId INT AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(50),
    Credit INT,
    Status BIT
);

-- 4. Tạo lại bảng Mark
CREATE TABLE Mark (
    MarkId INT AUTO_INCREMENT PRIMARY KEY,
    SubId INT,
    StudentId INT,
    Mark FLOAT,
    ExamTimes INT,
    FOREIGN KEY (SubId) REFERENCES Subject(SubId),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- 5. Thêm dữ liệu mẫu để truy vấn
INSERT INTO Student (StudentName, Address, Phone) VALUES
('Nguyen Van A', 'Ha Noi', '0987654321'),
('Tran Thi B', 'Hai Phong', '0123456789'),
('Le Van C', 'HCM', '0912345678');

INSERT INTO Subject (SubName, Credit, Status) VALUES
('Toan Cao Cap', 4, 1),
('Vat Ly', 3, 1),
('Lap Trinh C', 5, 1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes) VALUES
(1, 1, 8.5, 1),
(2, 2, 7.0, 1),
(3, 1, 9.5, 1),
(3, 3, 10.0, 1);

-- ==============================================================================
-- Yêu cầu 1: Hiển thị tất cả các thông tin môn học (bảng Subject) có credit lớn nhất
-- ==============================================================================
-- Sử dụng truy vấn con (Subquery) để tìm giá trị MAX(Credit), sau đó lọc ra môn học có Credit bằng giá trị đó.
SELECT * 
FROM Subject
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- ==============================================================================
-- Yêu cầu 2: Hiển thị các thông tin môn học có điểm thi lớn nhất
-- ==============================================================================
-- Kết nối bảng Subject và Mark, dùng truy vấn con tìm điểm thi cao nhất trong bảng Mark.
SELECT S.SubId, S.SubName, S.Credit, S.Status, M.Mark AS DiemThi
FROM Subject S
JOIN Mark M ON S.SubId = M.SubId
WHERE M.Mark = (SELECT MAX(Mark) FROM Mark);

-- ==============================================================================
-- Yêu cầu 3: Hiển thị thông tin sinh viên và điểm trung bình, xếp hạng giảm dần
-- ==============================================================================
-- Kết hợp GROUP BY để nhóm theo sinh viên, AVG để tính điểm trung bình và ORDER BY ... DESC để sắp xếp giảm dần.
-- Dùng LEFT JOIN để hiển thị cả những sinh viên chưa có điểm (nếu có).
SELECT S.StudentId, S.StudentName, S.Address, S.Phone, AVG(M.Mark) AS DiemTrungBinh
FROM Student S
LEFT JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName, S.Address, S.Phone
ORDER BY DiemTrungBinh DESC;