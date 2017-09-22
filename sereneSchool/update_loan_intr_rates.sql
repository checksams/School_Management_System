DROP PROCEDURE IF EXISTS `update_loan_intr_rates`;

DELIMITER $$

CREATE PROCEDURE `update_loan_intr_rates`(v_lir_code int,
								v_rate    int,
								v_div_factr    int,
								v_wef	varchar(45),
								v_wet varchar(45),
								v_lt_code int,
								out v_lircode int
								)
BEGIN
declare v_lir_wef, v_lir_wet date;
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
				set message_text='Error creating loan rate record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating loan rate record';
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
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_lir_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_lir_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_lir_code is null or v_lir_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_loan_intr_rates`
	(`lir_rate`,`lir_div_factr`,`lir_wef`,`lir_wet`,`lir_lt_code`)
	VALUES
	(v_rate,v_div_factr,v_lir_wef,v_lir_wet,v_lt_code);
	select max(lir_code) into v_lircode from  `serenehrdb`.`shr_loan_intr_rates`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_loan_intr_rates`
	SET `lir_rate` = v_rate,
		`lir_div_factr` = v_div_factr,
		`lir_wef` = v_wef,
		`lir_wet` = v_wet
	WHERE `lir_code` = v_lir_code;
	set v_lircode = v_lir_code;
end if;


COMMIT;
END;

$$