DROP PROCEDURE IF EXISTS `update_emp_pay_elements`;

DELIMITER $$

CREATE PROCEDURE `update_emp_pay_elements` (v_epe_code int,
								v_emp_code int,
								v_pel_code int,
								v_amt decimal(25,5),
								v_created_by  varchar(100),
								out v_epecode int,
								v_ot_hours int
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating employee pay element record...';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error updating employee pay element record...';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error updating employee pay element record..3...';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

if v_epe_code is null or v_epe_code = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_emp_pay_elements`
	(`epe_emp_code`,`epe_pel_code`,`epe_amt`,`epe_date`,`epe_created_by`, `epe_ot_hours`)
	VALUES
	(v_emp_code,v_pel_code,v_amt,Now(),v_created_by, v_ot_hours);
	select max(epe_code) into v_epecode from  `serenehrdb`.`shr_emp_pay_elements`;
else	
	set v_error_no = 2;
	UPDATE `serenehrdb`.`shr_emp_pay_elements`
	SET `epe_amt` = v_amt
	WHERE `epe_code` = v_epe_code;
	set v_epecode = v_epe_code;
end if;

if v_epe_code is not null and v_epe_code > 0 then
	set v_error_no = 3;
	UPDATE `serenehrdb`.`shr_emp_pay_elements`
	SET `epe_amt` = v_amt,
		`epe_ot_hours` = v_ot_hours
	WHERE `epe_code` = v_epe_code;
	set v_epecode = v_epe_code;
end if;

COMMIT;
END;

$$