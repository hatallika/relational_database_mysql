/*ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке*/

use vk;
SELECT DISTINCT firstname FROM users
ORDER BY firstname;

/*iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
 * Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)*/
ALTER TABLE profiles ADD COLUMN
is_active BOOL DEFAULT 1;

UPDATE profiles 
SET is_active = 0
WHERE birthday > (CURRENT_TIMESTAMP - interval 18 year); -- CURRENT_DATE()

SELECT * from profiles;

/*Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)*/
DELETE FROM messages
WHERE created_at > CURRENT_TIMESTAMP;
SELECT * from messages;


/* Тема курсового проекта сайт сети продуктовых магазинов (возможно его программа лояльности - личный кабинет, профиль, бонусы, персональные скидки) 