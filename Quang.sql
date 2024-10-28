USE QUANLYBENHNHAN


-- Function
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

-- Trigger
-- Tự động cập nhật số lượng giường khi có bệnh nhân nhập viện
GO

CREATE TRIGGER trg_UpdateSoLuongGiuongTrong ON BenhNhan AFTER INSERT
AS
BEGIN
  UPDATE Phong SET GiuongTrong = GiuongTrong - 1
  FROM Phong
  WHERE PhongID = (SELECT PhongID FROM inserted)
END
GO

-- Check
SELECT * FROM Phong
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Lê Hải Lâm', '2004-09-01', N'Nam', N'88 Giáp Nhị, Hà Nội', '0912567890', '2021-02-15', 1, 1);
-- ok


-- Tự động cập nhật tổng tiền trong biên lai khi có dịch vụ hoặc đơn thuốc được tạo mới
GO
CREATE TRIGGER trg_UpdateTongTienBienLai_AfterInsertDichVu ON DichVu AFTER INSERT
AS
BEGIN
  UPDATE BienLai 
  SET TongTien = COALESCE(TongTien, 0) + 
    (
      SELECT SUM(i.SoLan * ldv.GiaDichVu * (1 - ISNULL(bh.MienGiam, 0)))
      FROM inserted i
      LEFT JOIN LoaiDichVuKham ldv ON i.LoaiDichVuID = ldv.LoaiDichVuID
      LEFT JOIN BenhNhan bn ON i.BenhNhanID = bn.BenhNhanID
      LEFT JOIN BaoHiemYTe bh ON bn.BaoHiemID = bh.BaoHiemID
      WHERE i.BienLaiID = BienLai.BienLaiID
    )
  WHERE BienLai.BienLaiID IN (SELECT DISTINCT BienLaiID FROM inserted);
END;

GO

-- check 
SELECT * FROM BienLai
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES 
(1, 1, 1, 1),
(2, 2, 1, 1);
-- ok
GO


