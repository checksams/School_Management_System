DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_bank_branches`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_bank_branches`(v_bbr_code int,
								v_sht_desc varchar(15),
								v_name varchar(300),
								v_postal_address varchar(1000),
								v_physical_address varchar(1000),
								v_tel_no1 varchar(45),
								v_tel_no2 varchar(45),
								v_bnk_code int,
								out v_bbrcode int
								)
BEGIN
declare v_cnt, v_bnkcode int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating bank record';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error updating bank record';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_bnkcode = v_bnk_code;

select count(1) into v_cnt from `serenehrdb`.`shr_bank_branches`
where bbr_sht_desc = v_sht_desc and bbr_bnk_code = v_bnk_code;

#CALL raise_error (1356, 'My Error Message');
if (v_bbr_code is null or v_bbr_code = 0)  and v_cnt = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_bank_branches`
	(`bbr_sht_desc`,`bbr_name`,`bbr_postal_address`,`bbr_physical_address`,
	`bbr_tel_no1`,`bbr_tel_no2`,`bbr_bnk_code`)
	VALUES
	(v_sht_desc,v_name,v_postal_address,v_physical_address,
	v_tel_no1,v_tel_no2,v_bnkcode);
	select max(bbr_code) into v_bbrcode from `serenehrdb`.`shr_bank_branches`;
else
	if v_cnt > 0 then
		UPDATE `serenehrdb`.`shr_bank_branches`
		SET 
		`bbr_name` = v_name,
		`bbr_postal_address` = v_postal_address,
		`bbr_physical_address` = v_physical_address,
		`bbr_tel_no1` = v_tel_no1,
		`bbr_tel_no2` = v_tel_no2
		WHERE `bbr_sht_desc` = v_sht_desc
		and bbr_bnk_code = v_bnk_code;

		select bbr_code into v_bbrcode from `serenehrdb`.`shr_bank_branches`
		where `bbr_sht_desc` = v_sht_desc and bbr_bnk_code = v_bnk_code;
	else
		set v_error_no = 2;
		UPDATE `serenehrdb`.`shr_bank_branches`
		SET `bbr_sht_desc` = v_sht_desc,
		`bbr_name` = v_name,
		`bbr_postal_address` = v_postal_address,
		`bbr_physical_address` = v_physical_address,
		`bbr_tel_no1` = v_tel_no1,
		`bbr_tel_no2` = v_tel_no2
		WHERE `bbr_code` = v_bbr_code;
		set v_bbrcode = v_bbr_code;
	end if;
end if;


COMMIT;
END$$
DELIMITER ;
