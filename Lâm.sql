USE QUANLYBENHNHAN
-- code


-- Procedure tạo biên lai
GO
CREATE PROCEDURE sp_TaoBienLai 
  @HoSoID INT
AS
BEGIN
  IF NOT EXISTS (SELECT * FROM BienLai WHERE HoSoID = @HoSoID)
  BEGIN
    PRINT N'Hồ sơ bệnh án không tồn tại';
    RETURN;
  END
  
  INSERT INTO BienLai(HoSoID, TongTien, ThanhToan) VALUES(@HoSoID, NULL, 0)
  PRINT N'Đã tạo biên lai cho hồ sơ bệnh án'
  
END
GO

-- Check
SELECT * FROM BienLai
-- 

-- Procedure tạo DichVu 
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (2, 1, 2, 2);

GO
CREATE PROCEDURE sp_TaoDichVu 
  @LoaiDichVuID INT,
  @SoLan INT,
  @BienLaiID INT
AS
BEGIN
  IF NOT EXISTS (SELECT * FROM BienLai WHERE BienLaiID = @BienLaiID)
  BEGIN
    PRINT N'Biên lai không tồn tại';
    RETURN;
  END
  
  IF NOT EXISTS (SELECT * FROM LoaiDichVuKham WHERE LoaiDichVuID = @LoaiDichVuID)
  BEGIN
    PRINT N'Loại dịch vụ khám không tồn tại';
    RETURN;
  END

  DECLARE @HoSoID INT;
  DECLARE @BenhNhanID INT;
  SELECT @HoSoID = HoSoID FROM BienLai WHERE BienLaiID = @BienLaiID;
  SELECT @BenhNhanID = BenhNhanID FROM HoSoBenhAn WHERE HoSoID = @HoSoID;

  INSERT INTO DichVu(LoaiDichVuID, SoLan, BienLaiID, BenhNhanID)
  VALUES(@LoaiDichVuID, @SoLan, @BienLaiID, @BenhNhanID)

  PRINT N'Đã thêm dịch vụ vào biên lai'
END
GO

-- Check
SELECT * FROM DichVu
SELECT * FROM BienLai
SELECT * FROM LoaiDichVuKham
EXECUTE sp_TaoDichVu 2, 1, 2 
EXECUTE sp_TaoDichVu 16, 1, 2


INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (1, 1, 1, 1, N'Uống 1 viên/ngày');
GO
CREATE PROCEDURE sp_TaoDonThuoc
  @ThuocID INT,
  @SoLuong INT,
  @BienLaiID INT,
  @CachDung NVARCHAR(255)
AS
BEGIN
  IF NOT EXISTS (SELECT * FROM Thuoc WHERE ThuocID = @ThuocID)
  BEGIN
    PRINT N'Thuốc không tồn tại';
    RETURN;
  END

  IF NOT EXISTS (SELECT * FROM BienLai WHERE BienLaiID = @BienLaiID)
  BEGIN
    PRINT N'Biên lai không tồn tại';
    RETURN;
  END

  DECLARE @HoSoID INT;
  DECLARE @BenhNhanID INT;

  SELECT @HoSoID = HoSoID FROM BienLai WHERE BienLaiID = @BienLaiID;
  SELECT @BenhNhanID = BenhNhanID FROM HoSoBenhAn WHERE HoSoID = @HoSoID;

  INSERT INTO DonThuoc(ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung)
  VALUES(@ThuocID, @SoLuong, @BienLaiID, @BenhNhanID, @CachDung)

  PRINT N'Đã thêm đơn thuốc vào biên lai'
END

-- Check
SELECT * FROM DonThuoc
SELECT * FROM Thuoc
SELECT * FROM BienLai
EXECUTE sp_TaoDonThuoc 1, 1, 23, N'Uống 1 viên/ngày'

-- Procedure thanh toán cho bện nhân 
GO
CREATE PROCEDURE sp_ThanhToan
  @BenhNhanID INT
AS
BEGIN
  IF NOT EXISTS (SELECT * FROM HoSoBenhAn WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại';
    RETURN;
  END

  DECLARE @HoSoID INT;
  DECLARE @BienLaiID INT;

  SELECT @HoSoID = HoSoID FROM HoSoBenhAn WHERE BenhNhanID = @BenhNhanID;
  SELECT @BienLaiID = BienLaiID FROM BienLai WHERE HoSoID = @HoSoID;

  UPDATE BienLai SET ThanhToan = 1 WHERE BienLaiID = @BienLaiID
  PRINT N'Thanh toán thành công'
END

-- Check
SELECT * FROM BienLai

EXECUTE sp_ThanhToan 1