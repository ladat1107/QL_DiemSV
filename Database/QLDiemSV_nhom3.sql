CREATE DATABASE QLDiemSV
GO
USE QLDiemSV
 
GO
Create table LOAIGV(
MaLoaiGV int PRIMARY KEY,
TenLoai nvarchar(100) Not null unique
)
 
GO
Create table LOAIPHONG(
MaLoaiPhong int PRIMARY KEY,
TenLoai nvarchar(100) Not null unique
)
 
GO
Create table LOAILOP(
MaLoaiLop int PRIMARY KEY,
TenLoai nvarchar(100) Not null unique
)
 
GO
Create Table TAIKHOAN(
TaiKhoan varchar(50) PRIMARY KEY,
MatKhau varchar(50) Not null,
Loai int not null
)
 
GO
 
Create table KHOA(
MaKhoa varchar(20) PRIMARY KEY,
TenKhoa nvarchar(100) Not null unique,
MaTrKhoa varchar(20) ,
TrangThai bit Not null
)
 
GO
Create table GIANGVIEN(
MaGV varchar(20) PRIMARY KEY,
HoGV nvarchar(100) not null,
TenlotGV nvarchar(100) ,
TenGV nvarchar(100) not null,
CCCD varchar(12) not null unique,
DiaChi nvarchar(100) not null ,
Gioitinh bit not null , --NAM=0 || NU=1
NgaySinh date not null,
SDT varchar(10) not null unique,
Email varchar(100) unique,
MaLoaiGV int not null ,
MaKhoa varchar(20),
TaiKhoan varchar(50) ,
TrangThai bit,
 
CONSTRAINT FK_GIANGVIEN_KHOA FOREIGN KEY(MaLoaiGV) REFERENCES LOAIGV(MaLoaiGV)
          	on update cascade,
CONSTRAINT FK_GIANGVIEN_LOAIGV FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)
on update cascade,
CONSTRAINT FK_GIANGVIEN_TAIKHOAN FOREIGN KEY(TaiKhoan) REFERENCES TAIKHOAN(TaiKhoan)
on delete set null
on update cascade,
)
 
GO
ALTER table KHOA ADD CONSTRAINT FK_TrKhoa FOREIGN KEY(MaTrKhoa) REFERENCES GIANGVIEN(MaGV)
 
GO
Create table SINHVIEN(
MaSV varchar(20) PRIMARY KEY,
HoSV nvarchar(100) not null ,
TenlotSV nvarchar(100),
TenSV nvarchar(100) not null,
CCCD varchar(12) not null unique,
DiaChi nvarchar(100) not null,
Gioitinh bit not null , --NAM || NU
NgaySinh date not null ,
SDT varchar(10) not null unique,
Email varchar(100) unique,
NamNhapHoc int not null,
MaKhoa varchar(20) not null,
TaiKhoan varchar(50),
TrangThai bit not null,
 
CONSTRAINT FK_SINHVIEN_MAKHOA FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa) 
on update cascade,
CONSTRAINT FK_SINHVIEN_TAIKHOAN FOREIGN KEY(TaiKhoan) REFERENCES TAIKHOAN(TaiKhoan)
on delete set null
on update cascade,
)
 
Create table MONHOC(
MaMon varchar(20) PRIMARY KEY,
TenMon nvarchar(100) not null unique,
SoTinChi int not null,
MaKhoa varchar(20),
TrangThai bit not null,
 
CONSTRAINT FK_MONHOC_MAKHOA FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)
on update cascade,
)
 
GO
Create table MONTIENQUYET(
MaMon varchar(20),
MaMonTQ varchar(20),
CONSTRAINT FK_MonTienQuyet FOREIGN KEY (MaMonTQ) REFERENCES MONHOC(MaMon) ,
CONSTRAINT FK_MonHoc FOREIGN KEY (MaMon) REFERENCES MONHOC(MaMon) ,
primary key(MaMon,MaMonTQ)
)
 
GO
Create table PHONGHOC(
MaPhong varchar(20) PRIMARY KEY,
MaLoaiPhong int not null,
SucChua int not null ,
Toa nvarchar(100) not null,
 
CONSTRAINT FK_PHONGHOC_LOAIPHONG FOREIGN KEY(MaLoaiPhong) REFERENCES LOAIPHONG(MaLoaiPhong)
on update cascade,
)
 
GO
Create table CAHOC(
MaCa varchar(20) PRIMARY KEY,
TGBatDau time not null ,
TGKetThuc time not null
)
 
GO
Create table LOP(
MaLop varchar(20) PRIMARY KEY,
TenLop nvarchar(100) not null  ,
MaLoaiLop int,
SL int not null,
HK int not null ,
Namhoc int not null,
MaGV varchar(20) not null,
MaMon varchar(20) not null,
 
CONSTRAINT FK_LOP_LOAILOP FOREIGN KEY(MaLoaiLop) REFERENCES LOAILOP(MaLoaiLop)
on update cascade,
CONSTRAINT FK_LOP_GIANGVIEN FOREIGN KEY(MaGV) REFERENCES GIANGVIEN(MaGV) 
on update cascade,
CONSTRAINT FK_LOP_MOMHOC FOREIGN KEY(MaMon) REFERENCES MONHOC(MaMon),
)
 
GO
Create table BUOIHOC(
MaLop varchar(20) ,
MaCa varchar(20),
MaPhong varchar(20),
Thu int,
 
PRIMARY KEY(MaLop,MaCa,MaPhong,Thu),
CONSTRAINT FK_BUOIHOC_LOP FOREIGN KEY(MaLop) REFERENCES LOP(MaLop)
on delete cascade
on update cascade,
CONSTRAINT FK_BUOIHOC_CAHOC FOREIGN KEY(MaCa) REFERENCES CAHOC(MaCa) 
on update cascade,
CONSTRAINT FK_BUOIHOC_PHONGHOC FOREIGN KEY(MaPhong) REFERENCES PHONGHOC(MaPhong) 
on update cascade
)
 
 
GO
Create table DIEM(
MaSV varchar(20),
MaLop varchar(20),
DiemQT decimal(4,2),
DiemCK decimal(4,2),
 
PRIMARY KEY(MaSV,MaLop),
CONSTRAINT FK_DIEM_SINHVIEN FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MaSV)
on update cascade,
CONSTRAINT FK_DIEM_LOP FOREIGN KEY(MaLop) REFERENCES LOP(MaLop)
on delete cascade
)
 
 
--CHECK EMAIL
GO
CREATE FUNCTION ChkEmail(@EMAIL varchar(100)) RETURNS bit
AS BEGIN 
  DECLARE @bitEmailVal as Bit
  DECLARE @EmailText varchar(100)
 
  SET @EmailText=ltrim(rtrim(@EMAIL))
 
  SET @bitEmailVal = case  when @EmailText is null then 1
when @EmailText = '' then 0
          	           	when @EmailText like '% %' then 0
          	           	when @EmailText like ('%["(),:;<>\]%') then 0
          	           	when substring(@EmailText,charindex('@',@EmailText),len(@EmailText)) like ('%[!#$%&*+/=?^`_{|]%') then 0
          	           	when (left(@EmailText,1) like ('[-_.+]') or right(@EmailText,1) like ('[-_.+]')) then 0    	   	          	                         	                    	          	          	
          	           	when (@EmailText like '%[%' or @EmailText like '%]%') then 0
          	           	when @EmailText LIKE '%@%@%' then 0
          	           	when @EmailText NOT LIKE '_%@_%._%' then 0
          	           	else 1
      		          	   end
  RETURN @bitEmailVal
END
GO
 
-- TAI KHOAN
 ALTER TABLE TAIKHOAN ADD CONSTRAINT ChkTaiKhoan Check(NOT TaiKhoan like ('%[!#$%&*+/=?^`{|"(),:;<>\-.+]%') )
 
--GIANGVIEN
ALTER TABLE GIANGVIEN ADD CONSTRAINT HoTenGVNotNum Check(NOT (HoGV like '% [0-9]%' OR TenLotGV like '% [0-9]%' OR TenGV like '% [0-9]%'))
ALTER TABLE GIANGVIEN ADD CONSTRAINT ChkEmailGV Check([dbo].ChkEmail(Email)=1)
Alter table GIANGVIEN ADD CONSTRAINT ChkSdtGV Check(isnumeric(SDT)=1 and len(SDT)=10)
Alter table GIANGVIEN ADD CONSTRAINT ChkCccdGV Check(isnumeric(CCCD)=1 and len(CCCD)=12)
 
 
 
--SINH VIEN
ALTER TABLE SINHVIEN ADD CONSTRAINT HoSVNotNum Check(NOT (HoSV like '% [0-9]%' OR TenLotSV like '% [0-9]%' OR TenSV like '% [0-9]%'))
ALTER TABLE SINHVIEN ADD CONSTRAINT ChkEmailSV Check([dbo].ChkEmail(Email)=1)
Alter table SINHVIEN ADD CONSTRAINT ChkSdtSV Check(isnumeric(SDT)=1 and len(SDT)=10)
Alter table SINHVIEN ADD CONSTRAINT ChkCccdSV Check(isnumeric(CCCD)=1 and len(CCCD)=12)
 
--DIEM
Alter table DIEM ADD CONSTRAINT ChkDiemQT Check(DiemQT>=0.0 and DiemQT<=10.0)
Alter table DIEM ADD CONSTRAINT ChkDiemCK Check(DiemCK>=0.0 and DiemCK<=10.0)
 
--KHOA
ALTER TABLE KHOA ADD CONSTRAINT TenKhoaNotNum Check(NOT TenKhoa like '% [0-9]%')
 
--LOAIGV
ALTER TABLE LOAIGV ADD CONSTRAINT TenLoaiGVNotNum Check(NOT TenLoai like '% [0-9]%')
 
--LOAIPHONG
ALTER TABLE LOAIPHONG ADD CONSTRAINT TenLoaiPhongNotNum Check(NOT TenLoai like '% [0-9]%')
 
--LOAILOP
ALTER TABLE LOAILOP ADD CONSTRAINT TenLoaiLopNotNum Check(NOT TenLoai like '% [0-9]%')
 
 -- trigger xóa loại Phòng học
GO
CREATE TRIGGER tg_DelLoaiPhong ON LOAIPHONG
AFTER DELETE AS
          	DECLARE @MaLoaiPhong int
          	SELECT @MaLoaiPhong = deleted.MaLoaiPhong
          	FROM deleted
IF (@MaLoaiPhong IN (SELECT MaLoaiPhong FROM Phonghoc))
          	BEGIN
                         	RAISERROR (N'Không thể xóa loại phòng học!', 16,1);
 
                         	ROLLBACK
          	END
-- trigger xóa loại GV
GO
CREATE TRIGGER tg_DelLoaiGV ON LOAIGV
AFTER DELETE AS
          	DECLARE @MaLoaiGV int
          	SELECT @MaLoaiGV = deleted.MaLoaiGV
          	FROM deleted
IF (@MaLoaiGV IN (SELECT MaLoaiGV FROM Giangvien))
          	BEGIN
                         	RAISERROR (N'Không thể xóa loại giảng viên!', 16,1); ROLLBACK
          	END
