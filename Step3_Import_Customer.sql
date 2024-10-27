DELETE FROM Customer;


INSERT INTO Customer ( CustCode, CustName, Address, Tel, TaxCode)
SELECT DBWH_BIHEC.dbo.M_Customer.CustomerCode, DBWH_BIHEC.dbo.M_Customer.Name1, DBWH_BIHEC.dbo.M_Customer.Street, DBWH_BIHEC.dbo.M_Customer.Phone, DBWH_BIHEC.dbo.M_Customer.VATRegis
FROM DBWH_BIHEC.dbo.M_Customer
GROUP BY DBWH_BIHEC.dbo.M_Customer.CustomerCode, DBWH_BIHEC.dbo.M_Customer.Name1, DBWH_BIHEC.dbo.M_Customer.Street, DBWH_BIHEC.dbo.M_Customer.Phone, DBWH_BIHEC.dbo.M_Customer.VATRegis;


DELETE FROM [9_customer_daily_sales_tmp];


INSERT INTO [9_customer_daily_sales_tmp] ( CustomerCode, Province, CType, Channel, Region )
SELECT DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.Province, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Channel, DBWH_BIHEC.dbo.T_Sales.Region
FROM DBWH_BIHEC.dbo.T_Sales
GROUP BY DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.Province, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Channel, DBWH_BIHEC.dbo.T_Sales.Region;


UPDATE Customer
SET 
    Customer.Province = tmp.Province, 
    Customer.Region = tmp.Region,
    Customer.Channel = tmp.Channel, 
    Customer.CGrpCode = tmp.CType, 
    Customer.CGrpName = tmp.Channel
FROM 
    Customer
INNER JOIN 
    [9_customer_daily_sales_tmp] as tmp
ON 
    Customer.CustCode = tmp.CustomerCode;


