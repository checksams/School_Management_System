DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_payelements`;

DELIMITER $$
CREATE PROCEDURE `update_payelements`(v_pel_code int,
								v_sht_desc  varchar(100),
								v_desc  varchar(200),
								v_taxable   varchar(45),
								v_deduction	varchar(45),
								v_depends_on		int,
								v_type	varchar(45),
								out v_pelcode int,
								v_applied_to	varchar(45),
								v_nontax_allowed_amt	decimal(25,5),
								v_prescribed_amt	decimal(25,5)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no,v_cnt int;
declare v_error text;
declare v_appliedto varchar(45);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Pay Element record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Pay Element record';
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

set v_appliedto = v_applied_to;
if v_appliedto is null or v_appliedto = '' then
	set v_appliedto = 'EMPLOYEE';
end if;

#set v_error = concat('v_pel_code=', v_pel_code);
#CALL raise_error (1356, 'My Error Message');
if v_pel_code is null or v_pel_code = 0 then

	select count(1) into v_cnt from `serenehrdb`.`shr_pay_elements`
	where `pel_sht_desc` = v_sht_desc;
	if v_cnt > 0 then
		set v_error_no = 100;
		select concat('The pay element Short Description ',v_sht_desc,' is already being used.') into v_error;
		call raise_error();
	end if;
	select count(1) into v_cnt from `serenehrdb`.`shr_pay_elements`
	where `pel_desc` = v_desc;
	if v_cnt > 0 then
		set v_error_no = 100;
		select concat('The Pay Element Description ',v_desc,' is already being used.') into v_error;
		call raise_error();
	end if;

	set v_error_no = 3;
	select 'Unable to create record...' into v_error;
	INSERT INTO `serenehrdb`.`shr_pay_elements`
	(`pel_sht_desc`,`pel_desc`,`pel_taxable`,
	`pel_deduction`,`pel_depends_on`,`pel_type`,`pel_applied_to`,
	`pel_nontax_allowed_amt`,`pel_prescribed_amt`)
	VALUES
	(v_sht_desc,v_desc,v_taxable,
	v_deduction,v_depends_on,v_type,v_appliedto,
	v_nontax_allowed_amt, v_prescribed_amt);
	select max(pel_code) into v_pelcode from  `serenehrdb`.`shr_pay_elements`;
else	
	set v_error_no = 4;
	select 'Unable to update record...' into v_error;
	UPDATE `serenehrdb`.`shr_pay_elements`
	SET `pel_sht_desc` = v_sht_desc,
		`pel_desc` = v_desc,
		`pel_taxable` = v_taxable,
		`pel_deduction` = v_deduction,
		`pel_depends_on` = v_depends_on,
		`pel_type` = v_type,
		`pel_applied_to` = v_appliedto,
		`pel_nontax_allowed_amt` = v_nontax_allowed_amt,
		`pel_prescribed_amt` = v_prescribed_amt
	WHERE `pel_code` = v_pel_code;
	set v_pelcode = v_pel_code;
end if;


COMMIT;
END$$
DELIMITER ;
