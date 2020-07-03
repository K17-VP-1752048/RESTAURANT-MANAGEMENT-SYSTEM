create database HeThongNhaHangHuongViet
go
use HeThongNhaHangHuongViet

go
create table ChiNhanh(
	IDchinhanh varchar(10),
	TenChiNhanh varchar(20),
	SDT varchar(20),
	ThanhPho varchar(20),
	Quan varchar(20),
	Phuong varchar(20),
	Duong varchar(20),
	primary key (IDchinhanh)
)
go

create table MonAn(
	IDmon varchar(10),
	TenMon varchar(20),
	DonGia float,
	LoaiMon varchar(20),
	primary key (IDmon)
)
go
create table SLMonAnTrongNgay(
	IDchinhanh varchar(10),
	IDmon varchar(10),
	soluong int,
	primary key (IDchinhanh,IDmon),
	foreign key(IDchinhanh) references ChiNhanh(IDchinhanh),
	foreign key(IDmon) references MonAn(IDmon)
)
go
create table ThanhVien(
	CMND varchar(10),
	NgaySinh date,
	DiaChi varchar(20),
	SDT varchar(20),
	ChiNhanhDangKy varchar(10) not null, --IDchinhanh
	DiemTichLuy int Default(0),
	Hang varchar(10),
	Email varchar(20),
	pwd varchar(20),
	primary key (CMND),
	foreign key(ChiNhanhDangKy) references ChiNhanh(IDchinhanh)
)
go
create table ChucVu(
	IDchucvu varchar(10),
	TenChucVu varchar(20),
	primary key (IDchucvu)
)

create table NhanVien(
	IDnhanvien varchar(10),
	HoTen varchar(20),
	GioiTinh varchar(5),
	NgaySinh date,
	SDT varchar(20),
	DiaChi varchar(20),
	ChiNhanhLamViec varchar(10),
	IDChucVu varchar(10),
	pwd varchar(20),
	primary key (IDnhanvien),
	foreign key(IDChucVu) references ChucVu(IDChucVu),
	foreign key(ChiNhanhLamViec) references ChiNhanh(IDchinhanh),
)

go
create table DonHang(
	MaDonHang varchar(10),
	CMNDNguoiDat varchar(10),
	IDnhanvien varchar(10),
	ChiNhanhDuocChon varchar(10),
	KenhDatHang varchar(20),
	LoaiKhachHang varchar(20),
	thoigiandat datetime,
	TrangThai varchar(20),
	primary key(MaDonHang),
	foreign key(CMNDNguoiDat) references ThanhVien(CMND),
	foreign key(IDnhanvien) references NhanVien(IDnhanvien),
	foreign key(ChiNhanhDuocChon) references ChiNhanh(IDchinhanh)
	
)
go
create table ChiTietDonHang(
	MaDonHang varchar(10),
	IDmon varchar(10),
	tenmon varchar(20),
	dongia float,
	soluongdat int,
	TongTien1Mon float,
	primary key(MaDonHang, IDmon),
	foreign key(IDmon) references MonAn(IDmon),
	foreign key(MaDonHang) references DonHang(MaDonHang)
)
go

create table UuDai(
	MaUuDai varchar(10),
	LoaiUuDai varchar(20),
	TienGiamGia float,
	TinhTrangUuDai varchar(20),
	primary key (MaUuDai)
)

go
create table NhanUuDai(
	CMND varchar(10),
	MaUuDai varchar(10),
	SoLuong int,
	primary key(CMND, MaUuDai),
	foreign key(MaUuDai) references UuDai(MaUuDai),
	foreign key(CMND) references ThanhVien(CMND)
)
go
create table ThongTinGiaoHang(
	MaGiaoHang varchar(10),
	ThoiGianGiaoHang datetime,
	TenNguoiNhan varchar(20),
	SDTnguoinhan varchar(20),
	ThanhPho varchar(20),
	Quan varchar(20),
	Phuong varchar(20),
	Duong varchar(20),
	MaGiamGia varchar(10),
	MaDonHang varchar(10),
	primary key (MaGiaoHang),
	foreign key(MaDonHang) references DonHang(MaDonHang),
	foreign key(MaGiamGia) references UuDai(MaUuDai)
)
go
create table HoaDon(
	MaHoaDon varchar(10),
	MaDonHang varchar(10),
	TongTienChuaGiamGia float,
	TienGiamGia float,
	PhiGiao float,
	ThanhTien float,
	HinhThucThanhToan varchar(20),
	ngaythanhtoan datetime,
	primary key (MaHoaDon, MaDonHang),
	foreign key(MaDonHang) references DonHang(MaDonHang)
)

go 

--------------------------------------------------------------------------
insert into ChiNhanh values('CN1', 'HuongViet TQK', '028698752', 'Ho Chi Minh', '1', 'Tan Dinh', 'Tran Quang Khai')
insert into ChiNhanh values('CN2', 'HuongViet LVS', '028698765', 'Ho Chi Minh', 'Tan Binh','1', 'Le Van Sy')
insert into ChiNhanh values('CN3', 'HuongViet Lam Dong', '028696969', 'Da Lat', '1', '9', 'Hoang Hoa Tham')

