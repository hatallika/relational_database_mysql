 /* Описать модель хранения данных для сети продуктовых магазинов имеющего программу лояльности с бонусной картой.
  * Личный кабинет покупателя с историей чеков, бонусов, персональных предложений.
 
 Пользователи: id, e-mail, last name second name Анкета с данными: дата рождения, город, адресс, хобби, соц профили, дети,статус
 Количество бонусов, скидки, история покупок, обратная связь, персональные купоны, подписка на рассылку.
 
 Магазин: Каталог: Категории товаров, Товары: название цена скидка, Публикации: Новости и акции компании, скидки на категорию,скидки на товар
 */
 
DROP DATABASE IF EXISTS retailer_shop;
CREATE  DATABASE retailer_shop;
USE retailer_shop;

#Категории товаров в магазине
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название Категории товара',
	UNIQUE unique_name(name(20))
) COMMENT = 'Категории товаров';

INSERT INTO catalogs (name) VALUES
	('Овощи. Фрукты'),
	('Молочные продукты'),
	('Мясо. Птица'),
	('Рыба. Морепродукты'),
	('Бакалея'),
	('Вода. Соки. Напитки'),
	('Колбасы. Сосиски. Мясные деликатесы'),
	('Сыры'),
	('Замороженные продукты'),
	('Хлеб. Выпечка'),
	('Чай. Кофе'),
	('Сладости')
;

#Товары магазина
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название товара',
	description TEXT COMMENT 'Описание товара',
	price DECIMAL (11,2) COMMENT 'Цена товара',
	unit_type INT COMMENT 'Единица измерения',
	catalog_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
) COMMENT = 'Список товаров';

INSERT INTO `products` VALUES 
(1,'consequuntur','Et eum et sit dignissimos vel. Dicta consequatur aliquid sunt sapiente ut voluptas est odit. Sequi quod eum autem.',0.00,4,1,'2020-07-06 00:24:28','1994-01-10 10:54:41'),
(2,'rerum','Aliquam sapiente vel enim dolorem. Sequi laborum temporibus iure. Consequatur sunt et quia optio deleniti voluptates. Voluptate commodi deserunt harum.',7306807.50,2,2,'1990-09-16 20:43:08','2020-03-27 23:39:25'),
(3,'fugit','Dolores blanditiis natus non est. Sit exercitationem rem sed iure. Voluptatibus animi beatae beatae incidunt rem praesentium nostrum. Et impedit reiciendis consequatur numquam maiores. Eum ut velit voluptas voluptas aut quo.',0.00,4,3,'1972-10-18 14:17:39','1987-09-03 16:34:31'),
(4,'delectus','Et commodi illo atque dolor aperiam consequuntur ullam. Quo assumenda cum reprehenderit commodi unde. Laudantium molestias voluptate placeat cupiditate iure quasi dolor. Illo quia quidem eum dolor.',5288.05,3,4,'1974-03-06 01:07:35','1977-02-28 15:32:18'),
(5,'qui','Id inventore provident aut incidunt. Omnis autem molestias adipisci enim. Adipisci assumenda sed quo est sed sed.',7074707.69,4,5,'2002-10-29 22:27:28','2007-07-23 18:38:08'),
(6,'omnis','Doloribus ducimus omnis consequuntur cumque repellendus rerum impedit. Eos ad quisquam voluptatum reiciendis dolorem.',3.41,2,6,'1970-04-05 19:08:11','1975-03-30 17:25:47'),
(7,'repellendus','Eum nisi voluptatem aut rerum. Et assumenda excepturi et.',2118107.00,1,7,'2012-10-15 10:09:00','1994-10-22 07:25:01'),
(8,'alias','Voluptatum occaecati alias saepe hic ex optio. Sit nulla magnam autem asperiores praesentium totam. Enim voluptatibus aliquid voluptate quia minima doloremque. Qui et vitae voluptas rerum quos optio quia et.',6249.01,2,8,'2018-11-11 01:17:32','2015-02-11 10:33:02'),
(9,'molestiae','Et et natus earum quia odio debitis. Nostrum possimus omnis dolorum dolores et. Eum dolor autem sit nam cumque ducimus.',17821310.44,1,9,'1988-01-31 16:30:29','2019-11-21 07:44:20'),
(10,'architecto','Ut voluptas deserunt dolorum. Deleniti velit fugiat alias vel ex veritatis debitis. Aliquid quidem id deserunt occaecati.',897.28,2,10,'1982-06-01 10:27:00','1972-11-15 02:07:09')
;

