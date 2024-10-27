DELETE FROM Daily_sales;


---*Note: HPC khong co luu data trong cot orginvoice, cot orginvoice hien tai la HPC-customer code
---Import HAPH data
INSERT INTO Daily_sales( [Plant Code], [Plant - Key], [Material group-Master], [Material group-Master - Key], [Product Code], [Product Name], [Customer Code], [Customer Name], Address, [District Code], District, Province, Region, CustGroup, Channel, [Ship To Code], [Billing No], BILLINGDATE, Qty, [Net Price], [Net Sales], [Net Sales with Tax], [List Price], Reason, SalesMan, [Batch No], [Order No], [Order Date], Syslot, OrgInvoice, RedInvoice, ReturnType, ReturnReason)
SELECT DBWH_BIHEC.dbo.T_Sales_HAPH.WHS, DBWH_BIHEC.dbo.T_Sales_HAPH.Plant, DBWH_BIHEC.dbo.T_Sales_HAPH.ClientName, DBWH_BIHEC.dbo.T_Sales_HAPH.ClientCode, DBWH_BIHEC.dbo.T_Sales_HAPH.ProductID, DBWH_BIHEC.dbo.T_Sales_HAPH.ProductName, DBWH_BIHEC.dbo.T_Sales_HAPH.CustomerCode, DBWH_BIHEC.dbo.T_Sales_HAPH.CustomerName, DBWH_BIHEC.dbo.T_Sales_HAPH.CustomerAddress, DBWH_BIHEC.dbo.T_Sales_HAPH.DistrictCode, DBWH_BIHEC.dbo.T_Sales_HAPH.DistrictName, DBWH_BIHEC.dbo.T_Sales_HAPH.Province, DBWH_BIHEC.dbo.T_Sales_HAPH.Region, DBWH_BIHEC.dbo.T_Sales_HAPH.CType, DBWH_BIHEC.dbo.T_Sales_HAPH.Channel, DBWH_BIHEC.dbo.T_Sales_HAPH.ShipTo, DBWH_BIHEC.dbo.T_Sales_HAPH.InvoiceNo, DBWH_BIHEC.dbo.T_Sales_HAPH.InvoiceDate, DBWH_BIHEC.dbo.T_Sales_HAPH.Qty, DBWH_BIHEC.dbo.T_Sales_HAPH.NetPrice, DBWH_BIHEC.dbo.T_Sales_HAPH.NetSales, DBWH_BIHEC.dbo.T_Sales_HAPH.NetSalesVAT, DBWH_BIHEC.dbo.T_Sales_HAPH.ListPrice, DBWH_BIHEC.dbo.T_Sales_HAPH.Reason, DBWH_BIHEC.dbo.T_Sales_HAPH.SalesMan, DBWH_BIHEC.dbo.T_Sales_HAPH.BatchNo, DBWH_BIHEC.dbo.T_Sales_HAPH.OrderNo, DBWH_BIHEC.dbo.T_Sales_HAPH.OrderDate, DBWH_BIHEC.dbo.T_Sales_HAPH.Syslot, DBWH_BIHEC.dbo.T_Sales_HAPH.InvoiceNo, DBWH_BIHEC.dbo.T_Sales_HAPH.RedInvoice, DBWH_BIHEC.dbo.T_Sales_HAPH.ReturnType, DBWH_BIHEC.dbo.T_Sales_HAPH.ReturnReason
FROM DBWH_BIHEC.dbo.T_Sales_HAPH


--- Update Source
UPDATE Daily_sales SET Daily_sales.Source ='HPC'


---Import CG data
DELETE FROM Daily_sales_CG;


---get MTD data from T_SALES CHO 3 HANG CO SALES BEN CG
---244     MEDINOVA AG
---330     GALDERMA
---0G67       ACTAVIS

