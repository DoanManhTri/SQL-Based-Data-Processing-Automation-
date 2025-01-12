﻿---STEP 6----

--Correct text in channelCO
UPDATE [MASTER CUSTOMER] SET [ChannelCO] = 'HOSP.COVN STORE'  WHERE [ChannelCode] = 'HL';


UPDATE [MASTER CUSTOMER]
SET [ChannelCO] = 'WHOLESALER-PHARMACY'
WHERE [ChannelCode] = 'W7';


--UPCASE CHANNEL CO
UPDATE [MASTER CUSTOMER] SET [ChannelCO] = 'BEAUTY STORE' WHERE [ChannelCode] = 'B2';


UPDATE [MASTER CUSTOMER]  SET [ChannelCO] = 'CHINESE MEDICAL HALL' WHERE [ChannelCode] = 'C6';


UPDATE [MASTER CUSTOMER]  SET [ChannelCO] = 'ELECTRICAL SHOP' WHERE [ChannelCode] = 'E2';


UPDATE [MASTER CUSTOMER]  SET [ChannelCO] = 'GOVT. DEPT.' WHERE [ChannelCode] = 'G5';


UPDATE [MASTER CUSTOMER]  SET [ChannelCO] = 'GENERAL DISTRIBUTOR' WHERE [ChannelCode] = 'G8';


UPDATE [MASTER CUSTOMER]  SET [ChannelCO] = 'SOCIETY/FOUNDT/ASSCT' WHERE [ChannelCode] = 'S3';

UPDATE [MASTER CUSTOMER]  
SET [HospitalGroup] = 'Non-Hospital';


UPDATE [MASTER CUSTOMER]  
SET [HospitalGroup] = 'Hospital Pharmacy' 
WHERE 
    [ChannelCode] = 'B6' OR 
    [ChannelCode] = 'D4' OR 
    [ChannelCode] = 'H9' OR 
    [ChannelCode] = 'HL' OR 
    [ChannelCode] = 'MG';


UPDATE [MASTER CUSTOMER]  
SET [HospitalGroup] = 'Pharmaceutical Department' 
WHERE 
    [ChannelCode] = 'G2' OR 
    [ChannelCode] = 'G3' OR 
    [ChannelCode] = 'HA' OR 
    [ChannelCode] = 'P8';


--MG - MEDICAL DEVICE SHOP should be Non-Hospital
UPDATE [MASTER CUSTOMER]  
SET [HospitalGroup] = 'Non-Hospital' 
WHERE [ChannelMOM] = 'Others';


--CHANGE Please adjust South into South East
UPDATE [MASTER CUSTOMER]  
 SET [Land] = 'SOUTHEAST' WHERE [Land] = 'South';


UPDATE [MASTER CUSTOMER]  
 SET [channelDB] = [ChannelMOM];


--set Diagnostics for DENTAL SURGERY, LABORATORY, MEDICAL DEVICE CO., MEDICAL DEVICE SHOP
UPDATE [MASTER CUSTOMER]  
SET [channelDB] = 'Diagnostics' 
WHERE 
    [ChannelCO] = 'DENTAL SURGERY' or 
    [ChannelCO] = 'LABORATORY' or 
    [ChannelCO] = 'MEDICAL DEVICE CO.' or 
    [ChannelCO] = 'MEDICAL DEVICE SHOP';


--DUY - ADDED DEC 3, 2019
--UPDATE OMNI-CLASS 2019
UPDATE [MASTER CUSTOMER]  
 SET [Omni-Class] = Null;


UPDATE [0_Customer_class_2021] 
SET [0_Customer_class_2021].[Class] = [MASTER CUSTOMER].[Omni-Class]
FROM [0_Customer_class_2021] 
INNER JOIN [MASTER CUSTOMER] ON [0_Customer_class_2021].CustCode = [MASTER CUSTOMER].Kunnr 


--UPDATE OMNI-CLASS TO D If it is null
UPDATE [MASTER CUSTOMER]  
 SET [Omni-Class] = 'D' 
 WHERE 
    [Omni-Class] IS NULL AND 
    [ChannelMOM] Not like 'Hospital';


--UPDATE OMNI-CLASS TO Null for Hospital
UPDATE [MASTER CUSTOMER]  
SET [Omni-Class] = Null 
WHERE [ChannelMOM] like 'Hospital';


