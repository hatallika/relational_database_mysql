/*
 Практическое задание по теме “Транзакции, переменные, представления”
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

-- Создадим базу sample и таблицу users 
DROP DATABASE IF EXISTS sample;
CREATE  DATABASE sample;
USE sample;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- решение задачи
START TRANSACTION;
SELECT * FROM shop.users;

INSERT INTO users
SELECT * FROM shop.users 
WHERE id = 1;

SELECT * FROM users;

COMMIT;


/*Создайте представление, которое выводит название name товарной позиции из таблицы products
  и соответствующее название каталога name из таблицы catalogs.
  */
USE shop;
CREATE OR REPLACE VIEW names (name_prod, name_cat)AS
SELECT p.name, c.name
FROM products p
JOIN catalogs c ON p.catalog_id = c.id;

SELECT * FROM names;
  
/*(по желанию) Пусть имеется таблица с календарным полем created_at.
 * В ней размещены разряженые календарные записи за август 2018 года
 '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
 если дата присутствует в исходном таблице и 0, если она отсутствует.*/
 
/*(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

 * */