USE QUANLYBENHNHAN

GO
CREATE VIEW v_ThongTinBenhNhan AS
SELECT 
  bn.BenhNhanID AS IDBenhNhan,
  bn.HoTen AS HoTenBenhNhan,
  dbo.TinhTuoi(bn.BenhNhanID) AS Tuoi,
  bs.BacSiID AS IDBacSi,
  bs.HoTen AS TenBacSi,
  k.TenKhoa AS KhoaTrucThuoc,
  hs.ChanDoan AS ChuanDoanBenh,
  bl.TongTien AS TongTien
FROM 
  BenhNhan bn
  LEFT JOIN HoSoBenhAn hs ON bn.BenhNhanID = hs.BenhNhanID
  LEFT JOIN BacSi bs ON hs.BacSiID = bs.BacSiID
  LEFT JOIN Khoa k ON bs.KhoaID = k.KhoaID
  LEFT JOIN BienLai bl ON hs.HoSoID = bl.HoSoID;
GO





SELECT * FROM v_ThongTinBenhNhan