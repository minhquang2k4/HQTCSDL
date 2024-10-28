USE QUANLYBENHNHAN

-- hàm kiểm tra phòng còn trống khong
GO
CREATE FUNCTION dbo.KiemTraPhongConTrong (@PhongID INT)
RETURNS BIT
AS
BEGIN
  DECLARE @result BIT;
  if (SELECT GiuongTrong FROM Phong WHERE PhongID = @PhongID) > 0
    SET @result = 1;
  ELSE
    SET @result = 0;
  RETURN @result;
END
GO

-- check
SELECT dbo.KiemTraPhongConTrong(2) AS KiemTraPhongConTrong
-- ok







-- Kiểm tra bệnh nhân đã thanh toán chưa
GO
CREATE FUNCTION dbo.CheckThanhToan (@BenhNhanID INT)
RETURNS BIT
AS
BEGIN
  DECLARE @result BIT;
  SELECT TOP 1 @result = ThanhToan
  FROM BienLai
  WHERE HoSoID IN (SELECT HoSoID FROM HoSoBenhAn WHERE BenhNhanID = @BenhNhanID)
  ORDER BY BienLaiID DESC;
  
  RETURN ISNULL(@result, 0);
END
GO

-- Check
SELECT dbo.CheckThanhToan(1) as Trang_thai_thanh_toan
-- ok





-- Tính tuổi của bệnh nhân
GO
CREATE FUNCTION dbo.TinhTuoi (@BenhNhanID INT)
RETURNS INT
AS
BEGIN
  DECLARE @Tuoi INT;
  SET @Tuoi = DATEDIFF(YEAR, (SELECT NgaySinh FROM BenhNhan WHERE BenhNhanID = @BenhNhanID), GETDATE());
  RETURN @Tuoi;
END
GO

-- Check
SELECT dbo.TinhTuoi(2) AS Tuoi
-- ok