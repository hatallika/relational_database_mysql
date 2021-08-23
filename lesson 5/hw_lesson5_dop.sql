/*Задание по теме “Операторы, фильтрация, сортировка и ограничение
 ---------------------------------------------------------------- 
 * Задача 1: Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 * Заполните их текущими датой и временем.*/

USE shop;

UPDATE users 
SET created_at = NOW(), updated_at = CURRENT_TIMESTAMP;

/*Задача 2: Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
 * и в них долгое время помещались значения в формате "20.10.2017 8:10".
 * Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
 * -------------------------------------------------------------------
*/

-- Преобразуем формат "20.10.2017 8:10" в 2017-10-20 8:10:00"
UPDATE users 
SET
created_at = concat(substring(created_at, 7, 4), "-", substring(created_at, 4, 2),
"-", substring(created_at, 1, 2), " ", substring(created_at, 12, 4), ":", "00" ),

updated_at = concat(substring(updated_at, 7, 4), "-", substring(updated_at, 4, 2),
"-", substring(updated_at, 1, 2), " ", substring(updated_at, 12, 4), ":", "00" ) 
;
select created_at, updated_at from users; 

-- Второй вариант с использованием функции STR_TO_DATE (created_at, '%d.%m.%Y %k:%i') 
 SELECT STR_TO_DATE (created_at, '%d.%m.%Y %k:%i') FROM users;

UPDATE 
	users
SET
	created_at = STR_TO_DATE (created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE (created_at, '%d.%m.%Y %k:%i');

-- затем изменим тип полей created_at и updated_at
ALTER TABLE users
MODIFY created_at DATETIME DEFAULT NOW(),
MODIFY updated_at DATETIME DEFAULT NOW()
;
-- другой запрос на обновление формата 
ALTER TABLE users
	CHANGE 
		created_at created_at DATETIME DEFAULT NOW();
	
ALTER TABLE users
	CHANGE 
		updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;	

DESCRIBE users;
/*Задача 3: 
 * В таблице складских запасов storehouses_products в поле value могут встречаться
 * самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.
 * -----------------------------------------------------------------------
 */

-- заполнение данными.
truncate storehouses_products;
INSERT INTO storehouses_products
(storehouse_id, product_id, value) VALUES
(1, 1, 0),
(1, 2, 2500),
(1, 3, 0),
(1, 4, 30),
(1, 5, 500),
(1, 6, 0),
(1, 7, 1);

-- Сортировка согласно заданию, нулевые значения вниз, остальные по возрастанию.
SELECT value FROM storehouses_products
ORDER BY (IF(value > 0, 1, 0)) DESC, value ; 


/* Задача 4:(по желанию) Из таблицы users необходимо извлечь пользователей,
 * родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
 * -----------------------------------------------------------------------------
*/
-- Решение
SELECT id, name, 
CASE 
 WHEN month(birthday_at) = 5 THEN 'may'
 WHEN month(birthday_at) = 8 THEN 'august'
END AS `month` 
FROM users
WHERE month(birthday_at) = 5 OR month(birthday_at) = 8
ORDER BY month;

-- Можно сгруппировать пользователей и показать их в строке для каждой группы. 
SELECT GROUP_CONCAT(name), 
CASE 
 WHEN month(birthday_at) = 5 THEN 'may'
 WHEN month(birthday_at) = 8 THEN 'august'
END AS `month` 
FROM users
WHERE month(birthday_at) = 5 OR month(birthday_at) = 8
GROUP BY month;

-- Способ gb
SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users;
SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') = 'may';
SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

/*Задание 5:(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 * Отсортируйте записи в порядке, заданном в списке IN.*/
-- Функция FIELD(id, a, b, c) - возвращает позицию элементов (a, b, c) из заданного списка.
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


/*Практическое задание теме “Агрегация данных”*/
/* -----------------------------------------------------------------------*/

/*Задание 1: Подсчитайте средний возраст пользователей в таблице users*/
SELECT 
avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) as `avg_age`
FROM users;

/*Задание 2: Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
  Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

-- Подставим текущий год в дату рождения и вычислим день недели каждого пользователя сгрупировав по дням недели.

SELECT count(*), DAYNAME(concat(substring(NOW(),1,4), substring(birthday_at,5,15))) as `dayname`
FROM users
GROUP BY `dayname` ;

-- Способ gb
SELECT year(now()),month(birthday_at), day(birthday_at)
FROM users; 

SELECT 
	date_format(DATE(CONCAT_WS('-', year(now()), month(birthday_at), day(birthday_at))), '%W')  as `day`,
	count(*) as total 
FROM 
	users
GROUP BY `day`
ORDER BY total DESC;


/* Задание 3: (по желанию) Подсчитайте произведение чисел в столбце таблицы*/

-- Воспользуемся свойством логарифмов: логарифм произведения равен сумме логарифмов,
-- ln(2*3*4*5) = ln(2) + ln(3) + ln(4) + ln(5)
-- exp(ln(2*3*4*5)) = 2*3*4*5 = exp(ln(2) + ln(3) + ln(4) + ln(5)) */
SELECT exp(SUM(log(value))) as product FROM tbl;

-- формула gb
SELECT EXP(SUM(LN(value))) FROM tbl;

