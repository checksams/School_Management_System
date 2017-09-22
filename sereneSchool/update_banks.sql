DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_banks`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_banks`(v_bnk_code int,
								v_sht_desc varchar(15),
								v_name varchar(300),
								v_postal_address varchar(1000),
								v_physical_address varchar(1000),
								v_kba_code varchar(15),
								out v_bnkcode int
								)
BEGIN
declare v_cnt int;
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

select count(1) into v_cnt from `serenehrdb`.`shr_banks`
where bnk_sht_desc = v_sht_desc;

#CALL raise_error (1356, 'My Error Message');
if (v_bnk_code is null or v_bnk_code = 0) and v_cnt = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_banks`
	(`bnk_sht_desc`,`bnk_name`,`bnk_postal_address`,
	`bnk_physical_address`,`bnk_kba_code`)
	VALUES
	(v_sht_desc,v_name,v_postal_address,
	v_physical_address,v_kba_code);
	select max(bnk_code) into v_bnkcode from `serenehrdb`.`shr_banks`;
else
	if v_cnt > 0 then
		set v_error_no = 3;
		UPDATE `serenehrdb`.`shr_banks`
		SET `bnk_name` = v_name,
			`bnk_postal_address` = v_postal_address,
			`bnk_physical_address` = v_physical_address,
			`bnk_kba_code` = v_kba_code
		WHERE `bnk_sht_desc` = v_sht_desc;
		select bnk_code into v_bnkcode from `serenehrdb`.`shr_banks`
		where `bnk_sht_desc` = v_sht_desc;

	else
		set v_error_no = 2;
		UPDATE `serenehrdb`.`shr_banks`
		SET `bnk_sht_desc` = v_sht_desc,
			`bnk_name` = v_name,
			`bnk_postal_address` = v_postal_address,
			`bnk_physical_address` = v_physical_address,
			`bnk_kba_code` = v_kba_code
		WHERE `bnk_code` = v_bnk_code;
		set v_bnkcode = v_bnk_code;
	end if;
end if;


COMMIT;
END$$
DELIMITER ;
