USE QUANLYBENHNHAN
-- code

GO
-- Procedure kiểm tra phòng còn trống

GO

-- Procedure thêm bệnh nhân
ALTER PROCEDURE sp_ThemBenhNhan
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

EXEC sp_ThemBenhNhan N'Nguyễn Văn A', '1990-01-01', N'Nam', N'123 Đường ABC', '0123456789', 1, 1;

GO

-- Procedure cập nhật thông tin bệnh nhân
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
    END
END;
GO

-- Procedure tạo hồ sơ bệnh án
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
		
		-- Kiểm tra bệnh nhân tồn tại
		SELECT @PhongCuID = PhongID
		FROM BenhNhan
		WHERE BenhNhanID = @BenhNhanID;
		
		IF @PhongCuID IS NULL
		BEGIN
				PRINT N'Bệnh nhân không tồn tại!';
				RETURN;
		END
		
		-- Kiểm tra phòng mới có giường trống


		
		IF dbo.KiemTraPhongConTrong(@PhongMoiID) = 0
		BEGIN
				PRINT N'Phòng mới đã hết giường trống!';
				RETURN;
		END
		
		-- Cập nhật phòng cho bệnh nhân
		UPDATE BenhNhan
		SET PhongID = @PhongMoiID
		WHERE BenhNhanID = @BenhNhanID;
    PRINT N'Chuyển phòng thành công!';

END;
GO