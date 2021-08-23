/*ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке*/

use vk;
SELECT DISTINCT firstname FROM users
ORDER BY firstname;

/*iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
 * Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)*/
ALTER TABLE profiles ADD COLUMN
is_active bit DEFAULT 1;
-- десь тип bit подходит больше всего так как ключает строго 0 и 1.

UPDATE profiles 
SET is_active = 0
WHERE birthday > (CURRENT_TIMESTAMP - interval 18 year); -- CURRENT_DATE()

SELECT * from profiles;

/*Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)*/
DELETE FROM messages
WHERE created_at > CURRENT_TIMESTAMP;
SELECT * from messages;

-- способ преподавателя, удаление сообщений только для интерфейса пользователя, оставляем их на сервере.
ALTER TABLE messages 
ADD COLUMN is_deleted BIT DEFAULT 0;

UPDATE  messages 
SET is_deleted = 1
WHERE created_at > NOW();

-- далее в бизнес логике сообщения отмесенные как удаленые мы не будем выводить, искать и прочее. 
-- Т.о. удаление без удаления. Что используют современные сервисы.	 

/* Тема курсового проекта сайт сети продуктовых магазинов (возможно его программа лояльности - личный кабинет, профиль, бонусы, персональные скидки) 