DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_users`;

DELIMITER $$
CREATE PROCEDURE `update_users`(v_usr_code bigint,
								v_name  varchar(45),
								v_full_name  varchar(1000),
								v_emp_code  int,
								v_pwd_reset   varchar(5),
								out v_usrcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var,v_empcode int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_emp_code is null then
		set v_empcode = null;
	end if;

	if v_usr_code is null or v_usr_code = 0 then
		set v_error_no = 3;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_users`
		(`usr_name`,`usr_full_name`,`usr_emp_code`,`usr_pwd`,
		`usr_last_login`,`usr_login_atempts`,`usr_pwd_reset`)
		VALUES
		(v_name,v_full_name,v_empcode,md5(v_name),
		NULL,null,'YES');
		select max(usr_code) into v_usrcode from  `serenehrdb`.`shr_users`;
	else	
		set v_error = ' ';
		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_users`
		SET `usr_name` = v_name,
			`usr_full_name` = v_full_name,
			`usr_emp_code` = v_empcode,
			`usr_pwd_reset` = v_pwd_reset,
			`usr_login_atempts` = 0
		WHERE `usr_code` = v_usr_code;
		set v_usrcode = v_usr_code;

		if v_pwd_reset = 'YES' then				
			UPDATE `serenehrdb`.`shr_users`
			SET  `usr_pwd` = MD5(v_name)
			WHERE `usr_code` = v_usr_code;
		end if;
	end if;

COMMIT;
END$$
DELIMITER ;