-- trigger xóa loại Lớp học
GO
CREATE TRIGGER tg_DelLoaiLop ON LOAILOP
AFTER DELETE AS
          	DECLARE @MaLoaiLop int
          	SELECT @MaLoaiLop = deleted.MaLoaiLop
          	FROM deleted
IF (@MaLoaiLop IN (SELECT MaLoaiLop FROM Lop))
          	BEGIN
                         	RAISERROR (N'Không thể xóa loại lớp học!', 16,1); ROLLBACK
          	END
--trigger xóa ca học
GO
CREATE TRIGGER tg_DelCaHoc ON CAHOC
AFTER DELETE AS
          	DECLARE @MaCa varchar(20)
          	SELECT @MaCa = deleted.MaCa
          	FROM deleted
IF(@MaCa IN (SELECT MaCa FROM BUOIHOC))
          	BEGIN
RAISERROR (N'Không thể xóa ca học!', 16,1); ROLLBACK
          	END
 
-- trigger xóa khoa
GO
CREATE TRIGGER tg_DelKhoa ON KHOA
INSTEAD OF DELETE AS
          	DECLARE @MaKhoa varchar(20)
          	SELECT @MaKhoa = deleted.MaKhoa
          	FROM deleted
BEGIN
          	UPDATE KHOA
          	SET TrangThai = 0
          	WHERE KHOA.MaKhoa = @MaKhoa
END
-- trigger xóa giảng viên set lại trangthai và XÓA TK
GO
CREATE TRIGGER tg_DelGiangVien ON GIANGVIEN
INSTEAD OF DELETE AS
          	DECLARE @MaGV varchar(20)
          	SELECT @MaGV = deleted.MaGV
          	FROM deleted
BEGIN
          	UPDATE GIANGVIEN
          	SET TrangThai = 0
          	WHERE GIANGVIEN.MaGV = @MaGV
delete TaiKhoan where TaiKhoan=@MaGV
END
-- trigger xóa sinh viên set lại trangthai và XÓA TK
GO
Create TRIGGER tg_DelSinhVien ON SINHVIEN
INSTEAD OF DELETE AS
          	DECLARE @MaSV varchar(20)
          	SELECT @MaSV = deleted.MaSV
          	FROM deleted
BEGIN
          	
          	UPDATE SINHVIEN
          	SET TrangThai = 0
          	WHERE SINHVIEN.MaSV = @MaSV
          	delete TaiKhoan where TaiKhoan=@MaSV
END
 
 
 GO
 
 -- Trigger Kiểm tra SL của lớp với sức chứa phòng học
Create trigger tg_KtrSlSinhvienPhonghoc on BuoiHoc after insert, update
as Declare @SLSVTD int, @Succhua int, @MaLop varchar(20), @MaPhong varchar(20)
BEGIN
-- Lấy mã lớp và Mã phòng vừa thêm
Select @MaLop=n.MaLop, @MaPhong = n.MaPhong From Inserted n
--Lấy SL max học viên trong lớp
Select @SLSVTD = SL from LOP where @MaLop=MaLop
--Lấy sức chứa phòng học
Select @Succhua= SucChua from PHONGHOC where @MaPhong=MaPhong
 
if(@SLSVTD>@Succhua)
Begin
RAISERROR (N'Số lượng sinh viên vượt quá sức chứa của phòng', 16,1); Rollback;
end
END
 
GO
-- trigger Kiểm tra sl sinh vien them vao lop MAX
 
CREATE TRIGGER tg_KtrSLSinhvienLop ON Diem
AFTER INSERT  as DECLARE @SLSV INT , @max_limit INT, @MaLop varchar(20)
BEGIN
          	-- Lấy mã lớp vừa thêm/sửa
          	SELECT @MaLop=n.MaLop FROM Inserted n
 
          	-- Lấy số lượng sinh viên hiện tại trong lớp học
          	SELECT @SLSV =COUNT(MaSV) FROM Diem WHERE MaLop = @MaLop; 
          	
          	-- Lấy giới hạn tối đa cho lớp học
          	SELECT @max_limit=SL  FROM LOP where MaLop=@MaLop; 
 
          	-- Kiểm tra nếu số lượng sinh viên hiện tại vượt quá giới hạn
          	IF @SLSV > @max_limit
          	BEGIN
          	RAISERROR (N'Lớp học đã đủ số lượng sinh viên', 16,1);Rollback
          	END
 
END
 
--Function tạo mã sinh viên
GO
CREATE FUNCTION ft_TaoMaSV (@NamHoc int, @MaKhoa varchar(20)) RETURNS varchar(20)
AS
BEGIN
          	DECLARE @MaSVMoi varchar(20), @MaSVCu varchar(20)
          	SELECT TOP 1 @MaSVCu = MaSV
          	FROM SINHVIEN
          	WHERE @NamHoc = SINHVIEN.NamNhapHoc AND @MaKhoa = SINHVIEN.MaKhoa
          	ORDER BY MaSV DESC
          	
          	IF(@MaSVCu = '00000000')
      		SET @MaSVMoi = CONCAT (CAST(@NamHoc - 2000 AS varchar(2)), @MaKhoa, '0001')
          	ELSE
      		SET @MaSVMoi = CAST((CAST(@MaSVCu AS INT) + 1) AS varchar(20))
          	RETURN @MaSVMoi
END
GO
 
--trigger thêm sinh viên
GO
CREATE TRIGGER tg_ThemSV ON SINHVIEN
AFTER INSERT AS
          	DECLARE @MaSV varchar(20), @Email varchar(100), @NamHoc int, @MaKhoa varchar(20)
BEGIN
          	SELECT @Email = Email, @NamHoc = NamNhapHoc, @MaKhoa = MaKhoa
          	FROM inserted
 
          	SET @MaSV = DBO.ft_TaoMaSV(@NamHoc, @MaKhoa)
          	IF(@Email is null)
      		SET @Email  = CONCAT (@MaSV, '@student.hcmu.edu.vn')
 
          	INSERT INTO TAIKHOAN (TaiKhoan, MatKhau, Loai)
          	VALUES (@MaSV, '12345', 1);
 
          	UPDATE SINHVIEN
          	SET SINHVIEN.MaSV = @MaSV, SINHVIEN.Email = @Email, SINHVIEN.TaiKhoan = @MaSV
          	WHERE SINHVIEN.MaSV = '00000000'
END
--Function tạo Mã giảng viên
GO
create FUNCTION ft_TaoMaGV (@MaKhoa varchar(20)) RETURNS varchar(20)
AS
BEGIN
          	DECLARE @MaGVMoi varchar(20), @MaGVCu varchar(20)
          	IF(@MaKhoa is null)
  	                   	BEGIN
          	    SELECT TOP 1 @MaGVCu = MaGV
          	    FROM GIANGVIEN
          	    WHERE GIANGVIEN.MaKhoa is null
          	    ORDER BY MaGV DESC
 
         	     IF (@MaGVCu = '0000000')
                 	    	   SET @MaGVMoi = CONCAT('2000', '001')
          	    ELSE
                 	    	   SET @MaGVMoi =  CAST((CAST(@MaGVCu AS INT)+1) AS varchar(20))
  	                   	END
          	ELSE
  	                   	BEGIN
          	    SELECT TOP 1 @MaGVCu = MaGV
          	    FROM GIANGVIEN
          	    WHERE GIANGVIEN.MaKhoa = @MaKhoa
	       	   ORDER BY MaGV DESC
 
          	    IF (@MaGVCu = '0000000')
                 	    	   SET @MaGVMoi = CONCAT (@MaKhoa, '00001')
          	    ELSE
                 	    	   SET @MaGVMoi = CAST((CAST(@MaGVCu AS INT)+1) AS varchar(20))
                         	END
          	RETURN @MaGVMoi
END
 
--Trigger thêm giảng viên
GO
create TRIGGER tg_ThemGV ON GIANGVIEN
AFTER INSERT AS
          	DECLARE @Email varchar(100), @MaKHoa varchar(20), @MaGV varchar(20), @HoGV nvarchar(100), @TenGV nvarchar(100)
BEGIN
          	SELECT @HoGV = HoGV, @TenGV = TenGV, @MaKHoa = MaKhoa
          	FROM inserted
 
          	SET @MaGV = DBO.ft_TaoMaGV(@MaKHoa)
          	IF(@Email is null)
      		SET @Email = CONCAT (@MaGV, '@teacher.vnu.edu.vn')
          	
          	INSERT INTO TAIKHOAN (TaiKhoan, MatKhau, Loai)
          	VALUES (@MaGV, '12345', 2);
 
          	UPDATE GIANGVIEN
          	SET MaGV = @MaGV, Email = @Email, TaiKhoan = @MaGV
          	WHERE MaGV = '0000000'
END

 
--Function tạo mã lớp
GO
CREATE FUNCTION ft_TaoMaLop (@MaMon varchar(20), @NamHoc int) RETURNS varchar(20)
AS
BEGIN
          	DECLARE @MaLopCu varchar(20), @MaLopMoi varchar(20)
          	SELECT TOP 1 @MaLopCu = MaLop
          	FROM LOP
          	WHERE @NamHoc = LOP.Namhoc AND @MaMon = LOP.MaMon
          	ORDER BY MaLop DESC
 
          	IF (@MaLopCu = '00000000')
      		SET @MaLopMoi = CONCAT ( @MaMon, CAST(@NamHoc - 2000 AS varchar(2)), '01')
          	ELSE
      		SET @MaLopMoi = CAST((CAST(@MaLopCu AS INT) + 1) AS varchar(20))
          	RETURN @MaLopMoi
END
--Trigger thêm lớp
GO
CREATE TRIGGER tg_ThemLop ON LOP
AFTER INSERT AS
          	DECLARE @MaMon varchar(20), @NamHoc int, @MaLop varchar(20)
BEGIN
          	SELECT @MaMon = MaMon, @NamHoc = NamHoc
          	FROM inserted
 
          	SET @MaLop = DBO.ft_TaoMaLop(@MaMon, @NamHoc)
 
          	UPDATE LOP
          	SET MaLop = @MaLop
          	WHERE MaLop = '00000000'
END
 
--Thông tin giảng viên
GO
CREATE VIEW vi_ThongTinGV
AS
          	WITH TRUONGKHOA AS
          	(SELECT GIANGVIEN.MaGV, KHOA.TenKhoa
          	 FROM GIANGVIEN LEFT JOIN KHOA ON GIANGVIEN.MaGV = KHOA.MaTrKhoa)
 
          	SELECT GIANGVIEN.MaGV, CONCAT (GIANGVIEN.HoGV,' ', GIANGVIEN.TenlotGV,' ', GIANGVIEN.TenGV) AS TenGV,
      		   GIANGVIEN.CCCD, GIANGVIEN.DiaChi,
      		   CASE GIANGVIEN.GioiTinh WHEN 0 THEN N'Nam' WHEN 1 THEN N'Nữ' END AS GioiTinh,
      		   GIANGVIEN.NgaySinh, GIANGVIEN.SDT, GIANGVIEN.Email,
      		   KHOA.TenKhoa, TRUONGKHOA.TenKhoa AS TruongKhoa, LOAIGV.TenLoai AS LoaiGV, GIANGVIEN.TaiKhoan
          	FROM GIANGVIEN, LOAIGV, KHOA, TRUONGKHOA
          	WHERE GIANGVIEN.MaLoaiGV = LOAIGV.MaLoaiGV AND GIANGVIEN.MaKhoa = KHOA.MaKhoa
      		  AND  GIANGVIEN.MaGV = TRUONGKHOA.MaGV AND GIANGVIEN.TrangThai = 1
 
