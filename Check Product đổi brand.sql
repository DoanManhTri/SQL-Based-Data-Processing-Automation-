
SELECT 
	A.Notes,
    ProductCode, 
    A.ProductName, 
    BrandName, 
    B.PrdGroup3, 
    SupplierCode, 
    SUPPLIERGROUP
FROM 
    [MASTER PRODUCT] A
JOIN 
    DBWH_BIHEC.dbo.M_Product_Grp B 
ON 
    A.ProductCode COLLATE Latin1_General_CI_AI = B.ProductID COLLATE Latin1_General_CI_AI
WHERE 
    TRIM(BrandName) COLLATE Latin1_General_CI_AI != TRIM(PrdGroup3) COLLATE Latin1_General_CI_AI and SUPPLIERGROUP not like 'SYSMEX'
ORDER BY SUPPLIERGROUP