INSERT INTO Daily_sales_CG ( [Plant Code], [Plant - Key], [Material group-Master], [Material group-Master - Key], [Product Code], [Product Name], [Customer Code], [Customer Name], Address, [District Code], District, Province, Region, CustGroup, Channel, [Ship To Code], [Billing No], BILLINGDATE, Qty, [Net Price], [Net Sales], [Net Sales with Tax], [List Price], Reason, SalesMan, [Batch No], [Order No], [Order Date], Syslot, OrgInvoice, RedInvoice, ReturnType, ReturnReason, ARGRU, BEZEI, PaymentTerm)
SELECT DBWH_BIHEC.dbo.T_Sales.WHS, DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ProductID, DBWH_BIHEC.dbo.T_Sales.ProductName, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CustomerAddress, DBWH_BIHEC.dbo.T_Sales.DistrictCode, DBWH_BIHEC.dbo.T_Sales.DistrictName, DBWH_BIHEC.dbo.T_Sales.Province, DBWH_BIHEC.dbo.T_Sales.Region, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Channel, DBWH_BIHEC.dbo.T_Sales.ShipTo, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, DBWH_BIHEC.dbo.T_Sales.NetPrice, DBWH_BIHEC.dbo.T_Sales.NetSales, DBWH_BIHEC.dbo.T_Sales.NetSalesVAT, DBWH_BIHEC.dbo.T_Sales.ListPrice, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.BatchNo, DBWH_BIHEC.dbo.T_Sales.OrderNo, DBWH_BIHEC.dbo.T_Sales.OrderDate, DBWH_BIHEC.dbo.T_Sales.Syslot, DBWH_BIHEC.dbo.T_Sales.OrgInvoice, DBWH_BIHEC.dbo.T_Sales.RedInvoice, DBWH_BIHEC.dbo.T_Sales.ReturnType, DBWH_BIHEC.dbo.T_Sales.ReturnReason, DBWH_BIHEC.dbo.T_Sales.Advp_Camp, DBWH_BIHEC.dbo.T_Sales.Foc_Camp, DBWH_BIHEC.dbo.T_Sales.PaymentTerm
FROM DBWH_BIHEC.dbo.T_Sales
WHERE (((DBWH_BIHEC.dbo.T_Sales.Plant)='VN13' Or (DBWH_BIHEC.dbo.T_Sales.Plant)='VN14' Or (DBWH_BIHEC.dbo.T_Sales.Plant)='VN16')
AND ((DBWH_BIHEC.dbo.T_Sales.ClientCode)='0244' Or (DBWH_BIHEC.dbo.T_Sales.ClientCode)='0330' Or (DBWH_BIHEC.dbo.T_Sales.ClientCode)='0G67'));



--- Update Source
UPDATE Daily_sales_CG SET Daily_sales_CG.Source = 'CG'


--- Append into Daily_sales
INSERT INTO Daily_sales
SELECT *
FROM Daily_sales_CG;