--UPDATE Land HCMC => HCMCT
Update [MASTER CUSTOMER]
 SET [MASTER CUSTOMER].Land = 'HCMCT'
 WHERE [MASTER CUSTOMER].Land = 'HCMC'


--UPDATE ATC
UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].[ATC1 Description] = [ATC_DES].[ATC1 Desc]
FROM [MASTER PRODUCT]
INNER JOIN ATC_DES ON [MASTER PRODUCT].ATC1 = ATC_DES.ATC1 

---UPDATE BL1
UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].BL1 = [Business Line 1].[BL1]
FROM [MASTER PRODUCT] 
INNER JOIN [Business Line 1] ON [MASTER PRODUCT].BSClass = [Business Line 1].BSClass

---UPDATE BRAND NAME FROM PRODUCT TO MASTER PRODUCT
UPDATE Product 
SET  [Product].[Brand]= [MASTER PRODUCT].BrandName
FROM Product
INNER JOIN [MASTER PRODUCT] 
ON Product.ProductID = [MASTER PRODUCT].ProductCode 
WHERE 
     [MASTER PRODUCT].BrandName Is Null Or 
     [MASTER PRODUCT].BrandName = '';


---UPDATE BSCLASS - TAM THOI MODIFY, CUOI THANG CHECK LAI
UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].BSClass = [0_SUPPLIER_GROU_BSCLASS].BSClass 
FROM [MASTER PRODUCT] 
INNER JOIN [0_SUPPLIER_GROU_BSCLASS] ON [MASTER PRODUCT].SUPPLIERGROUP = [0_SUPPLIER_GROU_BSCLASS].SUPPLIERGROUP
WHERE [MASTER PRODUCT].BSClass is null

---UPDATE BRAND_SUP_BSCALSS FOR NEW PRODUCT
UPDATE [MASTER PRODUCT] 
 SET 
    [MASTER PRODUCT].BRAND_SUPPLIERGROUP_CLASS = [MASTER PRODUCT].[BrandName] + [MASTER PRODUCT].[SUPPLIERGROUP] + [MASTER PRODUCT].[BSClass]
 WHERE 
     [MASTER PRODUCT].BRAND_SUPPLIERGROUP_CLASS Is Null Or 
     [MASTER PRODUCT].BRAND_SUPPLIERGROUP_CLASS = '';


--- Update BSClass to Promotion of [MASTER PRODUCT]
UPDATE [MASTER PRODUCT]
 Set [MASTER PRODUCT].BSClass = 'Promotion'
 FROM [MASTER PRODUCT] 
 INNER JOIN [New product] ON [New product].PRODUCT = [MASTER PRODUCT].ProductCode
 WHERE LEFT([MASTER PRODUCT].ProductCode,1) = 2 ;


-- Update BSClass to Promotion of [MASTER PRODUCT]'cau nay co the bo
UPDATE [MASTER PRODUCT]
 Set [MASTER PRODUCT].BSClass = 'Promotion'
 WHERE LEFT([MASTER PRODUCT].ProductCode,1) = 2 ;


---UPDATE YTD_ORGANIC FOR NEW PRODUCT
DELETE FROM [0_ORGANIC_YTD_BY_BRAND];


INSERT INTO [0_ORGANIC_YTD_BY_BRAND] ( BRAND_SUPPLIERGROUP_CLASS, Organic_YTD )
 SELECT 
     [MASTER PRODUCT_PRE].BRAND_SUPPLIERGROUP_CLASS, 
     [MASTER PRODUCT_PRE].Organic_YTD
 FROM [MASTER PRODUCT_PRE]
 GROUP BY 
     [MASTER PRODUCT_PRE].BRAND_SUPPLIERGROUP_CLASS, 
     [MASTER PRODUCT_PRE].Organic_YTD;


UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].Organic_YTD = [0_ORGANIC_YTD_BY_BRAND].[Organic_YTD]
FROM [MASTER PRODUCT] 
INNER JOIN [0_ORGANIC_YTD_BY_BRAND] ON [MASTER PRODUCT].BRAND_SUPPLIERGROUP_CLASS = [0_ORGANIC_YTD_BY_BRAND].BRAND_SUPPLIERGROUP_CLASS
WHERE [MASTER PRODUCT].Organic_YTD Is Null ;


UPDATE [MASTER PRODUCT] 
 SET [MASTER PRODUCT].Organic_YTD = 0
 WHERE [MASTER PRODUCT].Organic_YTD Is Null;


