USE SQL_HW;

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(45),
`lastname` VARCHAR(45),
`post` VARCHAR(45),
`seniority` INT,
`salary` INT,
`age` INT
);

INSERT INTO `staff` (`firstname`, `lastname`, `post`, `seniority`, `salary`, `age`)
VALUES
('Вася', 'Васькин', 'Начальник', 40, 100000, 60),
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сашин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 2, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

SELECT * FROM `staff`;


# Задание 1. Отсортировать данные по полю salary в порядке убывания и возрастания. 

SELECT * FROM staff
ORDER BY salary DESC;

SELECT * FROM staff
ORDER BY salary;


# Задание 2. Выведите 5 максимальных зароботных плат.

SELECT salary
FROM staff
ORDER BY salary DESC
LIMIT 5;


# Задание 3. Посчитать суммарную зарплату по каждой специальности.

SELECT post "Должность", SUM(salary) "Суммарная заработная плата"
FROM staff
GROUP BY post;


# Задание 4. Найти количество сотрудников со специальностью "Рабочий" в возрасте от 24 до 49 лет ключительно
# взял оба ограничения по возрасту включительно

SELECT COUNT(post)
FROM staff
WHERE post = "Рабочий" AND age >= 24 AND age <= 49;
# WHERE post = "Рабочий" AND age BETWEEN 24 AND 49; # вторая запись данного задания


# Задание 5. Найти количество специальностей

SELECT COUNT(DISTINCT post) "Количество уникальных специальностей" 
FROM staff;


# Задание 6. Вывести специальности, у которых средний возраст сотрудников меньше 30 лет (включительно)

SELECT post "Специальности", AVG(age) "Средний возраст"
FROM staff
GROUP BY post
HAVING AVG(age) <= 30;