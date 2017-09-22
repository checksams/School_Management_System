DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_user_role_privlg`;

DELIMITER $$
CREATE PROCEDURE `update_user_role_privlg`(v_urp_code bigint,
								v_up_code bigint,
								v_ur_code bigint,
								v_min_amt decimal(25,5),
								v_max_amt decimal(25,5),
								out v_urpcode bigint
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

	if v_urp_code > 0  then
		set v_urpcode = v_urp_code;
	else
		select count(1) into v_cnt from  `serenehrdb`.`shr_user_role_privlg`
		where urp_ur_code = v_ur_code and urp_up_code = v_up_code;

		if v_cnt = 1 then
			select urp_code into v_urpcode from  `serenehrdb`.`shr_user_role_privlg`
			where urp_ur_code = v_ur_code and urp_up_code = v_up_code;
		end if;
	end if;

	if v_urpcode is null or v_urpcode = 0 then
		set v_error_no = 3;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_user_role_privlg`
		(`urp_ur_code`, `urp_up_code`, `urp_date`, `urp_min_amt`, `urp_max_amt`)
		VALUES
		(v_ur_code, v_up_code, Now(), v_min_amt, v_max_amt);
		select max(urp_code) into v_urpcode from  `serenehrdb`.`shr_user_role_privlg`;
	else	

		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_user_role_privlg`
		SET `urp_min_amt` = v_min_amt, 
			`urp_max_amt` = v_max_amt
		WHERE `urp_code` = v_urpcode;
	end if;

COMMIT;
END$$
DELIMITER ;