GO
 

--Procedure bắt lỗi
GO
CREATE PROCEDURE pr_ConstraintError
@Message nvarchar(3000)
AS
	BEGIN
		IF @Message LIKE '%ChkTaiKhoan%' RAISERROR (N'Tài khoản không được chứa ký tự đặt biệt',16,1) 
		ELSE IF @Message LIKE '%HoTenGVNotNum%' RAISERROR (N'Họ tên giảng viên không được chứa số',16,1) 
		ELSE IF @Message LIKE '%HoTenSVNotNum%' RAISERROR (N'Họ tên sinh viên không được chứa số',16,1) 
		ELSE IF @Message LIKE '%ChkEmail%' RAISERROR (N'Email không hợp lệ',16,1) 
		ELSE IF @Message LIKE '%ChkSdt%' RAISERROR (N'Số điện thoại không hợp lệ',16,1) 
		ELSE IF @Message LIKE '%ChkCccd%' RAISERROR (N'Căn cước công dân không hợp lệ',16,1) 
		ELSE IF @Message LIKE '%ChkDiem%' RAISERROR (N'Điểm vừa nhập không hợp lệ',16,1) 
		ELSE IF @Message LIKE '%TenKhoaNotNum%' RAISERROR (N'Tên khoa không được chứa số',16,1) 
		ELSE IF @Message LIKE '%TenLoaiGVNotNum%' RAISERROR (N'Tên loại giảng không được chứa số',16,1)
		ELSE IF @Message LIKE '%TenLoaiPhongNotNum%' RAISERROR (N'Tên loại phòng không được chứa số',16,1)
		ELSE IF @Message LIKE '%TenLoaiLopNotNum%' RAISERROR (N'Tên loại lớp không được chứa số',16,1) 
		ELSE IF @Message LIKE '%duplicate%' RAISERROR (N'Thông tin vừa nhập đã tồn tại',16,1)
		ELSE IF @Message LIKE '%FOREIGN KEY%' RAISERROR (N'Lỗi khóa ngoại',16,1)
		ELSE RAISERROR(@Message,16,1)
	END

GO
GO

CREATE PROCEDURE pr_InsertLop
    @TenLop nvarchar(100),
    @MaLoaiLop int,
    @SL int,
    @HK int,
    @Namhoc int,
    @MaGV varchar(20),
    @MaMon varchar(20),
    @MaCa varchar(20),
    @MaPhong varchar(20),
    @Thu int
AS
BEGIN
    BEGIN TRANSACTION; -- Bắt đầu giao dịch

	
    BEGIN TRY
		DECLARE @MaLop varchar(20)
        -- Thêm dữ liệu vào bảng LOP

        INSERT INTO LOP (MaLop, TenLop, MaLoaiLop, SL, HK, Namhoc, MaGV, MaMon)
        VALUES ('00000000', @TenLop, @MaLoaiLop, @SL, @HK, @Namhoc, @MaGV, @MaMon);

		select Top 1 @Malop = MaLop
		FROM LOP 
		WHERE LOP.MaMon = @MaMon and LOP.Namhoc = @Namhoc
		ORDER BY MaLOP DESC

        -- Thêm dữ liệu vào bảng BUOIHOC
        INSERT INTO BUOIHOC (MaLop, MaCa, MaPhong, Thu)
        VALUES (@MaLop, @MaCa, @MaPhong, @Thu);

        COMMIT TRANSACTION; -- Lưu thay đổi nếu không có lỗi
    END TRY
    BEGIN CATCH
		DECLARE @ERROR nvarchar(200)
		SELECT @ERROR = ERROR_MESSAGE()
		RAISERROR(@ERROR,16,1)
        ROLLBACK TRANSACTION; -- Hủy bỏ nếu có lỗi

    END CATCH
END;


GO
-- Procedure them giang vien
CREATE PROC pr_InsertGiangVien 
@Ho nvarchar(100),
@Lot nvarchar(100),
@Ten nvarchar(100),
@CCCD varchar(12),
@DiaChi nvarchar(100),
@GioiTinh bit,
@NgaySinh date,
@SDT varchar(10),
@Email varchar(100),
@MaLoai int,
@MaKhoa varchar(20),
@TaiKhoan varchar(50),
@TrangThai bit
AS
	BEGIN TRY
		INSERT INTO GIANGVIEN VALUES ( '0000000', @Ho, @Lot, @Ten, @CCCD, @DiaChi, @GioiTinh, @NgaySinh, @SDT, @Email, @MaLoai, @MaKhoa, @TaiKhoan, @TrangThai) 
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
-- Procedure update giang vien
CREATE PROCEDURE pr_UpdateGiangVien 
@MaGV varchar(20),
@Ho nvarchar(100),
@Lot nvarchar(100),
@Ten nvarchar(100),
@CCCD varchar(12),
@DiaChi nvarchar(100),
@GioiTinh bit,
@NgaySinh date,
@SDT varchar(10),
@Email varchar(100),
@MaLoai int,
@MaKhoa varchar(20),
@TaiKhoan varchar(50),
@TrangThai bit
AS
BEGIN TRY
	UPDATE GIANGVIEN SET 
	HoGV= @Ho,
	TenlotGV= @Lot, 
	TenGV= @Ten,
	CCCD= @CCCD,
	DiaChi= @DiaChi,
	Gioitinh = @GioiTinh,
	NgaySinh = @NgaySinh,
	SDT= @SDT,
	Email = @Email,
	MaLoaiGV= @MaLoai,
	MaKhoa = @MaKhoa,
	TaiKhoan= @TaiKhoan,
	TrangThai= @TrangThai
	WHERE MaGV=@MaGV
END TRY
BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Procedure delete giang vien
CREATE PROCEDURE pr_DeleteGiangVien 
@MaGV varchar(20)
AS
	BEGIN TRY
		DELETE GIANGVIEN WHERE MaGV=@MaGV
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Procedure them diem
CREATE PROCEDURE pr_InsertDiem 
@MaSV varchar(20),
@MaLop varchar(20),
@DiemQT decimal(4,2),
@DiemCK decimal(4,2)
AS
	BEGIN TRY
		INSERT INTO DIEM VALUES (@MaSV, @MaLop, @DiemQT, @DiemCK)
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Procedure update diem
CREATE PROCEDURE pr_UpdateDiem 
@MaSV varchar(20),
@MaLop varchar(20),
@DiemQT decimal(4,2),
@DiemCK decimal(4,2)
AS
	BEGIN TRY
		UPDATE DIEM SET 
		DiemQT = @DiemQT, 
		DiemCK=	@DiemCK
		WHERE MaSV = @MaSV AND MaLop = @MaLop
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
-- delete diem
CREATE PROCEDURE pr_DeleteDiem
@MaSV varchar(20),
@MaLop varchar(20)
AS
	BEGIN TRY
		DELETE DIEM WHERE MaSV = @MaSV AND MaLop = @MaLop
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO

--Procedure Them Buoi hoc
CREATE PROCEDURE pr_InsertBuoiHoc
@MaLop varchar(20),
@MaCa varchar(20),
@MaPhong varchar(20),
@Thu int
AS	
	BEGIN TRY
		INSERT INTO BUOIHOC VALUES (@MaLop, @MaCa, @MaPhong, @Thu)
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Procedure Update Buoi Hoc
CREATE PROCEDURE pr_UpdateBuoiHoc
@MaLop varchar(20),
@MaCa varchar(20),
@MaPhong varchar(20),
@Thu int
AS	
	BEGIN TRY
		UPDATE BUOIHOC SET MaLop = @MaLop, MaCa = @MaCa , MaPhong = @MaPhong, Thu = @Thu 
		WHERE MaLop = @MaLop AND MaCa = @MaCa AND MaPhong = @MaPhong AND Thu = @Thu
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Procedure delete buoi hoc
CREATE PROCEDURE pr_DeleteBuoiHoc
@MaLop varchar(20),
@MaCa varchar(20),
@MaPhong varchar(20),
@Thu int
AS	
	BEGIN TRY
		DELETE BUOIHOC
		WHERE MaLop = @MaLop AND MaCa = @MaCa AND MaPhong = @MaPhong AND Thu = @Thu
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH


GO
--Proceduce Them Khoa
CREATE PROCEDURE pr_InsertKhoa
@MaKhoa varchar(20),
@TenKhoa nvarchar(100),
@MaTruongKhoa varchar(20),
@TrangThai bit
AS
	BEGIN TRY
		INSERT INTO KHOA VALUES (@MaKhoa, @TenKhoa, @MaTruongKhoa, @TrangThai)
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Proceduce Update Khoa
CREATE PROCEDURE pr_UpdateKhoa
@MaKhoa varchar(20),
@TenKhoa nvarchar(100),
@MaTruongKhoa varchar(20),
@TrangThai bit
AS
	BEGIN TRY
		UPDATE KHOA SET TenKhoa= @TenKhoa , MaTrKhoa= @MaTruongKhoa, TrangThai = @TrangThai
		WHERE MaKhoa = @MaKhoa
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--Proceduce Delete Khoa
CREATE PROCEDURE pr_DeleteKhoa
@MaKhoa varchar(20)
AS
	BEGIN TRY
		DELETE KHOA WHERE MaKhoa = @MaKhoa
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH





-----CODE CUA MINH DUONG --------
GO
CREATE PROC PR_UpdateLOP
	@MaLop varchar(20),
	@TenLop nvarchar(100),
    @MaLoaiLop int,
    @SL int,
    @HK int,
    @Namhoc int,
    @MaGV varchar(20),
    @MaMon varchar(20)
AS 
	BEGIN TRY
		UPDATE LOP SET LOP.TenLop = @TenLop, LOP.MaLoaiLop = @MaLoaiLop, LOP.SL = @SL, LOP.HK = @HK,
					LOP.Namhoc = @Namhoc, LOP.MaGV = @MaGV, LOP.MaMon = @MaMon
		WHERE LOP.MaLop = @MaLop
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH
-----
GO 
CREATE PROC PR_DeleteLOP
	@MaLop varchar(20)
AS
	BEGIN TRY
		DELETE FROM LOP WHERE LOP.MaLop = @MaLop
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH
-----
GO
CREATE PROC PR_InsertMONHOC
	@MaMon varchar(20),
	@TenMon nvarchar(100),
	@SoTinChi int,
	@MaKhoa varchar(20),
	@TrangThai bit
AS
	BEGIN  TRY
		INSERT INTO MONHOC (MaMon, TenMon, SoTinChi, MaKhoa, TrangThai)
		VALUES (@MaMon, @TenMon, @SoTinChi, @MaKhoa, @TrangThai)
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

-----
GO
CREATE PROC PR_UpdateMONHOC
	@MaMon varchar(20),
	@TenMon nvarchar(100),
	@SoTinChi int,
	@MaKhoa varchar(20),
	@TrangThai bit
AS
	BEGIN TRY
		UPDATE MONHOC SET MONHOC.TenMon = @TenMon, MONHOC.SoTinChi = @SoTinChi,
						MONHOC.MaKhoa = @MaKhoa, MONHOC.TrangThai = @TrangThai
		WHERE MONHOC.MaMon = @MaMon
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

