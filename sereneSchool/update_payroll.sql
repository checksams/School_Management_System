DROP PROCEDURE IF EXISTS `update_payroll`;

DELIMITER $$

CREATE PROCEDURE `update_payroll` (v_pr_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_org_code	int,
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_prcode int,
								v_day1_hrs   decimal(5,2), 
								v_day2_hrs   decimal(5,2), 
								v_day3_hrs   decimal(5,2), 
								v_day4_hrs   decimal(5,2), 
								v_day5_hrs   decimal(5,2), 
								v_day6_hrs   decimal(5,2), 
								v_day7_hrs   decimal(5,2)
								)
BEGIN
declare v_pr_wef, v_pr_wet date;
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
				set message_text='Error creating payroll record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating payroll record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		elseif v_org_code is null then	
			signal sqlstate '45000'
				set message_text='Select an Organization to proceed.. ';
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
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_pr_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_pr_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_pr_code is null or v_pr_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_payrolls`
	(`pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,`pr_wef`,`pr_wet`,
	 `pr_day1_hrs`, `pr_day2_hrs`, `pr_day3_hrs`, `pr_day4_hrs`, 
	 `pr_day5_hrs`, `pr_day6_hrs`, `pr_day7_hrs`)
	VALUES
	(v_pr_code,v_sht_desc,v_desc,v_org_code,v_pr_wef,v_pr_wet,
	 v_day1_hrs, v_day2_hrs, v_day3_hrs, v_day4_hrs, 
	 v_day5_hrs, v_day6_hrs, v_day7_hrs);
	select max(pr_code) into v_prcode from  `serenehrdb`.`shr_payrolls`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_payrolls`
	SET `pr_code` = v_pr_code,
		`pr_sht_desc` = v_sht_desc,
		`pr_desc` = v_desc,
		`pr_org_code` = v_org_code,
		`pr_wef` = v_pr_wef,
		`pr_wet` = v_pr_wet,
		`pr_day1_hrs` = v_day1_hrs, 
		`pr_day2_hrs` = v_day2_hrs, 
		`pr_day3_hrs` = v_day3_hrs, 
		`pr_day4_hrs` = v_day4_hrs, 
		`pr_day5_hrs` = v_day5_hrs, 
		`pr_day6_hrs` = v_day6_hrs, 
		`pr_day7_hrs` = v_day7_hrs
	WHERE `pr_code` = v_pr_code;
	set v_prcode = v_pr_code;
end if;


COMMIT;
END;

$$