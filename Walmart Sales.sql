select * from Walmart_Sample..Walmart_Store_sales$


-- Which store has the maximum Sales?
select Store, (sum(Weekly_Sales))
from Walmart_Sample..Walmart_Store_sales$
group by Store
order by sum(Weekly_Sales) desc

--Which store has the max Standard Deviation?
select Store, STDEVP(Weekly_Sales)
from Walmart_Sample..Walmart_Store_sales$
group by Store
order by STDEVP(Weekly_Sales) desc

--Highest growth in Q3 2012
select Store, SUM(Weekly_Sales)
from Walmart_Sample..Walmart_Store_sales$
where YEAR(Date) = 2012 AND
MONTH(Date) IN (7,8,9)
group by Store
order by sum(Weekly_Sales) desc

--Holidays with higher sales than mean sales in non-holiday season
Create table nhsales
(
Store_ID numeric,
Avg_Sales numeric
)

Insert into Walmart_Sample..nhsales(Store_ID,Avg_Sales)
Select Store, Avg(Weekly_Sales)
from Walmart_Sample..Walmart_Store_sales$
where Holiday_Flag = 0
group by Store
order by Store ASC

select * from Walmart_Sample..nhsales

Create table hsales
(
Store_ID numeric,
Avg_Sales numeric
)

Insert into Walmart_Sample..hsales(Store_ID,Avg_Sales)
Select Store, Avg(Weekly_Sales)
from Walmart_Sample..Walmart_Store_sales$
where Holiday_Flag = 1
group by Store
order by Store ASC

select * from Walmart_Sample..hsales

select a.Store_ID, a.Avg_Sales 
from Walmart_Sample..hsales a
JOIN Walmart_Sample..nhsales b
on a.Store_ID = b.Store_ID
Where a.Avg_Sales > b.Avg_Sales