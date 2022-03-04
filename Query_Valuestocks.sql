with t1 as (select company ,CAST(RIGHT(CAST(fiscal_year as VARCHAR), 4)AS Integer)-(row_number() over (order by company)) as difference,
(row_number() over (order by company))as RN FROM dividend 
),
t2 as (select *,count(*) over (partition by difference)as number_of_partition from t1)

select  array_agg(distinct company) valuestocks  from t2 where number_of_partition >=3