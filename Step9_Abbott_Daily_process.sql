----ABBOT---

DECLARE @currentDate DATETIME = GETDATE(); -- current date
DECLARE @currentMonth NVARCHAR(2) = RIGHT('0' + CAST(MONTH(@currentDate) AS NVARCHAR(2)), 2); -- ensures two digits
DECLARE @YYYYMM NVARCHAR(6) = CAST(YEAR(@currentDate) AS NVARCHAR(4)) + @currentMonth;

--DECLARE @YYYYMM NVARCHAR(6) =202403

DELETE FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT
WHERE YYYYMM = @YYYYMM;


INSERT INTO DATA_TAKING_INVOICE_COMBINED_ABBOTT (
    PRODUCT, KUNNR_org, Qty, [Sales Value], HEC_INCLUDE, 
    Source, VBELN, PERNR, BILLINGDATE, Organic_MAT, Organic_YTD
)
SELECT 
    PRODUCT, KUNNR, SUM(Qty) AS SumOfQty, SUM(TT) AS SumOfTT, 
    HEC_INCLUDE, Source, VBELN, PERNR, BILLINGDATE, 
    CAST(0 AS BIT) AS Organic_MAT, -- Giả sử giá trị mặc định cho Organic_MAT là 0
    CAST(0 AS BIT) AS Organic_YTD  -- Giả sử giá trị mặc định cho Organic_YTD là 0
FROM 
    DAILY_SALE_DATA
WHERE 
    REASON LIKE 'Sales%'
GROUP BY 
    PRODUCT, KUNNR, HEC_INCLUDE, Source, VBELN, PERNR, BILLINGDATE;



--Updating YYYYMM in DATA_TAKING_INVOICE_COMBINED_ABBOTT:
UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT
SET YYYYMM = @YYYYMM
WHERE YYYYMM is null;


---Updating date format in DATA_TAKING_INVOICE_COMBINED_ABBOTT
UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT
SET Day_ddmmyyyy = 
    CONVERT(datetime, 
        SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 7, 2) + '/' + 
        SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 5, 2) + '/' + 
        SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 1, 4), 
        103)
WHERE 
    Day_ddmmyyyy IS NULL
    --AND ISDATE(
    --    SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 7, 2) + '/' + 
    --    SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 5, 2) + '/' + 
    --    SUBSTRING(CONVERT(varchar(8), BILLINGDATE), 1, 4)
    --) = 1;


---Updating DB_nhom in DATA_TAKING_INVOICE_COMBINED_ABBOTT based on a join with [MASTER PRODUCT]:
-- For SupplierCode not like '0091'
UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT
SET DB_nhom = 'LD'
FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT
INNER JOIN [MASTER PRODUCT] ON DATA_TAKING_INVOICE_COMBINED_ABBOTT.PRODUCT = [MASTER PRODUCT].ProductCode
WHERE DATA_TAKING_INVOICE_COMBINED_ABBOTT.DB_nhom IS NULL
AND [MASTER PRODUCT].SupplierCode NOT LIKE '0091';

-- For SupplierCode equal to '0091'
UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT
SET DB_nhom = '0091'
FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT
INNER JOIN [MASTER PRODUCT] ON [MASTER PRODUCT].ProductCode = DATA_TAKING_INVOICE_COMBINED_ABBOTT.PRODUCT
WHERE DATA_TAKING_INVOICE_COMBINED_ABBOTT.DB_nhom IS NULL
AND [MASTER PRODUCT].SupplierCode = '0091';

UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT
SET KUNNR = KUNNR_Org
WHERE KUNNR IS NULL;


---INFLUVAC

UPDATE DATA_TAKING_INVOICE_COMBINED_ABBOTT 
SET DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR = [DATA_TAKING_INVOICE_COMBINED_ABBOTT].[KUNNR_Org] + '_1'
FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT
INNER JOIN [MASTER PRODUCT] ON DATA_TAKING_INVOICE_COMBINED_ABBOTT.PRODUCT = [MASTER PRODUCT].ProductCode 
WHERE ((([MASTER PRODUCT].ATC2)='J07'));


DELETE FROM tmp_Abbott_Influvac_customer;


