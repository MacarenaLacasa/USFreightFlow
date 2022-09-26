CREATE TABLE origin_load 
(origin_state tinyint, 
load_2020 float, 
load_2019 float, 
load_2018 float) 

INSERT INTO origin_load 
SELECT 	m.dms_origst AS origin_state, 
	SUM(m.tons_2020)AS "load_2020",
	SUM(m.tons_2019)AS "load_2019",
	SUM(m.tons_2018)AS "load_2018"
FROM dbo.master_table AS m
WHERE m.trade_type = 1
	AND m.dms_mode = 1
GROUP BY m.dms_origst
ORDER BY m.dms_origst
;

CREATE TABLE year_origin_load (
origin_state tinyint, 
year int, 
load float)

INSERT INTO year_origin_load 
SELECT 
	origin_load.origin_state, 
	2018 AS "Year", 
	origin_load.load_2018 AS "load"
FROM origin_load
UNION
SELECT 
	origin_load.origin_state, 
	2019 AS "Year", 
	origin_load.load_2019 AS "load"
FROM origin_load
UNION
SELECT 
	origin_load.origin_state, 
	2020 AS "Year", 
	origin_load.load_2020 AS "load"
FROM origin_load
;
SELECT * 
FROM year_origin_load