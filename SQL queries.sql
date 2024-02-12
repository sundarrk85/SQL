
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
--sum(), avg(), max(), min(), count() 

Select SUm(All StandardCost) from Production.Product --same
Select SUm(StandardCost) from Production.Product --same

Select SUm(Distinct StandardCost) from Production.Product

Select Makeflag, Avg(Standardcost) as AverageCost from Production.Product group by MakeFlag

Select Count(*) from Production.Product 

Select Count(*) from Production.Product where Color is not null

Select Makeflag, MAX(StandardCost) as MaxStdCost from Production.Product 
Group by Makeflag
order by Max(StandardCost)


--LESS USED NUMBER FUNCTIONS
Select abs(-12345.45) 
Select abs(+12345.45) 
Select abs($12345.45) 
Select standardCost, CEILING(StandardCost) from Production.Product 
Select standardCost, FLOOR(StandardCost) from Production.Product 
--Ceiling - >= to that value
--Floor   - <= to that value
Select RAND()
Select RAND() + 3		--Rand value greater than 3
Select RAND()*5 + 3    
Select ROUND(45.1245,2)
Select ROUND(45.1245,3)

-------------------------------------------------------------------------------

--STRING FUNCTIONS IN SQL
SELECT CHARINDEX('D','DAD'); -- returns the position of the char
SELECT CHARINDEX('D','DAD',2);
 
SELECT Name
FROM Production.Product
 
SELECT Name, CHARINDEX('Cr', Name)
FROM Production.Product;
 
SELECT Name, CHARINDEX('Cr', Name)
FROM Production.Product
WHERE Name LIKE '%Cr%';


SELECT FirstName,Datalength(FirstName) AS NumberOfBytes
FROM Person.Person
GROUP BY FirstName;
 
SELECT FORMAT(20200616,'####/##/##');

SELECT FirstName,LEFT(FirstName,2) AS ExtractNameFromLeft
FROM Person.Person;
 
SELECT FirstName,RIGHT(FirstName,2) AS ExtractNameFromRight
FROM Person.Person;
 
SELECT FirstName,LEN(FirstName) AS ExtractLengthOfName
FROM Person.Person;

SELECT FirstName, LOWER(FirstName) AS LowerFName
FROM Person.Person;
 
SELECT FirstName, UPPER(FirstName) AS LowerFName
FROM Person.Person;
 
SELECT Ltrim('		Trim Left Side');
 
SELECT rtrim('Trim Left Side		 ');
 
SELECT trim('      Trim Both The Sides      ');

SELECT Name, PATINDEX('%Ball%',Name)   --returns the first occurence
FROM Production.Product
WHERE Name LIKE '%Ball%';
 
SELECT Name, Patindex('%Cr_nk%',Name)
FROM Production.Product
WHERE Name LIKE '%Cr%';
 
SELECT LoginID, REPLACE(LoginID,'adventure-works','aw') AS ReplaceString
FROM HumanResources.Employee;
 
SELECT FirstName, REPLICATE(FirstName,3) AS ReplicateFName
FROM Person.Person;

SELECT FirstName, REVERSE(FirstName) AS ReverseFName
FROM Person.Person;
 
SELECT Top 100 LastName, Substring(LastName,3,5) AS SubstringLName
FROM Person.Person
ORDER BY LastName;
 
SELECT ProductID, STR(ProductID) AS StringProductID
FROM Production.Product;


-------------------------------------------------------------------------------