INSERT INTO tmp_Abbott_Influvac_customer ( KUNNR, KUNNR_Org, Name1, Stras1, Land, Stras2, Channel_Ori, District, ChannelCode, ChannelCO, ChannelDB, ChannelMOM, HospitalGroup, [Omni-Chain], [Omni-Class], [Cosmetic-Channel], [Cosmetic-group], Notes, NAME_PROVINCE, Source, [Omni_Chain CustName], [Omni_Chain Brand], [Omni_Chain Group], Omni_Chain_Source, YTD_Active_Status, ChannelGROUP, PF_AVENE_CHANNEL, TradeGROUP, Online_vs_Offline, Sub_Channel, Sub_Channel_Abbott )
 SELECT DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR, DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR_Org, [MASTER CUSTOMER].Name1, [MASTER CUSTOMER].Stras1, [MASTER CUSTOMER].Land, [MASTER CUSTOMER].Stras2, [MASTER CUSTOMER].Channel_Ori, [MASTER CUSTOMER].District, [MASTER CUSTOMER].ChannelCode, [MASTER CUSTOMER].ChannelCO, [MASTER CUSTOMER].ChannelDB, [MASTER CUSTOMER].ChannelMOM, [MASTER CUSTOMER].HospitalGroup, [MASTER CUSTOMER].[Omni-Chain], [MASTER CUSTOMER].[Omni-Class]
 , [MASTER CUSTOMER].[Cosmetic-Channel], [MASTER CUSTOMER].[Cosmetic-group], [MASTER CUSTOMER].Notes, [MASTER CUSTOMER].NAME_PROVINCE, [MASTER CUSTOMER].Source, [MASTER CUSTOMER].[Omni_Chain CustName], [MASTER CUSTOMER].[Omni_Chain Brand], [MASTER CUSTOMER].[Omni_Chain Group], [MASTER CUSTOMER].Omni_Chain_Source, [MASTER CUSTOMER].YTD_Active_Status, [MASTER CUSTOMER].ChannelGROUP, [MASTER CUSTOMER].PF_AVENE_CHANNEL, [MASTER CUSTOMER].TradeGROUP
 , [MASTER CUSTOMER].Online_vs_Offline, [MASTER CUSTOMER].Sub_Channel, [MASTER CUSTOMER].Sub_Channel_Abbott
 FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT INNER JOIN [MASTER CUSTOMER] ON DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR_Org = [MASTER CUSTOMER].Kunnr
 GROUP BY DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR, DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR_Org, [MASTER CUSTOMER].Name1, [MASTER CUSTOMER].Stras1, [MASTER CUSTOMER].Land, [MASTER CUSTOMER].Stras2, [MASTER CUSTOMER].Channel_Ori, [MASTER CUSTOMER].District, [MASTER CUSTOMER].ChannelCode, [MASTER CUSTOMER].ChannelCO, [MASTER CUSTOMER].ChannelDB, [MASTER CUSTOMER].ChannelMOM, [MASTER CUSTOMER].HospitalGroup, [MASTER CUSTOMER].[Omni-Chain], [MASTER CUSTOMER].[Omni-Class]
 , [MASTER CUSTOMER].[Cosmetic-Channel], [MASTER CUSTOMER].[Cosmetic-group], [MASTER CUSTOMER].Notes, [MASTER CUSTOMER].NAME_PROVINCE, [MASTER CUSTOMER].Source, [MASTER CUSTOMER].[Omni_Chain CustName], [MASTER CUSTOMER].[Omni_Chain Brand], [MASTER CUSTOMER].[Omni_Chain Group], [MASTER CUSTOMER].Omni_Chain_Source, [MASTER CUSTOMER].YTD_Active_Status, [MASTER CUSTOMER].ChannelGROUP, [MASTER CUSTOMER].PF_AVENE_CHANNEL, [MASTER CUSTOMER].TradeGROUP, [MASTER CUSTOMER].Online_vs_Offline, [MASTER CUSTOMER].Sub_Channel, [MASTER CUSTOMER].Sub_Channel_Abbott
 HAVING (((DATA_TAKING_INVOICE_COMBINED_ABBOTT.KUNNR) Like '%_1'));


UPDATE tmp_Abbott_Influvac_customer SET tmp_Abbott_Influvac_customer.Notes = 'Influvac';


--???
DELETE FROM [MASTER PRODUCT]
WHERE ((([MASTER PRODUCT].Notes)='Influvac'));