---Update ATC3 - Medical Device
UPDATE [MASTER PRODUCT]
 SET
     ATC1 = 'X'
 WHERE BSClass = 'Diag'

--- Update ATC3 - Medical Device
Update [MASTER PRODUCT]
 SET
     ATC2 = 'X01',
     ATC3 = 'X01A',
     ATC4 = 'X01A0'
 WHERE ATC1 = 'X'

UPDATE [DAILY_SALE_DATA] SET [HEC_INCLUDE] = 1 ;

--TAM THOI LAY THEO SALEMAN CODE 20003231 Or 20050047 VÀ I2, SAU NAY REVIEW UPDATE LAI CHI LAY THEO SALE MAN CODE

UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.HEC_INCLUDE = 0
FROM [MASTER CUSTOMER] INNER JOIN DAILY_SALE_DATA ON [MASTER CUSTOMER].Kunnr = DAILY_SALE_DATA.KUNNR 
WHERE ((([MASTER CUSTOMER].ChannelCode)='I2') AND ((DAILY_SALE_DATA.PERNR)='20003231' Or (DAILY_SALE_DATA.PERNR)='20050047'));


---XU LY SALES CUA ROCHE DIAG QUA VIME
--ClientCode=0143 AND CustomerCode=121075660
UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.HEC_INCLUDE = 0
WHERE (((DAILY_SALE_DATA.PRINCIPALCODE)='0143') AND ((DAILY_SALE_DATA.KUNNR)='121075660'));



---BI FIE Overflow Storage Service
UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.HEC_INCLUDE = 0
WHERE (((DAILY_SALE_DATA.PRODUCT)='101183237' Or (DAILY_SALE_DATA.PRODUCT)='101183240'));



---Clientcode 0091 and CustomerCode 121009588 and Salesman 20003231 loai tru tu 2023
UPDATE DAILY_SALE_DATA SET DAILY_SALE_DATA.HEC_INCLUDE = 0
WHERE (((DAILY_SALE_DATA.KUNNR)='121009588' AND (DAILY_SALE_DATA.PERNR)='20003231' AND (DAILY_SALE_DATA.PRINCIPALCODE)='0091'));

---set BL New, BL GROUP New, FA_SName, FA_CLIENTS_NAMES

UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].[BL New] = [MASTER PRODUCT].[BL]


UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].[BL Group New] = [MASTER PRODUCT].[BL Group]


UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].[FA_SName] = [MASTER PRODUCT].[SUPPLIERGROUP]
WHERE [MASTER PRODUCT].[BL Group] = 'FA';


 -------------- CHECK -------------
UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_CLIENTS_NAME = [MASTER PRODUCT].[FA_SName];


-----INOVA
UPDATE [MASTER PRODUCT] 
SET 
    [MASTER PRODUCT].FA_SName = 'INOVA', 
    [MASTER PRODUCT].FA_CLIENTS_NAME = 'INOVA'
WHERE [MASTER PRODUCT].SUPPLIERGROUP='INOVA';


----ALCON SURGICAL
UPDATE [MASTER PRODUCT] 
SET 
    [MASTER PRODUCT].SUPPLIERGROUP = 'ALCON SURGICAL', 
    [MASTER PRODUCT].FA_CLIENTS_NAME = 'ALCON SURGICAL' 
WHERE [MASTER PRODUCT].BSClass = 'Diag' And [MASTER PRODUCT].SupplierCode = '0303';


----ALCON SURGICAL
UPDATE [MASTER PRODUCT] 
SET 
    [MASTER PRODUCT].SUPPLIERGROUP = 'ALCON SURGICAL' 
WHERE [MASTER PRODUCT].BSClass = 'Diag' And [MASTER PRODUCT].SupplierCode = '0303';


UPDATE [MASTER PRODUCT] 
SET 
    [MASTER PRODUCT].SupplierCode = 'M303' 
WHERE [MASTER PRODUCT].SUPPLIERGROUP = 'ALCON SURGICAL' ;



----ALCON DEOH
UPDATE [MASTER PRODUCT] 
SET 
    [MASTER PRODUCT].FA_SName = 'ALCON DEOH', 
    [MASTER PRODUCT].FA_CLIENTS_NAME = 'ALCON DEOH'
WHERE [MASTER PRODUCT].SUPPLIERGROUP='ALCON';


