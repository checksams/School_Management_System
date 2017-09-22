DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_emp_photo`;

DELIMITER $$
CREATE PROCEDURE `update_emp_photo`(v_emp_code bigint,
								v_photo_stream  mediumblob,
								v_photo_updatedby varchar(100)
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
	select length(v_photo_stream) into var;
	if var is null or var = 0 then
		set v_error_no = 3;
		select 'Upload a photo to proceed...' into v_error;
		call raise_error();
	end if;
	
	if v_emp_code is null or v_emp_code = 0 then
		set v_error_no = 3;
		select 'Select an employee to proceed...' into v_error;
		call raise_error();
	end if;	
	
	if v_photo_updatedby is null or v_photo_updatedby = "" then
		set v_error_no = 3;
		select 'Login first to proceed...' into v_error;
		call raise_error();
	end if;	

	set v_error_no = 3;
	select 'Unable to update employee photo...' into v_error;
	UPDATE `serenehrdb`.`shr_employees`
	SET `emp_photo` = v_photo_stream,
		`emp_photo_updatedby` = v_photo_updatedby
	WHERE `emp_code` = v_emp_code;

COMMIT;
END$$
DELIMITER ;
