﻿---- UPDTAE MASTER PRODUCT IF CSO_NAME = JANSSEN CSO then JOHNSON & JOHNSON
UPDATE [MASTER PRODUCT] SET [MASTER PRODUCT].CSO_Name = 'JOHNSON & JOHNSON'
WHERE ((([MASTER PRODUCT].BL)='CSO') AND (([MASTER PRODUCT].SupplierCode)='0337') AND (([MASTER PRODUCT].SUPPLIERGROUP)='JOHNSON & JOHNSON'));


UPDATE [MASTER PRODUCT_PRE] SET [MASTER PRODUCT_PRE].CSO_Name = 'JOHNSON & JOHNSON'
WHERE ((([MASTER PRODUCT_PRE].BL)='CSO') AND (([MASTER PRODUCT_PRE].SupplierCode)='0337') AND (([MASTER PRODUCT_PRE].SUPPLIERGROUP)='JOHNSON & JOHNSON'));



---Delete old data
DELETE FROM [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD]
WHERE
      [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month] =
          (
              SELECT DISTINCT [DAILY_SALE_DATA].[Calendar Month]
              FROM DAILY_SALE_DATA
          ) And
      [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year] =
          (
              SELECT DISTINCT [DAILY_SALE_DATA].[Calendar Year]
              FROM DAILY_SALE_DATA
          )


---Update new data
INSERT INTO [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] (
      [Business Line 1],
      Region,
      Organic_2023,
      Channels,
      [Calendar Month],
      [Calendar Year],
      [Billing Date],
      [GL IMS ATC 1],
      Client,
      [Client Code],
      [Net sales],
      BL,
      [BL Group],
      [BL Group New],
      FA_SName,
      FA_CLIENTS_NAME,
      Source,
      ReportGroup2_BU,
      CSO_Name,
      Sub_Channels,
      FA_INCLUDE,
      FA_Organic_YTD,
      CSO_INCLUDE,
      OB_Name,
	  Details_Channel)
  SELECT
      [MASTER PRODUCT].BL1,
      [MASTER CUSTOMER].Land,
      [MASTER PRODUCT].Organic_YTD,
      [MASTER CUSTOMER].ChannelMOM,
      [DAILY_SALE_DATA].[Calendar Month],
      [DAILY_SALE_DATA].[Calendar Year],
      [DAILY_SALE_DATA].[Billing Date],
      [MASTER PRODUCT].[ATC1 Description],
      [MASTER PRODUCT].SUPPLIERGROUP,
      [MASTER PRODUCT].SupplierCode,
      Sum([DAILY_SALE_DATA].TT) AS SumOfSumOfTT,
      [MASTER PRODUCT].BL, 
      [MASTER PRODUCT].[BL Group] ,
      [MASTER PRODUCT].[BL Group New],
      [MASTER PRODUCT].FA_SName,
      [MASTER PRODUCT].FA_CLIENTS_NAME,
      [DAILY_SALE_DATA].Source,
      [MASTER PRODUCT].ReportGroup2_BU,
      [MASTER PRODUCT].CSO_Name,
      [MASTER CUSTOMER].ChannelCO,
      [DAILY_SALE_DATA].FA_INCLUDE,
      [MASTER PRODUCT].FA_Organic_YTD,
      [DAILY_SALE_DATA].CSO_INCLUDE,
      [MASTER PRODUCT].OB_Name,
	  [MASTER CUSTOMER].DETAIL_CHANNEL
  FROM (DAILY_SALE_DATA
      INNER JOIN [MASTER CUSTOMER]
      ON [DAILY_SALE_DATA].KUNNR = [MASTER CUSTOMER].Kunnr)
      INNER JOIN [MASTER PRODUCT]
      ON [DAILY_SALE_DATA].PRODUCT = [MASTER PRODUCT].ProductCode
  WHERE DAILY_SALE_DATA.REASON = 'Sales'
  Group BY
      [MASTER PRODUCT].BL1,
      [MASTER CUSTOMER].Land,
      [MASTER PRODUCT].Organic_YTD,
      [MASTER CUSTOMER].ChannelMOM,
      [DAILY_SALE_DATA].[Calendar Month],
      [DAILY_SALE_DATA].[Calendar Year],
      [DAILY_SALE_DATA].[Billing Date],
      [MASTER PRODUCT].[ATC1 Description],
      [MASTER PRODUCT].SUPPLIERGROUP,
      [MASTER PRODUCT].SupplierCode,
      [DAILY_SALE_DATA].HEC_INCLUDE,
      [MASTER PRODUCT].BL,
      [MASTER PRODUCT].[BL Group],
      [MASTER PRODUCT].[BL Group New],
      [MASTER PRODUCT].FA_SName,
      [MASTER PRODUCT].FA_CLIENTS_NAME,
      [DAILY_SALE_DATA].Source,
      [MASTER PRODUCT].ReportGroup2_BU,
      [MASTER PRODUCT].CSO_Name,
      [MASTER CUSTOMER].ChannelCO,
      [DAILY_SALE_DATA].FA_Include,
      [MASTER PRODUCT].FA_Organic_YTD,
      [DAILY_SALE_DATA].CSO_INCLUDE,
      [MASTER PRODUCT].OB_Name,
	  [MASTER CUSTOMER].DETAIL_CHANNEL
  HAVING [DAILY_SALE_DATA].HEC_INCLUDE=1;