----ROCHE
UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].FA_SName = 'ROCHE - Outsourcing', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'ROCHE - Outsourcing'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP='F. HOFFMANN-LA ROCHE' AND 
     [MASTER PRODUCT].BL Like 'ALLIANCE*';


UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].FA_SName = 'ROCHE-Rocephin', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'ROCHE-Rocephin'
 WHERE 
     [MASTER PRODUCT].SUPPLIERGROUP='F. HOFFMANN-LA ROCHE' AND 
     [MASTER PRODUCT].BrandName Like 'Rocephin';


----0H64 - JGL
UPDATE [MASTER PRODUCT] SET 
     [MASTER PRODUCT].FA_SName = 'JGL', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'JGL'
 WHERE [MASTER PRODUCT].SupplierCode='0H64';


UPDATE [MASTER PRODUCT]     
SET [MASTER PRODUCT].FA_CLIENTS_NAME = [FA_CLIENT_BREAK_BY_BRAND].[Clients]
FROM [MASTER PRODUCT]
INNER JOIN FA_CLIENT_BREAK_BY_BRAND ON [MASTER PRODUCT].BrandName = FA_CLIENT_BREAK_BY_BRAND.BrandName 


UPDATE [MASTER PRODUCT] 
 SET [MASTER PRODUCT].FA_CLIENTS_NAME = 'BMS'
 WHERE [MASTER PRODUCT].FA_CLIENTS_NAME='BRISTOL-MYERS SQUIBB';


---Baxter HP
UPDATE [MASTER PRODUCT]     
SET 
     [MASTER PRODUCT].[BL New] = 'ALLIANCE 1',
     [MASTER PRODUCT].[BL Group New] = 'FA', 
     [MASTER PRODUCT].FA_SName = 'Baxter - HP', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'Baxter - HP'
FROM [MASTER PRODUCT] 
INNER JOIN [0_Baxter_HP_AL1] ON [MASTER PRODUCT].ProductCode = [0_Baxter_HP_AL1].[Product Code]

---Actavis - SUDOCREM
UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].[BL New] = 'ALLIANCE 1', 
     [MASTER PRODUCT].[BL Group New] = 'FA', 
     [MASTER PRODUCT].FA_SName = 'ACTAVIS - SUDOCREM', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'ACTAVIS - SUDOCREM'
 WHERE [MASTER PRODUCT].BrandName = 'SUDOCREM';


---Actavis - CSO
UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].[BL New] = 'ALLIANCE 1', 
     [MASTER PRODUCT].[BL Group New] = 'FA', 
     [MASTER PRODUCT].FA_SName = 'ACTAVIS - CSO', 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'ACTAVIS - CSO'
 WHERE [MASTER PRODUCT].BrandName Not like 'SUDOCREM' AND [MASTER PRODUCT].[SUPPLIERGROUP] like 'ACTAVIS' ;



----CEREBOS HEC - 0018 (NOT BELONG TO HEC)
UPDATE [MASTER PRODUCT] 
 SET [MASTER PRODUCT].[BL Group New] = 'Out_Stop'
 WHERE [MASTER PRODUCT].SupplierCode = '0018';


----0129     MADAUS
UPDATE [MASTER PRODUCT] 
 SET [MASTER PRODUCT].[BL Group New] = 'Out_Stop'
 WHERE [MASTER PRODUCT].SupplierCode = '0129';


--'0H64 - JGL
--'UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].[BL Group New] = 'Out_Stop'
--' WHERE [MASTER PRODUCT].SupplierCode = '0H64';
--'

UPDATE [MASTER PRODUCT] 
SET 
     [MASTER PRODUCT].FA_SName = Null, 
     [MASTER PRODUCT].FA_CLIENTS_NAME = Null
WHERE [MASTER PRODUCT].[BL Group New] Not Like 'FA';



---OWN BRAND
UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].FA_CLIENTS_NAME = [MASTER PRODUCT].SUPPLIERGROUP
 WHERE 
     [MASTER PRODUCT].SUPPLIERGROUP='MEDINOVA AG' Or 
     [MASTER PRODUCT].SUPPLIERGROUP='UNITED DRUG';


