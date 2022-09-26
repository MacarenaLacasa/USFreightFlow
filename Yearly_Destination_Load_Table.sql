CREATE TABLE destination_load 
(destination_state tinyint, 
load_2020 float, 
load_2019 float, 
load_2018 float) 
INSERT INTO destination_load 
SELECT 
	m.dms_destst AS destination_state, 
	SUM(m.tons_2020)AS "load_2020",
	SUM(m.tons_2019)AS "load_2019",
	SUM(m.tons_2018)AS "load_2018"
FROM dbo.master_table AS m
WHERE m.trade_type = 1
	AND m.dms_mode = 1
GROUP BY m.dms_destst
ORDER BY m.dms_destst;

SELECT *
FROM destination_load;


CREATE TABLE year_destination_load (
destination_state tinyint, 
year int, 
load float)

INSERT INTO year_destination_load 
SELECT 
	destination_load.destination_state, 
	2018 AS "Year", 
	destination_load.load_2018 AS "load"
FROM destination_load
UNION
SELECT 
	destination_load.destination_state, 
	2019 AS "Year", 
	destination_load.load_2019 AS "load"
FROM destination_load
UNION
SELECT 
	destination_load.destination_state, 
	2020 AS "Year", 
	destination_load.load_2020 AS "load"
FROM destination_load