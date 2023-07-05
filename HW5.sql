USE sql_hw; 

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

# 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
DROP VIEW cheap_cars;
CREATE VIEW cheap_cars AS
SELECT * FROM cars
WHERE cost < 25000;

SELECT * FROM cheap_cars;

# 2. Изменить в существующем представлении порог для стоимости: 
# пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW cheap_cars AS
SELECT * FROM cars
WHERE cost < 30000;

# 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
DROP VIEW cars_S_A;
CREATE VIEW cars_S_A AS
SELECT * FROM cars
WHERE name = "Skoda" OR name = "Audi";

SELECT * FROM cars_S_A;


# Доп задания:
# 1* Получить ранжированный список автомобилей по цене в порядке возрастания

SELECT
RANK() OVER(ORDER BY cost) `rank`,
name, cost
FROM cars;

# 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость

SELECT name, cost,
SUM(cost) OVER(PARTITION BY `group`) `sum`
FROM(
SELECT name, cost,
NTILE(3) OVER(ORDER BY cost DESC) `group`
FROM cars) `sum_top`
WHERE `group` = 1;

# немного сжульничал используя NTILE, но по другому ни как не получалось
# сам не до конца понял, что я тут понаписал, но результат выдает правильный)))
# если есть решение оптимальнее, буду рад увидеть в коментах к ДЗ, заранее спасибо.


# РЕШЕНИЕ ОТ ПРЕПОДАВАТЕЛЯ
SELECT name,
SUM(cost) OVER() 
FROM ( 
SELECT name, cost 
FROM cars 
ORDER BY cost DESC 
LIMIT 3) AS table_1;

# 3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)

SELECT id, name, cost
FROM(
SELECT 
id, name, cost,
LAG(cost) OVER () `previous`
FROM cars) `cars1`
WHERE cost - `previous` > 0;
# ЙИИИИХУУУ, я это сделал!!!!!))))))

SELECT 
id, name, cost,
LAG(cost) OVER () `previous`
FROM cars;  # для проверки

# РЕШЕНИЕ ОТ ПРЕПОДАВАТЕЛЯ
SELECT name 
FROM (
SELECT name, cost, 
LAG(cost) OVER() `lag`
FROM cars) AS table_2 
WHERE cost > `lag`;


# 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)

SELECT name, cost
FROM(
SELECT 
id, name, cost,
LEAD(cost) OVER () `next`
FROM cars) `cars2`
WHERE cost - `next`  < 0;


SELECT 
id, name, cost,
LEAD(cost) OVER () `next`
FROM cars;  # для проверки


# РЕШЕНИЕ ОТ ПРЕПОДАВАТЕЛЯ
SELECT name 
FROM (
SELECT name, cost, 
LEAD(cost) OVER() `lead` 
FROM cars) AS table_2 
WHERE cost < `lead`;


# 5*Получить список автомобилей, отсортированный по возрастанию цены, 
# и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля

SELECT name, cost,
`next` - cost AS `difference`
FROM(
SELECT 
ROW_NUMBER() OVER(ORDER BY cost DESC) `number`,
name, cost,
LAG(cost) OVER () `next`
FROM cars) `cars2`
ORDER BY cost;

# Выводит вроде правильно, но опять же не уверен в оптимальности написанного запроса

# БУДУ ОЧЕНЬ БЛАГОДАРЕН, ЕСЛИ НАПИШИТЕ ОПТИМАЛЬНЫЕ РЕШЕНИЯ 3, 4 И 5 ЗАДАЧИ


# РЕШЕНИЕ ОТ ПРЕПОДАВАТЕЛЯ
SELECT name, cost, cost-`lead` "Разница с ценой предыдущего авто"
FROM(
SELECT name, cost, 
LEAD(cost) OVER(ORDER BY cost) `lead`
FROM cars) table_3;
