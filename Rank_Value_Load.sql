USE Freight_flow;

CREATE TABLE rank_commodity
(sctg2 varchar(8), 
tons_2020 float, 
rank_tons varchar(8), 
value_2020 float, 
rank_value varchar(8)); 
DROP TABLE rank_commodity
with rank_commodity_tons (sctg2, tons_2020, [rank])
as
(
	SELECT 
		m.sctg2, 
		SUM(m.tons_2020),
		rank() OVER (order by SUM(m.tons_2020))
	FROM master_table m
	GROUP BY m.sctg2
),
rank_commodity_value (sctg2, value_2020, [rank])
as
(
	SELECT 
		m.sctg2, 
		SUM(m.current_value_2020),
		rank() OVER (order by SUM(m.current_value_2020))
	FROM master_table m
	GROUP BY m.sctg2
)



INSERT INTO rank_commodity
select 
	t.sctg2, 
	tons_2020, 
	t.rank AS 'rank_tons', 
	value_2020, 
	v.rank AS 'rank_value'
from rank_tons t
	join rank_value v
		on (t.sctg2 = v.sctg2)
