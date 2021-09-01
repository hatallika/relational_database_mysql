/*Задача 1: Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 *С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
 *с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 *с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 *----------------------------------------------------__________________*/
DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE now_time TIME default CURTIME();	
	CASE #now_time 
		WHEN now_time BETWEEN '06:00:00' AND '12:00:00' THEN
			RETURN 'Доброе утро';
		WHEN now_time BETWEEN '12:00:00' AND '18:00:00' THEN
			RETURN 'Добрый день';
		WHEN now_time BETWEEN '18:00:00' AND '00:00:00' THEN
			RETURN 'Добрый вечер';
		ELSE
			RETURN 'Доброй ночи';		
	END CASE;
END//
DELIMITER ;
SELECT hello();

/*Задача 2: В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
 Допустимо присутствие обоих полей или одно из них.
 Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 При попытке присвоить полям NULL-значение необходимо отменить операцию.
 ----------------------------------------------------------------------
 */

-- Пишем триггер который проверяет вводимые поля, и если оба будут пустые то отправит сообщение об ошибке
SELECT name, description FROM products;
DELIMITER //
DROP TRIGGER IF EXISTS check_name_description_insert//
CREATE TRIGGER check_name_description_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
	IF COALESCE(NEW.name, NEW.description) IS NULL THEN	
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;	 
END //

SELECT name, description FROM products//

DELIMITER //
DROP TRIGGER IF EXISTS check_name_description_update//
CREATE TRIGGER check_name_description_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN 
	IF COALESCE(NEW.name, NEW.description) IS NULL THEN	
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATED canceled';
	END IF;	 
END//
DELIMITER ;
-- 
INSERT INTO products (name, description) VALUES
(NULL, 'Процессор для настольных компьютеров, основанных на платформе Intel.');
INSERT INTO products (name, description) VALUES
('Intel Core i5-7400', NULL);
INSERT INTO products (name, description) VALUES
(NULL, NULL);

UPDATE products SET name = NULL, description = 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.' WHERE id = 5;
UPDATE products SET name = 'AMD FX-8321', description = NULL WHERE id = 6;
UPDATE products SET name = NULL, description = NULL WHERE id = 2;

/*(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
 * Вызов функции FIBONACCI(10) должен возвращать число 55.*/

DELIMITER //
DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fs DOUBLE;
	SET fs = SQRT(5);
	RETURN (POW((1 + fs)/2.0, num) + POW((1 - fs)/2.0, num))/fs;
END//
DELIMITER ;
SELECT FIBONACCI(10);