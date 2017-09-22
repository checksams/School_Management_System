DROP PROCEDURE IF EXISTS `update_org`;

DELIMITER $$

CREATE PROCEDURE `update_org` (in v_org_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(1000),
								v_postal_address  varchar(1000),
								v_physical_address  varchar(1000),
								v_type  varchar(5),
								v_parent_org_code	int,
								v_wef	varchar(45),
								v_wet	varchar(45),
								out v_orgcode int
								)
BEGIN
declare v_parent_org_sht_desc	varchar(45);
declare v_parent_orgcode int;
declare v_level	smallint;
declare v_dt_wef, v_dt_wet date;
declare v_ln, var, v_runng_org_code,v_runng_org_code2 int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

set v_level = 1;
set v_runng_org_code = v_parent_org_code;
select count(1) into var 
from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code;
while var > 0 do
	set v_level = (v_level + 1);
	select org_parent_org_code into v_runng_org_code2 
	from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code;
	select count(1) into var 
	from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code2;
	set v_runng_org_code = v_runng_org_code2;
end while;


#SELECT STR_TO_DATE('2013/05/21 extra characters','%Y/%m/%d') into v_dt_wef;
select char_length(v_wef) into var;
/*if (var>0) then
	SELECT STR_TO_DATE((select replace(v_wef,' PM','')),'%d/%m/%Y %H:%i:%s') into v_dt_wef;
else
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_dt_wef;
end if;*/

if var >= 10 then
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_dt_wef;
end if;

select char_length(v_wet) into var;
if var >= 10 then
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_dt_wet;
end if;
if (v_dt_wet is not null) then
	if (v_dt_wet < v_dt_wet) then
		call unavailable_proc();  
	end if;
end if;
select LENGTH(v_wef) into v_ln;

if v_parent_org_code is not null or v_parent_org_code !=0 then
	select org_sht_desc into v_parent_org_sht_desc 
	from  `serenehrdb`.`shr_organizations` where org_code = v_parent_org_code;
	set v_parent_orgcode = v_parent_org_code;
else
	set v_parent_orgcode = v_parent_org_code;
	set v_parent_org_sht_desc = null;
end if;
#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_org_code is null or v_org_code = 0 then
	INSERT INTO `serenehrdb`.`shr_organizations`
	(`org_sht_desc`,`org_desc`,`org_postal_address`,`org_physical_address`,
	`org_type`,`org_parent_org_code`,`org_parent_org_sht_desc`,`org_wef`,
	`org_wet`,`org_level`)
	VALUES
	(v_sht_desc,v_desc,v_postal_address,v_physical_address,
	v_type,v_parent_orgcode,v_parent_org_sht_desc,v_dt_wef,
	v_dt_wet,v_level);
	select max(org_code) into v_orgcode from  `serenehrdb`.`shr_organizations`;
else	
	UPDATE `serenehrdb`.`shr_organizations`
	SET `org_sht_desc` = v_sht_desc,
	`org_desc` = v_desc,
	`org_postal_address` = v_postal_address,
	`org_physical_address` = v_physical_address,
	`org_type` = v_type,
	`org_parent_org_code` = v_parent_orgcode,
	`org_parent_org_sht_desc` = v_parent_org_sht_desc,
	`org_wef` = v_dt_wef,
	`org_wet` = v_dt_wet,
	`org_level` = v_level
	WHERE `org_code` = v_org_code; 
	set v_orgcode = v_org_code;
end if;
COMMIT;

END

$$

DELIMITER ;