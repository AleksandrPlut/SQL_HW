# 1. Задание
USE SQL_HW;
DROP TABLE IF EXISTS mobile_phone;
CREATE TABLE IF NOT EXISTS mobile_phone
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL
);

INSERT INTO mobile_phone (ProductName, Manufacturer, ProductCount, Price)
VALUES 
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

SELECT * FROM mobile_phone;

# 2. Задание
SELECT ProductName, Manufacturer, Price FROM mobile_phone
WHERE ProductCount > 2;

# 3. Задание
SELECT * FROM mobile_phone
WHERE Manufacturer = 'Samsung';

# 4. Задание (чет сразу решил проверять по дву столбикам)
# 4.1 
SELECT * FROM mobile_phone
WHERE ProductName LIKE 'iP%'  OR  Manufacturer LIKE 'iP%';

# 4.2
SELECT * FROM mobile_phone
WHERE ProductName LIKE 'Sams___'  OR  Manufacturer LIKE 'Sams___';

# 4.3
SELECT * FROM mobile_phone
WHERE ProductName LIKE '%8'  OR  Manufacturer LIKE '%8';