---Update HFM Country
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD]
  SET 
      [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[HFM Country] = 'Vietnam', 
      [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Country = 'VN'
  WHERE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[HFM Country] Is Null


---- Update Organic
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD]
  Set [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Organic_2023 = 'No'
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Organic_2023)='0'));


---ABBVIE (update organic)
--- UPDATE 99_DAILY_DATA_FOR_POWER_BI_DASHBOARD SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].BL = 'ALLIANCE 8', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[BL Group] = 'FA', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[BL Group New] = 'FA', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'ABBVIE', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'ABBVIE', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_INCLUDE = No, [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'No'
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].BL = 'ALLIANCE 8', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[BL Group] = 'FA', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[BL Group New] = 'FA', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_INCLUDE = 0, [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'No'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74'));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_INCLUDE =1
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])=2021) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>6));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_INCLUDE = 1
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])=2022) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>0));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_INCLUDE = 1
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])>=2023) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>0));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'Yes'
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])=2021) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>6));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'Yes'
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])=2022) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>0));


 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'Yes'
  WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Client Code])='0E74') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Year])>=2023) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[Calendar Month])>0));


----chi can set orgnic = non cho JANSSEN CILAG, qua thang 10 2022 moi review lai
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'Yes'
  WHERE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[FA_CLIENTS_NAME] ='JANSSEN CILAG';


---changed April 7, 2023 - JANSSEN CILAG - CSO, moi chuyen tu Jan 2023 chua thoa dk org
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'No'
  WHERE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[FA_CLIENTS_NAME] ='JANSSEN CILAG - CSO';


---changed April 7, 2023 - ACTAVIS - CSO, moi chuyen tu Jan 2023 chua thoa dk org
 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'No'
  WHERE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].[FA_CLIENTS_NAME] ='ACTAVIS - CSO';


---Xu ly Organic
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Organic_2023 = 'No', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_Organic_YTD = 'No'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Client)='SANOFI AVENTIS') AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].Channels)='Hospital'));


---Update MSD history 2023 to ORGANON

----MSD-I-DIPROSPAN Organon-I-DIPROSPAN
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-DIPROSPAN', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-DIPROSPAN'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-DIPROSPAN'));


---MSD-I-FOSAMAX   Organon-I-FOSAMAX
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-FOSAMAX', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-FOSAMAX'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-FOSAMAX'));


----MSD-I-IMPLANON NXT  Organon-I-IMPLANON NXT
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-IMPLANON NXT', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-IMPLANON NXT'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-IMPLANON NXT'));


----MSD-I-ORGAMETRIL    Organon-I-ORGAMETRIL
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-ORGAMETRIL', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-ORGAMETRIL'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-ORGAMETRIL'));


