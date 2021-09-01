/*Задачи необходимо решить с использованием объединения таблиц (JOIN)*/

/* Задача 1: Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
который больше всех общался с выбранным пользователем (написал ему сообщений). */
set @user_id = 1;

-- Выведем получателя и отправителя
USE vk;
set @user_id = 1;
SELECT
	m.to_user_id as 'target',
	CONCAT (u.firstname," ", u.lastname) as 'sender',
	COUNT(*) as cnt
FROM messages m 
JOIN users u ON (u.id = from_user_id)
WHERE m.to_user_id = @user_id
GROUP BY m.from_user_id
ORDER BY cnt DESC LIMIT 1;


/*Задача 2: Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..*/
SELECT 
	count(*)
FROM likes l
JOIN media m ON l.media_id = m.id 
JOIN profiles p ON m.user_id = p.user_id
WHERE TIMESTAMPDIFF(year,p.birthday, now()) < 10;


/*Задача 3: Определить кто больше поставил лайков (всего): мужчины или женщины.*/
SELECT 
	gender,
	count(*) as cnt
FROM likes l
JOIN profiles p ON l.user_id = p.user_id 
GROUP BY gender
ORDER BY cnt DESC LIMIT 1;

-- Задача 3 Вариант 2 Через логическое выражение.
SELECT IF(
	(SELECT count(*) 
FROM likes l 
JOIN profiles p ON l.user_id = p.user_id 
WHERE p.gender = 'f') 
	> 
	(SELECT count(*) 
FROM likes l 
JOIN profiles p ON l.user_id = p.user_id 
WHERE p.gender = 'm'), 'f', 'm');



