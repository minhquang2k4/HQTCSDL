CREATE DATABASE QUANLYBENHNHAN
USE QUANLYBENHNHAN

-- xóa db
USE master
DROP DATABASE QUANLYBENHNHAN

-- Bảng khoa
CREATE TABLE Khoa
(
  KhoaID INT PRIMARY KEY IDENTITY(1,1),
  TenKhoa NVARCHAR(100) NOT NULL,
  SDTKhoa NVARCHAR(10),
);

-- Bảng phòng
CREATE TABLE Phong
(
  PhongID INT PRIMARY KEY IDENTITY(1,1),
  KhoaID INT,
  TongSoGiuong INT,
  GiuongTrong INT,
  FOREIGN KEY (KhoaID) REFERENCES Khoa(KhoaID)
);

-- Bảng thuốc
CREATE TABLE Thuoc
(
  ThuocID INT PRIMARY KEY IDENTITY(1,1),
  TenThuoc NVARCHAR(100) NOT NULL,
  DonViTinh NVARCHAR(50),
  GiaThuoc DECIMAL(10, 2)
);

-- Loai Dich Vu Kham
CREATE TABLE LoaiDichVuKham
(
  LoaiDichVuID INT PRIMARY KEY IDENTITY(1,1),
  TenDichVu NVARCHAR(100) NOT NULL,
  GiaDichVu DECIMAL(10, 2)
); 


-- Bảng bảo hiểm y tế
CREATE TABLE BaoHiemYTe
(
  BaoHiemID INT PRIMARY KEY IDENTITY(1,1),
  TenBaoHiem NVARCHAR(100) NOT NULL,
  MienGiam DECIMAL(10, 2)
);

-- Bảng bệnh nhân
CREATE TABLE BenhNhan
(
  BenhNhanID INT PRIMARY KEY IDENTITY(1,1),
  HoTen NVARCHAR(100) NOT NULL,
  NgaySinh DATE,
  GioiTinh NVARCHAR(3),
  DiaChi NVARCHAR(255),
  SDT NVARCHAR(10),
  NgayNhapVien DATE,
  NgayXuatVien DATE default NULL,
  PhongID INT,
  BaoHiemID INT DEFAULT 1,
  FOREIGN KEY (PhongID) REFERENCES Phong(PhongID),
  FOREIGN KEY (BaoHiemID) REFERENCES BaoHiemYTe(BaoHiemID)
);

-- Bảng bác sĩ
CREATE TABLE BacSi
(
  BacSiID INT PRIMARY KEY IDENTITY(1,1),
  HoTen NVARCHAR(100) NOT NULL,
  SDT NVARCHAR(15),
  Email NVARCHAR(100),
  KhoaID INT,
  FOREIGN KEY (KhoaID) REFERENCES Khoa(KhoaID)
);

-- Bảng hồ sơ bệnh án
CREATE TABLE HoSoBenhAn
(
  HoSoID INT PRIMARY KEY IDENTITY(1,1),
  BenhNhanID INT,
  BacSiID INT,
  ChanDoan NVARCHAR(MAX),
  NgayLap DATE,
  FOREIGN KEY (BenhNhanID) REFERENCES BenhNhan(BenhNhanID),
  FOREIGN KEY (BacSiID) REFERENCES BacSi(BacSiID)
);

-- Bảng biên lai
CREATE TABLE BienLai
(
  BienLaiID INT PRIMARY KEY IDENTITY(1,1),
  HoSoID INT,
  TongTien DECIMAL(10, 2),
  ThanhToan BIT DEFAULT 0,
  FOREIGN KEY (HoSoID) REFERENCES HoSoBenhAn(HoSoID)
);

-- Dich Vu 
CREATE TABLE DichVu
(
  DichVuID INT PRIMARY KEY IDENTITY(1,1),
  SoLan INT,
  LoaiDichVuID INT,
  BienLaiID INT,
  BenhNhanID INT,
  FOREIGN KEY (BenhNhanID) REFERENCES BenhNhan(BenhNhanID),
  FOREIGN KEY (BienLaiID) REFERENCES BienLai(BienLaiID),
  FOREIGN KEY (LoaiDichVuID) REFERENCES LoaiDichVuKham(LoaiDichVuID)
);

