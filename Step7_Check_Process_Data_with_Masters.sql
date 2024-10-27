-----STEP 7
DELETE FROM [0_DP_Step7_check_data_with_master_tmp];


DELETE FROM [0_DP_Step7_check_data_with_master_2_tmp];


INSERT INTO [0_DP_Step7_check_data_with_master_tmp] ( HEC_INCLUDE, BUILDINGDAY, TT, Qty )
  SELECT DAILY_SALE_DATA.HEC_INCLUDE, DAILY_SALE_DATA.BUILDINGDAY, Sum(DAILY_SALE_DATA.TT) AS SumOfTT, Sum(DAILY_SALE_DATA.Qty) AS SumOfQty
  FROM DAILY_SALE_DATA
  GROUP BY DAILY_SALE_DATA.HEC_INCLUDE, DAILY_SALE_DATA.BUILDINGDAY
  HAVING (((DAILY_SALE_DATA.HEC_INCLUDE)=1));


INSERT INTO [0_DP_Step7_check_data_with_master_2_tmp] ( HEC_INCLUDE, BUILDINGDAY, SumOfTT, SumOfQty )
  SELECT DAILY_SALE_DATA.HEC_INCLUDE, DAILY_SALE_DATA.BUILDINGDAY, Sum(DAILY_SALE_DATA.TT) AS SumOfTT, Sum(DAILY_SALE_DATA.Qty) AS SumOfQty
  FROM (DAILY_SALE_DATA INNER JOIN [MASTER CUSTOMER] ON DAILY_SALE_DATA.KUNNR = [MASTER CUSTOMER].Kunnr) INNER JOIN [MASTER PRODUCT] ON DAILY_SALE_DATA.PRODUCT = [MASTER PRODUCT].ProductCode
  GROUP BY DAILY_SALE_DATA.HEC_INCLUDE, DAILY_SALE_DATA.BUILDINGDAY
  HAVING (((DAILY_SALE_DATA.HEC_INCLUDE)=1));


UPDATE [0_DP_Step7_check_data_with_master_tmp] 
SET  [0_DP_Step7_check_data_with_master_tmp].TT_with_master=[0_DP_Step7_check_data_with_master_2_tmp].[SumOfTT] , [0_DP_Step7_check_data_with_master_tmp].Qty_with_master = [0_DP_Step7_check_data_with_master_2_tmp].[SumOfQty]
FROM [0_DP_Step7_check_data_with_master_tmp] INNER JOIN [0_DP_Step7_check_data_with_master_2_tmp] ON  [0_DP_Step7_check_data_with_master_tmp].BUILDINGDAY = [0_DP_Step7_check_data_with_master_2_tmp].BUILDINGDAY


UPDATE [0_DP_Step7_check_data_with_master_tmp] SET [0_DP_Step7_check_data_with_master_tmp].GAP_TT = [0_DP_Step7_check_data_with_master_tmp].TT - [0_DP_Step7_check_data_with_master_tmp].TT_with_master;


UPDATE [0_DP_Step7_check_data_with_master_tmp] SET [0_DP_Step7_check_data_with_master_tmp].GAP_Qty = [0_DP_Step7_check_data_with_master_tmp].Qty - [0_DP_Step7_check_data_with_master_tmp].Qty_with_master;


UPDATE [MASTER PRODUCT] 
SET [MASTER PRODUCT].FA_SName =[MASTER PRODUCT_PRE].[FA_SName],  [MASTER PRODUCT].FA_CLIENTS_NAME = [MASTER PRODUCT_PRE].[FA_CLIENTS_NAME], 
	[MASTER PRODUCT].FA_Organic_YTD =[MASTER PRODUCT_PRE].[FA_Organic_YTD] , [MASTER PRODUCT].FA_Organic_MAT =[MASTER PRODUCT_PRE].[FA_Organic_MAT] , 
	[MASTER PRODUCT].CSO_Name_pre =[MASTER PRODUCT_PRE].[CSO_Name_pre] , [MASTER PRODUCT].CSO_Name = [MASTER PRODUCT_PRE].[CSO_Name]
FROM [MASTER PRODUCT] INNER JOIN [MASTER PRODUCT_PRE] ON [MASTER PRODUCT_PRE].ProductCode = [MASTER PRODUCT].ProductCode 