------
GO
CREATE PROC PR_DeleteMONHOC
	@MaMon varchar(20)
AS
	BEGIN TRY
		DELETE FROM MONHOC WHERE MONHOC.MaMon = @MaMon
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH
-----
GO
CREATE PROC PR_InsertMONTQ
	@MaMon varchar(20),
	@MaMonTQ varchar(20)
AS
	BEGIN TRY
		INSERT INTO MONTIENQUYET (MaMon, MaMonTQ)
		VALUES (@MaMon, @MaMonTQ)
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH
----
GO 
CREATE PROC PR_DeleteMONTQ
	@MaMon varchar(20),
	@MaMonTQ varchar(20)
AS
	BEGIN TRY
		DELETE FROM MONTIENQUYET WHERE MONTIENQUYET.MaMon = @MaMon AND MONTIENQUYET.MaMonTQ = @MaMonTQ
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH


-----CODE CUA THANH DAT --------

GO

CREATE PROC pr_InsertSinhVien 
@Ho nvarchar(100),
@Lot nvarchar(100),
@Ten nvarchar(100),
@CCCD varchar(12),
@DiaChi nvarchar(100),
@GioiTinh bit,
@NgaySinh date,
@SDT varchar(10),
@Email varchar(100),
@NamNhapHoc int,
@MaKhoa varchar(20),
@TaiKhoan varchar(50),
@TrangThai bit
AS
	BEGIN TRY
		INSERT INTO SINHVIEN VALUES ( '00000000', @Ho, @Lot, @Ten, @CCCD, @DiaChi, @GioiTinh, @NgaySinh, @SDT, @Email, @NamNhapHoc, @MaKhoa, @TaiKhoan, @TrangThai) 
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
CREATE PROCEDURE pr_UpdateSinhVien 
@MaSV varchar(20),
@Ho nvarchar(100),
@Lot nvarchar(100),
@Ten nvarchar(100),
@CCCD varchar(12),
@DiaChi nvarchar(100),
@GioiTinh bit,
@NgaySinh date,
@SDT varchar(10),
@Email varchar(100),
@NamNH int,
@MaKhoa varchar(20),
@TaiKhoan varchar(50),
@TrangThai bit
AS
BEGIN TRY
	UPDATE SINHVIEN SET 
	HoSV= @Ho,
	TenlotSV= @Lot, 
	TenSV= @Ten,
	CCCD= @CCCD,
	DiaChi= @DiaChi,
	Gioitinh = @GioiTinh,
	NgaySinh = @NgaySinh,
	SDT= @SDT,
	Email = @Email,
	NamNhapHoc= @NamNH,
	MaKhoa = @MaKhoa,
	TaiKhoan= @TaiKhoan,
	TrangThai= @TrangThai
	WHERE MaSV=@MaSV
END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH


GO
-----
GO

CREATE PROC pr_DeleteSinhVien 
@MaSV varchar(20)
AS
	BEGIN TRY
		DELETE SINHVIEN WHERE MaSV = @MaSV
	END TRY
	BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH


GO

--- Proc thêm tài khoản ---
GO
CREATE PROC pr_InsertTaiKhoan
		@TaiKhoan varchar(50),
        @MatKhau varchar(50),
        @Loai int
AS
BEGIN TRY
INSERT INTO TAIKHOAN
     VALUES (@TaiKhoan, @MatKhau, @Loai)
END TRY
BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--- Proc cập nhật tài khoản ---
CREATE PROC pr_UpdateTaiKhoan
		@TaiKhoan varchar(50),
        @MatKhau varchar(50),
        @Loai int
AS
BEGIN TRY
	UPDATE TAIKHOAN
	   SET   MatKhau = @MatKhau,  Loai = @Loai	WHERE TaiKhoan = @TaiKhoan
END TRY
BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO
--- Proc xóa tài khoản ---
CREATE PROC pr_DeleteTaiKhoan
		@TaiKhoan varchar(50)
AS
BEGIN TRY
	DELETE FROM TAIKHOAN
		  WHERE TaiKhoan = @TaiKhoan
END TRY
BEGIN CATCH
		DECLARE @ERROR nvarchar(3000)
		SELECT @ERROR = ERROR_MESSAGE()
		EXEC pr_ConstraintError @ERROR
	END CATCH

GO

 
 GO
--trigger kiểm tra trung Buổi học
Create trigger tg_KtrThemBuoiHoc on BuoiHoc after insert, update
as declare @HK int,@NamHoc int, @SoLop int
BEGIN
          	--Lấy học kỳ, năm học của lớp mới
          	select @HK=HK,@NamHoc=Namhoc from inserted n, LOP
          	where n.MaLop=LOP.MaLop
          	--Lấy số lớp bị trùng
          	select @SoLop=count(*) from LOP as L,
                         	          	--Lấy các lớp có Cahoc,Thứ,Phòng trùng nhau
                         	          	(Select bh.MaLop from inserted n, BUOIHOC as bh
                         	          	 where n.MaCa=bh.MaCa and n.Thu=bh.Thu and  	n.MaPhong=bh.MaPhong) as Q
          	where L.MaLop=Q.MaLop and L.HK=@HK and L.Namhoc=@NamHoc
          	--Nếu >1 là trùng
          	IF(@SoLop>1)
          	BEGIN
          	RAISERROR (N'Trùng thời gian học', 16,1);
 	     	          	RollBack;
          	END   	
END
 
 
--View Xem Diem Theo Lop
GO
CREATE VIEW vi_DiemTBTheoLop AS
          	SELECT *,
     	 	CASE
            	         	WHEN NOT (DIEM.DiemQT is null OR DIEM.DiemCK is null) THEN ROUND((DIEM.DiemQT+DIEM.DiemCK)/2,1)
 
            	         	ELSE NULL
     	 	END  DiemTB,
     	 	CASE
           	          	WHEN (DIEM.DiemQT is null OR DIEM.DiemCK is null) THEN 0
            	         	WHEN ROUND((DIEM.DiemQT+DIEM.DiemCK)/2,1) >= 5 AND DIEM.DiemCK >= 3 THEN 2
            	         	ELSE 1
     	 	END AS QUAMON
          	FROM DIEM
 
 
--View Xem Diem Theo Mon Hoc
GO
CREATE VIEW vi_DiemTBTheoMon AS
WITH SortDiemTheoMon AS (
  SELECT
          	MaSV, LOP.MaMon, DiemTB, QUAMON,
	ROW_NUMBER() OVER(PARTITION BY MaSV, LOP.MaMon ORDER BY QUAMON DESC, DiemTB DESC) AS row_number
          	FROM vi_DiemTBTheoLop JOIN LOP ON vi_DiemTBTheoLop.MaLop = Lop.MaLop
          	WHERE NOT vi_DiemTBTheoLop.QUAMON = 0
)
          	SELECT MaSV, MaMon, DiemTB, QUAMON
          	FROM SortDiemTheoMon
          	WHERE row_number = 1
GO
-- trigger_Ktra sinh viên đã học môn tiên quyết
Create trigger tg_KtrSinhVienMonTQ on DIEM after insert, Update
as declare @MaLop varchar(20), @MaSV varchar(20), @MaMon varchar(20), @SoMonTQ int =0
BEGIN
          	-- Lấy môn học và sinh viên
          	select @MaSV=n.MaSV, @MaLop=n.MaLop, @MaMon=l.MaMon from inserted n, LOP as l where n.MaLop=l.MaLop
--Đếm số môn TQ
          	select @SoMonTQ= count(*) from MONTIENQUYET where @MaMon=MaMon
          	--Ktr qua các môn TQ chưa (nếu null và số môn TQ>0 là chưa ) 	
          	IF( (select DiemTB from dbo.vi_DiemTBTheoMon as D,
        	            	(select MaMonTQ from MONTIENQUYET where @MaMon=MaMon) as Q
          	where @MaSV=D.MaSV and D.MaMon=Q.MaMonTQ and D.QUAMON=2) is null and @SoMonTQ >0)
          	BEGIN
RAISERROR (N'Sinh viên chưa hoàn thành môn tiên quyết', 16,1);
          	RollBack;
          	END
END
 
--View Thong tin Sinh Viên
GO
CREATE VIEW vi_ThongTinSV AS
          	       SELECT SinhVien.MaSV, CONCAT(HoSV,' ', TenlotSV,' ', TenSV) AS HoTenSV,
          	CCCD, DiaChi,
          	CASE GioiTinh WHEN 0 THEN N'Nam'
                         	  WHEN 1 THEN N'Nữ'
          	END AS GioiTinh,
          	NgaySinh, SDT, Email, NamNhapHoc, TenKhoa, TaiKhoan, TBTichLuy
          	FROM SinhVien
     	 	JOIN KHOA ON SINHVIEN.MaKhoa = KHOA.MaKhoa
     	 	LEFT JOIN (SELECT MaSV, ROUND(SUM(DiemTB * SoTinChi)/SUM(SoTinChi),2) AS TBTichLuy
            	         	  FROM vi_DiemTBTheoMon JOIN MONHOC ON vi_DiemTBTheoMon.MaMon = MONHOC.MaMon
            	         	  WHERE QUAMON = 2
            	         	  GROUP BY MaSV) as TBTichLuy ON SINHVIEN.MaSV = TBTichLuy.MaSV
WHERE SINHVIEN.TrangThai = 1
 
GO
CREATE VIEW vi_ThongTinLop
AS
          	WITH SOLUONGSV AS
  	                   	(SELECT LOP.MaLop, COUNT(DIEM.MaSV) AS SLSV
  	                   	 FROM LOP Left join DIEm on DIEM.MaLop = LOP.MaLop
  	                   	 GROUP BY LOP.MaLop)
 
          	SELECT LOP.MaLop, LOP.TenLop, MONHOC.TenMon, LOAILOP.TenLoai AS LoaiLop,
  	                   	   SOLUONGSV.SLSV AS SoLuongSV, LOP.SL AS SoLuongMax, LOP.HK AS HocKy, MONHOC.SoTinChi AS SoTinChi,
              	       	   CONCAT( LOP.Namhoc, ' - ', CAST((CAST(LOP.Namhoc AS INT) + 1) AS VARCHAR(100))) AS NamHoc,
  	                   	   CONCAT (GIANGVIEN.HoGV,' ', GIANGVIEN.TenlotGV,' ', GIANGVIEN.TenGV) AS TenGV
          	FROM LOP, MONHOC, GIANGVIEN, LOAILOP, SOLUONGSV
          	WHERE  LOP.MaLop = SOLUONGSV.MaLop
   	   	AND LOP.MaMon = MONHOC.MaMon AND LOP.MaGV = GIANGVIEN.MaGV AND LOAILOP.MaLoaiLop = LOP.MaLoaiLop

 GO
--Trigger update truong khoa
CREATE trigger tg_UpdateTrKhoa on Khoa after update
as declare @MaKhoa1 varchar(20),@MaKhoa2 varchar(20)
BEGIN
          	select @MaKhoa2 = inserted.MaKhoa, @MaKhoa1 = GIANGVIEN.MaKhoa from GIANGVIEN, inserted Where inserted.MaTrKhoa = GIANGVIEN.MaGV
          	if( not @MaKhoa1 = @MaKhoa2)
          	BEGIN