-- Bảng đơn thuốc
CREATE TABLE DonThuoc
(
  DonThuocID INT PRIMARY KEY IDENTITY(1,1),
  ThuocID INT,
  BenhNhanID INT,
  SoLuong INT,
  CachDung NVARCHAR(MAX),
  BienLaiID INT,
  FOREIGN KEY (BienLaiID) REFERENCES BienLai(BienLaiID),
  FOREIGN KEY (BenhNhanID) REFERENCES BenhNhan(BenhNhanID),
  FOREIGN KEY (ThuocID) REFERENCES Thuoc(ThuocID)
);


-- Insert dữ liệu
-- Khoa
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Phụ Sản', '0111456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Nhi', '0222456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Tai Mũi Họng', '0333456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Răng Hàm Mặt', '0444456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Tim Mạch', '0555456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Da Liễu', '0666456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Nội Tiết', '0777456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Phẫu Thuật', '0888456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Mắt', '0999456999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Chấn thương chỉnh hình', '0999567999')
INSERT INTO Khoa (TenKhoa, SDTKhoa) VALUES (N'Khoa Thần kinh', '0999678999')


-- Phòng
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (1, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (1, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (2, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (2, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (3, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (3, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (4, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (4, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (5, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (5, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (6, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (6, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (7, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (7, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (8, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (8, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (9, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (9, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (10, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (10, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (11, 10, 10)
INSERT INTO Phong (KhoaID, TongSoGiuong, GiuongTrong) VALUES (11, 10, 10)

-- Thuốc
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Paracetamol', N'Viên', 5000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Amoxicillin', N'Viên', 10000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Azithromycin', N'Viên', 15000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Aspirin', N'Viên', 2000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Ibuprofen', N'Viên', 12000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Cefalexin', N'Viên', 18000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Clarithromycin', N'Viên', 25000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Omeprazole', N'Viên', 30000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Dexamethasone', N'Viên', 4000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Simvastatin', N'Viên', 20000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Lisinopril', N'Viên', 15000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Amlodipine', N'Viên', 25000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Levothyroxine', N'Viên', 22000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Furosemide', N'Viên', 5000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Co-amoxiclav', N'Viên', 22000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Loratidine', N'Viên', 10000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Cetirizine', N'Viên', 12000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Metformin', N'Viên', 18000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Pantoprazole', N'Viên', 20000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Sertraline', N'Viên', 30000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Prednisone', N'Viên', 15000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Tramadol', N'Viên', 25000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Salbutamol', N'Viên', 20000);
INSERT INTO Thuoc (TenThuoc, DonViTinh, GiaThuoc) VALUES (N'Atorvastatin', N'Viên', 35000);

-- Loai Dich Vu Kham
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Khám chuyên khoa', 70000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Chụp X-quang', 120000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Chụp CT-Scan', 500000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Nội soi tiêu hóa', 300000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Điện tim', 80000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Siêu âm tim', 250000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Khám da liễu', 60000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Tiêm phòng', 150000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Khám răng hàm mặt', 90000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Khám tai mũi họng', 75000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Khám mắt', 65000);
INSERT INTO LoaiDichVuKham (TenDichVu, GiaDichVu) VALUES (N'Đo thị lực', 50000);

-- Bảng Bao Hiem Y Te
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Không', 0);
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Bảo hiểm Xã hội', 0.7);
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Bảo hiểm Bưu điện', 0.6);
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Bảo hiểm Quân đội', 0.5);
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Bảo hiểm Công an', 0.4);
INSERT INTO BaoHiemYTe (TenBaoHiem, MienGiam) VALUES (N'Bảo hiểm Sức khỏe', 0.3);

-- Bệnh nhân
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Nguyễn Văn Hoàng', '1988-05-12', N'Nam', N'456 Nguyễn Trãi, TP.HCM', '0912567890', '2021-02-15', 1, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Trần Thị Mai', '1992-07-23', N'Nữ', N'789 Trần Hưng Đạo, TP.HCM', '0912678901', '2021-03-10', 1, 2);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Lê Văn Nam', '1978-10-10', N'Nam', N'101 Cách Mạng Tháng Tám, TP.HCM', '0912789012', '2021-04-20', 1, 3);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Hoàng Thị Lan', '1983-02-28', N'Nữ', N'202 Điện Biên Phủ, TP.HCM', '0912890123', '2021-05-30', 2, 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Phạm Văn Dũng', '1999-12-12', N'Nam', N'303 Lý Thường Kiệt, TP.HCM', '0912901234', '2021-06-10', 3, 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Bùi Thị Hương', '1991-04-18', N'Nữ', N'404 Phạm Ngũ Lão, TP.HCM', '0913012345', '2021-07-15', 4, 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Ngô Văn Phát', '1965-03-25', N'Nam', N'505 Huỳnh Tấn Phát, TP.HCM', '0913123456', '2021-08-20', 4, 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Võ Thị Hoa', '1975-11-11', N'Nữ', N'606 Hai Bà Trưng, TP.HCM', '0913234567', '2021-09-05', 4, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Đặng Văn Khải', '1982-01-17', N'Nam', N'707 Võ Văn Tần, TP.HCM', '0913345678', '2021-10-12', 5, 2);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Nguyễn Thị Thanh', '1989-06-08', N'Nữ', N'808 Nguyễn Thị Minh Khai, TP.HCM', '0913456789', '2021-11-01', 5, 3);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Nguyễn Thị Lan', '1989-06-08', N'Nữ', N'808 Nguyễn Thị Minh Khai, TP.HCM', '0913456789', '2021-11-01', 5, 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Tô Văn Minh', '1994-02-14', N'Nam', N'909 Hùng Vương, TP.HCM', '0913567890', '2021-12-15', 6, 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Trương Thị Ngọc', '1996-08-26', N'Nữ', N'1010 Trường Chinh, TP.HCM', '0913678901', '2022-01-05', 6, 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Trần Văn Oanh', '1993-04-03', N'Nam', N'1111 Pasteur, TP.HCM', '0913789012', '2022-02-15', 7, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Phan Thị Phương', '1998-10-30', N'Nữ', N'1212 Nguyễn Văn Cừ, TP.HCM', '0913890123', '2022-03-10', 8, 2);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Hà Văn Quang', '1985-12-24', N'Nam', N'1313 Tân Sơn Nhì, TP.HCM', '0913901234', '2022-04-22', 9, 3);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Vũ Thị Rạng', '1990-09-05', N'Nữ', N'1414 Trần Quang Khải, TP.HCM', '0914012345', '2022-05-30', 10, 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Thái Văn Sơn', '1997-06-20', N'Nam', N'1515 Lạc Long Quân, TP.HCM', '0914123456', '2022-06-10', 11, 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Lý Thị Thảo', '1987-03-14', N'Nữ', N'1616 Cách Mạng Tháng Tám, TP.HCM', '0914234567', '2022-07-05', 12, 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Võ Văn Út', '1968-01-18', N'Nam', N'1717 Nguyễn Văn Trỗi, TP.HCM', '0914345678', '2022-08-01', 13, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Lê Thị Vân', '1972-11-28', N'Nữ', N'1818 Lý Chính Thắng, TP.HCM', '0914456789', '2022-09-20', 14, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Lê Thị Xuân', '1972-11-28', N'Nữ', N'1818 Lý Chính Thắng, TP.HCM', '0914456789', '2022-09-20', 14, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Phạm Văn Duy', '1980-03-15', N'Nam', N'1919 Lê Quang Định, TP.HCM', '0914567890', '2022-10-15', 15, 2);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Trần Thị Ngọc', '1993-06-19', N'Nữ', N'2020 Nguyễn Kiệm, TP.HCM', '0914678901', '2022-11-10', 16, 3);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Nguyễn Văn Quý', '1977-08-09', N'Nam', N'2121 Phan Đăng Lưu, TP.HCM', '0914789012', '2022-12-01', 17, 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Đỗ Thị Hằng', '1989-05-25', N'Nữ', N'2222 Trần Quốc Thảo, TP.HCM', '0914890123', '2023-01-20', 18, 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Hồ Văn Thịnh', '1995-12-12', N'Nam', N'2323 Hoàng Sa, TP.HCM', '0914901234', '2023-02-05', 19, 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Vũ Thị Yến', '1984-07-08', N'Nữ', N'2424 Nguyễn Thị Định, TP.HCM', '0914012345', '2023-03-15', 20, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Phạm Văn Hoàng', '1992-10-11', N'Nam', N'2525 Tôn Đức Thắng, TP.HCM', '0914123456', '2023-04-25', 21, 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID, BaoHiemID) VALUES (N'Bùi Thị Lan', '1987-03-18', N'Nữ', N'2626 Điện Biên Phủ, TP.HCM', '0914234567', '2023-05-05', 22, 2);

-- Bác sĩ
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Trần Văn Nam', '0912345679', 'nam@gmail.com', 1);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Lê Thị Mai', '0912345680', 'mai@gmail.com', 2);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Nguyễn Văn An', '0912345681', 'an@gmail.com', 3);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Phạm Minh Tuấn', '0912345682', 'tuan@gmail.com', 4);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Võ Thị Tâm', '0912345683', 'tam@gmail.com', 5);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Đỗ Văn Duy', '0912345684', 'duy@gmail.com', 6);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Nguyễn Văn Phúc', '0912345685', 'phuc@gmail.com', 7);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Trịnh Thị Lệ', '0912345686', 'le@gmail.com', 8);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Nguyễn Hồng Nhung', '0912345687', 'nhung@gmail.com', 9);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Phan Văn Quyền', '0912345688', 'quyen@gmail.com', 10);
INSERT INTO BacSi (HoTen, SDT, Email, KhoaID) VALUES (N'Lê Văn Khoa', '0912345689', 'khoa@gmail.com', 11);




-- Hồ sơ bệnh án
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (1, 1, N'Trường hợp mang thai', '2023-01-01');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (2, 2, N'Sốt phát ban', '2023-01-02');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (3, 3, N'Viêm họng', '2023-01-03');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (4, 4, N'Sâu răng', '2023-01-04');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (5, 5, N'Tăng huyết áp', '2023-01-05');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (6, 6, N'Chàm', '2023-01-06');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (7, 7, N'Đái tháo đường', '2023-01-07');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (8, 8, N'Chấn thương', '2023-01-08');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (9, 9, N'Viêm kết mạc', '2023-01-09');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (10, 10, N'Gãy xương', '2023-01-10');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (11, 11, N'Tai biến mạch máu não', '2023-01-11');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (12, 1, N'Viêm nhiễm phụ khoa', '2023-01-12');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (13, 2, N'Viêm đường hô hấp', '2023-01-13');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (14, 3, N'Viêm xoang', '2023-01-14');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (15, 4, N'Viêm lợi', '2023-01-15');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (16, 5, N'Suy tim', '2023-01-16');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (17, 6, N'Mụn trứng cá', '2023-01-17');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (18, 7, N'Hội chứng Cushing', '2023-01-18');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (19, 8, N'Phẫu thuật khối u', '2023-01-19');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (20, 9, N'Đục thủy tinh thể', '2023-01-20');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (21, 10, N'Tổn thương khớp', '2023-01-21');
INSERT INTO HoSoBenhAn (BenhNhanID, BacSiID, ChanDoan, NgayLap) VALUES (22, 11, N'Chấn thương', '2023-01-22');

-- Biên lai
INSERT INTO BienLai (HoSoID, TongTien) VALUES (1, NULL); 
INSERT INTO BienLai (HoSoID, TongTien) VALUES (2, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (3, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (4, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (5, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (6, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (7, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (8, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (9, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (10, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (11, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (12, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (13, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (14, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (15, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (16, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (17, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (18, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (19, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (20, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (21, NULL);
INSERT INTO BienLai (HoSoID, TongTien) VALUES (22, NULL);

-- Dịch vụ
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (1, 1, 1, 1);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (2, 1, 2, 2);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (3, 1, 3, 3);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (4, 1, 4, 4);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (5, 1, 5, 5);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (6, 1, 6, 6);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (7, 1, 7, 7);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (8, 2, 8, 8);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (9, 1, 9, 9);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (10, 1, 10, 10);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (11, 2, 11, 11);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (12, 1, 12, 12);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (1, 1, 13, 13);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (2, 1, 14, 14);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (3, 1, 15, 15);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (4, 1, 16, 16);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (5, 1, 17, 17);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (6, 1, 18, 18);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (7, 1, 19, 19);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (8, 1, 20, 20);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (9, 1, 21, 21);
INSERT INTO DichVu (LoaiDichVuID, SoLan, BienLaiID, BenhNhanID) VALUES (10, 1, 22, 22);

-- Đơn thuốc
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (1, 1, 1, 1, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (2, 3, 1, 1, N'Uống 2 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (3, 1, 1, 1, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (2, 1, 2, 2, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (3, 2, 3, 3, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (4, 1, 4, 4, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (5, 1, 5, 5, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (6, 1, 6, 6, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (7, 1, 7, 7, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (8, 2, 8, 8, N'Uống 2 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (9, 1, 9, 9, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (10, 1, 10, 10, N'Uống 1 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (11, 2, 11, 11, N'Uống 2 viên/ngày');
INSERT INTO DonThuoc (ThuocID, SoLuong, BienLaiID, BenhNhanID, CachDung) VALUES (12, 1, 12, 12, N'Uống 1 viên/ngày');

-- Select all
SELECT * FROM Khoa;
SELECT * FROM Phong;
SELECT * FROM Thuoc;
SELECT * FROM LoaiDichVuKham;
SELECT * FROM BaoHiemYTe;
SELECT * FROM BenhNhan;
SELECT * FROM BacSi;
SELECT * FROM HoSoBenhAn;
SELECT * FROM BienLai;
SELECT * FROM DichVu;
SELECT * FROM DonThuoc;

-- Updata so luong giuong trong trong phong
UPDATE Phong
SET GiuongTrong = TongSoGiuong - COALESCE((SELECT COUNT(*) FROM BenhNhan WHERE PhongID = Phong.PhongID), 0);

-- Updata tong tien trong bien lai
UPDATE BienLai
SET TongTien = (COALESCE(DichVuTien, 0) + COALESCE(DonThuocTien, 0)) * (1 - ISNULL(bh.MienGiam, 0))
FROM BienLai
LEFT JOIN (
    SELECT BienLaiID, SUM(SoLan * GiaDichVu) AS DichVuTien
    FROM DichVu
    JOIN LoaiDichVuKham ON DichVu.LoaiDichVuID = LoaiDichVuKham.LoaiDichVuID
    GROUP BY BienLaiID
) AS DichVuTong ON BienLai.BienLaiID = DichVuTong.BienLaiID
LEFT JOIN (
    SELECT BienLaiID, SUM(SoLuong * GiaThuoc) AS DonThuocTien
    FROM DonThuoc
    JOIN Thuoc ON DonThuoc.ThuocID = Thuoc.ThuocID
    GROUP BY BienLaiID
) AS DonThuocTong ON BienLai.BienLaiID = DonThuocTong.BienLaiID
JOIN BenhNhan bn ON BienLai.BienLaiID = bn.PhongID
LEFT JOIN BaoHiemYTe bh ON bn.BaoHiemID = bh.BaoHiemID;
