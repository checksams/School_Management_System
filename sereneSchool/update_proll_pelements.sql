DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_proll_pelements`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proll_pelements`(v_pel_code int,
								v_pr_code int
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
				set message_text= v_error; #'Error validation payroll record';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Payrol Pay Element record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Pay Element record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Pay Element already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error_no = 1;
select count(*) into v_cnt from `serenehrdb`.`shr_proll_pelements`
where `pp_pel_code` = v_pel_code and `pp_pr_code` = v_pr_code;

if (v_pr_code is null or v_pr_code = 0) then
	set v_error_no = 1;
	select 'Select a payroll to attach...' into v_error;
	call raise_error();
elseif (v_pel_code is null or v_pel_code = 0) then
	set v_error_no = 1;
	select 'Select a pay element to proceed...' into v_error;
	call raise_error();
end if;

set v_error = concat(concat(concat('v_pel_code=', v_pel_code),' v_pr_code='),v_pr_code);
set v_error_no = 1;
if v_cnt is null or v_cnt = 0 then
	set v_error_no = 30;
	INSERT INTO `serenehrdb`.`shr_proll_pelements`
	(`pp_pel_code`,`pp_pr_code`)
	VALUES
	(v_pel_code,v_pr_code);
end if;


COMMIT;
END$$
DELIMITER ;
