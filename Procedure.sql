USE QUANLYBENHNHAN

GO
-- thủ tục nhập viện cho bệnh nhân
CREATE PROCEDURE sp_ThemBenhNhan
  @HoTen NVARCHAR(100),
  @NgaySinh DATE,
  @GioiTinh NVARCHAR(3),
  @DiaChi NVARCHAR(255),
  @SDT NVARCHAR(10),
  @PhongID INT,
  @BaoHiemID INT
AS
BEGIN
  -- Kiểm tra phòng còn trống không
	IF dbo.KiemTraPhongConTrong (@PhongID) = 0
	BEGIN
	  PRINT N'Phòng đã hết giường trống!';
	  RETURN;
	END

  -- Kiểm tra loại bảo hiểm y tế tồn tại không
	IF NOT EXISTS (SELECT * FROM BaoHiemYTe WHERE BaoHiemID = @BaoHiemID) 
	BEGIN 
	  PRINT N'Loại bảo hiểm không tồn tại!'; 
	  RETURN; 
	END

	INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID)
	VALUES (@HoTen, @NgaySinh, @GioiTinh, @DiaChi, @SDT, GETDATE(), @PhongID, @BaoHiemID);
	PRINT N'Thêm bệnh nhân thành công!';
END;
GO
-- Check
EXEC sp_ThemBenhNhan N'Nguyễn Đức Long', '2004-09-01', N'Nam', N'88 Giáp Nhị, Hà Nội', '0824919798', 1, 2;
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

  IF NOT EXISTS (SELECT * FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  IF NOT EXISTS (SELECT * FROM BaoHiemYTe WHERE BaoHiemID = @BaoHiemID) 
  BEGIN 
    PRINT N'Loại bảo hiểm không tồn tại!'; 
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
-- check
SELECT * FROM BenhNhan
EXECUTE sp_CapNhatBenhNhan 1, N'Phạm Minh Quân', '2004-09-01', N'Nam', N'88 Giáp Nhị, Hà Nội', '0824919798', 2;





-- Procedure tạo biên lai
GO
CREATE PROCEDURE sp_TaoBienLai 
  @HoSoID INT
AS
BEGIN
 -- Kiểm tra nếu hồ sơ bệnh án tồn tại trong bảng HoSoBenhAn
  IF NOT EXISTS (SELECT * FROM HoSoBenhAn WHERE HoSoID = @HoSoID)
  BEGIN
    PRINT N'Hồ sơ bệnh án không tồn tại';
    RETURN;
  END

  -- Kiểm tra nếu biên lai đã tồn tại
  IF EXISTS (SELECT * FROM BienLai WHERE HoSoID = @HoSoID)
  BEGIN
    PRINT N'Biên lai đã tồn tại cho hồ sơ bệnh án này';
    RETURN;
  END
  
  INSERT INTO BienLai(HoSoID, TongTien, ThanhToan) VALUES(@HoSoID, 0, 0)
  PRINT N'Tạo biên lai cho hồ sơ bệnh án thành công'
END
GO

-- Check ở dưới

-- Procedure tạo hồ sơ bệnh án
GO
CREATE PROCEDURE sp_TaoHoSoBenhAn
  @BenhNhanID INT,
  @BacSiID INT,
  @ChanDoan NVARCHAR(MAX)
AS
BEGIN        
  -- Kiểm tra bệnh nhân tồn tại
  IF NOT EXISTS (SELECT * FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  
  -- Kiểm tra bác sĩ tồn tại
  IF NOT EXISTS (SELECT * FROM BacSi WHERE BacSiID = @BacSiID)
  BEGIN
    PRINT N'Bác sĩ không tồn tại!';
    RETURN;
  END
  
  INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap)
  VALUES (@BenhNhanID, @BacSiID, @ChanDoan, GETDATE());
  
  -- Tạo biên lai tương ứng cho hồ sơ
  DECLARE @HoSoID INT;
  SELECT @HoSoID = MAX(HoSoID) FROM HoSoBenhAn;


  PRINT N'Tạo hồ sơ bệnh án thành công!';
  EXEC sp_TaoBienLai @HoSoID;
END;
GO

-- check
SELECT * FROM HoSoBenhAn
SELECT * FROM BienLai
SELECT * FROM BenhNhan

EXECUTE sp_TaoHoSoBenhAn 23, 1, N'Đau đầu vì không có người yêu';
-- ok





-- Procedure thanh toán cho bện nhân 
GO
CREATE PROCEDURE sp_ThanhToan
  @BenhNhanID INT
AS
BEGIN
  -- Kiểm tra bệnh nhân tồn tại
  IF NOT EXISTS (SELECT * FROM HoSoBenhAn WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại';
    RETURN;
  END

  DECLARE @HoSoID INT;
  DECLARE @BienLaiID INT;

  SELECT @HoSoID = HoSoID FROM HoSoBenhAn WHERE BenhNhanID = @BenhNhanID;
  SELECT @BienLaiID = BienLaiID FROM BienLai WHERE HoSoID = @HoSoID;

  UPDATE BienLai SET ThanhToan = 1 WHERE BienLaiID = @BienLaiID;
  PRINT N'Thanh toán thành công'
END

-- Check
SELECT * FROM BienLai

EXECUTE sp_ThanhToan 2





-- Procedure xuất viện
GO
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
  
  -- Kiểm tra bệnh nhân đã xuât viện hay chưa
  IF EXISTS (SELECT 1 FROM BenhNhan WHERE BenhNhanID = @BenhNhanID AND NgayXuatVien IS NOT NULL)
  BEGIN
    PRINT N'Bệnh nhân đã xuất viện trước đó!';
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
  PRINT N'Bệnh nhân đã xuất viện thành công!';

  UPDATE Phong
  SET GiuongTrong = GiuongTrong + 1
  WHERE PhongID = (SELECT PhongID FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)

END;
GO
-- Check
SELECT * FROM BenhNhan
SELECT * FROM Phong
SELECT * FROM BienLai
EXECUTE sp_XuatVien 1
EXECUTE sp_XuatVien 2





-- Procedure chuyển phòng
GO
ALTER PROCEDURE sp_ChuyenPhong
  @BenhNhanID INT,
  @PhongMoiID INT
AS
BEGIN      
  DECLARE @PhongCuID INT;
  DECLARE @ConTrong BIT;

  SELECT @PhongCuID = PhongID
  FROM BenhNhan
  WHERE BenhNhanID = @BenhNhanID;
  
  IF NOT EXISTS (SELECT * FROM BenhNhan WHERE BenhNhanID = @BenhNhanID)
  BEGIN
    PRINT N'Bệnh nhân không tồn tại!';
    RETURN;
  END
  
  -- check đã xuất viện chưa
  IF EXISTS (SELECT 1 FROM BenhNhan WHERE BenhNhanID = @BenhNhanID AND NgayXuatVien IS NOT NULL)
  BEGIN
    PRINT N'Bệnh nhân đã xuất viện!';
    RETURN;
  END

  IF @PhongCuID = @PhongMoiID
  BEGIN
	PRINT N'ID Phòng Trùng Nhau';
	RETURN;
  END

  IF dbo.KiemTraPhongConTrong(@PhongMoiID) = 0
  BEGIN
    PRINT N'Phòng mới đã hết giường trống!';
    RETURN;
  END
  
  -- Tăng số lượng giường trống của phòng cũ
  UPDATE Phong
  SET GiuongTrong = GiuongTrong + 1
  WHERE PhongID = @PhongCuID;
  -- Giảm số lượng giường trống của phòng mới 
  UPDATE Phong
  SET GiuongTrong = GiuongTrong - 1
  WHERE PhongID = @PhongMoiID;

  -- Cập nhật thông tin phòng mới cho bệnh nhân
  UPDATE BenhNhan
  SET PhongID = @PhongMoiID
  WHERE BenhNhanID = @BenhNhanID;
  PRINT N'Chuyển phòng thành công!';
END;
GO

-- Check
SELECT * FROM BenhNhan
SELECT * FROM Phong

EXECUTE sp_ChuyenPhong 1, 1 -- Phòng trùng nhau

EXECUTE sp_ChuyenPhong 1, 2
-- ok






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
SELECT * FROM BienLai -- Tổng tiền tự động update
SELECT * FROM LoaiDichVuKham

EXECUTE sp_TaoDichVu 2, 1, 2 


EXECUTE sp_TaoDichVu 16, 1, 2
-- ok





-- Procedure tạo đơn thuốc
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
EXECUTE sp_TaoDonThuoc 1, 1, 2, N'Uống 1 viên/ngày'
-- ok