# Покупатели состоящие в программе лояльности
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, # BEGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	firstname VARCHAR(200) COMMENT 'Имя покупателя',
	lastname VARCHAR(200) COMMENT 'Фамилия покупателя',
	email VARCHAR(200) UNIQUE,
	password VARCHAR(255),
	phone BIGINT UNSIGNED UNIQUE, # +7 (900) 123-45-67 => 79 001 234 567
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	INDEX idx_users_username (firstname, lastname)	
) COMMENT 'Покупатели';

INSERT INTO `users` VALUES
(1,'Wilford','Rowe','estella86@example.org','5243bd50e60f8f7996244228075a2bfa00c7df79',89452258497,'2002-05-16','2018-04-25 12:28:20','2013-05-31 12:51:26'),
(2,'Rey','Grant','bartoletti.morris@example.org','826bb0114ac2ff068d223b83eb51f5001a5071be',84943918446,'2019-06-29','2014-03-22 05:13:23','1975-12-07 16:58:08'),
(3,'Kolby','Blick','kayli06@example.com','4e77635fb53289aacb0dc499a18401154e433b95',88673922559,'2000-11-25','2010-09-08 06:15:38','1989-04-17 12:03:11'),
(4,'Maiya','Hoeger','zhegmann@example.com','edf5306562f395ead8d9a7d88466ca552725d453',89841043953,'1990-10-22','1986-11-25 17:33:13','1973-11-02 08:38:19'),
(5,'Christelle','Gislason','hoyt74@example.org','44939384567251075c3548b64cbae1ee2e75f724',82262969305,'1997-08-25','1975-01-05 12:40:06','1995-07-15 16:00:40'),
(6,'Neva','Kohler','goyette.cristobal@example.org','496c6ed34cc1a6f323553a6768bf3698f3fc706f',81724706240,'2001-08-23','1970-08-26 15:20:11','1983-06-08 07:17:00'),
(7,'Francis','Pouros','bonnie73@example.org','4fa5e42947b2eebf951d2a9714a9611bd974ee3c',82299607819,'2005-08-25','1977-01-13 00:30:31','1979-10-26 16:52:05'),
(8,'Timmothy','Moen','claudie.glover@example.com','b3708ccd92683a162d02ec81cf1060157169dd39',85223061065,'1973-07-16','2019-09-26 21:57:26','2001-12-16 05:24:15'),
(9,'Irma','Crooks','kbernhard@example.net','9de13f69668ff4e404f68e3b28f7541506fb6762',87514515323,'2009-09-15','1986-10-05 15:17:52','2008-03-29 12:44:45'),
(10,'Weston','Hackett','marianne06@example.com','dcdb86606c4fb4b5014fa4bcd7a7cec22236a906',89559451052,'1977-06-28','2006-08-23 01:31:58','2017-07-10 13:58:17')
;

