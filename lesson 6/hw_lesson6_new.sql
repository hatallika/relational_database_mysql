/*Задача 1:
 *Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
который больше всех общался с выбранным пользователем (написал ему сообщений).
---------------------------------------------------------------------------*/

use vk;
set @user_id = 1; -- заданный пользователь
select
	from_user_id,
	to_user_id,
	count(*) as total
from messages
where to_user_id = @user_id
group by from_user_id 
order by total desc LIMIT 1
;

-- Вариант Alex c выводом ФИО
SELECT  
  (SELECT firstname FROM users WHERE users.id = messages.from_user_id) AS from_user,
  count(*) as total
FROM messages 
WHERE to_user_id  = 1
GROUP BY from_user
ORDER BY total DESC LIMIT 1;




/*Задача 2*/
/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/
select *
from likes;
select * 
from media;

-- 1 вариант решения фильтруем в условии		
			
select 
	count(*)
from likes
WHERE (select (TIMESTAMPDIFF(year,birthday, now())) from profiles where user_id = 
			(select id from users where id = 
				(select user_id from media where id = media_id)  
			)
	) < 10;

	
-- Второй вариант решения -- фильтруем через список профилей удовлетворяющих условию.
-- вычислим список id users которым меньше 10 лет через дату рождения в профиле 
select 
	id 
from users
where id in	(
	select
		user_id
	from profiles
	where (TIMESTAMPDIFF(year,birthday, now()) < 10)
);
-- выгрузим все медиа получившие лайки, которые принадлежат пользователям из найденного списка. (media_id находящиеся в likes )

select 
	media_id,
	count(*),	
	(select (TIMESTAMPDIFF(year,birthday, now())) from profiles where user_id = (select id from users where id = (select user_id from media where id = media_id)  )
	) as 'age' -- возраст хозяина медиа */
from likes
where media_id in (select media.id from media -- пользователи в users меньше 10 лет 
					where user_id in (
						select 
							id 
						from users
						where id in	(
							select
								user_id
							from profiles
							where (TIMESTAMPDIFF(year,birthday, now()) < 10)
						) -- конец поиска users до 10 лет			

				) )
group by media_id WITH rollup ; -- для наглядности 

-- Уберем лишнее. Оставим только количество.
-- Решение варианта 2

select 	
	count(*)	
from likes
where media_id in (select media.id from media -- пользователи в users меньше 10 лет 
					where user_id in (
						select 
							id 
						from users
						where id in	(
							select
								user_id
							from profiles
							where (TIMESTAMPDIFF(year,birthday, now()) < 10)
						) -- конец поиска users до 10 лет			

				) );
				
	
/*Задача 3
 *Определить кто больше поставил лайков (всего): мужчины или женщины.*/ 

select 
	count(*) as total,
	(select gender from profiles where profiles.user_id = likes.user_id) as `gender`
from likes
group by gender
order by total DESC LIMIT 1;

-- Вариант логический 
-- на выходе логическое выражение. ищем количество f , затем m  сравниваем.
USE vk;
SELECT IF (
(SELECT count(*) as 'gender' FROM likes WHERE user_id in (SELECT user_id FROM profiles WHERE gender = 'f'))
>
(SELECT count(*) as 'gender' FROM likes WHERE user_id in (SELECT user_id FROM profiles WHERE gender = 'm')), 'больше - f', ', больше -m'
);


-- variant Alex

 SELECT DISTINCT 
 	(SELECT count(*) FROM likes WHERE user_id IN (SELECT id FROM users WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'm'))) AS male,
 	(SELECT count(*) FROM likes WHERE user_id IN (SELECT id FROM users WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'f'))) AS female
 FROM profiles 
 WHERE user_id IN (
 	SELECT id  FROM users WHERE id IN (SELECT user_id FROM likes WHERE users.id = likes.user_id) 
 );








