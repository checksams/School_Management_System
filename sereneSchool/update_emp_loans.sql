DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_emp_loans`;

DELIMITER $$
CREATE PROCEDURE `update_emp_loans`(v_el_code bigint,
								v_emp_code  bigint,
								v_eff_date  varchar(10),
								v_loan_applied_amt  decimal(25,5),
								v_service_charge  decimal(25,5),
								v_done_by  varchar(100),
								v_lt_code		int,
								out v_elcode int,
								v_tot_instalments int,
								v_instalment_amt decimal(25,5)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
declare v_error text;
declare v_effdate date;
declare v_issued_amt  decimal(25,5);
declare v_authorised varchar(5);
declare no_data_found boolean;
declare v_final_repay_date date;
		
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
set no_data_found = false;

if v_done_by is null or v_done_by = '' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Log in first to proceed...') into v_error;
	call raise_error();
end if;

	if not (v_el_code is null or v_el_code = 0) then
		set v_error_no = 100;
		set v_error = ' ';
		select concat(v_error,'Unable to find loan record...') into v_error;
		SELECT case when el_authorised is null then 'NO' else el_authorised end as el_authorised
		into v_authorised
		FROM `serenehrdb`.`shr_emp_loans` el
		left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
		where el_code = v_el_code;

		if no_data_found = true then
			set v_error_no = 100;
			select concat('Unable to find loan record...v_el_code=',v_el_code) into v_error;
			call raise_error();
		end if;
		set no_data_found = false;
	end if;

	if v_authorised != 'NO' and v_authorised is not null then	
		set v_error_no = 100;
		set v_error = ' ';
		select concat(v_error,'Updating authorised transactions is not allowed...Loan Id=', v_el_code,
				' Authorised=', v_authorised) into v_error;
		call raise_error();
	end if;

	if ((v_tot_instalments is null or v_tot_instalments = 0)
		and (v_instalment_amt is null or v_instalment_amt = 0)) then
			set v_error_no = 100;
			set v_error = ' ';
			select concat(v_error,'Enter the installment amount or expected total number of repayment installments to proceed...') into v_error;
			call raise_error();
	end if;

	set v_issued_amt = v_loan_applied_amt - v_service_charge;

	set v_error_no = 1;
	if v_eff_date is null then	
		set v_effdate = ' ';
	end if;
	select char_length(v_eff_date) into var;
	if var >= 10 then
		set v_error_no = 1;
		SELECT STR_TO_DATE(v_eff_date,'%d/%m/%Y') into v_effdate;
	else	
		set v_error_no = 2;
		select concat('The loan effective date is not valid... ',v_effdate) into v_error;
		call raise_error();
	end if;

	if v_loan_applied_amt is null or v_loan_applied_amt = 0 then
		set v_error_no = 3;
		select concat('The loan applied amount cannot be zero... loan_applied_amt=',v_loan_applied_amt) into v_error;
		call raise_error();
	end if;

	if v_el_code is null or v_el_code = 0 then
		set v_error_no = 30;
		select 'Unable to create loan record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_emp_loans`
		(`el_emp_code`,`el_date`,`el_eff_date`,`el_loan_applied_amt`,`el_issued_amt`,
		`el_service_charge`,`el_intr_rate`,`el_intr_div_factr`,
		`el_done_by`,`el_authorised_by`,`el_authorised_date`,`el_authorised`,
		`el_tot_tax_amt`,`el_lt_code`,`el_final_repay_date`, `el_tot_instalments`, 
		`el_instalment_amt`)
		VALUES
		(v_emp_code,Now(),v_effdate,v_loan_applied_amt,v_issued_amt,
		v_service_charge,0,1,
		v_done_by,null,null,'NO',
		0,v_lt_code,v_final_repay_date,v_tot_instalments,
		v_instalment_amt);
		select max(el_code) into v_elcode from  `serenehrdb`.`shr_emp_loans`;
	else	

		set v_error_no = 3;
		select 'Unable to update loan record...' into v_error;
		UPDATE `serenehrdb`.`shr_emp_loans`
		SET `el_eff_date` = v_effdate,
			`el_loan_applied_amt` = v_loan_applied_amt,
			`el_issued_amt` = v_issued_amt,
			`el_service_charge` = v_service_charge,
			`el_done_by` = v_done_by,
			`el_final_repay_date` = v_final_repay_date,
			`el_tot_instalments` = v_tot_instalments,
			`el_instalment_amt` = v_instalment_amt			
		WHERE `el_code` = v_el_code;
		set v_elcode = v_el_code;
	end if;

COMMIT;
END$$
DELIMITER ;
