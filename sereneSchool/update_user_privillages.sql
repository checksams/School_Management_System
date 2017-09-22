DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_user_privillages`;

DELIMITER $$
CREATE PROCEDURE `update_user_privillages`(v_up_code bigint,
								v_name  varchar(45),
								v_desc  varchar(1000),
								v_min_amt  decimal(25,5),
								v_max_amt  decimal(25,5),
								out v_upcode bigint,
								v_type		varchar(45)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
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

	if v_up_code is null or v_up_code = 0 then
		set v_error_no = 30;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_user_privillages`
		(`up_name`,`up_desc`,`up_min_amt`,`up_max_amt`,`up_type`)
		VALUES
		(v_name,v_desc,v_min_amt,v_max_amt,v_type);
		select max(up_code) into v_upcode from  `serenehrdb`.`shr_user_privillages`;
	else	

		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_user_privillages`
		SET `up_name` = v_name,
		`up_desc` = v_desc,
		`up_min_amt` = v_min_amt,
		`up_max_amt` = v_max_amt,
		`up_type` = v_type
		WHERE `up_code` = v_up_code;
		set v_upcode = v_up_code;
	end if;

COMMIT;
END$$
DELIMITER ;