RAISERROR (N'Trưởng khoa không thuộc khoa', 16,1);
     	 	rollback
          	END
END

go
create view vi_taikhoangiangvien as 
	select CONCAT( giangvien.hoGV, ' ', GIANGVIEN.TenlotGV, ' ', GIANGVIEN.TenGV) as TenGV, TAIKHOAN.TaiKhoan, TAIKHOAN.MatKhau, GIANGVIEN.TrangThai
	from GIANGVIEN, TAIKHOAN
	where TAIKHOAN.TaiKhoan = GIANGVIEN.TaiKhoan



go
create view vi_taikhoansinhvien as 
	select CONCAT( sinhvien.hoSV, ' ', sinhvien.Tenlotsv, ' ', sinhvien.Tensv) as TensV, TAIKHOAN.TaiKhoan, TAIKHOAN.MatKhau, sinhvien.TrangThai
	from sinhvien, TAIKHOAN
	where TAIKHOAN.TaiKhoan = sinhvien.TaiKhoan

GO
 create view vi_DiemSVTheoLop
  as
  (
	select SINHVIEN.MaSV, CONCAT(SINHVIEN.HoSV, ' ', SINHVIEN.TenlotSV, ' ', SINHVIEN.TenSV) as tenSV , lop.MaLop, lop.TenLop, vi_DiemTBTheoLop.DiemQT, vi_DiemTBTheoLop.DiemCK, vi_DiemTBTheoLop.DiemTB, vi_DiemTBTheoLop.QUAMON
	from vi_DiemTBTheoLop, SINHVIEN, LOP
	where vi_DiemTBTheoLop.MaLop = LOP.MaLop and vi_DiemTBTheoLop.MaSV = SINHVIEN.MaSV
  )

GO

 create view [dbo].[vi_DiemSVTheoMon]
  as
  (
	select SINHVIEN.MaSV, CONCAT(SINHVIEN.HoSV, ' ', SINHVIEN.TenlotSV, ' ', SINHVIEN.TenSV) as tenSV , MONHOC.MaMon, MONHOC.TenMon, vi_DiemTBTheoMon.DiemTB, vi_DiemTBTheoMon.QUAMON
	from vi_DiemTBTheoMon, SINHVIEN, MONHOC
	where vi_DiemTBTheoMon.MaMon = MONHOC.MaMon and vi_DiemTBTheoMon.MaSV = SINHVIEN.MaSV
  )

GO

create view [dbo].[vi_LopCaPhong] as
(
	select vi_ThongTinLop.TenLop, BUOIHOC.MaCa, BUOIHOC.MaPhong, BUOIHOC.thu
	from vi_ThongTinLop, BUOIHOC
	where vi_ThongTinLop.MaLop = BUOIHOC.MaLop
)

GO


 -- trigger xóa môn học
GO
CREATE TRIGGER tg_DelMonHoc ON MONHOC
INSTEAD OF DELETE AS
          	DECLARE @MaMon varchar(20)
          	SELECT @MaMon = deleted.MaMon
          	FROM deleted
BEGIN
          	
          	UPDATE MONHOC
          	SET TrangThai = 0
          	WHERE MONHOC.MaMon = @MaMon
END

GO

CREATE VIEW [dbo].[vi_ThongTinLopHoc]
AS 
	select vi_ThongTinLop.MaLop, vi_ThongTinLop.TenLop, vi_ThongTinLop.TenMon, vi_ThongTinLop.SoLuongSV, vi_ThongTinLop.SoLuongMax, BUOIHOC.Thu, BUOIHOC.MaCa, BUOIHOC.MaPhong
	from vi_ThongTinLop, BUOIHOC
	where vi_ThongTinLop.MaLop = BUOIHOC.MaLop
GO

create function ft_ThongTinSVChuaHoc(@MaLop varchar(20)) returns table
as return 
(
	select * from vi_ThongTinSV
	where vi_ThongTinSV.MaSV not in (select DIEM.MaSV from DIEM where Diem.MaLop = @MaLop)
)
GO
create function ft_FindDiemSVTheoLop (@MaLop varchar(20)) 
returns table as return
(
	select * from vi_DiemSVTheoLop
	where vi_DiemSVTheoLop.MaLop = @MaLop
)


GO
CREATE FUNCTION ft_TimTTLopTheoID (@MaLop varchar(20))
RETURNS TABLE 
AS RETURN
(
	SELECT vi_ThongTinLopHoc.* FROM vi_ThongTinLopHoc
	WHERE vi_ThongTinLopHoc.MaLop = @MaLop
)

GO



create function ft_TimGVTheoKhoa (@tenKhoa nvarchar(200)) returns table
as return
(
	select * from vi_ThongTinGV
	where vi_ThongTinGV.TenKhoa = @tenKhoa
)
GO

create function ft_TimSVTheoKhoa (@tenKhoa nvarchar(200)) returns table
as return
(
	select * from vi_ThongTinSV
	where vi_ThongTinSV.TenKhoa = @tenKhoa
	)
GO

 
GO

--Function TKB giảng vien dạy
GO
CREATE FUNCTION ft_TKBLopGVDangDay (@MaGV varchar(20), @HK int, @NamHoc int) 
RETURNS TABLE
AS
RETURN
(
    SELECT 
        l.MaLop, vi.TenLop, l.MaMon, vi.TenMon, l.Namhoc,  vi.LoaiLop, ca.MaCa, ca.TGBatDau, ca.TGKetThuc, ph.MaPhong, ph.Toa, ph.SucChua, bh.Thu, vi.SoTinChi, vi.TenGV
    FROM 
        LOP as l
    INNER JOIN BUOIHOC as bh ON bh.MaLop = l.MaLop
    INNER JOIN vi_ThongTinLop as vi ON vi.MaLop = l.MaLop
    INNER JOIN CAHOC as ca ON ca.MaCa = bh.MaCa
    INNER JOIN PHONGHOC as ph ON ph.MaPhong = bh.MaPhong
    WHERE 
        l.MaGV = @MaGV -- Điều kiện mới thêm vào
        AND vi.MaLop = l.MaLop 
        AND l.Namhoc = @NamHoc 
        AND l.Hk = @HK
);


GO
--Function TKB SV hoc

CREATE FUNCTION ft_TKBSVTheoHK (@MaSV varchar(20), @HK int, @NamHoc int) 
RETURNS TABLE
AS
RETURN
(
    SELECT 
        l.MaLop, vi.TenLop, l.MaMon, vi.TenMon, l.Namhoc,  vi.LoaiLop, ca.MaCa, ca.TGBatDau, ca.TGKetThuc, ph.MaPhong, ph.Toa, ph.SucChua, bh.Thu, vi.SoTinChi, vi.TenGV
    FROM 
        LOP as l
    INNER JOIN BUOIHOC as bh ON bh.MaLop = l.MaLop
    INNER JOIN vi_ThongTinLop as vi ON vi.MaLop = l.MaLop
    INNER JOIN CAHOC as ca ON ca.MaCa = bh.MaCa
    INNER JOIN PHONGHOC as ph ON ph.MaPhong = bh.MaPhong
    INNER JOIN DIEM as di ON di.MaSV = @MaSV AND di.MaLop=l.MaLop -- Điều kiện mới thêm vào
	
    WHERE 
        di.MaSV = @MaSV 
        AND vi.MaLop = l.MaLop 
        AND l.Namhoc = @NamHoc 
        AND l.Hk = @HK
);
GO


CREATE FUNCTION ft_ThongTinLopTheoHS (@MaSV varchar(20), @HK int, @namhoc int) RETURNS TABLE
AS
RETURN
(
	SELECT vilop.MaLop, vilop.TenLop,  vilop.TenMon ,vilop.LoaiLop ,vilop.SoTinChi, vilop.TenGV, DiemCK, DiemQT, Cast(DiemTB as decimal(3,1)) as DiemTB, 
		CASE
			WHEN (QUAMON = 2) THEN N'✔'
			WHEN (QUAMON = 1) THEN N'✘'
			ELSE NULL
     	END  QUAMON
	FROM vi_ThongTinLop as vilop
		JOIN LOP ON vilop.MaLop = LOP.MaLop
		JOIN vi_DiemTBTheoLop as vidiem ON vilop.MaLop = vidiem.MaLop
	WHERE MaSV = @MASV AND HK = @HK AND LOP.Namhoc = @namhoc
);
GO

--Function GVXem Diem theo lop
GO
CREATE FUNCTION ft_GVXemDiem (@MaGV varchar(20), @MaLop varchar(20)) RETURNS TABLE
AS
RETURN
(
    SELECT l.MaLop, l.TenLop, l.MaMon, sv.MaSV,
           sv.HoSV +' ' + sv.TenlotSV +' ' + sv.TenSV AS HoTenSV,l.Namhoc,
           vi.DiemQT, vi.DiemCK, vi.DiemTB
    FROM LOP AS l
    INNER JOIN vi_DiemTBTheoLop AS vi ON l.MaLop = vi.MaLop
    INNER JOIN SINHVIEN AS sv ON sv.MaSV = vi.MaSV
    WHERE l.MaGV = @MaGV AND l.MaLop = @MaLop
)

GO

--Function Check Dang nhap
CREATE FUNCTION ft_ChkDangNhap(@TK varchar(100),@MK varchar(100),@Loai int) RETURNS varchar(20)
AS BEGIN 
	IF (@Loai = 0 AND @TK = 'admin' AND @MK = 'admin123')
		RETURN 'admin'
	DECLARE @Ma varchar(20)
	IF (@Loai = 1)
	BEGIN
		SELECT @MA = MaSV
		FROM TAIKHOAN as tk
			JOIN SINHVIEN as sv ON tk.TaiKhoan = sv.TaiKhoan
		WHERE tk.TaiKhoan = @TK 
			AND MatKhau = @MK
			AND TrangThai = 1
	END
	IF (@Loai = 2)
	BEGIN
		SELECT @MA = MaGV
		FROM TAIKHOAN as tk
			JOIN GIANGVIEN as gv ON tk.TaiKhoan = gv.TaiKhoan
		WHERE tk.TaiKhoan = @TK 
			AND MatKhau = @MK
			AND TrangThai = 1
	END
	RETURN @Ma
END

GO


CREATE FUNCTION ft_ChkQuenMatKhau (@TK varchar(100), @Email varchar(100), @CCCD varchar(100), @Loai int) RETURNS bit
AS BEGIN
	DECLARE @Chk_TK varchar(100)

	IF (@Loai = 1)
		SELECT @Chk_TK = TaiKhoan
		FROM SINHVIEN
		WHERE SINHVIEN.TaiKhoan = @TK AND SINHVIEN.Email = @Email 
			AND SINHVIEN.CCCD = @CCCD AND SINHVIEN.TrangThai = 1

	IF (@Loai = 2)
		SELECT @Chk_TK = TaiKhoan
		FROM GIANGVIEN
		WHERE GIANGVIEN.TaiKhoan = @TK AND GIANGVIEN.Email = @Email 
			AND GIANGVIEN.CCCD = @CCCD AND GIANGVIEN.TrangThai = 1

	IF (@Chk_TK IS NULL)
		RETURN 0
	RETURN 1
END
GO


