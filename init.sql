CREATE DATABASE QUANLYBENHNHAN
USE QUANLYBENHNHAN

-- xóa db
-- USE master
-- DROP DATABASE QUANLYBENHNHAN

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

CREATE TABLE YTa
(
  YTaID INT PRIMARY KEY IDENTITY(1,1),
  HoTen NVARCHAR(100) NOT NULL,
  SDT NVARCHAR(15),
  Email NVARCHAR(100),
  PhongID INT,
  FOREIGN KEY (PhongID) REFERENCES Phong(PhongID)
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
  FOREIGN KEY (PhongID) REFERENCES Phong(PhongID)
);

-- Bảng thuốc
CREATE TABLE Thuoc
(
  ThuocID INT PRIMARY KEY IDENTITY(1,1),
  TenThuoc NVARCHAR(100) NOT NULL,
  DonViTinh NVARCHAR(50),
  GiaThuoc DECIMAL(10, 2)
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

-- Bảng đơn thuốc
CREATE TABLE DonThuoc
(
  DonThuocID INT PRIMARY KEY IDENTITY(1,1),
  HoSoID INT,
  NgayLap DATE,
  FOREIGN KEY (HoSoID) REFERENCES HoSoBenhAn(HoSoID)
);

-- Bảng chi tiết đơn thuốc
CREATE TABLE DonThuocChiTiet
(
  ChiTietID INT PRIMARY KEY IDENTITY(1,1),
  DonThuocID INT,
  ThuocID INT,
  SoLuong INT,
  CachDung NVARCHAR(MAX),
  FOREIGN KEY (DonThuocID) REFERENCES DonThuoc(DonThuocID),
  FOREIGN KEY (ThuocID) REFERENCES Thuoc(ThuocID)
);
GO

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

-- Y Tá
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Mận', '0912345678', 'man@gmail.com', 1);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Viên Thị Linh', '0913456789', 'linh@gmail.com', 1);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Dâu', '0914567890', 'dau@gmail.com', 2);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Kiều Thị Hải Anh', '0915678901', 'hanh@gmail.com', 2);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trần Thị Cam', '0916789012', 'cam@gmail.com', 3);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trần Thị Hạnh', '0917890123', 'hanhtran@gmail.com', 3);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Hà Thị Lê', '0918901234', 'le@gmail.com', 4);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phan Thị Lan', '0919012345', 'lan@gmail.com', 4);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Hồng', '0920123456', 'hong@gmail.com', 5);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Vũ Thị Hoa', '0921234567', 'hoa@gmail.com', 5);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Hằng', '0922345678', 'hang@gmail.com', 6);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Đỗ Thị Ngọc', '0923456789', 'ngoc@gmail.com', 6);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Yến', '0924567890', 'yen@gmail.com', 7);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Hoàng Thị Minh', '0925678901', 'minh@gmail.com', 7);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phạm Thị Quyên', '0926789012', 'quyen@gmail.com', 8);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lê Thị Lan', '0927890123', 'lanle@gmail.com', 8);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Bùi Thị Thu', '0928901234', 'thu@gmail.com', 9);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Ngô Thị Hoa', '0929012345', 'hoa@gmail.com', 9);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trần Thị Thuỳ', '0930123456', 'thuy@gmail.com', 10);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Xuân', '0931234567', 'xuan@gmail.com', 10);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Võ Thị Cúc', '0932345678', 'cuc@gmail.com', 11);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phạm Thị Mai', '0933456789', 'mai@gmail.com', 11);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phạm Thị Lý', '0934567890', 'ly@gmail.com', 12);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Vũ Thị Nhàn', '0935678901', 'nhan@gmail.com', 12);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lê Thị Quế', '0936789012', 'que@gmail.com', 13);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trần Thị Thảo', '0937890123', 'thao@gmail.com', 13);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Phúc', '0938901234', 'phuc@gmail.com', 14);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Hoàng Thị Minh Tuyết', '0939012345', 'tuyet@gmail.com', 14);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phan Thị Bích', '0940123456', 'bich@gmail.com', 15);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Đặng Thị Mỹ', '0941234567', 'my@gmail.com', 15);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Châu', '0942345678', 'chau@gmail.com', 16);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trương Thị Duyên', '0943456789', 'duyen@gmail.com', 16);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Tô Thị Hạnh', '0944567890', 'hanhto@gmail.com', 17);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lý Thị Mai', '0945678901', 'maito@gmail.com', 17);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phạm Thị Huyền', '0946789012', 'huyen@gmail.com', 18);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lưu Thị Liễu', '0947890123', 'lieu@gmail.com', 18);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Huỳnh Thị Thúy', '0948901234', 'thuy@gmail.com', 19);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lâm Thị Hường', '0949012345', 'huong@gmail.com', 19);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Nguyễn Thị Hương', '0950123456', 'huongn@gmail.com', 20);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Lê Thị Thuỳ', '0951234567', 'thuylt@gmail.com', 20);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Vũ Thị Hảo', '0952345678', 'hao@gmail.com', 21);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Phạm Thị Ngân', '0953456789', 'ngan@gmail.com', 21);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Ngô Thị Yến', '0954567890', 'yenngo@gmail.com', 22);
INSERT INTO YTa (HoTen, SDT, Email, PhongID) VALUES (N'Trần Thị Phượng', '0955678901', 'phuong@gmail.com', 22);