-----------------2023 update SUPPLIERGROUP FROM --MERCK SHARP & DOHME-- TO --ORGANON--
--- MSD IVF
UPDATE [MASTER PRODUCT] 
 SET 
     [MASTER PRODUCT].FA_CLIENTS_NAME = 'Organon IVF'
 WHERE 
     [MASTER PRODUCT].SUPPLIERGROUP ='ORGANON' AND 
     ([MASTER PRODUCT].ProductName Like '*Elonva*' Or
     [MASTER PRODUCT].ProductName Like '*Orgalutran*' Or
     [MASTER PRODUCT].ProductName Like '*Puregon*Cartridge*' Or
     [MASTER PRODUCT].ProductName Like '*Puregon*Vial*');


--- OLDER NAME ---- MSD-I-ANDRIOL TESTOCAP
--- NEW NAME 2023---- Organon-I-ANDRIOL TESTOCAP
Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-ANDRIOL TESTOCAP'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'ANDRIOL TESTOCAP'


---- OLDER NAME ---- MSD-I-ORGAMETRIL
--- NEW NAME 2023---- Organon-I-ORGAMETRIL
Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-ORGAMETRIL'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'ORGAMETRIL'


-- OLDER NAME ---- MSD-I-IMPLANON NXT
--- NEW NAME 2023---- Organon-I-IMPLANON NXT

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-IMPLANON NXT'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'IMPLANON NXT'


 ---OLDER NAME ---- MSD-I-DIPROSPAN
--- NEW NAME 2023---- Organon-I-DIPROSPAN

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-DIPROSPAN'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'DIPROSPAN'

--- OLDER NAME ---- MSD-I-FOSAMAX
--- NEW NAME 2023---- Organon-I-FOSAMAX

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-FOSAMAX'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'FOSAMAX'


--- OLDER NAME ---- MSD-I-REMERON
--- NEW NAME 2023---- Organon-I-REMERON

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-I-REMERON'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'REMERON'


--- OLDER NAME ---- MSD-II-AERIUS
--- NEW NAME 2023---- Organon-II-AERIUS

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-AERIUS'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'AERIUS'


--- OLDER NAME ---- MSD-II-SINGULAIR
---- NEW NAME 2023---- Organon-II-SINGULAIR

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-SINGULAIR'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'SINGULAIR'


--- OLDER NAME ---- MSD-II-COZAAR XQ
----NEW NAME 2023---- Organon-II-COZAAR XQ

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-COZAAR XQ'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'COZAAR XQ'


---- OLDER NAME ---- MSD-II-COZAAR
---- NEW NAME 2023---- Organon-II-COZAAR

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-COZAAR'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'COZAAR'


--- OLDER NAME ---- MSD-II-HYZAAR
---- NEW NAME 2023---- Organon-II-HYZAAR

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-HYZAAR'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'HYZAAR'


--- OLDER NAME ---- MSD-IVF-ELONVA
--- NEW NAME 2023---- Organon-IVF-ELONVA

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-IVF-ELONVA'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'ELONVA'


---- OLDER NAME ---- MSD-IVF-ORGALUTRAN
---- NEW NAME 2023---- Organon-IVF-ORGALUTRAN

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-IVF-ORGALUTRAN'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'ORGALUTRAN'


--- OLDER NAME ---- MSD-IVF-PUREGON
--- NEW NAME 2023---- Organon-IVF-PUREGON

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-IVF-PUREGON'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'PUREGON'


--- OLDER NAME ---- MSD-II-RENITEC
--- NEW NAME 2023---- Organon-II-RENITEC

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-RENITEC'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'RENITEC'


---- NEW NAME 2023---- Organon-II-ATOZET

