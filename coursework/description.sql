 /* Описать модель хранения данных для сайта продуктового магазина имеющего программу лояльности: 
 Пользоватили: id, e-mail, last name second name Анкета с данными: дата рождения, город, адресс, хобби, соц профили, дети,статус
 Количество бонусов, скидки, история покупок, обратная связь, персональные купоны, подписка на рассылку.
 
 Магазин: Каталог: Категории товаров, Товары: название цена скидка, Публикации: Новости и акции компании, скидки на категорию,скидки на товар
 */
 
DROP DATABASE IF EXISTS retailer_shop;
CREATE  DATABASE retailer_shop;
USE retailer_shop;

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

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';
