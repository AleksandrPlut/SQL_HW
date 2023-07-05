USE sql_hw;

# 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
# Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

# Решение через функцию
DELIMITER //
CREATE FUNCTION times (seconds INT)
RETURNS VARCHAR (45)
DETERMINISTIC
	BEGIN
		DECLARE days INT DEFAULT 0;
        DECLARE hours INT DEFAULT 0;
        DECLARE minutes INT DEFAULT 0;
        
		WHILE seconds >= 86400 DO
        SET days = seconds / 86400;
        SET seconds = seconds % 86400;
        END WHILE;
        
        WHILE seconds >= 3600 DO
        SET hours = seconds / 3600;
        SET seconds = seconds % 3600;
        END WHILE;
        
        WHILE seconds >= 60 DO
        SET minutes = seconds / 60;
        SET seconds = seconds % 60;
        END WHILE;
        
        RETURN CONCAT(days, " ", "days", " ", 
					 hours, " ", "hours", " ", 
                     minutes, " ", "minutes", " ", 
                     seconds, " ", "seconds");
	END //
DELIMITER ;
SELECT times(123456) AS Times;
    
# Решение через процедуру
DROP PROCEDURE times;
DELIMITER //
CREATE PROCEDURE times (seconds INT)
	BEGIN
		DECLARE days INT DEFAULT 0;
        DECLARE hours INT DEFAULT 0;
        DECLARE minutes INT DEFAULT 0;
        
        WHILE seconds >= 86400 DO
        SET days = seconds / 86400;
        SET seconds = seconds % 86400;
        END WHILE;
        
        WHILE seconds >= 3600 DO
        SET hours = seconds / 3600;
        SET seconds = seconds % 3600;
        END WHILE;
        
        WHILE seconds >= 60 DO
        SET minutes = seconds / 60;
        SET seconds = seconds % 60;
        END WHILE;
        
	SELECT CONCAT(days, " ", "days", " ", 
				  hours, " ", "hours", " ", 
				  minutes, " ", "minutes", " ", 
				  seconds, " ", "seconds") AS Times;
	END //
DELIMITER ;
CALL times(123456);
    
  
  
# 2. Создайте процедуру которая, выводит только четные числа от 1 до 10. 
# Пример: 2,4,6,8,10

DROP PROCEDURE nums;
DELIMITER //
CREATE PROCEDURE nums (a INT, b INT)
	BEGIN
		DECLARE result VARCHAR(45) DEFAULT NULL;
       		WHILE a <= b DO
				IF a % 2 = 0 THEN
					IF result IS NULL THEN
						SET result = concat(a);
					ELSE
						SET result = concat(result, ', ', a);
					END IF;
					SET a = a + 2;
                ELSE
					SET a = a + 1;
                END IF;
            END WHILE;
		SELECT result;
	END//
DELIMITER ;
CALL nums(1, 21);
