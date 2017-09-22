DROP PROCEDURE  IF EXISTS `serenehrdb`.`update_tax_rates`;

DELIMITER $$
CREATE PROCEDURE `update_tax_rates`(v_txr_code int,
								v_desc  varchar(100),
								v_rate_type   varchar(45),
								v_rate   int,
								v_div_factr   int,
								v_wef	varchar(45),
								v_wet varchar(45),
								v_range_from		int,
								v_range_to		int,
								v_tx_code		int,
								out v_txrcode int,
								v_frequency  varchar(45)
								)
BEGIN
declare v_tx_wef, v_tx_wet date;
declare var int;
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
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Tax rate record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Tax rate record';
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
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_tx_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_tx_wet;
end if;
if v_tx_wef is null then
	select tx_wef into v_tx_wef from shr_taxes
	where tx_code = v_tx_code;
end if;

#set v_error = concat('v_txr_code=', v_txr_code);
#CALL raise_error (1356, 'My Error Message');
if v_txr_code is null or v_txr_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_tax_rates`
	(`txr_desc`,`txr_rate_type`,`txr_rate`,`txr_div_factr`,
	`txr_wef`,`txr_wet`,`txr_tx_code`,`txr_range_from`,`txr_range_to`,
	`txr_frequency`)
	VALUES
	(v_desc,v_rate_type,v_rate,v_div_factr,
	v_tx_wef,v_tx_wet,v_tx_code, v_range_from, v_range_to,
	v_frequency);
	select max(txr_code) into v_txrcode from  `serenehrdb`.`shr_tax_rates`;
else	
	set v_error_no = 40;
	UPDATE `serenehrdb`.`shr_tax_rates`
	SET `txr_desc` = v_desc,
		`txr_rate_type` = v_rate_type,
		`txr_rate` = v_rate,
		`txr_div_factr` = v_div_factr,
		`txr_wef` = v_tx_wef,
		`txr_wet` = v_tx_wet,
		#`txr_tx_code` = v_tx_code,
		`txr_range_from` = v_range_from,
		`txr_range_to` = v_range_to,
		`txr_frequency` = v_frequency
	WHERE `txr_code` = v_txr_code;
	set v_txrcode = v_txr_code;
end if;


COMMIT;
END$$
DELIMITER ;
