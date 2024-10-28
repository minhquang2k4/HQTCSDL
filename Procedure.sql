USE QUANLYBENHNHAN

GO
CREATE PROCEDURE sp_ThemBenhNhan
  @HoTen NVARCHAR(100),
  @NgaySinh DATE,
  @GioiTinh NVARCHAR(3),
  @DiaChi NVARCHAR(255),
  @SDT NVARCHAR(10),
  @PhongID INT,
  @BaoHiemID INT = 1
AS
BEGIN       
	DECLARE @ConTrong BIT;
	-- EXEC sp_KiemTraPhongTrong @PhongID, @ConTrong OUTPUT;
	SET @ConTrong = dbo.KiemTraPhongConTrong (@PhongID)

	IF @ConTrong = 1
	BEGIN
    PRINT N'Phòng đã hết giường trống!';
    RETURN;
	END

	IF NOT EXISTS (SELECT * FROM BaoHiem WHERE BaoHiemID = @BaoHiemID) 
	BEGIN 
    PRINT N'Bảo hiểm không tồn tại!'; 
    RETURN; 
	END

	INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID)
	VALUES (@HoTen, @NgaySinh, @GioiTinh, @DiaChi, @SDT, GETDATE(), @PhongID, @BaoHiemID);
	PRINT N'Thêm bệnh nhân thành công!';
END;
GO


-- Check
EXEC sp_ThemBenhNhan N'Nguyễn Văn A', '1990-01-01', N'Nam', N'123 Đường ABC', '0123456789', 1, 1;
-- OK






-- Procedure cập nhật thông tin bệnh nhân
GO
CREATE PROCEDURE sp_CapNhatBenhNhan
  @BenhNhanID INT,
  @HoTen NVARCHAR(100),
  @NgaySinh DATE,
  @GioiTinh NVARCHAR(3),
  @DiaChi NVARCHAR(255),
  @SDT NVARCHAR(10),
  @BaoHiemID INT
AS
BEGIN
  IF NOT EXISTS (SELECT 1 FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  IF NOT EXISTS (SELECT * FROM BaoHiem WHERE BaoHiemID = @BaoHiemID) 
    BEGIN 
      PRINT N'Bảo hiểm không tồn tại!'; 
      RETURN; 
    END

  UPDATE BenhNhan
  SET HoTen = @HoTen,
    NgaySinh = @NgaySinh,
    GioiTinh = @GioiTinh,
    DiaChi = @DiaChi,
    SDT = @SDT,
    BaoHiemID = @BaoHiemID
  WHERE BenhNhanID = @BenhNhanID;
END;
GO

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


-- Procedure tạo hồ sơ bệnh án
GO
CREATE PROCEDURE sp_TaoHoSoBenhAn
  @BenhNhanID INT,
  @BacSiID INT,
  @ChanDoan NVARCHAR(MAX)
AS
BEGIN        
  -- Kiểm tra bệnh nhân tồn tại
  IF NOT EXISTS (SELECT 1 FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  
  -- Kiểm tra bác sĩ tồn tại
  IF NOT EXISTS (SELECT 1 FROM BacSi WHERE BacSiID = @BacSiID)
  BEGIN
    PRINT N'Bác sĩ không tồn tại!';
    RETURN;
  END
  
  INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap)
  VALUES (@BenhNhanID, @BacSiID, @ChanDoan, GETDATE());
  
  -- Tạo biên lai mới cho hồ sơ
  -- INSERT INTO BienLai (HoSoID, TongTien, ThanhToan)
  -- VALUES (SCOPE_IDENTITY(), 0, 0);
  DECLARE @HoSoID INT;
  SELECT @HoSoID = MAX(HoSoID) FROM HoSoBenhAn;

  EXEC sp_TaoBienLai(@HoSoID);
  PRINT N'Tạo hồ sơ bệnh án thành công!';
END;
GO






-- Procedure xuất viện
CREATE PROCEDURE sp_XuatVien
  @BenhNhanID INT
AS
BEGIN
  -- Kiểm tra bệnh nhân tồn tại
  IF NOT EXISTS (SELECT 1 FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  
  --goi ham ktra thanh toan
  IF dbo.CheckThanhToan(@BenhNhanID) = 0
  BEGIN
    PRINT N'Bệnh nhân chưa thanh toán!';
    RETURN;
  END
  
  -- Cập nhật ngày xuất viện
  UPDATE BenhNhan
  SET NgayXuatVien = GETDATE()
  WHERE BenhNhanID = @BenhNhanID;
  PRINT N'Bệnh nhân đã xuất viện!';
END;
GO


-- Procedure chuyển phòng
CREATE PROCEDURE sp_ChuyenPhong
  @BenhNhanID INT,
  @PhongMoiID INT
AS
BEGIN      
  DECLARE @PhongCuID INT;
  DECLARE @ConTrong BIT;

  SELECT @PhongCuID = PhongID
  FROM BenhNhan
  WHERE BenhNhanID = @BenhNhanID;
  
  IF @PhongCuID IS NULL
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  
  IF dbo.KiemTraPhongConTrong(@PhongMoiID) = 0
  BEGIN
    PRINT N'Phòng mới đã hết giường trống!';
    RETURN;
  END

  UPDATE BenhNhan
  SET PhongID = @PhongMoiID
  WHERE BenhNhanID = @BenhNhanID;
  PRINT N'Chuyển phòng thành công!';
END;
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