insert into MonAn values('Mon1', 'Com chien duong chau', 50000, 'Com')
insert into MonAn values('Mon2', 'Pho tai nam', 100000, 'Mon nuoc')
insert into MonAn values('Mon3', 'Goi ga chin cua', 500000, 'Goi')

insert into SLMonAnTrongNgay values ('CN1', 'Mon1', 98)
insert into SLMonAnTrongNgay values ('CN1', 'Mon2', 90)
insert into SLMonAnTrongNgay values ('CN1', 'Mon3', 100)
insert into SLMonAnTrongNgay values ('CN2', 'Mon1', 97)
insert into SLMonAnTrongNgay values ('CN2', 'Mon2', 100)
insert into SLMonAnTrongNgay values ('CN2', 'Mon3', 100)
insert into SLMonAnTrongNgay values ('CN3', 'Mon1', 95)
insert into SLMonAnTrongNgay values ('CN3', 'Mon2', 100)
insert into SLMonAnTrongNgay values ('CN3', 'Mon3', 90)


insert into ThanhVien values ('0258887895','1975/04/30', '101 Truong Van Hai', '0303584455','CN1', 150000, 'Silver', 'johson@mail.com', '123456')
insert into ThanhVien values ('0165815478','1980/04/30', '1 Dong Khoi', '0303566455','CN2', 0, 'Silver', 'comsuonn@mail.com', '163245')
insert into ThanhVien values ('0252247895','1985/04/30', '10 Truong Van Hai', '0341584466','CN3', 5250000, 'Gold', 'sieg.heil@mail.com', '123456')

insert into ChucVu values ('CV1', 'Quan Li Chung')
insert into ChucVu values ('CV2', 'Quan Li')
insert into ChucVu values ('CV3', 'Nhan Vien Le Tan')

insert into NhanVien values ('NV1', 'Nguyen Anh B', 'Nam', '1999-04-19', '0785444203', '71 Le Quy Don','CN1', 'CV1', '190499')
insert into NhanVien values ('NV2', 'Nguyen Thi D', 'Nu', '1997-09-02', '0785554212',  '8 Cong Hoa','CN2', 'CV2', '020997')
insert into NhanVien values ('NV3', 'Nguyen Chi E', 'Nam', '1998-12-1', '0985444555','45E Hai Thuong', 'CN3', 'CV3', '11298')


insert into DonHang values ('DH1', null, null, 'CN1', 'Online','Vang lai', '2020-05-06 09:22:15','Hoan tat')
insert into DonHang values ('DH2', '0258887895', null, 'CN2', 'Online', 'Thanh Vien', '2020-05-06 19:22:15', 'Hoan tat')
insert into DonHang values ('DH3', '0252247895', null, 'CN3', 'Online', 'Thanh Vien', '2020-05-06 19:22:15', 'Hoan tat')

insert into ChiTietDonHang values ('DH1', 'Mon1', 'Com chien duong chau', 50000, 2, 100000)
insert into ChiTietDonHang values ('DH1', 'Mon2', 'Pho tai nam', 100000, 10, 1000000)
insert into ChiTietDonHang values ('DH2', 'Mon1', 'Com chien duong chau', 50000, 3, 150000)
insert into ChiTietDonHang values ('DH3', 'Mon3', 'Goi ga chin cua', 500000, 10, 5000000)
insert into ChiTietDonHang values ('DH3', 'Mon1', 'Com chien duong chau', 50000, 5, 250000)

insert into UuDai values ('UD1', 'Discount 10000', 10000, 'Valid')
insert into UuDai values ('UD2', 'Discount 20000', 20000, 'Valid')
insert into UuDai values ('UD3', 'Discount 50000', 50000, 'Valid')

insert into NhanUuDai values ('0258887895', 'UD1', 2)
insert into NhanUuDai values ('0165815478', 'UD2', 3)
insert into NhanUuDai values ('0252247895', 'UD3', 2)

insert into ThongTinGiaoHang values ('TTGH1', '2020/05/6', 'Nguyen Thi A', '0909668811', 'Ho Chi Minh', 'Tan Binh', '13', 'Cong Hoa',  null, 'DH1')
insert into ThongTinGiaoHang values ('TTGH2', '2020/04/6', 'Nguyen Van B', '0909108811', 'Ho Chi Minh', '1', 'Cau Kho', 'Tran Khanh Hoi',  'UD2', 'DH2')
insert into ThongTinGiaoHang values ('TTGH3', '2020/05/4', 'Nguyen Cam C', '0903878811', 'Da Lat', '1', '13', 'Nguyen Van Troi',  'UD3', 'DH3')

insert into HoaDon values ('HD1', 'DH1', 1100000, 0, 50000, 1150000,  'Chuyen khoan', '2020-05-06')
insert into HoaDon values ('HD2', 'DH2', 150000, 20000, 50000, 180000,  'Chuyen khoan', '2020-05-06')
insert into HoaDon values ('HD3', 'DH3', 5250000, 312500, 20000, 4957500,  'Truc tiep', '2020-05-06')