---Import HEC data
---Call DoCmd.TransferSpreadsheet(acImport, acSpreadsheetTypeExcel8, Daily_sales, txt_Inhouse_path, True)
INSERT INTO Daily_sales( [Plant Code], [Plant - Key], [Material group-Master], [Material group-Master - Key], [Product Code], [Product Name], [Customer Code], [Customer Name], Address, [District Code], District, Province, Region, CustGroup, Channel, [Ship To Code], [Billing No], BILLINGDATE, Qty, [Net Price], [Net Sales], [Net Sales with Tax], [List Price], Reason, SalesMan, [Batch No], [Order No], [Order Date], Syslot, OrgInvoice, RedInvoice, ReturnType, ReturnReason, ARGRU, BEZEI, PaymentTerm)
SELECT DBWH_BIHEC.dbo.T_Sales.WHS, DBWH_BIHEC.dbo.T_Sales.Plant, DBWH_BIHEC.dbo.T_Sales.ClientName, DBWH_BIHEC.dbo.T_Sales.ClientCode, DBWH_BIHEC.dbo.T_Sales.ProductID, DBWH_BIHEC.dbo.T_Sales.ProductName, DBWH_BIHEC.dbo.T_Sales.CustomerCode, DBWH_BIHEC.dbo.T_Sales.CustomerName, DBWH_BIHEC.dbo.T_Sales.CustomerAddress, DBWH_BIHEC.dbo.T_Sales.DistrictCode, DBWH_BIHEC.dbo.T_Sales.DistrictName, DBWH_BIHEC.dbo.T_Sales.Province, DBWH_BIHEC.dbo.T_Sales.Region, DBWH_BIHEC.dbo.T_Sales.CType, DBWH_BIHEC.dbo.T_Sales.Channel, DBWH_BIHEC.dbo.T_Sales.ShipTo, DBWH_BIHEC.dbo.T_Sales.InvoiceNo, DBWH_BIHEC.dbo.T_Sales.InvoiceDate, DBWH_BIHEC.dbo.T_Sales.Qty, DBWH_BIHEC.dbo.T_Sales.NetPrice, DBWH_BIHEC.dbo.T_Sales.NetSales, DBWH_BIHEC.dbo.T_Sales.NetSalesVAT, DBWH_BIHEC.dbo.T_Sales.ListPrice, DBWH_BIHEC.dbo.T_Sales.Reason, DBWH_BIHEC.dbo.T_Sales.SalesMan, DBWH_BIHEC.dbo.T_Sales.BatchNo, DBWH_BIHEC.dbo.T_Sales.OrderNo, DBWH_BIHEC.dbo.T_Sales.OrderDate, DBWH_BIHEC.dbo.T_Sales.Syslot, DBWH_BIHEC.dbo.T_Sales.OrgInvoice, DBWH_BIHEC.dbo.T_Sales.RedInvoice, DBWH_BIHEC.dbo.T_Sales.ReturnType, DBWH_BIHEC.dbo.T_Sales.ReturnReason, DBWH_BIHEC.dbo.T_Sales.Advp_Camp, DBWH_BIHEC.dbo.T_Sales.Foc_Camp, DBWH_BIHEC.dbo.T_Sales.PaymentTerm
FROM DBWH_BIHEC.dbo.T_Sales
WHERE ((DBWH_BIHEC.dbo.T_Sales.Plant) NOT LIKE 'VN13' AND (DBWH_BIHEC.dbo.T_Sales.Plant) NOT LIKE 'VN14' AND (DBWH_BIHEC.dbo.T_Sales.Plant) NOT LIKE 'VN16');



---add them code de check Daily_sales, chi lay nhung ngay co thay doi moi process tiep

DELETE FROM [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp];


INSERT INTO [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] ( BILLINGDATE, New_Qty, New_TT )
SELECT Daily_sales.BILLINGDATE, Sum(Daily_sales.Qty) AS SumOfQty, Sum(Daily_sales.[Net Sales]) AS [SumOfNet Sales]
FROM Daily_sales
GROUP BY Daily_sales.BILLINGDATE;


DELETE FROM [0_DP_Step5_CheckProcessed_data_vs_newdata_2_tmp];


INSERT INTO [0_DP_Step5_CheckProcessed_data_vs_newdata_2_tmp] ( BILLINGDATE, Processed_Qty, Processed_TT )
SELECT CONVERT(VARCHAR(8), CAST(DAILY_SALE_DATA.BILLINGDATE AS BIGINT)), Sum(DAILY_SALE_DATA.Qty) AS SumOfQty, Sum(DAILY_SALE_DATA.TT) AS SumOfTT
FROM DAILY_SALE_DATA
GROUP BY DAILY_SALE_DATA.BILLINGDATE;


UPDATE t1
SET t1.Processed_Qty = t2.Processed_Qty,
    t1.Processed_TT = t2.Processed_TT
FROM [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] AS t1
INNER JOIN [0_DP_Step5_CheckProcessed_data_vs_newdata_2_tmp] AS t2
ON t1.BILLINGDATE = t2.BILLINGDATE;

UPDATE [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp]
SET Processed_Qty = ISNULL(Processed_Qty, 0),
	Processed_TT = ISNULL(Processed_TT, 0)

UPDATE [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] SET [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Gap_Qty = [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].[Processed_Qty]-[0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].[New_Qty], [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Gap_TT = [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].[Processed_TT]-[0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].[New_TT];


UPDATE [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] SET [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Process_Yes_No = 'No';


UPDATE [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] SET [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Process_Yes_No = 'Yes'
WHERE ((([0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Gap_Qty)<> 0)) OR ((([0_DP_Step5_CheckProcessed_data_vs_newdata_tmp].Gap_TT)<>0));


