DROP PROCEDURE IF EXISTS `update_loan_types`;

DELIMITER $$

CREATE PROCEDURE `update_loan_types`(v_lt_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_min_repay_prd    int,
								v_max_repay_prd    int,
								v_min_amt    int,
								v_max_amt    int,
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_ltcode int
								)
BEGIN
declare v_lt_wef, v_lt_wet date;
declare var int;
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
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating loan type record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating loan type record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_lt_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_lt_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_lt_code is null or v_lt_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_loan_types`
	(`lt_sht_desc`,`lt_desc`,`lt_min_repay_prd`,`lt_max_repay_prd`,
	`lt_min_amt`,`lt_max_amt`,`lt_wef`,`lt_wet`)
	VALUES
	(v_sht_desc,v_desc,v_min_repay_prd,v_max_repay_prd,
	v_min_amt,v_max_amt,v_lt_wef,v_lt_wet);
	select max(lt_code) into v_ltcode from  `serenehrdb`.`shr_loan_types`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_loan_types`
	SET `lt_sht_desc` = v_sht_desc,
		`lt_desc` = v_desc,
		`lt_min_repay_prd` = v_min_repay_prd,
		`lt_max_repay_prd` = v_max_repay_prd,
		`lt_min_amt` = v_min_amt,
		`lt_max_amt` = v_max_amt,
		`lt_wef` = v_lt_wef,
		`lt_wet` = v_lt_wet
	WHERE `lt_code` = v_lt_code;
	set v_ltcode = v_lt_code;
end if;


COMMIT;
END;

$$