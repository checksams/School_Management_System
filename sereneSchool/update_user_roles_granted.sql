DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_user_roles_granted`;

DELIMITER $$
CREATE PROCEDURE `update_user_roles_granted`(v_usg_code bigint,
								v_usr_code  int,
								v_ur_code  int,
								v_created_by  varchar(100),
								out v_usgcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var, v_cnt int;
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

	if v_usg_code > 0  then
		set v_usgcode = v_usg_code;
	else
		select count(1) into v_cnt from  `serenehrdb`.`shr_user_roles_granted`
		where usg_usr_code = v_usr_code and usg_ur_code = v_ur_code;

		if v_cnt = 1 then
			select usg_code into v_usgcode from  `serenehrdb`.`shr_user_roles_granted`
			where usg_usr_code = v_usr_code and usg_ur_code = v_ur_code;
		end if;
	end if;


	if v_usgcode is null or v_usgcode = 0 then
		set v_error_no = 30;
		INSERT INTO `serenehrdb`.`shr_user_roles_granted`
		(`usg_usr_code`,`usg_ur_code`,`usg_date`,`usg_created_by`)
		VALUES
		(v_usr_code,v_ur_code,Now(),v_created_by);
		select max(usg_code) into v_usgcode from  `serenehrdb`.`shr_user_roles_granted`;
	end if;

COMMIT;
END$$
DELIMITER ;