-- Bệnh nhân
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Nguyễn Văn Hoàng', '1988-05-12', N'Nam', N'456 Nguyễn Trãi, TP.HCM', '0912567890', '2021-02-15', 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Trần Thị Mai', '1992-07-23', N'Nữ', N'789 Trần Hưng Đạo, TP.HCM', '0912678901', '2021-03-10', 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Lê Văn Nam', '1978-10-10', N'Nam', N'101 Cách Mạng Tháng Tám, TP.HCM', '0912789012', '2021-04-20', 1);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Hoàng Thị Lan', '1983-02-28', N'Nữ', N'202 Điện Biên Phủ, TP.HCM', '0912890123', '2021-05-30', 2);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Phạm Văn Dũng', '1999-12-12', N'Nam', N'303 Lý Thường Kiệt, TP.HCM', '0912901234', '2021-06-10', 3);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Bùi Thị Hương', '1991-04-18', N'Nữ', N'404 Phạm Ngũ Lão, TP.HCM', '0913012345', '2021-07-15', 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Ngô Văn Phát', '1965-03-25', N'Nam', N'505 Huỳnh Tấn Phát, TP.HCM', '0913123456', '2021-08-20', 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Võ Thị Hoa', '1975-11-11', N'Nữ', N'606 Hai Bà Trưng, TP.HCM', '0913234567', '2021-09-05', 4);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Đặng Văn Khải', '1982-01-17', N'Nam', N'707 Võ Văn Tần, TP.HCM', '0913345678', '2021-10-12', 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Nguyễn Thị Thanh', '1989-06-08', N'Nữ', N'808 Nguyễn Thị Minh Khai, TP.HCM', '0913456789', '2021-11-01', 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Nguyễn Thị Lan', '1989-06-08', N'Nữ', N'808 Nguyễn Thị Minh Khai, TP.HCM', '0913456789', '2021-11-01', 5);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Tô Văn Minh', '1994-02-14', N'Nam', N'909 Hùng Vương, TP.HCM', '0913567890', '2021-12-15', 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Trương Thị Ngọc', '1996-08-26', N'Nữ', N'1010 Trường Chinh, TP.HCM', '0913678901', '2022-01-05', 6);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Trần Văn Oanh', '1993-04-03', N'Nam', N'1111 Pasteur, TP.HCM', '0913789012', '2022-02-15', 7);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Phan Thị Phương', '1998-10-30', N'Nữ', N'1212 Nguyễn Văn Cừ, TP.HCM', '0913890123', '2022-03-10', 8);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Hà Văn Quang', '1985-12-24', N'Nam', N'1313 Tân Sơn Nhì, TP.HCM', '0913901234', '2022-04-22', 9);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Vũ Thị Rạng', '1990-09-05', N'Nữ', N'1414 Trần Quang Khải, TP.HCM', '0914012345', '2022-05-30', 10);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Thái Văn Sơn', '1997-06-20', N'Nam', N'1515 Lạc Long Quân, TP.HCM', '0914123456', '2022-06-10', 11);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Lý Thị Thảo', '1987-03-14', N'Nữ', N'1616 Cách Mạng Tháng Tám, TP.HCM', '0914234567', '2022-07-05', 12);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Võ Văn Út', '1968-01-18', N'Nam', N'1717 Nguyễn Văn Trỗi, TP.HCM', '0914345678', '2022-08-01', 13);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Lê Thị Vân', '1972-11-28', N'Nữ', N'1818 Lý Chính Thắng, TP.HCM', '0914456789', '2022-09-20', 14);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Lê Thị Xuân', '1972-11-28', N'Nữ', N'1818 Lý Chính Thắng, TP.HCM', '0914456789', '2022-09-20', 14);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Phạm Văn Duy', '1980-03-15', N'Nam', N'1919 Lê Quang Định, TP.HCM', '0914567890', '2022-10-15', 15);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Trần Thị Ngọc', '1993-06-19', N'Nữ', N'2020 Nguyễn Kiệm, TP.HCM', '0914678901', '2022-11-10', 16);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Nguyễn Văn Quý', '1977-08-09', N'Nam', N'2121 Phan Đăng Lưu, TP.HCM', '0914789012', '2022-12-01', 17);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Đỗ Thị Hằng', '1989-05-25', N'Nữ', N'2222 Trần Quốc Thảo, TP.HCM', '0914890123', '2023-01-20', 18);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Hồ Văn Thịnh', '1995-12-12', N'Nam', N'2323 Hoàng Sa, TP.HCM', '0914901234', '2023-02-05', 19);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Vũ Thị Yến', '1984-07-08', N'Nữ', N'2424 Nguyễn Thị Định, TP.HCM', '0914012345', '2023-03-15', 20);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Phạm Văn Hoàng', '1992-10-11', N'Nam', N'2525 Tôn Đức Thắng, TP.HCM', '0914123456', '2023-04-25', 21);
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, DiaChi, SDT, NgayNhapVien, PhongID) VALUES (N'Bùi Thị Lan', '1987-03-18', N'Nữ', N'2626 Điện Biên Phủ, TP.HCM', '0914234567', '2023-05-05', 22);

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

-- đơn thuốc
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (1, '2023-01-01');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (2, '2023-01-02');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (3, '2023-01-03');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (4, '2023-01-04');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (5, '2023-01-05');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (6, '2023-01-06');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (7, '2023-01-07');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (8, '2023-01-08');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (9, '2023-01-09');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (10, '2023-01-10');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (11, '2023-01-11');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (12, '2023-01-12');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (13, '2023-01-13');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (14, '2023-01-14');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (15, '2023-01-15');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (16, '2023-01-16');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (17, '2023-01-17');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (18, '2023-01-18');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (19, '2023-01-19');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (20, '2023-01-20');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (21, '2023-01-21');
INSERT INTO DonThuoc (HoSoID, NgayLap) VALUES (22, '2023-01-22');


-- đơn thuốc chi tiết
INSERT INTO DonThuocChiTiet (DonThuocID, ThuocID, SoLuong) VALUES (1, 1, 2);



SELECT * FROM Khoa;
SELECT * FROM Phong;
SELECT * FROM YTa;
SELECT * FROM BenhNhan;
SELECT * FROM Thuoc;
SELECT * FROM BacSi;
SELECT * FROM HoSoBenhAn;
SELECT * FROM DonThuoc;
SELECT * FROM DonThuocChiTiet;