-- ==========================================
-- PHẦN 1: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ==========================================
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE `Order` (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

-- ==========================================
-- PHẦN 2: THÊM DỮ LIỆU VÀO CÁC BẢNG
-- ==========================================
INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- ==========================================
-- PHẦN 3: CÁC CÂU LỆNH TRUY VẤN (SELECT)
-- ==========================================
-- Yêu cầu 1: Hiển thị thông tin oID, oDate, oTotalPrice của tất cả các hóa đơn
SELECT oID, oDate, oTotalPrice 
FROM `Order`;

-- Yêu cầu 2: Hiển thị danh sách khách hàng đã mua hàng và sản phẩm được mua
SELECT c.Name AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

-- Yêu cầu 3: Hiển thị tên những khách hàng không mua bất kỳ sản phẩm nào
SELECT c.Name 
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;

-- Yêu cầu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
SELECT o.oID, o.oDate, SUM(od.odQTY * p.pPrice) AS oTotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON p.pID = od.pID
GROUP BY o.oID, o.oDate;