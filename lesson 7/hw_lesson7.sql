USE shop;
/* Задача 1:
 * Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

-- 1 вариант со вложеным запросом 
SELECT id, name, birthday_at FROM users
WHERE id = ANY (SELECT user_id FROM orders);

-- 2 вариант с JOIN
SELECT users.id, users.name, birthday_at 
FROM users JOIN  orders
ON users.id = orders.user_id
GROUP BY users.id;


-- Задача 2:
-- Выведите список товаров products и разделов catalogs, который соответствует товару.

-- 1 способ вложенными запросами.
SELECT 
	id, name, (SELECT name FROM catalogs WHERE catalogs.id = products.catalog_id) as'c_name'
FROM 
	products; 

-- 2 способ c JOIN
SELECT 
	products.id, products.name, catalogs.name
FROM 
	products
JOIN 
	catalogs
ON
	catalogs.id = products.catalog_id;

/*Задача 3
 * Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
 * Поля from, to и label содержат английские названия городов, поле name — русское.
 * Выведите список рейсов flights с русскими названиями городов.
*/	

DROP DATABASE IF EXISTS flyght_data;
CREATE DATABASE flyght_data;
USE flyght_data;

DROP TABLE IF EXISTS cities;
 CREATE TABLE  cities(
 	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
 	name VARCHAR(50) COMMENT 'ru'
 );

DROP TABLE IF EXISTS flights;
 CREATE TABLE flights(
 	id SERIAL PRIMARY KEY,
 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
 	`to` VARCHAR(50) NOT NULL COMMENT 'en',
 	
 	FOREIGN KEY(`from`) REFERENCES cities(label),
 	FOREIGN KEY(`to`)  REFERENCES cities(label)
 );

 INSERT INTO cities VALUES
 	('Moscow', 'Москва'),
 	('Saint Petersburg', 'Санкт-Петербург'),
 	('Samara', 'Самара'),
 	('Tomsk', 'Томск'),
 	('Ufa', 'Уфа');

 INSERT INTO flights VALUES
 	(NULL, 'Moscow', 'Saint Petersburg'),
 	(NULL, 'Saint Petersburg', 'Samara'),
 	(NULL, 'Samara', 'Tomsk'),
 	(NULL, 'Tomsk', 'Ufa'),
 	(NULL, 'Ufa', 'Moscow');

 -- 1 Вариант с вложенными запросами. 
 SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;

-- 2 Вариант с JOIN
SELECT f.id, c.name AS `from`, c1.name as `to`
FROM flights f
JOIN cities c ON c.label = f.`from`
JOIN cities c1 ON c1.label = f.`to`
ORDER BY f.id;
