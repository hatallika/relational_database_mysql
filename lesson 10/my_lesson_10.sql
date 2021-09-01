/*Напишем процедуру, которая будет предлагать пользователям новых друзей.
Критерии выбора пользователей:
-	из одного города
-	состоят в одной группе
-	друзья друзей
Из выборки будем показывать 5 человек в случайной комбинации.
*/
DROP PROCEDURE IF EXISTS sp_frendship_offers;

USE vk;
DELIMITER //
CREATE PROCEDURE sp_frendship_offers(for_user_id BIGINT UNSIGNED)
BEGIN
	# из одного города
	SELECT p2.user_id
	FROM profiles p1 
	JOIN profiles p2 ON p1.hometown = p2.hometown 
	WHERE p1.user_id  = for_user_id
		AND p2.user_id != for_user_id
UNION
	# состоят в одной группе
	SELECT uc2.user_id
	FROM  users_communities uc1
	JOIN  users_communities uc2 ON uc1.community_id = uc2.community_id
	WHERE uc1.user_id  = for_user_id
		AND uc2.user_id != for_user_id
UNION
	# друзья друзей
	SELECT fr3.target_user_id
	FROM friend_requests fr1
	JOIN friend_requests fr2
		on (fr1.target_user_id = fr2.initiator_user_id 
			or fr1.initiator_user_id = fr2.target_user_id)
	JOIN friend_requests fr3
		on (fr3.target_user_id = fr2.initiator_user_id 
			or fr3.initiator_user_id = fr2.target_user_id)		
	 
	WHERE (fr1.initiator_user_id  = for_user_id or  fr1.target_user_id = for_user_id) 
		AND fr2.status  = 'approved'
		AND fr3.status  = 'approved'
		AND fr3.target_user_id != for_user_id
	ORDER BY RAND() 
	LIMIT 5
	;

END//
DELIMITER ;

call sp_frendship_offers(1);

DROP FUNCTION IF EXISTS vk.friendship_direction;

DELIMITER $$
$$
CREATE FUNCTION vk.friendship_direction(check_user_id BIGINT UNSIGNED)
RETURNS FLOAT READS SQL DATA
# DETERMINISTIC, NO SQL, or READS SQL DATA
BEGIN
	DECLARE request_to_user INT;
	DECLARE request_from_user INT;

	SET request_to_user = (
		SELECT COUNT(*) 
		FROM friend_requests
		WHERE target_user_id  = check_user_id
	);
	/*SET request_from_user = (
		SELECT COUNT(*) 
		FROM friend_requests
		WHERE initiator_user_id  = check_user_id;
	);*/

	SELECT COUNT(*)
	INTO request_from_user
	FROM friend_requests
	WHERE initiator_user_id  = check_user_id;

	RETURN request_to_user / request_from_user;
	
END$$
DELIMITER ;

SELECT ROUND(friendship_direction(1), 2) AS user_popularity; 

-- Транзакции
/*START TRANSACTION;
	INSERT INTO users ( firstname, lastname, email, phone)
	VALUES ('New2', 'User2', 'new@mail12.ru', 45344545663);

	INSERT INTO profiles (user_id, gender, birthday, hometown)
	VALUES (last_insert_id(), 'FFFF', '1999-10-10', 'Moskow');
COMMIT;
#ROLLBACK;*/

SELECT * FROM users ORDER BY id DESC;
SELECT * FROM profiles ORDER BY user_id DESC;

-- Процедура для отслеживания попадания данных в таблицу.
DROP PROCEDURE IF EXISTS vk.sp_add_user;

DROP PROCEDURE IF EXISTS vk.sp_add_user;

DROP PROCEDURE IF EXISTS vk.sp_add_user;

DELIMITER $$
$$
CREATE PROCEDURE vk.sp_add_user( 
	firstname varchar(100), lastname varchar(100), 
	email varchar(100), phone varchar(12), hometown varchar(50), photo_id INT, 
	
	OUT tran_result VARCHAR(200))
BEGIN
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET `_rollback` = 1;
		END;	
	START TRANSACTION;
		INSERT INTO users ( firstname, lastname, email, phone)
		VALUES (firstname, lastname, email, phone);
	
		INSERT INTO profiles (user_id, hometown, photo_id)
		VALUES (last_insert_id(), hometown, photo_id); 
	
	IF `_rollback` = 1 THEN
		SET tran_result = 'ROLLBACK';
		ROLLBACK;
	ELSE
		SET tran_result = 'COMMIT'; 
		COMMIT;
	END IF; 	
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS vk.sp_add_user;

DELIMITER $$
$$
CREATE PROCEDURE vk.sp_add_user( 
	firstname varchar(100), lastname varchar(100), 
	email varchar(100), phone varchar(12), hometown varchar(50), photo_id INT, 
	
	OUT tran_result VARCHAR(200))
BEGIN
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			SET `_rollback` = 1;
			GET stacked DIAGNOSTICS CONDITION 1
				code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
			SET tran_result = CONCAT('ERROR ocured. Code: ', code, 'Text: ', error_string);
		END;
	
	START TRANSACTION;
		INSERT INTO users ( firstname, lastname, email, phone)
		VALUES (firstname, lastname, email, phone);
	
		INSERT INTO profiles (user_id, hometown, photo_id)
		VALUES (last_insert_id(), hometown, photo_id); 
	
	IF `_rollback` = 1 THEN		
		ROLLBACK;
	ELSE
		SET tran_result = 'OK'; 
		COMMIT;
	END IF; 	
END$$
DELIMITER ;

call sp_add_user('New2', 'User', 'ne87@mail.com', 454545353, 'Moscow', 1, @tran_result);
SELECT @tran_result;

-- Представления VIEW
CREATE VIEW v_friends AS
	SELECT *
 	FROM users u
    JOIN friend_requests fr ON u.id = fr.target_user_id
 	WHERE 
		fr.status = 'approved'

  		UNION
  	
	SELECT *
	FROM users u
	JOIN friend_requests fr ON u.id = fr.initiator_user_id
	WHERE 
		fr.status = 'approved'
;
SELECT * FROM v_friends
where id = 1;

DROP VIEW v_friends;
-- 	Триггеры

USE vk;

DELIMITER $$
$$
CREATE TRIGGER check_user_age_before_update
BEFORE UPDATE
ON profiles FOR EACH ROW
BEGIN
	IF NEW.birthday >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Обновление отменено. Дата рождения должна быть в прошлом.';
	END IF;
END
$$
DELIMITER ;

SELECT * FROM profiles
WHERE user_id = 1;

-- Обновим ДР пользователя с некорректной датой

UPDATE profiles
SET birthday='2000.10.10'
WHERE user_id = 1;

-- Триггер выдаст ошибку ту, что в нем написали.


