
------------------------------------------------------------------using CASE
Select NationalIDNumber, Hiredate, vacationhours,
CASE 
WHEN VacationHours > 70 THEN 'Vacation hours over limit'
WHEN VacationHours BETWEEN 40 AND 70 THEN 'Vacation hours average'
ELSE 'Vacation hours within limit' 
END AS vacationHourslimit
from HumanResources.Employee;


--CASE 
Select BusinessEntityID, NationalIDNumber, BirthDate, MaritalStatus,
CASE WHEN MaritalStatus = 'S' THEN 'Single' ELSE 'Married' END AS Status
from HumanResources.Employee;
------------------------------------------------------------------------------

--WHERE
Select BusinessEntityID, NationalIDNumber, BirthDate, MaritalStatus
from HumanResources.Employee where MaritalStatus = 'S';

Select BusinessEntityID, NationalIDNumber, BirthDate, MaritalStatus
from HumanResources.Employee where BirthDate >'1985-01-20';

Select BusinessEntityID, NationalIDNumber, BirthDate, MaritalStatus
from HumanResources.Employee where year(BirthDate) >'1985';

------------------------------------------------------------------------------

--COMPARISON OPERATORS    =, <> or !=, >, <, >=, <=

Select StateProvinceCode, CountryRegionCode from Person.StateProvince
where StateProvinceCode <> CountryRegionCode


Select StateProvinceCode, CountryRegionCode from Person.StateProvince
where StateProvinceCode = CountryRegionCode


Select StateProvinceCode, CountryRegionCode from Person.StateProvince
where StateProvinceCode < CountryRegionCode


Select StateProvinceCode, CountryRegionCode from Person.StateProvince
where StateProvinceCode > CountryRegionCode

-------------------------------------------------------------------------------

--ARITHMETIC OPERATORS	  +, -, *, /
Select StandardCost,ListPrice, StandardCost + ListPrice AS 'TOTAL'
from Production.Product
WHERE StandardCost > 0

Select StandardCost,ListPrice, StandardCost + ListPrice AS 'TOTAL'
from Production.Product
WHERE ReorderPoint/ StandardCost > 0 AND
StandardCost <> 0 --To avoid div by zero error

-------------------------------------------------------------------------------

--LOGICAL OPERATORS		AND, OR, NOT
Select ProductID, Name, StandardCost, ListPrice, SafetyStockLevel
from Production.Product where ProductID < 600 AND StandardCost > 50

Select ProductID, Name, StandardCost, ListPrice, SafetyStockLevel
from Production.Product where ProductID < 600 OR StandardCost > 50

Select ProductID, Name, StandardCost, ListPrice, SafetyStockLevel
from Production.Product where NOT ProductID = 4;

Select ProductID, Name, StandardCost, ListPrice, SafetyStockLevel
from Production.Product where NOT ProductID = 4;

-------------------------------------------------------------------------------

--PLUS OPERATOR
Select Title, FirstName, MiddleName, LastName, Title +' ' + FirstName + MiddleName + LastName AS 'Name'
From Person.Person;
--NULL + NULL = NULL

Select CONCAT(Firstname,' ', Middlename,' ',Lastname) AS fullname From Person.Person

Select FirstName, BusinessEntityID, CONCAT_WS('.','adventure-works','com') AS Domain from Person.Person

SELECT FirstName, BusinessEntityID,
CONCAT(FIrstName, BusinessEntityID, '@', CONCAT_WS('.','adventure-works','com')) AS Email
FROM Person.Person

-------------------------------------------------------------------------------
--IS NULL VALUE - Unknown or missing value
				-- cannot define
				-- Neither empty nor 0
--IS NULL, IS NOT NULL
Select ProductId ,name, color from Production.Product
where color is null

Select ProductId ,name, color from Production.Product
where color is not null

-------------------------------------------------------------------------------
--BETWEEN OPERATOR -- BETWEEN & NOT BETWEEN
Select ProductId ,name, color from Production.Product
where ProductID BETWEEN 1 AND 500;

Select ProductId ,name, color from Production.Product
where ProductID NOT BETWEEN 1 AND 500

Select purchaseorderid, modifieddate from Purchasing.PurchaseOrderDetail
where ModifiedDate between '20140202' AND '20150812';
--00:00:00.000

------------------------------------------------------------------------------
--CAST FUNCTION
Select Birthdate from HumanResources.Employee -- it is in date type

Select CAST(Birthdate as datetime) As 'BirthDateTime' from HumanResources.Employee

SELECT CAST('2020-02-03' as datetime) AS 'TEST'
SELECT CAST('20200203' as datetime) AS 'TEST'

Select CAST(1.734 AS int);

--not showing ----- Select CAST(5 as float);

Select PurchaseOrderID, ModifiedDate from Purchasing.PurchaseOrderDetail
where Cast(ModifiedDate as date) between '2014-02-03' AND '2015-08-12'

-------------------------------------------------------------------------------
--IN, NOT IN OPERATOR

Select * from Production.Product where ProductID in (1,5,10,20)

Select * from Person.StateProvince where StateProvinceCode in ('AK','AZ','CO','MB','IA')

Select * from Person.StateProvince where StateProvinceCode not in ('AK','AZ','CO','MB','IA')

-------------------------------------------------------------------------------
--LIKE OPERATOR

Select BusinessEntityId, Jobtitle from HumanResources.Employee where Jobtitle LIKE 'R%'

Select BusinessEntityId, Jobtitle from HumanResources.Employee where Jobtitle LIKE 'Research and Development%'

Select BusinessEntityId, Jobtitle from HumanResources.Employee where Jobtitle LIKE '%Manager%'