INSERT INTO [MASTER CUSTOMER] ( Notes, KUNNR, Name1, Stras1, Land, Stras2, Channel_Ori, District, ChannelCode, ChannelCO, ChannelDB, ChannelMOM, HospitalGroup, [Omni-Chain], [Omni-Class], [Cosmetic-Channel], [Cosmetic-group], NAME_PROVINCE, Source, [Omni_Chain CustName], [Omni_Chain Brand], [Omni_Chain Group], Omni_Chain_Source, YTD_Active_Status, ChannelGROUP, PF_AVENE_CHANNEL, TradeGROUP, Online_vs_Offline, Sub_Channel, Sub_Channel_Abbott )
 SELECT tmp_Abbott_Influvac_customer.Notes, tmp_Abbott_Influvac_customer.KUNNR, tmp_Abbott_Influvac_customer.Name1, tmp_Abbott_Influvac_customer.Stras1, tmp_Abbott_Influvac_customer.Land, tmp_Abbott_Influvac_customer.Stras2, tmp_Abbott_Influvac_customer.Channel_Ori, tmp_Abbott_Influvac_customer.District, tmp_Abbott_Influvac_customer.ChannelCode, tmp_Abbott_Influvac_customer.ChannelCO, tmp_Abbott_Influvac_customer.ChannelDB
 , tmp_Abbott_Influvac_customer.ChannelMOM, tmp_Abbott_Influvac_customer.HospitalGroup, tmp_Abbott_Influvac_customer.[Omni-Chain], tmp_Abbott_Influvac_customer.[Omni-Class], tmp_Abbott_Influvac_customer.[Cosmetic-Channel], tmp_Abbott_Influvac_customer.[Cosmetic-group], tmp_Abbott_Influvac_customer.NAME_PROVINCE, tmp_Abbott_Influvac_customer.Source, tmp_Abbott_Influvac_customer.[Omni_Chain CustName]
 , tmp_Abbott_Influvac_customer.[Omni_Chain Brand], tmp_Abbott_Influvac_customer.[Omni_Chain Group], tmp_Abbott_Influvac_customer.Omni_Chain_Source, tmp_Abbott_Influvac_customer.YTD_Active_Status, tmp_Abbott_Influvac_customer.ChannelGROUP , tmp_Abbott_Influvac_customer.PF_AVENE_CHANNEL, tmp_Abbott_Influvac_customer.TradeGROUP, tmp_Abbott_Influvac_customer.Online_vs_Offline, tmp_Abbott_Influvac_customer.Sub_Channel, tmp_Abbott_Influvac_customer.Sub_Channel_Abbott
 FROM [MASTER CUSTOMER] RIGHT JOIN tmp_Abbott_Influvac_customer ON [MASTER CUSTOMER].Kunnr = tmp_Abbott_Influvac_customer.KUNNR
 WHERE ((([MASTER CUSTOMER].Kunnr) Is Null));

UPDATE [MASTER CUSTOMER]
SET Sub_Channel = NULL, 
    Sub_Channel_Abbott = NULL;

UPDATE MC
SET MC.Sub_Channel = ABB.[Final Channel], 
    MC.Sub_Channel_Abbott = ABB.[Final Channel]
FROM [MASTER CUSTOMER] AS MC
INNER JOIN [0_Abbott_customer_list_channel] AS ABB 
    ON MC.Kunnr = ABB.DCusID;

UPDATE [MASTER CUSTOMER]
SET Sub_Channel = 'Influvac', 
    Sub_Channel_Abbott = 'Influvac'
WHERE Kunnr LIKE '%\_1' ESCAPE '\';

UPDATE MC
SET MC.Sub_Channel = ABB.Sub_Channel_Abbott
FROM [MASTER CUSTOMER] AS MC
INNER JOIN [0_ABBOTT_DKSH_CUSTOMER_CHANNEL] AS ABB 
    ON MC.ChannelCode = ABB.ChannelCode
WHERE MC.Sub_Channel IS NULL;


UPDATE [MASTER CUSTOMER]
SET Sub_Channel = Sub_Channel_DKSH_Manually_changes
WHERE Sub_Channel_DKSH_Manually_changes IS NOT NULL;

UPDATE [MASTER CUSTOMER]
SET Abbott_sales = 0, 
    Rx_otc_Abbott_sales = 0;

