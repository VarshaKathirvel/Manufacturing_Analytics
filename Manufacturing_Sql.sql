create database manufacture;

USE manufacture;

SELECT * FROM manufacturing_data;

/* To count total rows  */
SELECT 
    COUNT(*) AS total_rows
FROM 
    manufacturing_data;
    
 /* Total Manufactured Qty */
select concat(round(sum(`today Manufactured qty`)/1000000,2), "M") as Total_Manufactured_Qty from manufacturing_data;

/* Total Rejected Qty */
select concat(round(sum(`Rejected Qty`)/1000,2), "K") as Total_Rejected_Qty from manufacturing_data;

/* Total Processed Qty */
select concat(round(sum(`Processed Qty`)/1000000,2), "M") as Total_Processed_Qty from manufacturing_data;

/* Percentage Wastage Qty */
select concat(round(sum(`Rejected Qty`)/sum(`Processed Qty`)*100,2), "%") as Percentage_Wastage_Qty from manufacturing_data;

/* Employee wise Rejected Qty */
select
`Emp Name`,concat(Round(sum(`Rejected qty`)/1000,2),"K") as Employee_wise_Rejected_Qty from manufacturing_data
group by `Emp Name`;


/* 2.Manufactured v/s Rejected Qty */ 
SELECT 
    CONCAT('manufactured :',
            ROUND(SUM(`today Manufactured qty`) / 1000000,
                    2),"M",
            ' ',
            '|   Rejected :',
            ROUND(SUM(`Rejected Qty`)/1000,2),"K") AS Manufactured_versus_Rejected_Qty
FROM
    manufacturing_data;

/* Total Value by buyers */
select
`Buyer`,concat(Round(sum(`TotalValue`)/1000000,2),"M") as Total_Values_by_Buyers from manufacturing_data
group by `Buyer`
order by sum(`TotalValue`) desc;


/* Top 5 machine wise Rejected Qty */
select
`Machine Code`,concat(Round(sum(`Rejected Qty`)/1000,2),"K") as Top_5_Machine_wise_Rejected_Qty from manufacturing_data
group by `Machine Code`
order by sum(`Rejected Qty`) desc
limit 5;

/* Total Value by Customers */
select
`Cust Name`,concat(Round(sum(`TotalValue`)/1000000,2),"M") as Total_Values_by_Custoers from manufacturing_data
group by `Cust Name`
order by sum(`TotalValue`) desc;


/* Department wise Manufactured and Rejected Qty */
SELECT `Department Name` ,
    CONCAT(ROUND(SUM(`today Manufactured qty`)/1000000,2),"M") as Manufactured_Qty,
	concat(ROUND(SUM(`Rejected Qty`)/1000,2),"K") AS Rejected_Qty
FROM
    manufacturing_data
    group by `Department Name` ;


/* Production Comparision Trend */
SELECT monthname(`Doc Date`) as Month_Name,
    CONCAT(ROUND(SUM(`today Manufactured qty`)/1000000,2),"M") as Manufactured_Qty,
    CONCAT(ROUND(SUM(`Processed Qty`)/1000000,2),"M") as Processed_Qty,
	concat(ROUND(SUM(`Rejected Qty`)/1000,2),"K") AS Rejected_Qty
FROM
    manufacturing_data
    group by month(`Doc Date`),monthname(`Doc Date`)
    order by month(`Doc Date`);
    
    


SELECT 
    `Emp Name`,
    SUM(`today Manufactured qty`) AS Total_Manufactured,
    SUM(`WO Qty`) AS Total_WO,
    ROUND((SUM(`today Manufactured qty`) * 100.0) / NULLIF(SUM(`WO Qty`), 0), 2) AS Efficiency_Percentage
FROM Manufacturing_data
GROUP BY `Emp Name`;

SELECT 
    `Item Code`,
    `Item Name`,
    SUM(`WO Qty`) AS WO,
    SUM(`today Manufactured qty`) AS Manufactured,
    concat(ROUND((SUM(`WO Qty` - `today Manufactured qty`) * 100.0) / NULLIF(SUM(`WO Qty`), 0), 2), "%") AS Wastage_Percentage
FROM Manufacturing_data
GROUP BY `Item Code`, `Item Name`
HAVING Wastage_Percentage > 20;

# Wastage Level Classification #
SELECT 
    `Operation Name`,
    CASE 
        WHEN (`WO Qty` - `today Manufactured qty`) * 100.0 / NULLIF(`WO Qty`, 0) > 20 THEN 'High Wastage'
        WHEN (`WO Qty` - `today Manufactured qty`) * 100.0 / NULLIF(`WO Qty`, 0) > 10 THEN 'Moderate Wastage'
        ELSE 'Low Wastage'
    END AS Wastage_Level
FROM Manufacturing_data;


# Repeat Orders Analysis #
SELECT 
    `Buyer`,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN `Repeat` > 0 THEN 1 ELSE 0 END) AS Repeat_Orders
FROM Manufacturing_data
GROUP BY `Buyer`;


# Most Frequently Used Machines #
SELECT 
    `Machine Code`, 
    COUNT(*) AS Usage_Count
FROM manufacturing_data
GROUP BY `Machine Code`
ORDER BY Usage_Count DESC
LIMIT 3;



















    
    
    
    

    
    