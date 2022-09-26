
CREATE TABLE supplyvsdemand
(state varchar(8), 
year int, 
o_load float, 
d_load float, 
export_import float)

INSERT INTO SupplyvsDemand
SELECT 
o.origin_state AS "state", 
o.year AS year, 
o.load As o_load, 
d.load AS d_load, 
(o.load-d.load) AS export_import 
FROM year_origin_load AS o 
FULL JOIN year_destination_load AS d 
ON o.origin_state = d.destination_state 
AND o.year = d.year
; 