----MSD-I-REMERON   Organon-I-REMERON
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-REMERON', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-REMERON'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-REMERON'));


---MSD-I-ANDRIOL TESTOCAP  Organon-I-ANDRIOL TESTOCAP
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName = 'Organon-I-ANDRIOL TESTOCAP', [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME = 'Organon-I-ANDRIOL TESTOCAP'
 WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_SName)='MSD-I-ANDRIOL TESTOCAP'));


---update CSO

--UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].CSO_INCLUDE = 1
-- WHERE ((([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].CSO_Name) Is Not Null) AND (([99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].CSO_Name) Not Like 'BI CSO'));

 UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET FA_CLIENTS_NAME ='MAYOLY SPINDLER' WHERE FA_CLIENTS_NAME='IPSEN CHC'

 ---tu 2024: ABBVIE Botox gop chung Aesthetics
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME ='ABBVIE AESTHETICS'
WHERE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD].FA_CLIENTS_NAME='ABBVIE BOTOX' AND [Calendar Year] >= 2024

-----Update Fa_organic_YTD =No cho ELI LILLY 8 vì chuyển team từ AL1 sang AL8 từ tháng 10/2023

update [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] set FA_Organic_YTD ='No' where FA_CLIENTS_NAME ='ELI LILLY 8' and ([Calendar Month]>=10 and [Calendar Year]=2023)

update [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] set FA_Organic_YTD ='No' where FA_CLIENTS_NAME ='ELI LILLY 1' and ([Calendar Month]<10 and [Calendar Year]=2023)

update [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] set FA_Organic_YTD ='No' where FA_CLIENTS_NAME like 'JANSSEN CILAG%' and [Calendar Year]>=2023 ---cho lớn hơn 2023 vì để tính organic pre của AL8---


--- TỪ THÁNG 12/2023 TRỞ VỀ TRƯỚC THÌ J&J THUỘC AL8

update [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] set FA_CLIENTS_NAME ='JANSSEN CILAG - FA 8' where FA_CLIENTS_NAME ='JANSSEN CILAG - FA 1' and ([Calendar Month]<=12 and [Calendar Year]<=2023)

update [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] set FA_CLIENTS_NAME ='JANSSEN CILAG - CSO 8' where FA_CLIENTS_NAME ='JANSSEN CILAG - CSO 1' and ([Calendar Month]<=12 and [Calendar Year]<=2023)

--update BL, Fa_client_names cho hãng MAYLOY vì chuyển team từ AL3 sang AL8

UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET BL ='ALLIANCE 3', FA_CLIENTS_NAME ='MAYOLY SPINDLER 3'
WHERE FA_CLIENTS_NAME ='MAYOLY SPINDLER' AND ([Calendar Year] <2024 or ([Calendar Year]=2024 and [Calendar Month]<=6))


----từ 1/7/2024, Galderma nhóm Cetaphil (Cx) và nhóm Restylene(Ax) không còn tính sale cho AL vì đã chuyển qua 4PL

UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET FA_INCLUDE=0, FA_Organic_YTD=0 
WHERE FA_CLIENTS_NAME NOT LIKE 'GALDERMA Rx' AND [Client Code]='0330' AND ([Calendar Year] >2024 or ([Calendar Year]=2024 and [Calendar Month]>=7))

UPDATE [2022_DAILY] SET FA_INCLUDE =0
FROM [2022_DAILY] A JOIN [MASTER PRODUCT] B ON A.PRODUCT = B.ProductCode 
WHERE B.SupplierCode ='0330' AND B.FA_CLIENTS_NAME NOT LIKE 'GALDERMA Rx' AND A.YYYYMM>=202407

-- tháng 7/2024 có Reconcile L'Oreal CSMO Jul2024 nên update cso name theo cso include
UPDATE [99_DAILY_DATA_FOR_POWER_BI_DASHBOARD] SET CSO_Name='L''OREAL-CSO' WHERE Client ='L''OREAL' AND CSO_INCLUDE=1