--DATE FUNCTIONS IN SQL SERVER

 /*
 year - y, yyyy, yy
 quarter - q, qq
 month - m, mm
 day - d, dd
 hour - hh
 minute - mi, n
 seconds - s, ss
 millisecond - ms
 */

 SELECT ProductID, SellStartDate,dateadd(yyyy,3,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(q,3,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(m,3,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(d,3,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(hh,3,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(n,50,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,dateadd(s,10,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,SellEndDate, dateadd(ms,50,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,SellEndDate, dateadd(m,50,sellstartdate) AS NewSellStartDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,SellEndDate, datediff(yyyy,sellstartdate,sellenddate) AS diffDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,SellEndDate, datediff(q,sellstartdate,sellenddate) AS diffDate
FROM Production.Product;
 
SELECT ProductID, SellStartDate,SellEndDate, datediff(q,sellstartdate,sellenddate) AS diffDate
FROM Production.Product
WHERE SellEndDate IS NOT NULL;

SELECT ProductID, SellStartDate,datepart(month,sellstartdate) AS Extractmonth
FROM Production.Product;
 
SELECT ProductID, SellStartDate,day(sellstartdate) AS ExtractDay
FROM Production.Product;
 
SELECT ProductID, SellStartDate,month(sellstartdate) AS ExtractMonth
FROM Production.Product;
 
SELECT ProductID, SellStartDate,year(sellstartdate) AS ExtractYear
FROM Production.Product;

SELECT ProductID, SellStartDate,datename(month,sellstartdate) AS Extractmonth
FROM Production.Product;
 
SELECT ProductID, SellStartDate,eomonth(sellstartdate) AS EndOfMonth
FROM Production.Product;

SELECT CURRENT_TIMESTAMP;
SELECT getdate();
SELECT sysdatetime();
SELECT SYSDATETIMEOFFSET(); -- more accurate

SELECT SellStartDate, isdate(SellStartDate)
FROM Production.Product;
 
SELECT isdate(1) As booleanValue;

-------------------------------------------------------------------------------

-- GENERAL FUNCTIONS
 
SELECT isnull(NULL,'Abc');  --returns boolean
 
SELECT isnull('123','Abc');  -- returns '123' if it is not null else returns 'Abc'
 
SELECT isnull(NULL,0);  --return 0
 
SELECT isnull(0,5);
 
SELECT isnull(' ',5);  --returns ' '
 
SELECT Color, isnull(Color,'hello') as CheckforNull
FROM Production.Product;
 
SELECT StandardCost, isnumeric(StandardCost) AS testNumeric
FROM Production.Product;
 
SELECT Color, isnumeric(Color) AS testNumeric
FROM Production.Product;

SELECT coalesce(NULL,NULL,'Welcome',NULL,'SQL');		-- returns first non null value from the list
 
SELECT coalesce(NULL,NULL,NULL,NULL,'SQL');
 
SELECT Title, MiddleName, coalesce(title,middlename)
FROM Person.Person;
 
SELECT NULLIF(14,12);		

SELECT NULLIF(12,NULL);	
 
SELECT StandardCost, convert(nvarchar(20),StandardCost) AS convertedType
FROM Production.Product;
 
SELECT ProductId,StandardCost, ListPrice, 
 iif(ListPrice>=StandardCost,'Profit','Loss') AS testCondition
FROM Production.Product
WHERE Listprice < StandardCost;
 
SELECT ProductId,StandardCost, ListPrice, 
 iif(ListPrice>=StandardCost,'Profit','Loss') AS testCondition
FROM Production.Product;
--WHERE Listprice < StandardCost;
 
SELECT ProductId,StandardCost, ListPrice, 
 iif(ListPrice<StandardCost,'Profit','Loss') AS testCondition
FROM Production.Product;
--WHERE Listprice < StandardCost;

-------------------------------------------------------------------------------

-- HAVING CLAUSE

/*Mostly used to fliter records of aggregate function or records where Gorup 
By clause is used*/

SELECT max(StandardCost)
FROM Production.Product
HAVING max(standardCost) > 200;
 
SELECT DueDate,Sum(OrderQty) AS TotalOrderPerDueDate
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND Month(DueDate) < 9
GROUP BY DueDate
ORDER BY DueDate DESC;
 
SELECT DueDate,Sum(OrderQty) AS TotalOrderPerDueDate
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND Month(DueDate) < 9 
GROUP BY DueDate
HAVING sum(OrderQty) < 6000
ORDER BY DueDate DESC;
 
SELECT DueDate,Sum(OrderQty) AS TotalOrderPerDueDate
FROM Purchasing.PurchaseOrderDetail
--WHERE YEAR(DueDate) > 2011 AND Month(DueDate) < 9 
GROUP BY DueDate
HAVING sum(OrderQty) < 6000
ORDER BY DueDate DESC;

-------------------------------------------------------------------------------

--SUB QUERY

SELECT NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
   (SELECT BusinessEntityID
     FROM HumanResources.EmployeeDepartmentHistory
   )
ORDER BY JobTitle;
 
SELECT BusinessEntityID,NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
   (SELECT BusinessEntityID
     FROM HumanResources.EmployeeDepartmentHistory
   )
ORDER BY JobTitle;
 
SELECT BusinessEntityID,NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
   (SELECT BusinessEntityID
     FROM HumanResources.EmployeeDepartmentHistory
	 WHERE BusinessEntityID <= 100
   )
ORDER BY JobTitle;

SELECT Min(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
  (SELECT TOP 2 UnitPrice
   FROM Purchasing.PurchaseOrderDetail
   ORDER BY UnitPrice DESC
  );
 
SELECT Min(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
  (SELECT TOP 3 UnitPrice
   FROM Purchasing.PurchaseOrderDetail
   ORDER BY UnitPrice DESC
  );
 
SELECT Min(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
  (SELECT TOP 3 UnitPrice
   FROM Purchasing.PurchaseOrderDetail
   GROUP BY UnitPrice
   ORDER BY UnitPrice DESC
  );
 
 
SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice >
 (SELECT Avg(ListPrice)
  FROM Production.Product
 );
 
SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice <
 (SELECT Avg(ListPrice)
  FROM Production.Product
 );

--EXISTS 
SELECT *
FROM HumanResources.Employee;
 
SELECT *
FROM HumanResources.Department;
 
SELECT BusinessEntityId, JobTitle 
FROM HumanResources.Employee
WHERE EXISTS							-- returns true to the main query if exists
  (SELECT DepartmentID
   FROM HumanResources.Department
   WHERE Name = 'Sales'
  );
 
SELECT BusinessEntityId, JobTitle 
FROM HumanResources.Employee
WHERE EXISTS
  (SELECT DepartmentID
   FROM HumanResources.Department
   WHERE Name = 'Sales'
  ) AND JobTitle LIKE '%Sales%';

--Nested sub query
SELECT ProductSubCategoryID
FROM Production.Product
WHERE ProductSubCategoryID IN
 (SELECT ProductSubCategoryID
  FROM Production.ProductSubcategory
  WHERE ProductCategoryID IN
   (SELECT ProductCategoryID 
    FROM Production.ProductCategory
	WHERE Name LIKE '%Bikes%'
   )
  );
 
SELECT DISTINCT ProductSubCategoryID
FROM Production.Product
WHERE ProductSubCategoryID IN
 (SELECT ProductSubCategoryID
  FROM Production.ProductSubcategory
  WHERE ProductCategoryID IN
   (SELECT ProductCategoryID 
    FROM Production.ProductCategory
	WHERE Name LIKE '%Bikes%'
   )
  );









  







