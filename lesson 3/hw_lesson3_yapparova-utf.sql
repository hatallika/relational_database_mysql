USE vk;

-- справочник городов
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	
	name VARCHAR(128) NOT NULL
);

DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country_id INT(11) UNSIGNED NOT NULL,
	name VARCHAR(128) NOT NULL,
	
	FOREIGN KEY(country_id) REFERENCES countries(id)
	#ON UPDATE  CASCADE
	#ON DELETE RESTRICT
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	region_id INT(11) UNSIGNED NOT NULL,	
	name VARCHAR(128) NOT NULL, 
 
	FOREIGN KEY(region_id) REFERENCES regions(id) 
);

ALTER TABLE profiles ADD COLUMN city_id INT(11) UNSIGNED;

ALTER TABLE profiles ADD FOREIGN KEY (city_id) REFERENCES cities(id);

/* Фотоальбомы пользователей.  Пользователи могут создавать свои альбомы без фото.
 * Созданные фото без указания альбома будут присваиваться автоматически 
 */


DROP TABLE IF EXISTS albums;
CREATE TABLE albums ( 
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL, -- кто создал альбом
	title VARCHAR(250) NOT NULL,
	description VARCHAR(255),
	created_at DATETIME DEFAULT NOW(),-- дата создания альбома
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	INDEX (title),
	FOREIGN KEY(user_id) REFERENCES users(id)
); 

DROP TABLE IF EXISTS photo;
CREATE TABLE photo(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL, -- пользователь загрузивший фото 
	album_id BIGINT UNSIGNED, -- в какой альбом добавлено фото
	title VARCHAR(250),
	description VARCHAR(255),
	filename VARCHAR(255) COMMENT 'адрес фото', 
	created_at DATETIME DEFAULT NOW(), -- дата добавления фото
	
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(album_id) REFERENCES albums(id)
);

-- Оценка пользователей Лайки и Диздайлки
DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
	id SERIAL,
	status ENUM ('like', 'dislike', 'empty'),
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(media_id) REFERENCES media(id)
);

