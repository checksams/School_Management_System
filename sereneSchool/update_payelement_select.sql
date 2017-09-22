DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_payelement_select`;

DELIMITER $$
CREATE PROCEDURE `update_payelement_select`(v_pel_code int,
											v_select int)
BEGIN
	declare c_pel_code,c_pel_order, v_max_pel_order int;
	declare sqlstate_code char(5) default '00000';
	declare message_text TEXT;
	declare mysql_error, v_error_no int;
	declare v_error text;
	declare done boolean;

	DECLARE cursor_pe CURSOR FOR SELECT pel_code, pel_order
			from shr_pay_elements
			where pel_code = v_pel_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			
			if v_error_no = 1 then 
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

	set v_error_no = 1;
	set v_error = ' ';

	update `shr_pay_elements`
	set pel_selected = v_select
	where pel_code = v_pel_code;

	
COMMIT;
END$$
DELIMITER ;