UPDATE MC
SET MC.Abbott_sales = 1
FROM [MASTER CUSTOMER] AS MC
INNER JOIN DATA_TAKING_INVOICE_COMBINED_ABBOTT AS DTICA ON MC.Kunnr = DTICA.KUNNR 
INNER JOIN [MASTER PRODUCT] AS MP ON MP.ProductCode = DTICA.PRODUCT 
WHERE DTICA.DB_nhom = '0091';


UPDATE MC
SET MC.Rx_otc_Abbott_sales = 1
FROM [MASTER CUSTOMER] AS MC
INNER JOIN DATA_TAKING_INVOICE_COMBINED_ABBOTT AS DTICA 
    ON MC.Kunnr = DTICA.KUNNR
INNER JOIN [MASTER PRODUCT] AS MP 
    ON MP.ProductCode = DTICA.PRODUCT
WHERE DTICA.DB_nhom = '0091' 
    OR (DTICA.DB_nhom = 'LD' AND (MP.BSClass = 'Rx' OR MP.BSClass = 'OTC'));

-- Assuming YYYYMM is a variable that you have set earlier in your script.

UPDATE DTICA
SET DTICA.Organic_YTD = CASE WHEN MP.Organic_YTD = 'Yes' THEN 1 ELSE 0 END, 
    DTICA.Organic_MAT = CASE WHEN MP.Organic_MAT = 'Yes' THEN 1 ELSE 0 END
FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT AS DTICA
INNER JOIN [MASTER PRODUCT] AS MP 
    ON MP.ProductCode = DTICA.PRODUCT
WHERE DTICA.YYYYMM = @YYYYMM;


UPDATE DTICA
SET DTICA.Organic_YTD = 0,
    DTICA.Organic_MAT = 0  
FROM DATA_TAKING_INVOICE_COMBINED_ABBOTT AS DTICA
INNER JOIN [MASTER PRODUCT] AS MP ON DTICA.PRODUCT = MP.ProductCode 
INNER JOIN [MASTER CUSTOMER] AS MC ON DTICA.KUNNR_Org = MC.Kunnr
WHERE DTICA.YYYYMM = @YYYYMM 
    AND MC.ChannelMOM = 'Hospital' 
    AND MP.SUPPLIERGROUP = 'SANOFI AVENTIS';


---Check Gap 99_Daily vs Data Taking Invoice Abbott
DELETE FROM ABBOTT_TAKING_INVOICE;

INSERT INTO ABBOTT_TAKING_INVOICE(BILLINGDATE, Day_ddmmyyyy, [Billing Date], SumOfQTY, [SumOfSales Value])
SELECT 
    DTICA.BILLINGDATE, 
    DTICA.Day_ddmmyyyy, 
    SUBSTRING(CONVERT(VARCHAR(10), DTICA.BILLINGDATE), 5, 2) + '.' + 
    SUBSTRING(CONVERT(VARCHAR(10), DTICA.BILLINGDATE), 7, 2) + '.' + 
    SUBSTRING(CONVERT(VARCHAR(10), DTICA.BILLINGDATE), 1, 4) AS [Billing Date], 
    SUM(DTICA.QTY) AS SumOfQTY, 
    SUM(DTICA.[Sales Value]) AS [SumOfSales Value]
FROM 
    DATA_TAKING_INVOICE_COMBINED_ABBOTT AS DTICA
WHERE 
    DTICA.HEC_INCLUDE = 1
GROUP BY 
    DTICA.BILLINGDATE, 
    DTICA.Day_ddmmyyyy;

DELETE FROM [99_DAILY];

INSERT INTO [99_DAILY]([Calendar Year], [Calendar Month], [Billing Date], [SumOfNet sales])
SELECT 
    DDBI.[Calendar Year], 
    DDBI.[Calendar Month], 
    SUBSTRING(DDBI.[Billing Date], 4, 2) + '.' + 
    SUBSTRING(DDBI.[Billing Date], 1, 2) + '.' + 
    SUBSTRING(DDBI.[Billing Date], 7, 4) AS [Billing Date],
    SUM(DDBI.[Net sales]) AS [SumOfNet sales]
FROM 
    [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] AS DDBI
GROUP BY 
    DDBI.[Calendar Year], 
    DDBI.[Calendar Month], 
    DDBI.[Billing Date];


