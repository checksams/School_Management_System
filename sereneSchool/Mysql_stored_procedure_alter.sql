
DROP PROCEDURE IF EXISTS update_vehicle; 

DELIMITER $$
CREATE PROCEDURE `update_vehicle`(v_fv_code int,
                                v_number_plate  varchar(45),
								v_reg_no  varchar(100),
								v_sht_desc  varchar(100),
								v_reg_date  varchar(100),
								v_chasis_no  varchar(100),
								v_engine_no  varchar(100),
								v_log_book_no  varchar(100),
                                v_max_no_psger  decimal(3),
								out v_fvcode int
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;
if v_fv_code is null or v_fv_code = 0 then
	INSERT INTO `serenefleet`.`fl_vehicles` (
    `fv_number_plate`, `fv_reg_no`,`fv_sht_desc`,fv_fvc_code,
    `fv_chasis_no`, `fv_engine_no`,`fv_log_book_no`,fv_max_no_psger )
	VALUES
	(v_number_plate,v_reg_no, v_sht_desc,-1,
    v_chasis_no, v_engine_no, v_log_book_no, v_max_no_psger 
    );

	select max(fv_code) into v_fvcode from  `serenefleet`.`fl_vehicles`;
else	
	UPDATE `serenefleet`.`fl_vehicles`
	SET `fv_number_plate` = v_number_plate,
		`fv_reg_no` = v_reg_no,
        fv_sht_desc = v_sht_desc,
        #fv_reg_date = v_reg_date,
        fv_chasis_no = v_chasis_no,
        fv_engine_no = v_engine_no,
        fv_log_book_no = v_log_book_no,
        fv_max_no_psger  = v_max_no_psger 
	WHERE `fv_code` =v_fv_code; 
	set v_fvcode =v_fv_code;
end if;
COMMIT;

END$$
DELIMITER ;
