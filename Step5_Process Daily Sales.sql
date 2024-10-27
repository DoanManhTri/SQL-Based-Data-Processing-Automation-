---STEP5-----
---Process OrgInvoice DATE/MM
----CURRENT MONTH
DELETE FROM [1_DATA_CURRENT_MONTH_INVOICE_DATA_tmp];


INSERT INTO [1_DATA_CURRENT_MONTH_INVOICE_DATA_tmp] ( [Billing No], BILLINGDATE, REASON, Product, Qty, TT )
SELECT Daily_sales.[Billing No], Daily_sales.BILLINGDATE, Daily_sales.REASON, Daily_sales.[Product Code], Daily_sales.Qty, Daily_sales.[Net Sales]
FROM Daily_sales
GROUP BY Daily_sales.[Billing No], Daily_sales.BILLINGDATE, Daily_sales.REASON, Daily_sales.[Product Code], Daily_sales.Qty, Daily_sales.[Net Sales];


UPDATE ds
SET ds.OrgInvoice_date = tmp1.BILLINGDATE,
    ds.OrgInvoice_Reason = tmp1.REASON
FROM Daily_sales AS ds
INNER JOIN [1_DATA_CURRENT_MONTH_INVOICE_DATA_tmp] AS tmp1
ON ds.OrgInvoice = tmp1.[Billing No]
AND ds.[Product Code] = tmp1.Product
AND ABS(ds.Qty) = ABS(tmp1.qty)
AND ABS(ds.[Net Sales]) = ABS(tmp1.TT);


---Delete data da proceed truoc day ma khong co thay doi tren bang daily sales
UPDATE ds
SET ds.Process_Yes_No = tmp.[Process_Yes_No]
FROM Daily_sales AS ds
INNER JOIN [0_DP_Step5_CheckProcessed_data_vs_newdata_tmp] AS tmp
ON ds.BILLINGDATE = tmp.BILLINGDATE;


DELETE FROM Daily_sales
WHERE (((Daily_sales.Process_Yes_No)='No'));

----LUU Y ADD THEM THANG KHI QUA THANG MOI, sua ngay thang nam o doan cuoi

---M09_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M09] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

---M08_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M08] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;


---M07_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M07] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;


---M06_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M06] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

---M05_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M05] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

---M04_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M04] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

---M03_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M03] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;


---M02_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M02] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

---M01_2024
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2024_M01] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M12 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M12] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;


-- M11 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M11] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M10 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M10] AS tmp
ON ds.OrgInvoice = tmp.VBELN  AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M09 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M09] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M08 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M08] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M07 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M07] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M06 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M06] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M05 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M05] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M04 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M04] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M03 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M03] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M02 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M02] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M01 2023
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2023_M01] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M12 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M12] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M11 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M11] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M10 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M10] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M09 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M09] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M08 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M08] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M07 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M07] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M06 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M06] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M05 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M05] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M04 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M04] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M03 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M03] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M02 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M02] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M01 2022
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2022_M01] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M12 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M12] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M11 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M11] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M10 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M10] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M09 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M09] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M08 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M08] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M07 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M07] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M06 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M06] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M05 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M05] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

-- M04 2021
UPDATE ds
SET ds.OrgInvoice_date = CAST(CAST(tmp.BILLINGDATE AS INT) AS NVARCHAR(8)),
    ds.OrgInvoice_Reason = tmp.REASON
FROM Daily_sales AS ds
INNER JOIN [1_INHOUSE_DATA_2021_M04] AS tmp
ON ds.OrgInvoice = tmp.VBELN AND ds.[Product Code] = tmp.PRODUCT AND ABS(ds.Qty) = ABS(tmp.Qty) AND ABS(ds.[Net Sales]) = ABS(tmp.TT)
WHERE ds.OrgInvoice_date IS NULL;

UPDATE Daily_sales SET Daily_sales.OrgInvoice_YYYYMM = Left([Daily_sales].[OrgInvoice_date],6);

---set to current month if OrgInvoice_YYYYMM, LUU Y SUA CODE DOAN NAY
---Thang 7 thi sua lai 202307

UPDATE Daily_sales SET Daily_sales.OrgInvoice_YYYYMM = '202410' where Daily_sales.OrgInvoice_YYYYMM is null;


