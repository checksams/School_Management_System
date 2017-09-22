DROP PROCEDURE IF EXISTS `update_taxes`;

DELIMITER $$

CREATE PROCEDURE `update_taxes` (v_tx_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_txcode int
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
				set message_text='Error creating Tax record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Tax record';
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
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_tx_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_tx_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_tx_code is null or v_tx_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_taxes`
	(`tx_sht_desc`,`tx_desc`,`tx_wef`,`tx_wet`)
	VALUES
	(v_sht_desc,v_desc,v_tx_wef,v_tx_wet);
	select max(tx_code) into v_txcode from  `serenehrdb`.`shr_taxes`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_taxes`
	SET `tx_sht_desc` = v_sht_desc,
		`tx_desc` = v_desc,
		`tx_wef` = v_tx_wef,
		`tx_wet` = v_tx_wet
	WHERE `tx_code` = v_tx_code;
	set v_txcode = v_tx_code;
end if;


COMMIT;
END;

$$