Update [MASTER PRODUCT]
 SET [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Organon-II-ATOZET'
 WHERE
     [MASTER PRODUCT].SUPPLIERGROUP = 'ORGANON' And
     [MASTER PRODUCT].BrandName = 'ATOZET'

--NVS_Clau lu
UPDATE [MASTER PRODUCT] 
SET 
[MASTER PRODUCT].[BL New] = 'ALLIANCE 3',
[MASTER PRODUCT].[BL Group New] = 'FA', 
[MASTER PRODUCT].FA_SName = 'NOVARTIS Glau-Lu', 
[MASTER PRODUCT].FA_CLIENTS_NAME = 'NOVARTIS Glau-Lu'
FROM [MASTER PRODUCT]
INNER JOIN [0_NVS_Clau_Lu_AL1] 
ON [MASTER PRODUCT].ProductCode = [0_NVS_Clau_Lu_AL1].[Product Code]



---GALDERMA
UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_CLIENTS_NAME = 'GALDERMA Ax'
  WHERE ((([MASTER PRODUCT].SupplierCode)='0330') AND (([MASTER PRODUCT].BrandName) Like 'RESTYLANE'));


UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_CLIENTS_NAME = 'GALDERMA Cx'
  WHERE ((([MASTER PRODUCT].SupplierCode)='0330') AND (([MASTER PRODUCT].BrandName) Like 'CETAPHIL%'));


UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_CLIENTS_NAME = 'GALDERMA Rx'
  WHERE ((([MASTER PRODUCT].SupplierCode)='0330') AND (([MASTER PRODUCT].BrandName) Like 'DIFFERIN' Or ([MASTER PRODUCT].BrandName) Like 'EPIDUO'));

UPDATE [MASTER PRODUCT] SET BL='4PL', [BL Group]='4PL', [BL New]='4PL', [BL Group New]='4PL' WHERE FA_CLIENTS_NAME IN ('GALDERMA Ax', 'GALDERMA Cx')

---MsgBox done. update BL NEW, FA NAME

----set FA_INCLUDE to HEC_INCLUDE
UPDATE DAILY_SALE_DATA 
  SET DAILY_SALE_DATA.FA_INCLUDE = [DAILY_SALE_DATA].[HEC_INCLUDE];


----Do not count ADC PHARMA, VIFOR, JGL
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.FA_INCLUDE = 0
FROM DAILY_SALE_DATA
INNER JOIN [MASTER PRODUCT] 
ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode 
WHERE 
[MASTER PRODUCT].FA_CLIENTS_NAME='ADC PHARMA' Or 
[MASTER PRODUCT].FA_CLIENTS_NAME='VIFOR' Or 
[MASTER PRODUCT].FA_CLIENTS_NAME='JGL';



---Ipsen SC: không tính s? sales c?a account “121009588 CONG TY CO PHAN DUOC LIEU TRUNG UONG 2”
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.FA_INCLUDE = 0
FROM DAILY_SALE_DATA 
INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode 
INNER JOIN [MASTER CUSTOMER] 
ON 
    ([MASTER CUSTOMER].Kunnr = DAILY_SALE_DATA.KUNNR) AND 
    (DAILY_SALE_DATA.KUNNR = [MASTER CUSTOMER].Kunnr) 
 WHERE 
[MASTER PRODUCT].FA_CLIENTS_NAME='IPSEN SC' AND 
[MASTER CUSTOMER].Kunnr='121009588';


---MSD-IVF: COMMING SOON

---Omron: tính sales Inter-company, không tính Public E Marketplace.
UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.FA_INCLUDE = 0
FROM DAILY_SALE_DATA
INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode
INNER JOIN [MASTER CUSTOMER] ON DAILY_SALE_DATA.KUNNR = [MASTER CUSTOMER].Kunnr 
WHERE 
[MASTER PRODUCT].FA_CLIENTS_NAME='OMRON HEALTHCARE' AND 
[MASTER CUSTOMER].ChannelCode='P0';


--- từ 1/7/2024, Galderma nhóm Cetaphil (Cx) và nhóm Restylene(Ax) không còn tính sale cho AL vì đã chuyển qua 4PL

UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.FA_INCLUDE = 0
FROM DAILY_SALE_DATA
INNER JOIN [MASTER PRODUCT] 
ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode 
WHERE 
[MASTER PRODUCT].FA_CLIENTS_NAME not like 'GALDERMA Rx' AND [MASTER PRODUCT].SupplierCode='0330'

--- từ 1/7/2024, mayoly còn còn thuộc AL

UPDATE DAILY_SALE_DATA 
SET DAILY_SALE_DATA.FA_INCLUDE = 0
FROM DAILY_SALE_DATA
INNER JOIN [MASTER PRODUCT] 
ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode 
WHERE 
[MASTER PRODUCT].FA_CLIENTS_NAME like 'MAYOLY SPINDLER'

---MsgBox Done. FA include

---MOT SO HANG CHUYEN TU 3/4PL SANG FULL ALLICANCE CHUA DU DIEN KIEN TINH ORGANIC - MOI THANG PHAI REVIEW
UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].FA_Organic_YTD = [MASTER PRODUCT].[Organic_YTD], 
[MASTER PRODUCT].FA_Organic_MAT = [MASTER PRODUCT].[Organic_MAT];


UPDATE [MASTER PRODUCT] 
 SET 
