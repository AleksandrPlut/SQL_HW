# 1. Задание
USE SQL_HW;

DROP TABLE IF EXISTS sales;

CREATE TABLE IF NOT EXISTS sales
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    count_product INT DEFAULT 0
);

SELECT * FROM sales;

INSERT INTO sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

# 2. Задание
/*
	меньше 100 - Маленький заказ
    от 100 до 300 - Средний заказ
    больше 300 - Большой заказ
*/

SELECT
id AS "id заказ",
IF (count_product <= 100, "Маленький заказ",
	IF (count_product > 100 AND count_product <= 300, "Средний заказ",
		IF (count_product > 300, "Большой заказ", "Не определено"))) AS "Тип заказа"
FROM sales;

# 3. Задание

DROP TABLE IF EXISTS orders;

CREATE TABLE IF NOT EXISTS orders
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(30) NOT NULL,
    amount FLOAT,
    order_status VARCHAR(45)
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANSELLED');

SELECT * FROM orders;

SELECT id, employee_id, amount, order_status,
CASE 
	WHEN order_status = 'OPEN' THEN 'Order is in open status'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANSELLED' THEN 'Order is canselled'
    ELSE "Null"
END AS full_order_status
FROM orders;

    