--LIKE with [...] char clause

Select * from Person.StateProvince where StateProvinceCode LIKE 'A[BKL]%'
--Can be 'AB', 'AK', 'AL'

Select * from Person.StateProvince where StateProvinceCode LIKE '[IL]A%'
--starts with I or L ends with 'A'

Select * from Person.StateProvince where StateProvinceCode LIKE '%[IL][ABCDEFG]%'
--Getting IA, IB, etc


--LIKE OPERATOR WITH [start-end]
Select * from Production.Product where ProductNumber LIKE 'L[IJKLMN]%'
				--same
Select * from Production.Product where ProductNumber LIKE 'L[I-N]%'

Select * from Production.Product where ProductNumber LIKE 'L[IJKLMN]%'

Select * from Production.Product where ProductNumber LIKE 'L[A-Z]-[0-9]%'

--LIKE with Negation [^...] ^ - Negation symbol
Select * from Production.Product where ProductNumber LIKE 'L[^I-N]%'


--LIKE with _ symbol (_ deals with single character)
Select * from Person.StateProvince where StateProvinceCode LIKE 'A[BKL]_'

Select * from Person.StateProvince where name LIKE 'AL____'

Select * from Person.StateProvince where name LIKE 'AL__'

-------------------------------------------------------------------------------
--ESCAPING CHARACTERS
Select * from Purchasing.Vendor where NAme LIKE '%.%'

Select * from Purchasing.Vendor where NAme LIKE '%''%'  --single quote - give one extra single quote

-------------------------------------------------------------------------------
--ORDER BY CLAUSE

Select * from HumanResources.JobCandidate order by ModifiedDate DESC --DEFAULT ASC

Select TOP 3 * from HumanResources.JobCandidate order by ModifiedDate DESC

Select * from Person.Address order by AddressID ASC 

Select * from Person.Address order by AddressID DESC

Select CONCAT(AddressID,Addressline1, ' ', AddressLine2 + ' ',City, ' ',StateProvinceID,
' ', PostalCode) AS 'Postal Address'from Person.Address order by AddressID


Select ProductID,name,StandardCost,ListPrice from Production.Product 
order by StandardCost ASC, ListPrice DESC

/*
Record 1 - stdcost = 100, Listprice = 10
Record 2 - stdcost = 100, Listprice = 15
Result will be Rec2 then Rec1
*/

Select ProductID,name,StandardCost,ListPrice from Production.Product 
order by 4 desc
--ORDER BY 4 means it will order 4th column in select statement


Select businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by BirthDate desc


Select AddressID,AddressLine1 from Person.Address order by LEN(AddressLine1) DESC

Select AddressID,AddressLine1, LEN(AddressLine1) AS 'length' from Person.Address order by LEN(AddressLine1) DESC



--OFFSET, FETCH are used to limit the results (FETCH - optional) 

Select businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate ASC

Select businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate ASC
OFFSET 5 ROWS 
--it will exclude first 5 rows



Select businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate ASC
OFFSET 5 ROWS 
FETCH NEXT 20 ROWS ONLY;
--it excludes first 5 rows & getting 20 rows after excluding 5 rows



Select businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate DESC
OFFSET 0 ROWS 
FETCH NEXT 5 ROWS ONLY;

Select TOP 5 businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate DESC
		--SAME
Select TOP 5 businessentityID, NationalIDnumber, Hiredate from HumanResources.Employee
order by HireDate DESC


Select TOP 2 ProductID, name, StandardCost from Production.Product
order by StandardCost desc

Select TOP 2 WITH TIES ProductID, name, StandardCost from Production.Product
order by StandardCost desc
--WITH TIES - if you don't know how many records with similar rows (here std cost)


Select TOP 3 SalesOrderID, SalesOrderDetailID, OrderQty from Sales.SalesOrderDetail
Order by OrderQty desc

Select TOP 3 WITH TIES SalesOrderID, SalesOrderDetailID, OrderQty from Sales.SalesOrderDetail
Order by OrderQty desc


Select TOP 10 PERCENT SalesOrderID, SalesOrderDetailID, OrderQty from Sales.SalesOrderDetail
Order by OrderQty desc
--Getting top 10% record

-------------------------------------------------------------------------------

--GROUP BY CLAUSE (To group records on basis of columns)

Select SalesOrderID, OrderQty from Sales.SalesOrderDetail

Select SalesOrderID, SUM(OrderQty) from Sales.SalesOrderDetail
Group by SalesOrderID


Select * from HumanResources.Department

Select GroupName from HumanResources.Department
GROUP BY GroupName

Select DISTINCT(GroupName) from HumanResources.Department


--Total count for each grp
Select GroupName, Count(*) AS TotalCount from HumanResources.Department
GROUP BY GroupName
Select GroupName, Count(GroupName) AS TotalCount from HumanResources.Department
GROUP BY GroupName


Select * from HumanResources.EmployeePayHistory

Select PayFrequency, SUM(Rate) AS TotalRatePerPayFreq from HumanResources.EmployeePayHistory
GROUP BY PayFrequency
ORDER BY PayFrequency DESC



Select ProductID, Shelf from Production.ProductInventory

Select ProductID, Shelf, SUM(Quantity) AS 'Sum per product shelf' from Production.ProductInventory
GROUP BY ProductID, Shelf
ORDER BY Shelf DESC

--FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY

-------------------------------------------------------------------------------

--FUNCTIONS in SQL

--NUMERICAL functions,

--Added this comment for Git learning purpose

--Added this comment from remote repo
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--added comment on 27th Nov 2023
--added comment again



