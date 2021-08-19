/* Задание 1
 * Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки
 * и поля принимающие значение NULL. Напишите запрос, который заменяет все такие поля на строку ‘empty’. 
 * Помните, что на уроке мы установили уникальность на поле name.
 * Возможно ли оставить это условие? Почему?
*/

-- Создадим таблицу
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела'/*,
	UNIQUE unique_name(name(10))*/
) COMMENT = 'Разделы интернет-магазина';

-- Заполним данными
INSERT INTO catalogs VALUES
(NULL, NULL),
(NULL, ''),
(NULL, 'Процессоры');

-- Заменим NULL и ''
UPDATE catalogs SET name='empty' WHERE name='' OR name is NULL;
SELECT * FROM catalogs; 