--Function ds lop sinh vien da hoc
CREATE FUNCTION ft_LayDanhSachLopSinhVienDaHocCoDiem(@MaSV varchar(20))
RETURNS TABLE
AS
RETURN
(
    SELECT LOP.*, DIEM.DiemQT, DIEM.DiemCK 
    FROM LOP
    INNER JOIN DIEM ON LOP.MaLop = DIEM.MaLop
    WHERE DIEM.MaSV = @MaSV
)

GO

--Function ds lop giang vien da day
CREATE FUNCTION ft_LayDanhSachLopGiangVienDaDay(@MaGV varchar(20))
RETURNS TABLE
AS
RETURN
(
    SELECT LOP.* 
    FROM LOP
    WHERE LOP.MaGV = @MaGV
)


GO

CREATE FUNCTION ft_TinhTBTL (@MaSV varchar(20)) RETURNS decimal(4,2)
AS BEGIN
	DECLARE @TongDiem float
	DECLARE @TongTC float

	SELECT @TongDiem = SUM(DiemTB*SoTinChi) , @TongTC = SUM(SoTinChi)
	FROM vi_DiemTBTheoMon as vidiem
		JOIN MONHOC ON vidiem.MaMon = MONHOC.MaMon
	WHERE MaSV = @MaSV AND NOT QUAMON = 0
	GROUP BY MaSV

	RETURN @TongDiem/@TongTC
END

--ft_Thong ke điểm sinh viên
  GO
   CREATE FUNCTION ft_ThongKeSV (@MaSV varchar(20)) RETURNS TABLE
  AS
  RETURN
		SELECT l.HK, l.Namhoc, AVG(vi.DiemTB) as TB
		FROM LOP as l
		INNER JOIN vi_DiemSVTheoLop as vi ON l.MaLop = vi.MaLop AND vi.MaSV = @MaSV
		GROUP BY l.HK, l.Namhoc;


GO

 --- Procedure đổi mật khẩu ---

CREATE PROCEDURE pr_DoiMK
@mkcu varchar(20), @mkmoi varchar(20), @mkxacnhan varchar(20)
AS BEGIN
	IF( @mkmoi <> @mkxacnhan) 
		BEGIN
			RAISERROR (N'Mật khẩu xác nhận không trùng khớp ',16,1)
			RETURN
		END
	IF (@mkmoi = @mkcu)
		BEGIN
			RAISERROR (N'Mật khẩu mới bị trùng ',16,1)
			RETURN
		END
	DECLARE @tk varchar(20)
	SET @tk = SUSER_NAME();
	
	IF NOT EXISTS (SELECT * FROM TAIKHOAN WHERE TaiKhoan = @tk AND MatKhau = @mkcu)
		BEGIN
			RAISERROR (N'Mật khẩu không đúng ',16,1)	
			RETURN
		END

	DECLARE @loai bit

	SELECT @loai = Loai 
	FROM TAIKHOAN
	WHERE TaiKhoan = @tk AND MatKhau = @mkcu;

	EXEC pr_UpdateTaiKhoan @tk, @mkmoi, @loai;
END

GO


CREATE ROLE GiangVien_User

GRANT SELECT,UPDATE ON GIANGVIEN TO GiangVien_User
GRANT SELECT,UPDATE,INSERT,DELETE ON DIEM TO GiangVien_User
GRANT SELECT,UPDATE ON TAIKHOAN TO GiangVien_User
--Grant view for teacher
GRANT SELECT ON vi_DiemTBTheoLop TO GiangVien_User
GRANT SELECT ON vi_DiemTBTheoMon TO GiangVien_User
GRANT SELECT ON vi_DiemSVTheoLop TO GiangVien_User
GRANT SELECT ON vi_DiemSVTheoMon TO GiangVien_User
GRANT SELECT ON vi_thongtinGV TO GiangVien_User

--Grant function for teacher
GRANT SELECT ON ft_TKBLopGVDangDay TO GiangVien_User
GRANT SELECT ON ft_GVXemDiem TO GiangVien_User

--Grant procedure for teacher
GRANT EXECUTE ON pr_UpdateGiangVien TO GiangVien_User
GRANT EXECUTE ON pr_InsertDiem TO GiangVien_User
GRANT EXECUTE ON pr_UpdateDiem TO GiangVien_User
GRANT EXECUTE ON pr_DeleteDiem TO GiangVien_User
GRANT EXECUTE ON pr_UpdateTaiKhoan TO GiangVien_User
GRANT EXECUTE ON pr_DoiMK TO GiangVien_User

--Deny
DENY INSERT, DELETE, REFERENCES ON GIANGVIEN TO GiangVien_User
DENY INSERT, DELETE, REFERENCES ON TAIKHOAN TO GiangVien_User


GO
CREATE ROLE SinhVien_User
GRANT SELECT,UPDATE ON SinhVien TO SinhVien_User
GRANT SELECT ON DIEM TO SinhVien_User
--Grant view for student
GRANT SELECT ON vi_DiemTBTheoLop TO SinhVien_User
GRANT SELECT ON vi_DiemTBTheoMon TO SinhVien_User
GRANT SELECT ON vi_DiemSVTheoMon TO SinhVien_User
GRANT SELECT ON vi_DiemSVTheoMon TO SinhVien_User
GRANT SELECT ON vi_thongtinSV TO SinhVien_User

--Grant function for student
GRANT SELECT ON ft_TKBSVTheoHK TO SinhVien_User 
GRANT SELECT ON ft_ThongTinLopTheoHS TO SinhVien_User 
GRANT EXEC ON dbo.ft_TinhTBTL TO SinhVien_User
GRANT SELECT ON ft_ThongKeSV TO SinhVien_User 

--Grant procdure for student
GRANT EXECUTE ON pr_UpdateSinhVien TO SinhVien_User
GRANT EXECUTE ON pr_UpdateTaiKhoan TO SinhVien_User
GRANT EXECUTE ON pr_DoiMK TO SinhVien_User
--Deny
DENY INSERT, DELETE, REFERENCES ON SINHVIEN TO SinhVien_User
DENY INSERT, DELETE, REFERENCES ON TAIKHOAN TO SinhVien_User
DENY INSERT, DELETE, UPDATE, REFERENCES ON DIEM TO SinhVien_User

GO
CREATE ROLE Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON SINHVIEN TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON GIANGVIEN TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON KHOA TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON LOP TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON BUOIHOC TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TAIKHOAN TO Admin_User
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON DIEM TO Admin_User

--Grant view for Admin
GRANT SELECT ON  vi_DiemSVTheoLop TO Admin_User
GRANT SELECT ON  vi_DiemSVTheoMon TO Admin_User
GRANT SELECT ON  vi_DiemTBTheoLop TO Admin_User
GRANT SELECT ON  vi_DiemTBTheoMon TO Admin_User
GRANT SELECT ON  vi_LopCaPhong TO Admin_User
GRANT SELECT ON  vi_taikhoangiangvien TO Admin_User
GRANT SELECT ON  vi_taikhoansinhvien TO Admin_User
GRANT SELECT ON  vi_ThongTinGV TO Admin_User
GRANT SELECT ON  vi_ThongTinSV TO Admin_User
GRANT SELECT ON  vi_ThongTinLop TO Admin_User

--grant procedure for admin
GRANT EXECUTE TO Admin_User
GRANT SELECT TO Admin_User
--grant alter user and role
GRANT ALTER ANY ROLE TO Admin_User;
GRANT ALTER ANY USER TO Admin_User;


