/*i. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)*/
use vk;

-- users Пользователи
INSERT INTO users (firstname, lastname, email, password_hash, phone) VALUES
('Shad','Oneal','pharetra.felis@variusorci.co.uk','16861121 5693',81202747264),
('Adria','Dyer','vitae.odio.sagittis@mattisCraseget.ca','16671127 3752',89207859424),
('Austin','Newton','Aenean.massa.Integer@pedeultrices.net','16540821 1976',86632025716),
('Honorato','Woodward','vulputate@magnaPraesent.org','16770716 3957',84552312321),
('Caryn','Sandoval','tincidunt.nunc@anteMaecenasmi.ca','16660721 2302',82144993820),
('Addison','Walter','egestas@Morbiquisurna.net','16521113 2252',89935267802),
('Jessica','Pugh','fringilla.ornare.placerat@malesuadafringillaest.edu','16750630 3077',89928236015),
('Solomon','Gilbert','semper@elit.org','16930822 4774',87866225769),
('Darrel','Carroll','sit@Nullatempor.net','16230521 3577',87038974423),
('Octavius','Duke','penatibus.et@Fusce.edu','16800430 5903',88569722257);

-- profiles Профили пользователей
INSERT INTO profiles (user_id, gender, birthday , hometown) VALUES
(1,'m','2021-10-30','Huara'),
(2,'m','2021-03-15','Puerto López'),
(3,'m','2021-06-20','Lleida'),
(4,'f','2022-06-19','Cajazeiras'),
(5,'f','2021-10-22','Sale'),
(6,'f','2022-05-23','Córdoba'),
(7,'m','2022-07-10','Oostakker'),
(8,'m','2021-02-02','Zielona Góra'),
(9,'m','2022-05-09','Sassocorvaro'),
(10,'f','2022-02-13','Castelluccio Superiore');

-- messages - Отправка сообщения
INSERT INTO messages (from_user_id, to_user_id, body) values
('1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.'),
('2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.'),
('3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.'),
('1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.'),
('1','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.'),
('5','2','Voluptatem trt ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.'),
('5','1','Seeint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.'),
('2','1','Sed mollitrrera quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.'),
('3','1','Quod dicta omnis placeat id et offis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.'),
('1','5','Volupwewtas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.')
;

-- friend-requests Отправка запроса в друзья. 
/*Здесь делаю однострочную и многострочную вставку*/

INSERT INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`)
VALUES ('1', '2', 'requested');

INSERT INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`)
VALUES ('1', '3', 'requested');

INSERT INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`)
VALUES ('1', '4', 'requested');

INSERT INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`)
VALUES ('1', '5', 'requested');

INSERT INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`) VALUES
('1', '6', 'requested'),
('1', '7', 'requested'),
('1', '8', 'requested'),
('2', '3', 'requested');

-- Ответ на запрос дружбы
UPDATE friend_requests
SET 
	status = 'declined'
WHERE
	initiator_user_id = 1 and target_user_id = 3;

UPDATE friend_requests
SET 
	status = 'approved'
WHERE
	initiator_user_id = 1 and target_user_id = 2;

-- communities Сообщества
INSERT INTO communities (name, admin_user_id) VALUES
('Duis risus odio,',2),
('risus. Donec egestas. Aliquam nec',7),
('non magna. Nam',1),
('tincidunt adipiscing. Mauris',2),
('Nullam lobortis quam',2),
('auctor non, feugiat nec,',3),
('condimentum eget, volutpat ornare,',9),
('Ut tincidunt vehicula risus. Nulla',8),
('pede nec ante blandit viverra.',3),
('et, eros. Proin',1),
('arcu. Vestibulum ante ipsum primis',2),
('mi fringilla mi',4),
('non arcu. Vivamus sit',1),
('rhoncus. Donec est.',3),
('egestas rhoncus. Proin nisl sem,',6),
('eget varius ultrices, mauris',2),
('Suspendisse eleifend. Cras sed',6),
('nostra, per inceptos hymenaeos.',3),
('odio a purus. Duis elementum,',6),
('lectus ante dictum',1);

-- users_communities Вступления в сообщества
INSERT INTO users_communities VALUES 
(4,10),(10,5),(5,2),(2,6),(8,4),(3,3),(3,9),(4,5),(5,3),(10,3),(5,4),(2,7),(2,8),(8,3),(5,5),(3,7),
(9,6),(10,7),(5,9),(6,10),(7,8),(5,10),(10,4),(5,7),(8,10),(5,6),(1,9),(2,4),(1,10),(7,9);

-- media_types Типы данных
INSERT INTO media_types (name) VALUES ('audio'),('video'),('text'),('music'),('image');

-- media
INSERT INTO media (media_type_id, user_id, body, filename, `size`, metadata) VALUES
(4,9,"ornare egestas ligula. Nullam feugiat placerat",'name_1',5350,"null"),
(5,7,"in, cursus et, eros. Proin ultrices.",'name_2',4497,"null"),
(5,10,"iaculis quis, pede. Praesent eu dui. Cum sociis natoque",'name_3',1060,"null"),
(2,1,"Integer vitae nibh. Donec est",'name_4',9770,"null"),
(2,9,"nisi nibh lacinia orci, consectetuer euismod",'name_5',2829,"null"),
(4,9,"gravida nunc sed pede. Cum",'name_6',11574,"null"),
(1,6,"amet orci. Ut sagittis lobortis",'name_7',6649,"null"),
(3,4,"condimentum eget, volutpat ornare, facilisis eget, ipsum.",'name_8',11511,"null"),
(4,8,"id, ante. Nunc mauris sapien,",'name_9',19074,"null"),
(2,3,"lacinia orci, consectetuer euismod est arcu ac orci. Ut semper",'name_10',19899,"null");

-- likes
INSERT INTO likes (user_id, media_id) VALUES
(1,2),(1,3),(1,4),(2,2),(2,3),(2,5),(5,1),(5,2),(4,9),(2,4);
-- photo_albums
INSERT INTO photo_albums (name, user_id) VALUES
("nec,",3),("Curabitur",10),("eget",6),("velit",2),("nec,",3),("tempus",9),("condimentum",1),
("laoreet",3),("Nunc",9),("euismod",4);

-- 
INSERT INTO photos (album_id, media_id) VALUES
(10,1),(5,4),(9,6),(7,5),(8,9),(3,1),(9,4),(1,3),(4,9),(2,4);