[MASTER PRODUCT].FA_Organic_YTD = 'No', 
[MASTER PRODUCT].FA_Organic_MAT = 'No'
  WHERE [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'ACTAVIS - SUDOCREM';


UPDATE [MASTER PRODUCT] 
  SET 
[MASTER PRODUCT].FA_Organic_YTD = 'No', 
[MASTER PRODUCT].FA_Organic_MAT = 'No'
  WHERE [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'Baxter - HP';


UPDATE [MASTER PRODUCT] 
  SET 
[MASTER PRODUCT].FA_Organic_YTD = 'No', 
[MASTER PRODUCT].FA_Organic_MAT = 'No'
  WHERE [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'BMS';


----ABBVIE
UPDATE [MASTER PRODUCT] 
  SET [MASTER PRODUCT].BL = 'ALLIANCE 8', [MASTER PRODUCT].[BL Group] = 'FA', 
  [MASTER PRODUCT].[BL New] = 'ALLIANCE 8', [MASTER PRODUCT].[BL Group New] = 'FA',
  [MASTER PRODUCT].FA_2021_Include = 'ALLIANCE 8', [MASTER PRODUCT].FA_Organic_YTD = 'No', 
  [MASTER PRODUCT].FA_Organic_MAT = 'No'
  WHERE ((([MASTER PRODUCT].SupplierCode)='0E74'));


UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_SName = 'ABBVIE AESTHETICS', [MASTER PRODUCT].FA_CLIENTS_NAME = 'ABBVIE AESTHETICS'
  WHERE ((([MASTER PRODUCT].BrandName)='JUVEDERM' or ([MASTER PRODUCT].BrandName)='COOLSCLUPTING') AND (([MASTER PRODUCT].SUPPLIERGROUP)='ABBVIE PHARMA.'));



UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_SName = 'ABBVIE BOTOX', [MASTER PRODUCT].FA_CLIENTS_NAME = 'ABBVIE BOTOX'
  WHERE ((([MASTER PRODUCT].BrandName)='BOTOX') AND (([MASTER PRODUCT].SUPPLIERGROUP)='ABBVIE PHARMA.'));


UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].FA_SName = 'ABBVIE EYE CARE', [MASTER PRODUCT].FA_CLIENTS_NAME = 'ABBVIE EYE CARE'
  WHERE ((([MASTER PRODUCT].BrandName) Not In ('JUVEDERM','COOLSCLUPTING','BOTOX')) AND (([MASTER PRODUCT].SUPPLIERGROUP)='ABBVIE PHARMA.'));

----Tách group cho INOVA betadine

UPDATE [MASTER PRODUCT]
SET FA_CLIENTS_NAME='INOVA Betadine', FA_SName='INOVA Betadine'
WHERE SUPPLIERGROUP='INOVA' AND BrandName LIKE '%betadine%'


----JANSSEN CILAG
UPDATE [MASTER PRODUCT] 
  SET 
[MASTER PRODUCT].FA_Organic_YTD = 'No', 
[MASTER PRODUCT].FA_Organic_MAT = 'No'
  WHERE [MASTER PRODUCT].[FA_CLIENTS_NAME] = 'JANSSEN CILAG';



----MsgBox Done.FA ORGANIC

 --------- TRADE GROUP ------


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = [MASTER CUSTOMER].[ChannelDB];


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = [MASTER CUSTOMER].[Omni_Chain Group]
  WHERE ((([MASTER CUSTOMER].[Omni_Chain Group])='Modern Chain')) OR ((([MASTER CUSTOMER].[Omni_Chain Group])='Traditional Chain'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Others'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='C6'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Beauty Store'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='B2'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Beauty Store'
  WHERE ((([MASTER CUSTOMER].[Omni_Chain Group])='Health & Beauty'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Super_Hyper Market'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='S6' Or ([MASTER CUSTOMER].ChannelCode)='H6'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'CVS_Mini Market'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='M3' Or ([MASTER CUSTOMER].ChannelCode)='CO'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'E-commerce'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='P0'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'E-commerce'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='E0'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'E-commerce'
  WHERE ((([MASTER CUSTOMER].Kunnr)='121094126' Or ([MASTER CUSTOMER].Kunnr)='121095837' Or ([MASTER CUSTOMER].Kunnr)='121101736' Or ([MASTER CUSTOMER].Kunnr)='121104273' Or ([MASTER CUSTOMER].Kunnr)='121104976'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Grocery Store'
  WHERE ((([MASTER CUSTOMER].ChannelCode)='G4'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = 'Traditional Pharmacy'
  WHERE ((([MASTER CUSTOMER].TradeGROUP)='Pharmacy'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].TradeGROUP = Null
  WHERE ((([MASTER CUSTOMER].TradeGROUP)='Hospital'));


---MsgBox Done update TradeGroup

UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].Online_vs_Offline = 'Offline'


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].Online_vs_Offline = 'Online'
  WHERE ((([MASTER CUSTOMER].TradeGROUP)='E-commerce'));


UPDATE [MASTER CUSTOMER] SET [MASTER CUSTOMER].Online_vs_Offline = Null
  WHERE ((([MASTER CUSTOMER].TradeGROUP) is Null));


--'''''CSO''''''''
--''''' UPDATE CSO NAME FOR STADA ''''''

UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].CSO_Name = 'STADA'
  WHERE ((([MASTER PRODUCT].SUPPLIERGROUP)='STADA') AND (([MASTER PRODUCT].CSO_Name) Is Null) AND (([MASTER PRODUCT].BL)='CSO'));

  UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].OB_Name = [MASTER PRODUCT].BrandName
  WHERE [BL Group] ='own brand' and OB_Name is null

UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].CM_Brand = [MASTER PRODUCT].BrandName
WHERE [MASTER PRODUCT].CM_Brand IS NULL


----OB_Name và OB_Group
UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].OB_Name = [MASTER PRODUCT].[BrandName]
WHERE (([MASTER PRODUCT].[BL Group]='OWN BRAND') AND (([MASTER PRODUCT].OB_Name) Is Null));


UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].OB_Group = 'OB_CSC'
WHERE (([MASTER PRODUCT].[OB_Name] Not Like 'FLUOMIZIN' And [MASTER PRODUCT].[OB_Name] Not Like 'GYNOFLOR')AND [MASTER PRODUCT].[BL Group]='OWN BRAND');

UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].OB_Group = 'OB_Women health'
WHERE (([MASTER PRODUCT].[OB_Name] Like 'FLUOMIZIN' or [MASTER PRODUCT].[OB_Name] Like 'GYNOFLOR')AND [MASTER PRODUCT].[BL Group]='OWN BRAND');

---Eli lilly chuyen qua AL8
update [MASTER PRODUCT] set FA_SName ='ELI LILLY 8', FA_CLIENTS_NAME='ELI LILLY 8' where SUPPLIERGROUP ='ELI LILLY'


-------Process cho cột Clients_Name Trên DAILY_SALE_DATA
update DAILY_SALE_DATA
set Clients_Name = null


update A 
set A.Clients_Name = b.FA_CLIENTS_NAME
from DAILY_SALE_DATA A join [MASTER PRODUCT] B on A.PRODUCT =B.ProductCode
where b.FA_CLIENTS_NAME is not null and A.FA_INCLUDE=1 and A.Clients_Name is null

update A
set A.Clients_Name =B.CSO_Name
from DAILY_SALE_DATA A join [MASTER PRODUCT] B on A.PRODUCT =B.ProductCode
where B.CSO_Name is not null and A.CSO_INCLUDE=1 and A.Clients_Name is null

update A
set A.Clients_Name =B.OB_NAME
from DAILY_SALE_DATA A join [MASTER PRODUCT] B on A.PRODUCT =B.ProductCode
where B.OB_NAME is not null  and A.Clients_Name is null

update DAILY_SALE_DATA
set Clients_Name = SUPPLIERGROUP
FROM DAILY_SALE_DATA A JOIN [MASTER PRODUCT] B ON A.PRODUCT =B.ProductCode
WHERE BD_request_BusinessModel='4PL' OR (A.CSO_Name='BI CSO' AND CSO_INCLUDE=0)

UPDATE A
SET A.MAT_Group4= B.Mat_Group4
FROM [MASTER PRODUCT] A JOIN DBWH_BIHEC.dbo.M_Product_Grp B on A.ProductCode collate Latin1_General_CI_AI =B.ProductID

UPDATE A
SET A.ListPrice= B.ListPrice
FROM [MASTER PRODUCT] A JOIN DBWH_BIHEC.dbo.M_Product_Grp B on A.ProductCode collate Latin1_General_CI_AI =B.ProductID