# Анкета покупателя questionnaire
DROP TABLE IF EXISTS questionnaire;
CREATE TABLE questionnaire (
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM ('male','female'),
	hometown VARCHAR(250),
	family_status BIT,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	#Хобби и дети будут вынесены в отдельные таблицы со связями user_id 
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `questionnaire` VALUES
(1,'female','Michelebury',1,'2014-10-27 23:32:31','1983-06-23 12:13:52'),
(2,'female','Wehnerburgh',1,'1995-08-29 03:59:53','2004-08-27 07:04:59'),
(3,'male','West Nigelberg',1,'2011-09-20 04:47:17','1996-11-27 22:24:04'),
(4,'female','Connorton',0,'1975-05-22 08:16:05','2000-07-18 09:34:09'),
(5,'male','South Eleonore',1,'1999-06-13 12:42:44','2019-01-08 07:16:06'),
(6,'female','Skylarfort',1,'1990-02-27 15:11:37','2001-10-15 02:36:25'),
(7,'male','Bobbieton',1,'1993-01-02 10:14:57','2011-01-09 18:48:18'),
(8,'female','Elzafort',1,'1999-06-11 09:52:17','1994-01-18 11:32:11'),
(9,'female','Adeleshire',0,'1996-05-04 16:13:21','2009-02-12 05:43:08'),
(10,'female','Lake Justinatown',1,'1989-03-22 22:23:06','1987-08-04 19:43:34')
;

-- Дети в анкете покупателя. Ребенок созается в момент записи из анкеты родителя. Не учитываем если разные родители записали одного и того же ребенка. Будут как разные.
DROP TABLE IF EXISTS children;
CREATE TABLE children (
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED,
name VARCHAR(255) COMMENT 'Имя ребенка',
birthday_at DATE COMMENT 'Дата рождения ребенка',
gender ENUM ('male','female'),

FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `children` VALUES 
(1,1,'Rick','2009-05-07','female'),(2,2,'Seth','1982-03-13','female'),
(3,3,'Fiona','2014-10-06','female'),(4,4,'Natalia','1980-01-22','female'),
(5,5,'Ashleigh','1992-06-21','male'),(6,6,'Khalid','1984-05-29','male'),
(7,7,'Andreane','1986-08-08','female'),(8,8,'Yvonne','1972-06-29','male'),
(9,9,'Arturo','1986-04-18','male'),(10,10,'Gertrude','1991-09-12','male')
;

-- справочник интересов/хобби 
DROP TABLE IF EXISTS interests;
CREATE TABLE interests (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Категория интересов'
);

INSERT INTO interests (name) VALUES
('Спорт. Фитнес'), ('Путешествия'), ('Сад. Огород. Дача'),
('Рукоделие'), ('Иностранные языки'), ('Дизайн. Рисование'),
('Компьютерные игры'), ('Чтение'),('Фильмы'),('Музыка');

DROP TABLE IF EXISTS users_interests;
CREATE TABLE users_interests (
user_id BIGINT UNSIGNED NOT NULL,
interest_id BIGINT UNSIGNED NOT NULL,

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (interest_id) REFERENCES interests(id)
);

INSERT INTO `users_interests` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Список купонов на скидку на категорию товаров
DROP TABLE IF EXISTS coupons_catalog;
CREATE TABLE coupons_catalog (
id SERIAL PRIMARY KEY,
catalog_id BIGINT UNSIGNED NOT NULL,
discount_percent DECIMAL(5,2) COMMENT 'процент скидки 0..100',
started_at DATETIME COMMENT 'Начало действия скидки',
finished_at DATETIME COMMENT 'Конец действия скидки',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
) COMMENT 'скидки на категории товаров';


INSERT INTO  coupons_catalog (catalog_id, discount_percent, started_at, finished_at) VALUES
(1, 30.00, '2021-10-01 00:00:00', '2021-12-31 23:59:59'),
(2, 30.00, '2021-10-01 00:00:00', '2021-12-31 23:59:59'),
(2, 15.00, '2021-10-01 00:00:00', '2021-12-31 23:59:59'),
(3, 25.00, '2021-10-01 00:00:00', '2021-12-31 23:59:59'),
(4, 5.00, '2021-10-01 00:00:00', '2021-12-31 23:59:59')
;


-- Персональные купоны
/*Купоны - скидки на категории товаров предоставляем группе пользователей*/
DROP TABLE IF EXISTS coupons_catalog_users;
CREATE TABLE coupons_catalog_users (
user_id BIGINT UNSIGNED NOT NULL,
coupons_catalog_id BIGINT UNSIGNED NOT NULL,
	
PRIMARY KEY (user_id, coupons_catalog_id),
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (coupons_catalog_id) REFERENCES coupons_catalog(id)
);

INSERT INTO coupons_catalog_users
(user_id, coupons_catalog_id)
VALUES(1, 1),(1,2),(2,1),(3,1),(4,1),(5,1),(2,4),(6,4);

#Бонусный счет покупателя. Возможно должен быть вычитаемым из истории полкупок и чеков, либо записан из бизнес логики сервиса.
DROP TABLE IF EXISTS bonus_account;
CREATE TABLE bonus_account (
user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
total DECIMAL(10,2),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `bonus_account`(user_id, total) VALUES 
(1,721.00),(2,124.00),(3,554.00),(4,771.00),(5,533.00),
(6,713.00),(7,820.00),(8,158.00),(9,274.00),(10,537.00);

#чеки
DROP TABLE IF EXISTS receipts;
CREATE TABLE receipts (
	id SERIAL PRIMARY KEY,
	`number` BIGINT UNSIGNED NOT NULL ,
	user_id BIGINT UNSIGNED NOT NULL,	
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
	
	FOREIGN KEY (user_id) REFERENCES users(id)	
) COMMENT = 'Чеки покупателей';

INSERT INTO `receipts` VALUES 
(1,4,1,'2004-07-24 19:07:33','2012-10-18 06:19:12'),(2,936287374,2,'2015-06-05 08:57:00','1978-04-17 03:40:58'),
(3,0,3,'1997-04-07 05:59:11','1984-07-04 06:44:06'),(4,911446454,4,'2014-02-02 15:41:55','1982-11-13 12:36:48'),
(5,668854,5,'1999-05-07 07:09:47','1995-02-23 08:06:57'),(6,3250142,6,'1980-07-20 21:41:18','1982-01-08 06:57:15'),
(7,41137,7,'1999-03-31 20:08:12','2021-02-14 08:05:20'),(8,78,8,'2006-08-09 10:43:55','2008-01-02 03:44:50'),
(9,183869,9,'2003-03-05 23:53:22','2010-01-13 22:52:02'),(10,5035932,10,'1994-12-07 13:36:51','1972-02-17 00:39:15'),
(11,2488335,1,'2012-10-01 17:45:52','2003-09-06 22:23:24'),(12,3261,2,'1984-09-07 04:45:39','1984-11-06 19:51:18'),
(13,140984,3,'1980-07-07 03:21:48','1978-07-04 04:11:49'),(14,108571,4,'1983-03-17 09:52:27','1996-09-21 00:07:26'),
(15,5763,5,'1983-02-04 04:06:47','1997-02-13 15:03:44'),(16,9947292,6,'2003-12-10 00:35:25','2000-08-20 19:50:07'),
(17,951799992,7,'1999-12-28 11:10:31','2001-03-31 08:22:22'),(18,52,8,'1984-04-07 06:58:17','1982-06-16 02:37:41'),
(19,5730546,9,'2013-12-16 05:13:07','1997-03-19 05:10:03'),(20,571,10,'2009-05-07 05:33:04','2010-03-27 00:20:18')
;

# Сформированные чеки покупок
DROP TABLE IF EXISTS receipts_products;
CREATE TABLE receipts_products (	
	receipt_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	price_on_sale DECIMAL(10,2) NOT NULL COMMENT 'Стоимость товара на момент продажи' ,
	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество товара в чеке',
	bonus DECIMAL(10,2) COMMENT 'Бонус за товар',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY (receipt_id, product_id),
	FOREIGN KEY (receipt_id) REFERENCES receipts(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
) COMMENT = 'Состав чека';

INSERT INTO receipts_products
(receipt_id, product_id, price_on_sale, total, bonus)
VALUES
(1, 1, '200.00', 2, '5.00'),
(1, 2, '3000.00', 1, '30.00'),
(1, 3, '500.00', 1, '10.00'),
(1, 7, '500.00', 1, '10.00'),
(2, 1, '500.00', 1, '10.00'),
(2, 3, '500.00', 1, '10.00'),
(3, 2, '500.00', 1, '10.00'),
(3, 4, '500.00', 1, '10.00'),
(3, 6, '500.00', 1, '10.00')
;

# История начисления списания бонусов. Храним движения по счету

/*Справочник событий к начислению бонусов и списанию*/
DROP TABLE IF EXISTS descriptions_operation;
CREATE TABLE descriptions_operation (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) COMMENT 'Причина изменения бонусов'
);

INSERT INTO descriptions_operation
(name)
VALUES('Начисление: по чеку'), ('Списание: по чеку'),
('Начисление: День рождение'), ('Списание: возврат по чеку'), ('Персональная акция')
;


DROP TABLE IF EXISTS bonus_history;
CREATE TABLE bonus_history (
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
quantity DECIMAL(10,2) COMMENT 'Количество начисленных или списанных бонусов', 
operation ENUM ('accrued', 'write-off'),
`date` DATETIME COMMENT 'дата и время операции',
description_operation_id INT UNSIGNED NOT NULL,

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (description_operation_id) REFERENCES descriptions_operation(id)
);

INSERT INTO `bonus_history` VALUES
(1,1,174.00,'write-off','1978-11-23 09:23:00',1),(2,2,176.00,'write-off','1990-03-16 15:12:40',2),
(3,3,129.00,'accrued','1974-09-28 23:05:49',3),(4,4,117.00,'accrued','1991-01-30 23:26:45',4),
(5,5,171.00,'write-off','1991-02-18 01:18:32',5),(6,6,192.00,'accrued','1996-09-28 10:01:26',1),
(7,7,167.00,'accrued','1998-10-31 11:45:15',2),(8,8,127.00,'accrued','1970-02-03 10:23:15',3),
(9,9,173.00,'write-off','1978-12-13 07:57:00',4),(10,10,160.00,'accrued','2014-05-05 07:29:12',5),
(11,1,198.00,'accrued','2000-06-29 20:24:07',1),(12,2,180.00,'write-off','2004-08-25 04:25:48',2),
(13,3,197.00,'accrued','2019-07-06 13:21:30',3),(14,4,150.00,'accrued','2000-10-28 23:43:42',4),
(15,5,125.00,'write-off','1976-08-07 22:07:42',5),(16,6,122.00,'write-off','1988-01-06 22:36:14',1),
(17,7,148.00,'accrued','1985-09-30 08:00:15',2),(18,8,135.00,'write-off','1971-03-24 06:43:21',3),
(19,9,165.00,'write-off','1975-01-24 13:56:06',4),(20,10,181.00,'accrued','2018-02-22 08:25:03',5),
(21,1,114.00,'write-off','1974-08-10 03:27:24',1),(22,2,139.00,'write-off','2007-05-27 18:46:07',2),
(23,3,197.00,'accrued','2001-07-29 06:46:45',3),(24,4,128.00,'accrued','1983-12-31 01:10:36',4),
(25,5,164.00,'write-off','2006-08-03 18:27:42',5),(26,6,127.00,'write-off','1973-01-23 08:52:09',1),
(27,7,163.00,'write-off','1996-10-17 09:15:40',2),(28,8,159.00,'write-off','1990-11-02 02:54:05',3),
(29,9,123.00,'write-off','2014-09-05 08:11:50',4),(30,10,100.00,'write-off','1989-06-12 06:01:42',5)
;



#история бонусного счета: Начисление/ Списание. Начислено может быть за покупку, или по другому событию пользователю на счет. Списание за покупку.  
#форма обратной связи - статус обработки обращений. Ответ на обращения.
#история покупок в личном кабинете может быть реализована в представлении из номер чека, дата чека, id продукта, количество товара, стоимость на момент покупки, бонус за товар, статус отмены чека)
