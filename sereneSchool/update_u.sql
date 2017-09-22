DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_u`;

DELIMITER $$
CREATE PROCEDURE `update_u`(v_name  varchar(45),
								v_pwd  varchar(100),
								v_new_pwd  varchar(100),
								v_re_new_pwd  varchar(100)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var,v_cnt int;
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

	if v_name is null or v_name = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'You must be logged in to perform this task.' into v_error;
		call raise_error();
	end if;

	if v_pwd is null or v_pwd = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'Enter the current password to proceed...' into v_error;
		call raise_error();
	end if;

	if v_new_pwd is null or v_new_pwd = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The new password cannot be null...' into v_error;
		call raise_error();
	end if;

	if v_new_pwd <> v_re_new_pwd then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The new password does not match the Re-entered new password...' into v_error;
		call raise_error();
	end if;

	select char_length(v_new_pwd) into var;
	if var < 6 then
		set v_error_no = 3;
		select 'The password should be atleast 6 characters long...' into v_error;
		call raise_error();
	end if;

	Select count(1) into v_cnt from shr_users 
	where usr_name=v_name and usr_pwd=MD5(v_pwd);

	if v_cnt = 0 then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The current password is wrong. Enter the correct password to proceed...' into v_error;

		UPDATE `serenehrdb`.`shr_users`
		SET usr_login_atempts = case when usr_login_atempts is null then 0 else usr_login_atempts end +1
		WHERE `usr_name` = v_name;
		call raise_error();
	end if;

	set v_error = ' ';
	set v_error_no = 3;
	select 'Unable to update record...' into v_error;
	UPDATE `serenehrdb`.`shr_users`
	SET `usr_pwd_reset` = 'NO',
		`usr_pwd` = MD5(v_new_pwd),
		`usr_login_atempts` = 0
	WHERE `usr_name` = v_name;

COMMIT;
END$$
DELIMITER ;
