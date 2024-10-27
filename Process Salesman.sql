---LẤY CODE TỪ HỆ THỐNG ĐỂ ĐƯA VÀO BẢNG SALESMAN 
INSERT INTO Salesman_New(SalesNamCode,FirstName, LastName, FullName)
SELECT  B.SalesNamCode, B.FirstName, B.LastName, B.FullName
from Salesman_New A
Right join DBWH_BIHEC.dbo.M_SalesMan b on A.SalesNamCode = b.SalesNamCode
where a.SalesNamCode is null

---UPDATE CỘT FULLNAME THEO HỆ THỐNG (PHÒNG KHI HỆ THỐNG CÓ UPDATE TÊN MỚI)
UPDATE A
SET A.FullName= B.FullName
FROM Salesman_New A
JOIN DBWH_BIHEC.dbo.M_SalesMan B on A.SalesNamCode = b.SalesNamCode

---UPDATE CỘT TIỀN TỐ TỪ TÊN ĐỂ LẤY THÔNG TIN VỀ GROUP TEAM
UPDATE Salesman_New
SET Tien_to=LEFT(FullName, CHARINDEX('-', FullName) - 1)
WHERE FullName like '%-%'


---Map bảng mapping để lấy thông tin cho cột group và team
UPDATE A
SET a.team=b.[Diễn giải], A.[group]=b.[Group]
FROM Salesman_New A
JOIN Mapping_Salesman B ON A.Tien_to =b.[Tiền tố]

--UPDATE CỘT YTD_SALES_2024 
UPDATE Salesman_New
SET Active_Jan_2023_Sep_2024='No';

WITH Sales_by_salesman as
	(select distinct PERNR
	from Salesman_New a
	join [2022_DAILY] b on a.SalesNamCode = b.PERNR
	where [Calendar Year]>=2024
)
UPDATE Salesman_New
SET Active_Jan_2023_Sep_2024 ='Yes'
from Salesman_New A
join Sales_by_salesman b on a.SalesNamCode=b.PERNR


