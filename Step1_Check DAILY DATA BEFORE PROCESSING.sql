---1. check t sales

SELECT DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, Sum(DBWH_BIHEC.dbo.T_Sales.NetSales) AS SumOfNetSales
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.InvoiceDate
ORDER BY InvoiceDate ASC;

----2. check code 127

SELECT DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.DistrictCode, DBWH_BIHEC.dbo.T_Sales.DistrictName, Sum(DBWH_BIHEC.dbo.T_Sales.NetSales) AS SumOfNetSales
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.DistrictCode, DBWH_BIHEC.dbo.T_Sales.DistrictName
HAVING (((DBWH_BIHEC.dbo.T_Sales.DistrictCode) Is Null Or (DBWH_BIHEC.dbo.T_Sales.DistrictCode)='')) OR (((DBWH_BIHEC.dbo.T_Sales.DistrictName) Is Null Or (DBWH_BIHEC.dbo.T_Sales.DistrictName)='')) OR (((DBWH_BIHEC.dbo.T_Sales.CustomerCode) Like '127%')) OR (((DBWH_BIHEC.dbo.T_Sales.CustomerCode)='#' Or (DBWH_BIHEC.dbo.T_Sales.CustomerCode)='Not assigned' Or (DBWH_BIHEC.dbo.T_Sales.CustomerCode) Is Null Or (DBWH_BIHEC.dbo.T_Sales.CustomerCode)=''));

---3. sales man

SELECT DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, Sum(DBWH_BIHEC.dbo.T_Sales.NetSales) AS SumOfNetSales
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty
HAVING (((DBWH_BIHEC.dbo.T_Sales.SalesMan)='20003231' Or (DBWH_BIHEC.dbo.T_Sales.SalesMan)='20050047'));

---4. I2

SELECT DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, Sum(DBWH_BIHEC.dbo.T_Sales.NetSales) AS SumOfNetSales
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, DBWH_BIHEC.dbo.T_Sales.CType
HAVING (((DBWH_BIHEC.dbo.T_Sales.SalesMan)='20003231' Or (DBWH_BIHEC.dbo.T_Sales.SalesMan)='20050047') AND ((DBWH_BIHEC.dbo.T_Sales.CType)='I2'));


----4. VN69

SELECT DBWH_BIHEC.dbo.T_Sales.WHS, DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, Sum(DBWH_BIHEC.dbo.T_Sales.NetSales) AS SumOfNetSales
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.WHS, DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.Year, DBWH_BIHEC.dbo.T_Sales.Month, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty
HAVING (((DBWH_BIHEC.dbo.T_Sales.WHS)='VN69')) OR (((DBWH_BIHEC.dbo.T_Sales.Plant)='VN69'));

----5. Return
SELECT DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.Qty, DBWH_BIHEC.dbo.T_Sales.NetSales, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.ReturnType, DBWH_BIHEC.dbo.T_Sales.ReturnReason
FROM DBWH_BIHEC.dbo.T_Sales
WHERE (((DBWH_BIHEC.dbo.T_Sales.Qty)>'0') AND ((DBWH_BIHEC.dbo.T_Sales.ReturnType) Is Not Null)) OR (((DBWH_BIHEC.dbo.T_Sales.NetSales)>'0') AND ((DBWH_BIHEC.dbo.T_Sales.ReturnType) Is Not Null));


---6. Check Customer có nhiều ChannelCode
SELECT a.KUNNR, B.ChannelCode, COUNT(distinct A.Kunnr)
FROM DAILY_SALE_DATA A
JOIN [MASTER CUSTOMER] B ON A.KUNNR=B.Kunnr
group by a.KUNNR, B.ChannelCode
having COUNT(distinct A.Kunnr)>1