GO
-- Procedure tạo UserSQL --------------------------------------------------------
CREATE PROCEDURE pr_CreateUserLogin  @tk varchar(50), @mk varchar(50), @loai int
AS BEGIN
	DECLARE @dbname NVARCHAR(MAX)
	SET @dbname = DB_NAME()
	if(@loai = 1 OR @loai = 2)
		BEGIN TRANSACTION
			EXEC('CREATE LOGIN [' + @tk + '] WITH PASSWORD = '''+ @mk +''', DEFAULT_DATABASE=[' + @dbname + ']')
			EXEC('CREATE USER [' + @tk + '] FOR LOGIN [' + @tk + ']')
			IF(@loai = 1)
				EXEC sp_addrolemember 'SinhVien_User', @tk
			ELSE
				EXEC sp_addrolemember 'GiangVien_User', @tk
		COMMIT TRANSACTION;
END
GO

-- Procedure cập nhật UserSQL ------------------------------------------------
CREATE PROCEDURE pr_UpdateUserLogin  @tk varchar(50), @mkcu varchar(50), @mkmoi varchar(50)
AS BEGIN
	IF (@mkcu <> @mkmoi) 
			EXEC('ALTER LOGIN [' + @tk + '] WITH PASSWORD = ''' 
			+ @mkmoi +''' OLD_PASSWORD = ''' + @mkcu + '''')
END

GO

-- Procedure xóa UserSQL ----------------------------------------------------
CREATE PROCEDURE pr_DeleteUserLogin  @tk varchar(50)
AS BEGIN
	TRANSACTION BEGIN
		IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = @tk)
			EXEC('DROP USER [' + @tk+ ']')
		IF NOT EXISTS (SELECT name FROM sys.server_principals 
						WHERE type_desc = 'SQL_LOGIN' AND name = CONVERT(VARCHAR(18), @tk))
			EXEC('DROP LOGIN [' + @tk + ']')
	COMMIT TRANSACTION 
		

END

GO
-- Procedure kill UserProcess --------------------------------------------------
CREATE PROCEDURE pr_KillUserProcess  @tk varchar(50)
AS BEGIN
	TRANSACTION BEGIN
		WHILE (EXISTS (SELECT session_id
						FROM sys.dm_exec_sessions
						WHERE login_name = @tk))
		BEGIN 
			DECLARE @sid INT
			SELECT  @sid = session_id
			FROM sys.dm_exec_sessions
			WHERE login_name = @tk

			DECLARE @sid_str nvarchar(20)
			SET @sid_str = Convert(NVARCHAR(20), @sid)
		
			EXEC('KILL ' + @sid)
		END
	COMMIT TRANSACTION
END


GO

-- Trigger thêm tài khoản --------------------------------------------------
CREATE TRIGGER tg_InsertTaiKhoan ON TAIKHOAN
FOR INSERT
AS
DECLARE @tk varchar(50), @mk varchar(50), @loai int
SELECT @tk = TaiKhoan, @mk = MatKhau, @loai = Loai FROM inserted
BEGIN
	BEGIN TRY
		EXEC pr_CreateUserLogin @tk, @mk, @loai
	END TRY
	BEGIN CATCH
		DECLARE @err NVARCHAR(MAX) 
		SELECT @err = N'Lỗi thêm tài khoản. Nguyên nhân: ' + ERROR_MESSAGE() 
		RAISERROR(@err, 16, 1) 
		ROLLBACK TRANSACTION; 
		ROLLBACK;
	END CATCH 
END

GO
-- Trigger cập nhật tài khoản---------------------------------------------------
CREATE TRIGGER tg_UpdateTaiKhoan ON TAIKHOAN
FOR UPDATE 
AS
DECLARE @tk varchar(50), @mkcu varchar(50), @loai int , @mkmoi varchar(50)
SELECT @tk = i.TaiKhoan, @mkmoi = i.MatKhau, @loai = i.Loai, @mkcu = d.MatKhau
FROM inserted as i, deleted as d
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = @tk)
			EXEC pr_CreateUserLogin @tk, @mkmoi, @loai
		ELSE 
			EXEC pr_UpdateUserLogin @tk, @mkcu, @mkmoi
			END TRY
	BEGIN CATCH
		DECLARE @err NVARCHAR(MAX) 
		SELECT @err = N'Lỗi cập nhật tài khoản. Nguyên nhân: ' + ERROR_MESSAGE() 
		RAISERROR(@err, 16, 1) 
		ROLLBACK TRANSACTION; 
		ROLLBACK;
	END CATCH 
END
--Trigger sửa tài khoản-------------------------------------------------------------
GO

CREATE TRIGGER tg_DeleteTaiKhoan ON TAIKHOAN
FOR DELETE
AS
DECLARE @tk varchar(50)
SELECT @tk = TaiKhoan FROM deleted
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
			EXEC pr_KillUserProcess @tk
			EXEC pr_DeleteUserLogin @tk
		COMMIT TRANSACTION;
	END TRY 
	BEGIN CATCH 
		DECLARE @err NVARCHAR(MAX) 
		SELECT @err = N'Lỗi xóa tài khoản. Nguyên nhân: ' + ERROR_MESSAGE() 
		RAISERROR(@err, 16, 1) 
		ROLLBACK TRANSACTION
		ROLLBACK
	END CATCH 
END





GO
BEGIN
	DECLARE @cmd nvarchar(max) = ''

	SELECT @cmd += 'DROP USER ['+name+'];' 
	FROM sys.sysusers 
	WHERE name not in ('guest', 'INFORMATION_SCHEMA', 'sys','public')
		and issqluser = 1 
		and name not like 'db%'

	EXEC (@cmd);
END

GO

BEGIN
	DECLARE @cmd nvarchar(max) = ''

	SELECT @cmd += 'DROP LOGIN ['+name+'];' 
	FROM sys.server_principals
	WHERE type_desc = 'SQL_LOGIN' 
		and default_database_name = 'QLDiemSV'

	EXEC (@cmd);
END


GO

 INSERT INTO LOAIGV (MaLoaiGV, TenLoai)
VALUES
          	(1, N'Cơ hữu'),
          	(2, N'Thỉnh giảng');
 
GO
INSERT INTO LOAIPHONG(MaLoaiPhong, TenLoai)
VALUES
          	(1, N'Lý thuyết'),
          	(2, N'Thực hành');
 
GO
INSERT INTO LOAILOP(MaLoaiLop, TenLoai)
VALUES
          	(1, N'Lớp offline'),
          	(2, N'Lớp mooc');
 
GO
INSERT INTO KHOA(MaKhoa, TenKhoa, MaTrKhoa, TrangThai)
VALUES
          	('11', N'Chính trị và Luật',NULL,1),
          	('12', N'Cơ khí chế tạo máy',NULL,1),
          	('13', N'Cơ khí động lực',NULL,1),
          	('14', N'Công nghệ hóa học và thực phẩm',NULL,1),
          	('15', N'Công nghệ thông tin',NULL,1),
          	('16', N'Đào tạo quốc tế',NULL,1),
          	('17', N'Điện-Điện tử',NULL,1),
          	('18', N'In-Truyền thông',NULL,1),
          	('19', N'Khoa học ứng dụng',NULL,1),
          	('20', N'Kinh tế',NULL,1),
          	('21', N'Ngoại ngữ',NULL,1),
          	('22', N'Thời trang và du lịch',NULL,1),
          	('23', N'Xây dựng',NULL,1);
 
 
GO
INSERT INTO GIANGVIEN VALUES    ('0000000', N'Hàng', N'Lâm Trang', N'Anh', '123456789012', N'Hà Nội', 1, '1990-01-01', '0921644441', null, 1, '11', NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Nguyễn', N'Hà', N'Giang', '987654321012', N'Long An', 1, '1995-02-15', '0925011115', null, 2, '12', NULL, 0)
INSERT INTO GIANGVIEN VALUES    ('0000000', N'Trần', N'Tuấn', N'Khải', '123456789013', N'Tây Ninh', 0, '1980-03-05', '0922022828', null, 2, '13', NULL, 1)
INSERT INTO GIANGVIEN VALUES    ('0000000', N'Lê', N'Thành', N'Danh', '479245478512', N'TP.HCM', 0, '1980-03-05', '0922902828', null, 2, '14', NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Nguyễn ', N'Lê Diệu', N'Thảo', '987654321013', N'Đồng Tháp', 1, '1975-07-20', '0922599797', null, 1, '15', NULL, 0)
INSERT INTO GIANGVIEN VALUES    ('0000000', N'Lâm', N'Thành', N'Kim', '456789123013', N'Ninh Bình', 0, '1982-12-10', '0923877775', null, 2, '16', NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Nguyễn', N'Thanh', N'Tiến', '123456789014', N'Cần Thơ', 0, '1988-05-15', '0922602828', null, 1, '17', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Ngô', N'Quỳnh', N'Mai', '987654321014', N'Đồng Nai', 1, '1972-08-25', '0976932112', null, 2, '18', NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Thân', N'Trung', N'Tín', '456789123014', N'Tây Ninh', 0, '1991-04-30', '0927427788', null, 1, '19', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Nguyễn', N'Thanh', N'Bình', '123456789015', N'TP.HCM', 0, '1977-01-10', '0921411115', null, 2, '20', NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Nguyễn', N'Hương', N'Giang', '987654321015', N'Hà Nội', 1, '1984-11-20', '0968084664', null, 1, '21', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Trần', N'Văn', N'Sơn', '456789123015', N'Quảng Nam', 0, '1989-02-28', '0921977771', null, 2, '22',  NULL, 1)
INSERT INTO GIANGVIEN VALUES    ('0000000', N'Phạm', N'Thanh', N'Hằng', '123456789016', N'Thừa Thiên Huế', 1, '1986-07-15', '0523441234', null, 1, '23',  NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Lê', N'Kim', N'Phước', '987654321016', N'TP.HCM', 0, '1990-10-05', '0928693377', null, 2, '15',  NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Hồ', N'Ngọc', N'Hà', '456789123016', N'Quảng Bình', 1, '1980-09-30', '0928693374', null, 1, '13',  NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Lê', N'Thành', N'Phát', '123456789017', N'Tiền Giang', 0, '1976-06-20', '0922752828', null, 2, '19',  NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Trần', N'Ngọc Lan', N'Khuê', '987654321017', N'TP.HCM', 1, '1983-03-15', '0588342342', null, 1, '11',  NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Vũ', N'Trung', N'Kiệt', '456789123017', N'Huế', 0, '1978-12-10', '0928123377', null, 2, '14',  NULL, 1)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Lâm', N'Như', N'Vân', '123456789018', N'Bến Tre', 1, '1972-04-25', '0982260726', null, 1, '16',  NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Hồ', N'Chí', N'Vỹ', '456789123012', N'Hải Phòng', 0, '1985-11-30', '0921511118', null, 1, '18',  NULL, 1)
GO
Update KHOA set MaTrKhoa='1100001' where MaKhoa='11'
Update KHOA set MaTrKhoa='1200001' where MaKhoa='12'
Update KHOA set MaTrKhoa='1300001' where MaKhoa='13'
Update KHOA set MaTrKhoa='1400001' where MaKhoa='14'
Update KHOA set MaTrKhoa='1500001' where MaKhoa='15'
Update KHOA set MaTrKhoa='1600001' where MaKhoa='16'
Update KHOA set MaTrKhoa='1700001' where MaKhoa='17'
Update KHOA set MaTrKhoa='1800001' where MaKhoa='18'
Update KHOA set MaTrKhoa='1900001' where MaKhoa='19'
Update KHOA set MaTrKhoa='2000001' where MaKhoa='20'
Update KHOA set MaTrKhoa='2100001' where MaKhoa='21'
Update KHOA set MaTrKhoa='2200001' where MaKhoa='22'
Update KHOA set MaTrKhoa='2300001' where MaKhoa='23'
 
GO
INSERT INTO SINHVIEN VALUES ('00000000', N'Nguyễn', N'Trung', N'Quân', '123456789012', N'TP.HCM', 0, '2004-01-01', '0928723377', null, 2022, '11', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Trần', N'Trà', N'My', '987654321025', N'Nam Định', 1, '2003-02-02', '0921075599', null, 2021, '12', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Lê', N'Thành', N'Đạt', '123458289013', N'Ninh Thuận', 0, '2003-05-03', '0925077775', null, 2021, '13', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Dương', N'Minh', N'Tuấn', '579245678512', N'Bình Thuận', 0, '2005-07-12', '0981567290', null, 2023, '14', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Vũ', N'Thúy', N'Quỳnh','107654321013', N'Điện Biên', 1, '2002-12-02', '0965777015', null, 2020, '15', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Trần', N'Đình', N'Dương', '466782129013', N'Đồng Nai', 0, '2002-05-13', '0922715858', null, 2020, '16', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Hứa', N'Vỹ', N'Văn', '124856789014', N'Vĩnh Phúc', 0, '2004-06-01', '0927133377', null, 2022, '17', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Cao', N'Thị', N'Ngân', '987454322014', N'TP.HCM', 1, '2005-07-02', '0927213377', null, 2023, '18', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Lâm', N'Đinh Hoàng', N'Dũng', '456729123017', N'Hà Tĩnh', 0, '2003-03-18', '0926744446', null, 2021, '19', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Nguyễn', N'Anh', N'Tú', '125456789011', N'Nghệ An', 0, '2004-01-28', '0968175088', null, 2022, '20', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Đỗ', N'Thanh', N'Hoa', '987554321020', N'Hà Nội 2', 1, '2005-04-30', '0960436006', null, 2023, '21', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Phùng', N'Lê Thanh', N'Phúc', '056713123015', N'Thừa Thiên Huế', 0, '2002-10-08', '0942310077', null, 2020, '22', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Lê', N'Tường', N'Vân', '123456484016', N'Đà Nẵng', 1, '2005-11-22', '0922147788', null, 2023, '13', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Trần', N'Khải', N'Minh', '986652121016', N'Kon Tum', 0, '2004-10-20', '0925033335', null, 2022, '15', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Chúng', N'Huyền', N'Thanh', '255784123516', N'Lâm Đồng', 1, '2003-02-27', '0968771271', null, 2021, '16', NULL, 1)
 
INSERT INTO MONHOC VALUES ('1500', N'Công nghệ phần mềm', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1501', N'An toàn thông tin', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1502', N'Xử lý ảnh số', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1503', N'Lập trình web', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1900', N'Toán 1', 3, '19', 1)
INSERT INTO MONHOC VALUES ('1901', N'Toán 2', 3, '19', 1)
INSERT INTO MONHOC VALUES ('1902', N'Vật lý 1', 3, '19', 1)
INSERT INTO MONHOC VALUES ('2100', N'Anh Văn 1', 3, '21', 1)
INSERT INTO MONHOC VALUES ('2101', N'Anh văn 2', 3, '21', 1)
INSERT INTO MONHOC VALUES ('2102', N'Anh văn 3', 3, '21', 1)
INSERT INTO MONHOC VALUES ('2000', N'Kinh tế vi mô', 3, '20', 1)
INSERT INTO MONHOC VALUES ('2001', N'Kinh tế vĩ mô', 3, '20', 1)
INSERT INTO MONHOC VALUES ('2002', N'Nguyên lý thông kê', 3, '20', 1)
 
INSERT INTO MONTIENQUYET VALUES ('1900','1901')
INSERT INTO MONTIENQUYET VALUES ('2100','2101')
INSERT INTO MONTIENQUYET VALUES ('2000','2001')
GO
INSERT INTO PHONGHOC VALUES ('10', 1, 80, N'A')
INSERT INTO PHONGHOC VALUES ('11', 1, 80, N'B')
INSERT INTO PHONGHOC VALUES ('12', 1, 80, N'C')
INSERT INTO PHONGHOC VALUES ('13', 1, 80, N'D')
INSERT INTO PHONGHOC VALUES ('14', 1, 80, N'E')
INSERT INTO PHONGHOC VALUES ('15', 2, 80, N'A')
INSERT INTO PHONGHOC VALUES ('16', 2, 80, N'B')
INSERT INTO PHONGHOC VALUES ('17', 2, 80, N'C')
INSERT INTO PHONGHOC VALUES ('18', 2, 80, N'D')
 
INSERT INTO CAHOC VALUES ('1', '07:00:00', '09:00:00')
INSERT INTO CAHOC VALUES ('2', '09:00:00', '11:00:00')
INSERT INTO CAHOC VALUES ('3', '11:00:00', '13:00:00')
INSERT INTO CAHOC VALUES ('4', '13:00:00', '15:00:00')
INSERT INTO CAHOC VALUES ('5', '15:00:00', '17:00:00')
INSERT INTO CAHOC VALUES ('6', '17:00:00', '19:00:00')
INSERT INTO CAHOC VALUES ('7', '19:00:00', '21:00:00')
 
 INSERT INTO LOP VALUES ('00000000', N'Công nghệ phần mềm', 1, 80, 1, 2023, '1500001', '1500')
INSERT INTO LOP VALUES ('00000000', N'Xử lý ảnh số', 1, 80, 1, 2023, '1500002', '1502')
INSERT INTO LOP VALUES ('00000000', N'An toàn thông tin', 1, 80, 1, 2023, '1500002', '1501')
INSERT INTO LOP VALUES ('00000000', N'Toán 1', 1, 80, 2, 2023, '1900001', '1900')
INSERT INTO LOP VALUES ('00000000', N'Toán 2', 1, 80, 2, 2023, '1900002', '1901')
INSERT INTO LOP VALUES ('00000000', N'Anh văn 1', 1, 80, 1, 2022, '2100001', '2100')
INSERT INTO LOP VALUES ('00000000', N'Anh văn 2', 1, 80, 2, 2022, '2100001', '2100')
INSERT INTO LOP VALUES ('00000000', N'Kinh tế vi mô', 1, 80, 1, 2021, '2000001', '2000')
 
INSERT INTO BUOIHOC VALUES ('15002301', '1','10', 2)
INSERT INTO BUOIHOC VALUES ('15012301', '2','11', 3)
INSERT INTO BUOIHOC VALUES ('15022301', '3','12', 4)
INSERT INTO BUOIHOC VALUES ('19002301', '4','13', 5)
INSERT INTO BUOIHOC VALUES ('19012301', '5','14', 6)
INSERT INTO BUOIHOC VALUES ('20002101', '6','15', 7)
INSERT INTO BUOIHOC VALUES ('21002201', '7','16', 2)
INSERT INTO BUOIHOC VALUES ('21002202', '7','17', 3)
 
 
INSERT INTO DIEM VALUES ('20150001', '15002301', NULL, NULL)
INSERT INTO DIEM VALUES ('20160001', '15002301', NULL, NULL)
INSERT INTO DIEM VALUES ('20220001', '15002301', NULL, NULL)
INSERT INTO DIEM VALUES ('21120001', '15012301', NULL, NULL)
INSERT INTO DIEM VALUES ('20220001', '15012301', NULL, NULL)

INSERT INTO MONHOC VALUES ('1100', N'Triết học', 3, '11', 1)
INSERT INTO MONHOC VALUES ('1101', N'Kinh tế chính trị', 3, '11', 1)
INSERT INTO MONHOC VALUES ('1102', N'Pháp luật đại cương', 3, '11', 1)
INSERT INTO MONHOC VALUES ('1103', N'Tư tưởng Hồ Chí Minh', 3, '11', 1)
INSERT INTO MONHOC VALUES ('1104', N'Lịch sử Đảng', 3, '11', 1)

INSERT INTO MONHOC VALUES ('1200', N'Sức bền vật liệu', 3, '12', 1)
INSERT INTO MONHOC VALUES ('1201', N'Công nghệ chế tạo máy', 3, '12', 1)
INSERT INTO MONHOC VALUES ('1202', N'Cơ kỹ thuật', 3, '12', 1)
INSERT INTO MONHOC VALUES ('1203', N'Vẽ kỹ thuật cơ khí', 3, '12', 1)
INSERT INTO MONHOC VALUES ('1204', N'Vật liệu học', 3, '12', 1)
INSERT INTO MONHOC VALUES ('1205', N'Thực tập tiện CKM', 3, '12', 1)

INSERT INTO MONHOC VALUES ('1300', N'Nguyên lý - chi tiết máy', 3, '13', 1)
INSERT INTO MONHOC VALUES ('1301', N'Nhiệt động lực học kỹ thuật', 3, '13', 1)
INSERT INTO MONHOC VALUES ('1302', N'Kỹ Thuật Lạnh', 3, '13', 1)
INSERT INTO MONHOC VALUES ('1303', N'Công nghệ kim loại', 3, '13', 1)
INSERT INTO MONHOC VALUES ('1304', N'Công nghệ thủy lực và khí nén', 3, '13', 1)
INSERT INTO MONHOC VALUES ('1305', N'Nhà máy nhiệt điện', 3, '13', 1)

INSERT INTO MONHOC VALUES ('1400', N'Hóa hữu cơ', 3, '14', 1)
INSERT INTO MONHOC VALUES ('1401', N'Hóa thực phẩm', 3, '14', 1)
INSERT INTO MONHOC VALUES ('1402', N'Công nghệ chế biến lương thực', 3, '14', 1)
INSERT INTO MONHOC VALUES ('1403', N'Hóa lý', 3, '14', 1)
INSERT INTO MONHOC VALUES ('1404', N'Phụ gia thực phẩm', 3, '14', 1)
INSERT INTO MONHOC VALUES ('1405', N'Cảm quan thực phẩm', 3, '14', 1)

INSERT INTO MONHOC VALUES ('1504', N'Kỹ thuật lập trình', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1505', N'Lập trình hướng đối tượng', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1506', N'Cấu trúc dữ liệu và giải thuật', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1507', N'Lập trình trên Window', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1508', N'Cơ sở dữ liệu', 3, '15', 1)
INSERT INTO MONHOC VALUES ('1509', N'Hệ quản trị cơ sở dữ liệu', 3, '15', 1)

INSERT INTO SINHVIEN VALUES ('00000000', N'Ngô', N'Thừa', N'  n', '243784129736', N'Điện Biên', 1, '2001-02-22', '0968764171', null, 2021, '15', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Trương', N'Văn', N'Dũng', '243784680516', N'Gia Lai', 0, '2001-02-22', '0968972271', null, 2021, '15', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Mai', N'Thị', N'Diệu', '243784123123', N'Đắk Nông', 1, '2001-02-22', '0968773451', null, 2021, '15', NULL, 1)
INSERT INTO SINHVIEN VALUES ('00000000', N'Võ', N'Văn', N'Duyệt', '243784752516', N'Khánh Hòa', 0, '2001-02-22', '0965870271', null, 2021, '15', NULL, 1)

INSERT INTO GIANGVIEN VALUES	('0000000', N'Đinh', N'Văn', N'Đạt', '767654321013', N'Bến Tre', 1, '1975-07-20', '0922638797', null, 1, '15', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Ngô', N'Thị', N'Dung', '109654321013', N'Lai Châu', 1, '1985-02-10', '8652599797', null, 1, '15', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Lê', N'Văn', N'Duy', '945254321013', N'Sơn La', 1, '1978-05-12', '0927139797', null, 1, '15', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Vũ', N'Văn', N'Dũng', '987658531013', N'Hà Tĩnh', 1, '1979-12-15', '0920979797', null, 1, '15', NULL, 0)
INSERT INTO GIANGVIEN VALUES	('0000000', N'Bùi', N'Văn', N'Dật', '908554321013', N'Nghệ An', 1, '1970-10-10', '0922567797', null, 1, '15', NULL, 0)



INSERT INTO LOP VALUES ('00000000', N'Kỹ thuật lập trình 1', 1, 120, 2, 2022, '1500003', '1504')
INSERT INTO LOP VALUES ('00000000', N'Kỹ thuật lập trình 2', 1, 120, 2, 2022, '1500006', '1504')
INSERT INTO LOP VALUES ('00000000', N'Lập trình hướng đối tượng 1', 1, 120, 2, 2022, '1500007', '1505')
INSERT INTO LOP VALUES ('00000000', N'Cơ sở dữ liệu 1', 1, 120, 2, 2022, '1500004', '1508')
INSERT INTO LOP VALUES ('00000000', N'Hệ quản trị cơ sở dữ liệu 1', 1, 120, 2, 2022, '1500002', '1509')
INSERT INTO LOP VALUES ('00000000', N'Cấu trúc dữ liệu và giải thuật', 1, 120, 2, 2022, '1500001', '1506')

insert into phonghoc values ('19',1,150,'A')
insert into phonghoc values ('20',1,150,'B')
insert into phonghoc values ('21',1,150,'C')
insert into phonghoc values ('22',1,150,'D')
insert into phonghoc values ('23',1,150,'E')

INSERT INTO BUOIHOC VALUES ('15042202', 1, 19, 2) 

INSERT INTO BUOIHOC VALUES ('15042203', 2, 19, 2) 
INSERT INTO BUOIHOC VALUES ('15052201', 3, 20, 3) 
INSERT INTO BUOIHOC VALUES ('15062201', 4, 21, 4) 
INSERT INTO BUOIHOC VALUES ('15082201', 5, 22, 5) 
INSERT INTO BUOIHOC VALUES ('15092201', 6, 23, 6) 

insert into diem values  ('21150001', '15042202', null, null)
insert into diem values  ('22150001', '15042203', null, null)
insert into diem values  ('22150001', '15052201', null, null)
insert into diem values  ('22150001', '15062201', null, null)
insert into diem values  ('22150001', '15082201', null, null)

insert into diem values  ('21150002', '15082201', null, null)
insert into diem values  ('21150003', '15082201', null, null)
insert into diem values  ('21150004', '15082201', null, null)
insert into diem values  ('20150001', '15082201', null, null)
insert into diem values  ('20160001', '15082201', null, null)


GO
CREATE LOGIN [admin] WITH PASSWORD = 'admin123', DEFAULT_DATABASE=[QLDiemSV];
GO
CREATE USER [admin] FOR LOGIN [admin];
GO
EXEC sp_addrolemember 'Admin_User', admin;
GO
USE master
GO
GRANT ALTER ANY LOGIN TO [admin];
GO
USE QLDiemSV