---end xu ly return''''

---start process daily sales (including previous days if changes + yesterday data)
UPDATE Daily_sales 
SET Daily_sales.[Material group-Master - Key] = 'M303' 
WHERE Daily_sales.[Material group-Master - Key]= 'V303';


UPDATE Daily_sales  SET Daily_sales.[Material group 1] = [Product].[Mat_Group1] FROM Daily_sales INNER JOIN Product ON Daily_sales.[Product Code] = [Product].ProductID;


---Update Daily_sales Discount
--UPDATE Daily_sales SET Discount = ([List Price] - [Net Price]) * Qty;
UPDATE Daily_sales
SET Discount = TRY_CAST((TRY_CAST([List Price] AS BIGINT) - TRY_CAST([Net Price] AS BIGINT)) AS BIGINT) * TRY_CAST(Qty AS BIGINT)


---Delete BillingDate
DELETE FROM BillingDate;


---Insert new BillingDates
INSERT INTO BillingDate ( BILLINGDATE ) 
SELECT Daily_sales.BILLINGDATE 
FROM Daily_sales 
GROUP BY Daily_sales.BILLINGDATE;


--- Classify duplicated dates between DAILY_SALE_DATA and BillingDate
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.[Update] = 1
FROM DAILY_SALE_DATA 
INNER JOIN BillingDate ON DAILY_SALE_DATA.BILLINGDATE = BillingDate.BILLINGDATE  ;


---Delete rows in DAILY_SALE_DATA which are Yes
DELETE FROM DAILY_SALE_DATA WHERE DAILY_SALE_DATA.[Update] = 1;


--DELETE FROM DAILY_SALE_DATA;


--- Trim Reason
UPDATE Daily_sales
Set Reason = Trim(Reason)


---Update DAILY_SALE_DATA
INSERT INTO [DAILY_SALE_DATA] (
    Plant, 
    [Plant - Key], 
    PRINCIPALCODE, 
    PRODUCT, 
    KUNNR, 
    VBELN, 
    BILLINGDATE, 
    REASON, 
    PERNR, 
    Source, 
    Discount, 
    Qty , 
    TT, 
    TTV,
    ARGRU,
    BEZEI,
    PaymentTerm,
	HEC_INCLUDE,
	FA_INCLUDE,
	CSO_INCLUDE,
	IS_RETURN)
SELECT 
    [Daily_sales].[Plant Code], 
    [Daily_sales].[Plant - Key], 
    [Daily_sales].[Material group-Master - Key], 
    [Daily_sales].[Product Code], 
    [Daily_sales].[Customer Code], 
    [Daily_sales].[Billing No], 
    [Daily_sales].BILLINGDATE, 
    [Daily_sales].Reason, 
    [Daily_sales].Salesman, 
    [Daily_sales].Source, 
    Sum([Daily_sales].Discount) As Discount, 
    Sum([Daily_sales].Qty) AS SumOfQty, 
    Sum([Daily_sales].[Net Sales]) AS SumOfTT, 
    Sum([Daily_sales].[Net Sales with Tax]) AS SumOfTTV,
    [Daily_sales].ARGRU,
    [Daily_sales].BEZEI,
    [Daily_sales].PaymentTerm,
	0 AS HEC_INCLUDE,
	0 AS FA_INCLUDE,
	0 AS CSO_INCLUDE,
	0 AS IS_RETURN
FROM [Daily_sales]
GROUP BY 
    [Daily_sales].[Plant Code], 
    [Daily_sales].[Plant - Key], 
    [Daily_sales].[Material group-Master - Key], 
    [Daily_sales].[Product Code], 
    [Daily_sales].[Customer Code] ,
    [Daily_sales].[Billing No], 
    [Daily_sales].BILLINGDATE, 
    [Daily_sales].Reason, 
    [Daily_sales].Salesman, 
    [Daily_sales].Source,
    [Daily_sales].ARGRU,
    [Daily_sales].BEZEI,
    [Daily_sales].PaymentTerm

---Update BILLINGDAY in DAILY_SALE_DATA
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.BUILDINGDAY = Right(CAST(CAST([BILLINGDATE] AS BIGINT) AS VARCHAR(10)),2);


---Update Month & Year in DAILY_SALE_DATA
UPDATE DAILY_SALE_DATA 
SET [Calendar Month] = CAST(SUBSTRING(LTRIM(STR([BILLINGDATE], 10, 0)), 5, 2) AS INT)
WHERE EXISTS (
    SELECT 1
    FROM BillingDate
    WHERE LTRIM(STR(BillingDate.BILLINGDATE, 10, 0)) = LTRIM(STR(DAILY_SALE_DATA.[BILLINGDATE], 10, 0))
);


 
UPDATE DAILY_SALE_DATA 
SET [Calendar Year] = CAST(LEFT(LTRIM(STR([BILLINGDATE], 10, 0)), 4) AS INT)
WHERE EXISTS (
    SELECT 1
    FROM BillingDate
    WHERE LTRIM(STR(BillingDate.BILLINGDATE, 10, 0)) = LTRIM(STR(DAILY_SALE_DATA.[BILLINGDATE], 10, 0))
);



---Update [Bulling Date] to same with [Billing Date] in 99_DAILY_DATA_FOR_POWER_BI_DASHBOARD
UPDATE DAILY_SALE_DATA 
SET [Billing Date] = 
    RIGHT(CONVERT(VARCHAR(10), CAST([BILLINGDATE] AS BIGINT)), 2) + '.' + 
    SUBSTRING(CONVERT(VARCHAR(10), CAST([BILLINGDATE] AS BIGINT)), 5, 2) + '.' + 
    LEFT(CONVERT(VARCHAR(10), CAST([BILLINGDATE] AS BIGINT)), 4)
WHERE EXISTS (
    SELECT 1
    FROM BillingDate
    WHERE CONVERT(VARCHAR(10), CAST(BillingDate.BILLINGDATE AS BIGINT)) = CONVERT(VARCHAR(10), CAST(DAILY_SALE_DATA.[BILLINGDATE] AS BIGINT))
);



---Update SALE_RETURN in DAILY_SALE_DATA
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.SALE_RETURN = 'Sale';


---Classify Return in DAILY_SALE_DATA
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.SALE_RETURN = 'Return' 
WHERE DAILY_SALE_DATA.Qty<0;


Update DAILY_SALE_DATA
Set DAILY_SALE_DATA.IS_RETURN = 1
WHERE DAILY_SALE_DATA.SALE_RETURN = 'Return'



---Classify Rejection_Type
UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.Rejection_Type = 'Others' 
WHERE (((DAILY_SALE_DATA.IS_RETURN)=1));


--UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.Rejection_Type = 'Outright Rejection' 
--WHERE (((DAILY_SALE_DATA.IS_RETURN)=1) AND ((DAILY_SALE_DATA.BEZEI) = 'Outright Rejection' Or (DAILY_SALE_DATA.BEZEI)='Wrong Delivered Product'));

UPDATE A
SET A.Rejection_Type = 'Outright Rejection', A.ReturnType =B.ReturnType_Old
FROM DAILY_SALE_DATA A
INNER JOIN [0_Outright_Rejection] B ON A.ARGRU= B.REASON_CODE


---Delete old data of SALES_BY_KUNNR
DELETE FROM SALES_BY_KUNNR;


---Update SALES_BY_KUNNR
INSERT INTO SALES_BY_KUNNR (KUNNR, SumOfTT )
SELECT 
    Daily_sales.[Customer Code], 
    Sum(Daily_sales.[Net Sales]) AS SumOfTT
FROM Daily_sales
GROUP BY Daily_sales.[Customer Code];


--- Delete SALES_BY_PRODUCT
DELETE FROM SALES_BY_PRODUCT;


--- Update SALES_BY_PRODUCT
INSERT INTO SALES_BY_PRODUCT ( PRODUCT, SumOfTT )
SELECT 
    Daily_sales.[Product Code], 
    Sum(Daily_sales.[Net Sales]) AS SumOfTT
FROM Daily_sales
GROUP BY Daily_sales.[Product Code];

--- Delete [New product]
DELETE FROM [New product];


--- Update [New product]
INSERT INTO [New product] ( PRODUCT, ProductCode )
SELECT 
    SALES_BY_PRODUCT.PRODUCT, 
    [MASTER PRODUCT].ProductCode
FROM [MASTER PRODUCT] 
    RIGHT JOIN SALES_BY_PRODUCT 
    ON [MASTER PRODUCT].ProductCode = SALES_BY_PRODUCT.PRODUCT
GROUP BY 
    SALES_BY_PRODUCT.PRODUCT, 
    [MASTER PRODUCT].ProductCode
HAVING [MASTER PRODUCT].ProductCode Is Null;


--- Update new product note
UPDATE np
SET np.[Notes] = 
	CASE 
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '01' THEN 'New Jan ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '02' THEN 'New Feb ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '03' THEN 'New Mar ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '04' THEN 'New Apr ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '05' THEN 'New May ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '06' THEN 'New Jun ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '07' THEN 'New Jul ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '08' THEN 'New Aug ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '09' THEN 'New Sep ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '10' THEN 'New Oct ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '11' THEN 'New Nov ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '12' THEN 'New Dec ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		ELSE 'Other'
	END
FROM [New product] np
INNER JOIN Daily_sales ds ON np.PRODUCT = ds.[Product Code]
WHERE SUBSTRING(ds.BILLINGDATE, 5, 2) BETWEEN '01' AND '12';



--- Delete old data of [New customer] table
DELETE FROM [New customer];


--- Update new customers
INSERT INTO [New customer] ( SALES_BY_KUNNR_Kunnr, [MASTER CUSTOMER_Kunnr])
SELECT SALES_BY_KUNNR.KUNNR, [MASTER CUSTOMER].Kunnr
FROM [MASTER CUSTOMER] 
    RIGHT JOIN SALES_BY_KUNNR 
    ON [MASTER CUSTOMER].Kunnr = SALES_BY_KUNNR.KUNNR
GROUP BY SALES_BY_KUNNR.KUNNR, [MASTER CUSTOMER].Kunnr
HAVING [MASTER CUSTOMER].Kunnr Is Null;


---Update new customer note
UPDATE nc
SET nc.[Notes] =
	CASE 
		--WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '01' THEN 'New Jan 2020'
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '01' THEN 'New Jan ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '02' THEN 'New Feb ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '03' THEN 'New Mar ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '04' THEN 'New Apr ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '05' THEN 'New May ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '06' THEN 'New Jun ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '07' THEN 'New Jul ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '08' THEN 'New Aug ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '09' THEN 'New Sep ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '10' THEN 'New Oct ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '11' THEN 'New Nov ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		WHEN SUBSTRING(ds.BILLINGDATE, 5, 2) = '12' THEN 'New Dec ' + CAST(YEAR(ds.BillingDate) AS VARCHAR)
		ELSE 'Other'
	END
FROM [New customer] nc
INNER JOIN Daily_sales ds ON nc.SALES_BY_KUNNR_Kunnr = ds.[Customer Code]
WHERE SUBSTRING(ds.BILLINGDATE, 5, 2) BETWEEN '01' AND '12';


--Delete old data of 9_NEW_CUSTOMER_TO_MASTER_CUSTOMER
DELETE FROM [9_NEW_CUSTOMER_TO_MASTER CUSTOMER];


--- Update new customers into 9_NEW_CUSTOMER_TO_MASTER_CUSTOMER
INSERT INTO [9_NEW_CUSTOMER_TO_MASTER CUSTOMER] (CustCode, CustName, Address, District, CGrpCode, CGrpName, Stras2, Land, ChannelCO, ChannelMOM, Notes )
SELECT 
    Customer.CustCode, 
    Customer.CustName, 
    Customer.Address, 
    Customer.District, 
    Customer.CGrpCode, 
    Customer.CGrpName, 
    [0_added_value_customer_mapping].Stras2, 
    [0_added_value_customer_mapping].Land, 
    [0_CHANNEL_CODE].ChannelCO, 
    [0_CHANNEL_CODE].ChannelMOM, 
    [New customer].Notes
FROM (([New customer] 
    INNER JOIN Customer 
    ON [New customer].SALES_BY_KUNNR_Kunnr = Customer.CustCode) 
    INNER JOIN [0_added_value_customer_mapping] 
    ON Customer.Province = [0_added_value_customer_mapping].Province) 
    INNER JOIN [0_CHANNEL_CODE] 
    ON Customer.CGrpCode = [0_CHANNEL_CODE].ChannelCode
GROUP BY 
    Customer.CustCode, 
    Customer.CustName, 
    Customer.Address, 
    Customer.District, 
    Customer.CGrpCode, 
    Customer.CGrpName, 
    [0_added_value_customer_mapping].Stras2, 
    [0_added_value_customer_mapping].Land, 
    [0_CHANNEL_CODE].ChannelCO, 
    [0_CHANNEL_CODE].ChannelMOM, 
    [New customer].Notes;


---Make table list customer from Daily_Sales_CG
--- Delete Daily_Sales_CG_Customer_tmp
DELETE FROM Daily_Sales_CG_Customer_tmp;


INSERT INTO [Daily_Sales_CG_Customer_tmp] ( [SALES_BY_KUNNR_Kunnr], [Customer Name], Address, District, CustGroup, Channel, Province, Region, ChannelCO, ChannelMOM, Notes, Source )
SELECT DISTINCT 
    [New customer].[SALES_BY_KUNNR_Kunnr], 
    Daily_sales_CG.[Customer Name], 
    Daily_sales_CG.Address, 
    Daily_sales_CG.District, 
    Daily_sales_CG.CustGroup, 
    Daily_sales_CG.Channel, 
    Daily_sales_CG.Province, 
    Daily_sales_CG.Region, 
    [0_CHANNEL_CODE].ChannelCO, 
    [0_CHANNEL_CODE].ChannelMOM, 
    [New customer].Notes, 
    Daily_sales_CG.Source
FROM (Daily_sales_CG 
    INNER JOIN [New customer] 
    ON Daily_sales_CG.[Customer Code] = [New customer].SALES_BY_KUNNR_Kunnr) 
    INNER JOIN [0_CHANNEL_CODE] 
    ON Daily_sales_CG.CustGroup = [0_CHANNEL_CODE].ChannelCode;


----Check customer with the customer list from HEC - If null will to insert into

INSERT INTO [9_NEW_CUSTOMER_TO_MASTER CUSTOMER] ( CustCode, CustName, Address, District, CGrpCode, CGrpName, Stras2, Land, ChannelCO, ChannelMOM, Notes, Source )
SELECT Daily_Sales_CG_Customer_tmp.SALES_BY_KUNNR_Kunnr, 
    Daily_Sales_CG_Customer_tmp.[Customer Name] , 
    Daily_Sales_CG_Customer_tmp.Address, 
    Daily_Sales_CG_Customer_tmp.District, 
    Daily_Sales_CG_Customer_tmp.CustGroup, 
    Daily_Sales_CG_Customer_tmp.Channel, 
    Daily_Sales_CG_Customer_tmp.Province, 
    Daily_Sales_CG_Customer_tmp.Region, 
    Daily_Sales_CG_Customer_tmp.ChannelCO, 
    Daily_Sales_CG_Customer_tmp.ChannelMOM, 
    Daily_Sales_CG_Customer_tmp.Notes, 
    Daily_Sales_CG_Customer_tmp.Source
FROM Daily_Sales_CG_Customer_tmp 
    LEFT JOIN [9_NEW_CUSTOMER_TO_MASTER CUSTOMER] 
    ON Daily_Sales_CG_Customer_tmp.SALES_BY_KUNNR_Kunnr = [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CustCode
WHERE ((([9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CustCode) Is Null))
GROUP BY 
    Daily_Sales_CG_Customer_tmp.SALES_BY_KUNNR_Kunnr, 
    Daily_Sales_CG_Customer_tmp.[Customer Name], 
    Daily_Sales_CG_Customer_tmp.Address, 
    Daily_Sales_CG_Customer_tmp.District, 
    Daily_Sales_CG_Customer_tmp.CustGroup, 
    Daily_Sales_CG_Customer_tmp.Channel, 
    Daily_Sales_CG_Customer_tmp.Province, 
    Daily_Sales_CG_Customer_tmp.Region, 
    Daily_Sales_CG_Customer_tmp.ChannelCO, 
    Daily_Sales_CG_Customer_tmp.ChannelMOM, 
    Daily_Sales_CG_Customer_tmp.Notes, Daily_Sales_CG_Customer_tmp.Source;



--- Delete [9_NEW_PRODUCT_TO_MASTER]
DELETE FROM [9_NEW_PRODUCT_TO_MASTER];


--- Update 9_NEW_PRODUCT_TO_MASTER
INSERT INTO [9_NEW_PRODUCT_TO_MASTER] (PRODUCT, Notes, PRODUCTNAME, PRINCIPALCODE, MG1, BSClassMM, SUPPLIERGROUP, BL, [BL Group], BrandName, Category )
SELECT 
    [New product].PRODUCT, 
    [New product].Notes, 
    Daily_sales.[Product Name], 
    Daily_sales.[Material group-Master - Key], 
    Daily_sales.[Material group 1], 
    [0_MG1_CODE].BSClassMM, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].SUPPLIERGROUP, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].BL, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].[BL Group], 
    Product.Brand, 
    Product.Category
FROM ([0_SUPLIER_CODE_TO_SUPLIER_GROUP] 
    INNER JOIN ((Daily_sales 
    INNER JOIN [New product] 
    ON Daily_sales.[Product Code] = [New product].PRODUCT) 
    INNER JOIN [0_MG1_CODE] 
    ON Daily_sales.[Material group 1] = [0_MG1_CODE].MG1) 
    ON [0_SUPLIER_CODE_TO_SUPLIER_GROUP].SupplierCode = Daily_sales.[Material group-Master - Key]) 
    INNER JOIN Product 
    ON Daily_sales.[Product Code] = Product.ProductID
GROUP BY 
    [New product].PRODUCT, 
    [New product].Notes, 
    Daily_sales.[Product Name], 
    Daily_sales.[Material group-Master - Key], 
    Daily_sales.[Material group 1], 
    [0_MG1_CODE].BSClassMM, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].SUPPLIERGROUP, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].BL, 
    [0_SUPLIER_CODE_TO_SUPLIER_GROUP].[BL Group], 
    Product.Brand, Product.Category;


--- Delete [BL Group] = FA & PRINCIPALCODE = 0053 (NVS)
DELETE FROM [9_NEW_PRODUCT_TO_MASTER]
WHERE [BL Group] = 'FA' AND PRINCIPALCODE = '0053';



---------------ADD UPDATE MOI CHO NVS - Glau Lu From 092023 for new product
UPDATE [9_NEW_PRODUCT_TO_MASTER] 
SET [9_NEW_PRODUCT_TO_MASTER].[BL Group] = 'FA', 
[9_NEW_PRODUCT_TO_MASTER].[BL] = 'ALLIANCE 3'
WHERE ((([9_NEW_PRODUCT_TO_MASTER].PRINCIPALCODE)='0053') AND (([9_NEW_PRODUCT_TO_MASTER].BrandName) Like 'AZARGA' Or ([9_NEW_PRODUCT_TO_MASTER].BrandName)Like 'AZOPT' Or ([9_NEW_PRODUCT_TO_MASTER].BrandName) Like 'DUOTRAV' Or ([9_NEW_PRODUCT_TO_MASTER].BrandName)Like 'SIMBRINZA' Or ([9_NEW_PRODUCT_TO_MASTER].BrandName) Like 'TRAVATAN' Or ([9_NEW_PRODUCT_TO_MASTER].BrandName) Like 'LUCENTIS'));


 -------- ADD them doan run show code moi trong 9 NEW PRODUCT De add vao table maintain cua NVS - Glau lu
--DoCmd.OpenQuery (check_newproduct_NVS_Clau_Lu)


--Update [MASTER CUSTOMER] from 9_NEW_CUSTOMER_TO_MASTER_CUSTOMER
INSERT INTO [MASTER CUSTOMER] (Kunnr, Name1, Stras1, District, Stras2, Land, ChannelCode, Channel_Ori, ChannelCO, ChannelMOM, Notes, Source, [Omni-Chain], YTD_Active_Status, Abbott_sales, Rx_otc_Abbott_sales,[Not Use Update], [LOREAL_4PL], [Omni-Chain_org] )
SELECT 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CustCode, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CustName, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].Address, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].District, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].Stras2, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].Land, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CGrpCode, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].CGrpName, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].ChannelCO, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].ChannelMOM, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].Notes, 
    [9_NEW_CUSTOMER_TO_MASTER CUSTOMER].Source,
	0 as [Omni-Chain],
	0 AS YTD_Active_Status,
	0 AS Abbott_sales,
	0 AS Rx_otc_Abbott_sales,
	0 as [Not Use Update],
	0 as [LOREAL_4PL],
	0 as [Omni-Chain_org]
FROM [9_NEW_CUSTOMER_TO_MASTER CUSTOMER];



-- Update [MASTER PRODUCT] from 9_NEW_PRODUCT_TO_MASTER
INSERT INTO [MASTER PRODUCT] (Notes, ProductCode, PRODUCTNAME, SupplierCode, BSClass_MM, SUPPLIERGROUP, BL, [BL Group], BrandName, Category, Active_product_L1M, Active_product_2019_2021,
				Active_product_2019_2022, YTD_Active_Status)
SELECT 
    [9_NEW_PRODUCT_TO_MASTER].Notes,
    [9_NEW_PRODUCT_TO_MASTER].PRODUCT, 
    [9_NEW_PRODUCT_TO_MASTER].PRODUCTNAME, 
    [9_NEW_PRODUCT_TO_MASTER].PRINCIPALCODE, 
    [9_NEW_PRODUCT_TO_MASTER].BSClassMM, 
    [9_NEW_PRODUCT_TO_MASTER].SUPPLIERGROUP, 
    [9_NEW_PRODUCT_TO_MASTER].BL, 
    [9_NEW_PRODUCT_TO_MASTER].[BL Group],
    [9_NEW_PRODUCT_TO_MASTER].[BrandName],
    [9_NEW_PRODUCT_TO_MASTER].[Category],
	0 AS Active_product_L1M,
	0 AS Active_product_2019_2021,
	0 AS Active_product_2019_2022,
	0 as YTD_Active_Status
FROM [9_NEW_PRODUCT_TO_MASTER];


--- Update BSClass from BSClass_MM
Update [MASTER PRODUCT]
Set [MASTER PRODUCT].BSClass = [MASTER PRODUCT].BSClass_MM
WHERE [MASTER PRODUCT].BSClass Is Null


-- Update Source
Update DAILY_SALE_DATA
SET DAILY_SALE_DATA.Source = 'HEC'
WHERE DAILY_SALE_DATA.Source Is Null


---Update return reason
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.OrgInvoice = [Daily_sales].[OrgInvoice], DAILY_SALE_DATA.ReturnType = [Daily_sales].[ReturnType], DAILY_SALE_DATA.ReturnReason = [Daily_sales].[ReturnReason], DAILY_SALE_DATA.OrgInvoice_date = [Daily_sales].[OrgInvoice_date], DAILY_SALE_DATA.OrgInvoice_YYYYMM = [Daily_sales].[OrgInvoice_YYYYMM],DAILY_SALE_DATA.OrgInvoice_Reason = [Daily_sales].[OrgInvoice_Reason]
FROM DAILY_SALE_DATA
INNER JOIN [Daily_sales] ON DAILY_SALE_DATA.VBELN = Daily_sales.[Billing No] AND DAILY_SALE_DATA.PRODUCT = Daily_sales.[Product Code] AND ABS(DAILY_SALE_DATA.Qty) = ABS(Daily_sales.Qty) AND ABS(Daily_sales.[Net Sales]) = ABS(DAILY_SALE_DATA.TT)

---PF
DELETE FROM tmp_PFDC_Product

INSERT INTO tmp_PFDC_Product (SupplierCode, ProductCode, CSO_Name, Mat_Group4)
SELECT [MASTER PRODUCT].SupplierCode, [MASTER PRODUCT].ProductCode, 'PIERRE FABRE - PFDC' AS CSO_Name, DBWH_BIHEC.dbo.M_Product_Grp.Mat_Group4
FROM [MASTER PRODUCT] 
INNER JOIN DBWH_BIHEC.dbo.M_Product_Grp ON [MASTER PRODUCT].ProductCode = DBWH_BIHEC.dbo.M_Product_Grp.ProductID COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE ([MASTER PRODUCT].SupplierCode='0274') AND (DBWH_BIHEC.dbo.M_Product_Grp.Mat_Group4='VOI');



UPDATE [MASTER PRODUCT]  SET [MASTER PRODUCT].CSO_Name = [tmp_PFDC_Product].[CSO_Name]
FROM [MASTER PRODUCT] INNER JOIN tmp_PFDC_Product ON [MASTER PRODUCT].ProductCode = tmp_PFDC_Product.ProductCode
WHERE (((tmp_PFDC_Product.Mat_Group4)='VOI'));


----Update Cho L'Oreal CSMO

UPDATE [MASTER PRODUCT] 
SET BL='CSO', [BL Group]='CSO', [BL Group New]='CSO', [BL New]='CSO', CSO_Name='L''OREAL-CSO', CSO_Name_pre ='L''OREAL-CSO'
FROM [MASTER PRODUCT]
INNER JOIN DBWH_BIHEC.dbo.M_Product_Grp ON [MASTER PRODUCT].ProductCode = DBWH_BIHEC.dbo.M_Product_Grp.ProductID COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE ([MASTER PRODUCT].SupplierCode='0043') AND (DBWH_BIHEC.dbo.M_Product_Grp.Mat_Group4='VP3');


--''
--'UPDATE 0_SUPPLIER_CSO INNER JOIN [MASTER PRODUCT] ON [0_SUPPLIER_CSO].ProductCode = [MASTER PRODUCT].ProductCode SET [MASTER PRODUCT].CSO_Name = [0_SUPPLIER_CSO].[Abbreviation]
--'WHERE ((([0_SUPPLIER_CSO].ProductCode) Is Not Null));
--'

UPDATE [MASTER PRODUCT]  SET [MASTER PRODUCT].CSO_Name = [MASTER PRODUCT].[SUPPLIERGROUP]
FROM [MASTER PRODUCT] INNER JOIN [0_SUPPLIER_CSO] ON [MASTER PRODUCT].SupplierCode = [0_SUPPLIER_CSO].SupplierCode
WHERE ((([MASTER PRODUCT].CSO_Name) Is Null));


UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.CSO_INCLUDE = 0, DAILY_SALE_DATA.CSO_Name = Null;


UPDATE DAILY_SALE_DATA  SET DAILY_SALE_DATA.CSO_INCLUDE = 1, DAILY_SALE_DATA.CSO_Name = [MASTER PRODUCT].[CSO_Name]
FROM DAILY_SALE_DATA INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode
WHERE ((([MASTER PRODUCT].CSO_Name) Is Not Null));


--UPDATE DAILY_SALE_DATA  SET DAILY_SALE_DATA.CSO_INCLUDE = 0
--FROM DAILY_SALE_DATA INNER JOIN BICSO_Exclude_M1_2024 ON DAILY_SALE_DATA.KUNNR = BICSO_Exclude_M1_2024.CustCode
--WHERE (((BICSO_Exclude_M1_2024.CustCode) Is Not Null) AND ((DAILY_SALE_DATA.CSO_Name)='BI CSO') AND ((DAILY_SALE_DATA.BILLINGDATE) >= 20230801)) ;


---UPDATE CHO BI CSO
UPDATE DAILY_SALE_DATA SET CSO_INCLUDE =1
FROM DAILY_SALE_DATA 
INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode
INNER JOIN [MASTER CUSTOMER] ON DAILY_SALE_DATA.KUNNR = [MASTER CUSTOMER].Kunnr
WHERE [MASTER CUSTOMER].ChannelMOM Not Like 'Hospital' AND [MASTER PRODUCT].CSO_Name='BI CSO' AND DAILY_SALE_DATA.BILLINGDATE >=20240101


UPDATE DAILY_SALE_DATA SET CSO_INCLUDE =0
FROM DAILY_SALE_DATA 
INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode
INNER JOIN [MASTER CUSTOMER] ON DAILY_SALE_DATA.KUNNR = [MASTER CUSTOMER].Kunnr
WHERE [MASTER CUSTOMER].ChannelMOM='Hospital' AND [MASTER PRODUCT].CSO_Name='BI CSO' AND DAILY_SALE_DATA.BILLINGDATE >=20240101;


--UPDATE DAILY_SALE_DATA INNER JOIN BICSO_Exclude ON DAILY_SALE_DATA.KUNNR = BICSO_Exclude.CustCode SET DAILY_SALE_DATA.CSO_INCLUDE = No 
--WHERE (((BICSO_Exclude.CustCode) Is Not Null) AND ((DAILY_SALE_DATA.CSO_Name)='BI CSO') AND ((DAILY_SALE_DATA.BILLINGDATE) <= 20230731)) ;






