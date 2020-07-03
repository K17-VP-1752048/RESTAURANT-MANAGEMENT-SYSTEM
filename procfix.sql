--1. DangKyThanhVien
use HeThongNhaHangHuongViet
go
create proc dangky
	@CMND varchar(10),
	@NgaySinh date,
	@DiaChi varchar(20),
	@SDT varchar(20),
	@ChiNhanhDangKy varchar(10), --IDchinhanh
	@Email varchar(20),
	@pwd varchar(20)
as
begin
begin tran
	if exists (select CMND from ThanhVien where CMND = @CMND)
	begin
		print 'CMND da su dung'
		rollback tran
		return
	end
	if not exists (select IDchinhanh from ChiNhanh where IDchinhanh = @ChiNhanhDangKy)
	begin
		print 'Khong co chi nhanh nay'
		rollback tran
		return
	end
	insert into ThanhVien values(@CMND, @NgaySinh, @DiaChi, @SDT, @ChiNhanhDangKy, 0, 'Silver', @Email, @pwd)

	if(@pwd is null or @Email is null or @SDT is null)
	Begin        
			Print 'Ban chua nhap du thong tin dang ky'         
			Rollback tran  
			return
		End
	If (@@error <> 0)  
		Begin        
			Print 'Khong the dang ky thanh vien'         
			Rollback tran  
			return
		End
commit tran
end
go
exec dangky '0259777777','1999-10-11','Quan 9 TPHCM', '0909090900', 'CN1', 'nguyentrang@gmail.com', '12345'
go

--2. KH lua chon chi nhanh hoac chi nhanh khach dky doi voi thanh vien . Truong hop KH khong chon chi nhanh thi he thong chon chi nhanh cung TP voi dia chi giao hang
create proc xemmenutheochinhanh
	@CMND varchar(10),
	@chinhanhluachon varchar(10),
	---dia chi nhan
	@ThanhPho varchar(20),
	@Quan varchar(20),
	@Phuong varchar(20)
as
begin
begin tran
	--set tran isolation level read committed
	waitfor delay '00:00:05'
	if(@CMND is not null)
	begin
		if not exists (select * from ThanhVien where @CMND = CMND)
		begin
			print 'Thanh vien chua dang ky'
			rollback tran
			return
		end
		select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon from ThanhVien tv, SLMonAnTrongNgay sl, MonAn mon where sl.IDmon = mon.IDmon
													and tv.CMND = @CMND and tv.ChiNhanhDangKy = sl.IDchinhanh
	end
	else
	begin
		if(@chinhanhluachon is not null)
		begin
			if not exists (select IDchinhanh from ChiNhanh where IDchinhanh = @chinhanhluachon)
			begin
				print 'Chi nhanh khong ton tai'
				rollback tran
				return
			end
			select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon 
			from ChiNhanh cn, SLMonAnTrongNgay sl, MonAn mon where sl.IDchinhanh = @chinhanhluachon	and sl.IDmon = mon.IDmon
		end
		else
		begin
			if not exists(select * from ChiNhanh where ThanhPho = @ThanhPho)
			begin
				print 'Chi nhanh hien khong co o noi nay'
				rollback tran
				return
			end
			else
			begin
				if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan and Phuong = @Phuong)
				begin
					select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon 
					from SLMonAnTrongNgay sl, MonAn mon, ChiNhanh cn where  sl.IDchinhanh = cn.IDchinhanh and cn.ThanhPho = @ThanhPho and cn.Quan = @Quan and cn.Phuong = @Phuong and sl.IDmon = mon.IDmon 
				end
				else 
				begin
					if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan)
					begin
						select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon 
						from SLMonAnTrongNgay sl, MonAn mon, ChiNhanh cn where  sl.IDchinhanh = cn.IDchinhanh and cn.ThanhPho = @ThanhPho and cn.Quan = @Quan and sl.IDmon = mon.IDmon 
					end
					else
					begin
						select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon 
						from SLMonAnTrongNgay sl, MonAn mon, ChiNhanh cn where sl.IDchinhanh = cn.IDchinhanh and cn.ThanhPho = @ThanhPho and sl.IDmon = mon.IDmon 
					end
				end
				
				
			end
		end
	end
commit tran
end
go
exec xemmenutheochinhanh null, null, 'Ho Chi Minh', '1', null
go
select * from ChiNhanh
go
--3. tao don hang
create proc taodonhang
	@CMNDNguoiDat varchar(10), --doi voi thanh vien dat hang
	@IDnhanvien varchar(10), --doi voi nhan vien tao don hang
	@ChiNhanhDuocChon varchar(10),
	@KenhDatHang varchar(20),
	@MaDonHang varchar(10) OUTPUT
as
begin
begin tran
	declare @loaiKH nvarchar(20) 
	if(@CMNDNguoiDat is not null)
	begin
		if not exists (select * from ThanhVien where CMND = @CMNDNguoiDat)
		begin
			print 'Thanh vien nay chua duoc dang ky'
			rollback tran
			return
		end
		set @loaiKH = 'Thanh Vien'
	end
	else begin set @loaiKH = 'Vang lai' end
	if(@IDnhanvien is not null)
	begin
		if not exists (select * from NhanVien where IDnhanvien = @IDnhanvien)
		begin
			print 'Nhan vien nay khong co trong he thong'
			rollback tran
			return
		end
	end
	if not exists (select * from ChiNhanh where IDchinhanh = @ChiNhanhDuocChon)
	begin
		print 'Chi nhanh nay khong co trong he thong'
		rollback tran
		return
	end
	if(@KenhDatHang is null)
	begin
		print 'Ban chua nhap kenh dat hang'
		rollback tran
		return
	end

	--ma don hang duoc cap tu dong
	declare @count int = 1
	while exists(select * from  DonHang where 'DH' + CONVERT(varchar(3),@count) = MaDonHang)
	begin
		set @count = @count + 1;
	end
	insert into DonHang values('DH' + CONVERT(varchar(3),@count), @CMNDNguoiDat, @IDnhanvien, @ChiNhanhDuocChon, @KenhDatHang, @loaiKH, GETDATE(), null)

	set @MaDonHang = 'DH' + CONVERT(varchar(3),@count)

	If (@@error <> 0)  
	Begin        
		Print 'Khong the tao don hang'         
		Rollback tran  
		return
	End
commit tran
end
go
DECLARE @tmp varchar(10)
exec taodonhang null,null,'CN1', 'Online', @tmp OUTPUT
go
--4. khach hang chon mon an va so luong phan an
create proc DatMon
	@MaDonHang varchar(10), 
	@IDmon varchar(10), 
	@soluongdat int
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @MaDonHang)
	begin
		print 'Khong ton tai ma don hang'
		rollback tran
		return
	end

	if(@soluongdat < 0)
	begin
		print 'So luong dat khong hop le'
		rollback tran
		return
	end

	declare @chinhanhduocchon varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)
	declare @soluonghienco int = (select soluong from SLMonAnTrongNgay with(updlock) where  IDchinhanh = @chinhanhduocchon and IDmon = @IDmon)
	if((@soluongdat < 0) or (@soluongdat > @soluonghienco))
	begin
		print 'So luong dat khong hop le'
		rollback tran
		return
	end

	declare @tenmon nvarchar(20) = (select TenMon from MonAn where IDmon = @IDmon)
	declare @dongia nvarchar(20) = (select DonGia from MonAn where IDmon = @IDmon)
	declare @chinhanh varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)
	if not exists (select * from ChiTietDonHang where IDmon = @IDmon and MaDonHang = @MaDonHang)
	begin
		insert into ChiTietDonHang values (@MaDonHang, @IDmon, @tenmon, @dongia, @soluongdat, @dongia*@soluongdat)
	end
	else
	begin
		--cap nhat lai so luong dat thi phai tra lai so luong cu cho chi nhanh
		declare @soluong int = (select soluongdat from ChiTietDonHang where MaDonHang = @MaDonHang and IDmon = @IDmon)
		update SLMonAnTrongNgay set soluong = soluong + @soluong where IDmon = @IDmon and IDchinhanh = @chinhanh
		update ChiTietDonHang set soluongdat = @soluongdat where IDmon = @IDmon and MaDonHang = @MaDonHang
	end
	--mon an duoc them vao don hang, thi cap nhat lai so luong phan an mon nay o chi nhanh
	set @soluong = (select soluong from SLMonAnTrongNgay with(updlock) where  IDchinhanh = @chinhanhduocchon and IDmon = @IDmon)
	waitfor delay '00:00:05'
	update SLMonAnTrongNgay set soluong = @soluong - @soluongdat where IDmon = @IDmon and IDchinhanh = @chinhanh
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the dat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec DatMon 'DH4', 'Mon1', 5

--Xoa mon vua dat khoi gio hang
create proc XoaMonVuaDat
	@MaDonHang varchar(10), 
	@IDmon varchar(10)
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @MaDonHang)
	begin
		print 'Khong ton tai ma don hang'
		rollback tran
		return
	end

	declare @soluongdat int = (select soluongdat from ChiTietDonHang where MaDonHang = @MaDonHang and IDmon = @IDmon)
	
	delete from ChiTietDonHang where MaDonHang = @MaDonHang and IDmon = @IDmon
	
	--mon an bi xoa khoi gio hang, thi cap nhat lai so luong phan an cua mon vua them vao gio hang
	declare @chinhanh varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)
	update SLMonAnTrongNgay set soluong = soluong + @soluongdat where IDmon = @IDmon and IDchinhanh = @chinhanh
	If (@@error <> 0)  
		Begin        
			Print 'Khong the dat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec XoaMonVuaDat 'DH4', 'Mon1'

go

--5. Khach hang nhap thong tin giao hang sau khi dat hang
create proc KHnhapthongtingiaohang
	@TenNguoiNhan varchar(20),
	@SDTnguoinhan varchar(20),
	@ThanhPho  varchar(20),
	@Quan varchar(20),
	@Phuong varchar(20),
	@Duong varchar(20),
	
	@MaGiamGia varchar(10),
	@MaDonHang varchar(10)
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @MaDonHang)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end

	--yeu cau KH nhap du thong tin dia chi nhan hang
	if (@Quan is null or @Phuong is null or @Duong is null or @ThanhPho is null)
	begin
			print 'Ban chua nhap du thong tin'
			rollback tran
			return
		end
	declare @tp varchar(20) = (select cn.ThanhPho from DonHang dh, ChiNhanh cn where dh.ChiNhanhDuocChon = cn.IDchinhanh and dh.MaDonHang = @MaDonHang)
	if (@ThanhPho != @tp)
	begin
		print 'Chi nhanh nay rat xa noi giao hang, vui long chon chi nhanh khac'
		rollback tran
		return
	end
	--neu KH la khach vang lai
	if ((select CMNDNguoiDat from DonHang where MaDonHang = @MaDonHang) is null)
	begin
		--Khach vang lai khong co ma giam gia
		if(@MaGiamGia is not null)
		begin
			print 'Ban khong co ma giam gia nay'
			rollback tran
			return
		end
	end
	else --neu khach hang la thanh vien
	begin
		--kiem tra ma giam gia cua KH nhap dung khong
		if(@MaGiamGia is not null)
		begin
			if not exists (select * from DonHang dh join NhanUuDai ud on MaDonHang = @MaDonHang and dh.CMNDNguoiDat = ud.CMND and ud.MaUuDai = @MaGiamGia)
			begin
				print 'Ban khong co ma giam gia nay'
				rollback tran
				return
			end
		end
	end

	--ma giao hang duoc he thong cap tu dong
	declare @count int = 1
	while exists(select * from ThongTinGiaoHang where 'TTGH' + CONVERT(varchar(3),@count) = MaGiaoHang)
	begin
		set @count = @count + 1;
	end

	--du tinh thoi gian giao sau khi dat 45'
	declare @thoigiandat datetime = (select thoigiandat from DonHang where MaDonHang = 'DH4')
	declare @second int = ((select DATEPART(HOUR, @thoigiandat))*3600 + (select DATEPART(MINUTE, @thoigiandat))*60 + (select DATEPART(SECOND, @thoigiandat)))
	declare @date varchar(20) = CONVERT(date, @thoigiandat)

	insert into ThongTinGiaoHang values ('TTGH' + CONVERT(varchar(3),@count), DATEADD(s,  @second + 45*60, @date), @TenNguoiNhan, @SDTnguoinhan, @ThanhPho, @Quan, @Phuong, @Duong, @MaGiamGia, @MaDonHang)
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cung cap thong tin giao hang'         
			Rollback tran  
			return
		End
commit tran
end
go
exec KHnhapthongtingiaohang 'Vi', '0909092222', 'Ho Chi Minh', '1', 'Tang Nhon Phu B', '5 Tran Phu',  null, 'DH4'

select * from ThongTinGiaoHang
select * from DonHang
go

--6. Lap hoa don sau khi KH dat hang va cung cap thong tin giao hang
create proc LapHoaDon
	@MaDonHang varchar(10),
	@HinhThucThanhToan varchar(20)
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @MaDonHang)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end
	if (@HinhThucThanhToan is null)
	begin
		print 'Ban chua chon hinh thuc thanh toan'
		rollback tran
		return
	end

	--ma hoa don duoc cap tu dong
	declare @count int = 1
	while exists(select * from HoaDon where 'HD' + CONVERT(varchar(3),@count) = MaHoaDon)
	begin
		set @count = @count + 1;
	end

	--tinh tong tien cua hoa don bang cach cong tong tien cua tung mon an 
	declare CS_donhang cursor for select TongTien1Mon from ChiTietDonHang where MaDonHang = @MaDonHang
	open CS_donhang 
	declare @tongtien1mon float
	declare @tongtien float = 0
	fetch next from CS_donhang into @tongtien1mon
	while (@@FETCH_STATUS = 0)
	begin
		set @tongtien = @tongtien + @tongtien1mon
		fetch next from CS_donhang into @tongtien1mon
	end
	close CS_donhang
	deallocate CS_donhang

	--tinh phi giao hang
	declare @phigiao float
	declare @QuanGH nvarchar(20) = (select Quan from ThongTinGiaoHang where MaDonHang = @MaDonHang)
	declare @PhuongGH nvarchar(20) = (select Phuong from ThongTinGiaoHang where MaDonHang = @MaDonHang)
	declare @ThanhPhoGH nvarchar(20) = (select ThanhPho from ThongTinGiaoHang where MaDonHang = @MaDonHang)
	--cung quan cung phuong duoc mien phi phi giao
	if exists(select * from DonHang dh, ChiNhanh cn 
	where dh.ChiNhanhDuocChon = cn.IDchinhanh and cn.ThanhPho = @QuanGH and cn.Quan = @QuanGH and cn.Phuong != @PhuongGH and dh.MaDonHang = @MaDonHang)
	begin
		set @phigiao = 0
		select @phigiao
	end
	--cung quan khac phuong phi giao la 20000
	else if exists(select * from DonHang dh, ChiNhanh cn 
	where dh.ChiNhanhDuocChon = cn.IDchinhanh and cn.ThanhPho = @ThanhPhoGH and cn.Quan = @QuanGH and cn.Phuong != @PhuongGH and dh.MaDonHang = @MaDonHang)
	begin
		set @phigiao = 20000
		
	end
	--khac quan phi giao la 50000
	else if exists(select * from DonHang dh, ChiNhanh cn 
	where dh.ChiNhanhDuocChon = cn.IDchinhanh and cn.ThanhPho = @ThanhPhoGH and  cn.Quan != @QuanGH and cn.Phuong != @PhuongGH  and dh.MaDonHang = @MaDonHang)
	begin
		set @phigiao = 50000

	end
	--khac thanh pho khong giao hang
	else
	begin
		print 'Nha hang khong co chi nhanh o thanh pho nay'
		rollback tran
		return
	end

	--ma giam gia la loai uu dai nao
	declare @CMND varchar(10)
	declare @magiamgia varchar(20) = (select MaGiamGia from ThongTinGiaoHang where MaDonHang = @MaDonHang)
	declare @tiengiamgia float = 0
	if(@magiamgia is not null)
	begin
		set @CMND = (select CMNDNguoiDat from DonHang where MaDonHang = @MaDonHang)
		if((select TinhTrangUuDai from UuDai where MaUuDai = @magiamgia) = 'Valid')
		begin
			set @tiengiamgia = (select TienGiamGia from UuDai where MaUuDai = @magiamgia)
			update NhanUuDai set SoLuong = SoLuong - 1 where MaUuDai = @magiamgia and CMND = @CMND
		end
		
	end

	if (@CMND is not null)
	begin
		declare @diemtichluy float = (select DiemTichLuy from ThanhVien where CMND = @CMND)
		if(@diemtichluy > 20000000)
		begin
			set @tiengiamgia = @tiengiamgia + @tongtien*0.1
		end
		if(@diemtichluy > 5000000 and @diemtichluy <= 20000000) 
		begin
			set @tiengiamgia = @tiengiamgia + @tongtien*0.05
		end
	end
	
	insert into HoaDon values ('HD' + CONVERT(varchar(3),@count), @MaDonHang, @tongtien, @tiengiamgia, @phigiao, @tongtien - @tiengiamgia + @phigiao, @HinhThucThanhToan, GETDATE())
	

	If (@@error <> 0)  
		Begin        
			Print 'Khong the thuc hien thanh toan hoa don'         
			Rollback tran  
			return
		End
commit tran
end
go
exec LapHoaDon 'DH9', 'Chuyen khoan'

go

--8. Ghi nhan diem tich luy cho KH sau khi trang thai don hang la  'Hoan tat'
create proc GhiNhanDiemTichLuy
	@CMND varchar(10),
	@MaDonHang varchar(10)
as
begin
begin tran
	if not exists (select * from ThanhVien where CMND = @CMND)
	begin
		print 'Thanh vien khong ton tai'
		rollback tran
		return
	end
	if not exists (select * from DonHang where MaDonHang = @MaDonHang and TrangThai = 'Hoan tat')
	begin
		print 'Don hang chua hoan tat'
		rollback tran
		return
	end

	declare @diemtichluy float = (select DiemTichLuy from ThanhVien with (updlock) where CMND = @CMND)
	set @diemtichluy = @diemtichluy + (select ThanhTien from HoaDon where MaDonHang = @MaDonHang) 
	waitfor delay '00:00:05'
	update ThanhVien set DiemTichLuy = @diemtichluy where CMND = @CMND

	if(@diemtichluy > 20000000)
	begin
		update ThanhVien set Hang = 'Diammond' where CMND = @CMND
	end
	if(@diemtichluy > 5000000 and @diemtichluy <= 20000000) 
	begin
		update ThanhVien set Hang = 'Gold' where CMND = @CMND
	end
	if(@diemtichluy <= 5000000)
	begin
		update ThanhVien set Hang = 'Silver' where CMND = @CMND
	end
	If (@@error <> 0)  
		Begin        
			Print 'Khong the ghi nhan diem tich luy'         
			Rollback tran  
			return
		End
commit tran
end
go

exec GhiNhanDiemTichLuy '0259777777', 'DH4'

----9. them mon an moi vao menu
create proc ThemMonAn
	@TenMon varchar(20),
	@dongia float,
	@Loaimon varchar(20)
as
begin
begin tran
	if(@TenMon is null or @dongia is null or @Loaimon is null)
	begin
		print 'Ban chua nhap thong tin mon day du'
		rollback tran
		return
	end
	if exists (select TenMon from MonAn where TenMon = @TenMon)
	begin
		print 'Mon an nay da co trong menu'
		rollback tran
		return
	end
	if(@dongia <= 0)
	begin
		print 'Don gia khong hop le'
		rollback tran
		return
	end

	--id mon an duoc tao tu dong
	declare @count int = 1
	while exists(select * from  MonAn where 'Mon' + CONVERT(varchar(3),@count) = IDmon)
	begin
		set @count = @count + 1;
	end

	insert into MonAn values ('Mon' + CONVERT(varchar(3),@count), @TenMon, @dongia, @Loaimon)

	--xai cursor de them mon an moi cho tung chi nhanh
	declare CS_chinhanh cursor for select IDchinhanh from ChiNhanh
	open CS_chinhanh 
	declare @idchinhanh varchar(10)
	fetch next from CS_chinhanh into @idchinhanh
	while (@@FETCH_STATUS = 0)
	begin
		insert into SLMonAnTrongNgay values (@idchinhanh,'Mon' + CONVERT(varchar(3),@count),0)
		fetch next from CS_chinhanh into @idchinhanh
	end
	close CS_chinhanh
	deallocate CS_chinhanh

	If (@@error <> 0)  
	Begin        
		Print 'Khong the them mon an'         
		Rollback tran  
		return
	End
commit tran
end
go
exec ThemMonAn 'Mien xao chay', 30000, 'Món chay'
go
---10. sua doi thong tin mon an
create proc CapNhatMonAn
	@IDmon varchar(10),
	@TenMon varchar(20),
	@dongia float
as
begin
begin tran
	if not exists (select * from MonAn where IDmon = @IDmon)
	begin
		print 'Mon an ban muon cap nhat khong co trong menu'
		rollback tran
		return
	end
	if((@TenMon is null and @dongia is null) or (@TenMon = '' and @dongia = '')
		or (@TenMon is null and @dongia = '') or (@TenMon = '' and @dongia is null))
	begin
		print 'Ban khong nhap thong tin can cap nhat'
		rollback tran
		return
	end
	
	if(@TenMon is not null)
	begin
		update MonAn set TenMon = @TenMon where IDmon = @IDmon
	end
	
	if(@dongia is not null)
	begin
		update MonAn set DonGia = @dongia where IDmon = @IDmon
	end
	waitfor delay '00:00:10'
	if(@dongia <= 0)
	begin
		print 'Don gia khong hop le'
		rollback tran
		return
	end
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec CapNhatMonAn 'Mon1', 'Com chien', null
select * from MonAn

go

----11. Xoa mon an trong menu
/*create proc XoaMonAn
	@IDmon varchar(10)
as
begin
begin tran
	if not exists (select * from MonAn where IDmon = @IDmon)
	begin
		Print 'Mon an nay khong co trong thuc don'         
		Rollback tran  
		return
	end

	--xoa mon an nay ra khoi tung chi nhanh
	declare CS_chinhanh cursor for select IDchinhanh from ChiNhanh
	open CS_chinhanh 
	declare @idchinhanh varchar(10)
	fetch next from CS_chinhanh into @idchinhanh
	while (@@FETCH_STATUS = 0)
	begin
		delete from SLMonAnTrongNgay where IDchinhanh = @idchinhanh and IDmon = @IDmon
		fetch next from CS_chinhanh into @idchinhanh
	end
	close CS_chinhanh
	deallocate CS_chinhanh

	delete from MonAn where IDmon = @IDmon
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the xoa mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec XoaMonAn 'Mon4'
go*/

--12. cap nhat so luong mon an trong ngay theo chi nhanh
create proc SLMonAnTrongNgayDuocCungCap
	@IDchinhanh varchar(10),
	@IDmon varchar(10),
	@soluongphan int
as
begin
begin tran
	if not exists (select * from MonAn where IDmon = @IDmon)
	begin
		Print 'Mon an nay khong co trong thuc don'         
		Rollback tran  
		return
	end
	if not exists (select * from ChiNhanh where IDchinhanh = @IDchinhanh)
	begin
		Print 'Nha hang khong co chi nhanh nay'         
		Rollback tran  
		return
	end
	
	if (@soluongphan is null or (@soluongphan < 0))
	begin
		Print 'So luong phan an cap nhat khong hop le'         
		Rollback tran  
		return
	end

	update SLMonAnTrongNgay set soluong = @soluongphan where IDchinhanh = @IDchinhanh and IDmon = @IDmon

	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat so luong phan mon an nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec SLMonAnTrongNgayDuocCungCap 'CN1', 'Mon4', 95
select * from MonAn
select * from SLMonAnTrongNgay
go

----13. sua doi thong tin thanh vien, luu y can dien day du thong tin sua doi
create proc capnhatthanhvien
	@CMND varchar(10),
	@NgaySinh date,
	@DiaChi varchar(20),
	@SDT varchar(20)
as
begin
begin tran
	if not exists(select * from ThanhVien where CMND = @CMND)
	begin
		print 'Thanh vien nay chua duoc dang ky'
		rollback tran
		return
	end
	if(@NgaySinh is null and @NgaySinh is null and @SDT is null)
	begin
		print 'Ban chua nhap thong tin de he thong cap nhat'
		rollback tran
		return
	end
	if(@NgaySinh is not null)
	begin
		update ThanhVien set NgaySinh = @NgaySinh where CMND = @CMND
	end
	if(@DiaChi is not null)
	begin
		update ThanhVien set DiaChi = @DiaChi where CMND = @CMND
	end
	if(@SDT is not null)
	begin
		update ThanhVien set SDT = @SDT where CMND = @CMND
	end
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat thong tin thanh vien nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec capnhatthanhvien '0258887895','1999-10-11','5 Tran Phu','0909090911'

--14. thanh vien thay doi mat khau dang nhap
create proc thaydoimatkhau
	@CMND varchar(10),
	@maukhaucu varchar(20), --xac nhan mat khau cu, sau do nhap mat khau moi
	@matkhaumoi varchar(20)
as
begin
begin tran
	if not exists(select * from ThanhVien where CMND = @CMND)
	begin
		print 'Thanh vien nay chua duoc dang ky'
		rollback tran
		return
	end
	if((select pwd from ThanhVien where CMND = @CMND) != @maukhaucu)
	begin
		print 'Ban nhap sai mat khau'
		rollback tran
		return
	end
	if(@matkhaumoi is null)
	begin
		print 'Ban chua nhap mat khau moi'
		rollback tran
		return
	end
	update ThanhVien set pwd = @matkhaumoi where CMND = @CMND
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat thong tin thanh vien nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec thaydoimatkhau '0258887895', '123456', '999999'
select * from ThanhVien
--15. xoa thanh vien
/*create proc xoathanhvien
	@CMNDthanhvien varchar(10)
as
begin
begin tran
	if not exists(select * from ThanhVien where CMND = @CMNDthanhvien)
	begin
		print 'Khong co thanh vien nay'
		rollback tran
		return
	end
	delete from ThanhVien where CMND = @CMNDthanhvien
	If (@@error <> 0)  
		Begin        
			Print 'Khong the xoa thanh vien nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec xoathanhvien '112222'
select * from ThanhVien*/
go
--16. dang nhap thanh vien
create proc dangnhap
	@CMND varchar(10),
	@pwd varchar(20),
	@CMNDOUTPUT varchar(10) OUTPUT
as
begin
begin tran
	if not exists(select * from ThanhVien where CMND = @CMND)
	begin
		print 'Khong co thanh vien nay'
		rollback tran
		return
	end
	if((select pwd from ThanhVien where CMND = @CMND) != @pwd)
	begin
		print 'Ban nhap sai mat khau'
		rollback tran
		return
	end
	set @CMNDOUTPUT = @CMND
commit tran
end
go
declare @cmnd varchar(10)
exec dangnhap '0258887895', '123456', @cmnd OUTPUT
select @cmnd

select * from NhanVien
--16. dang nhap nhan vien
create proc dangnhapnhanvien
	@IDnhanvien varchar(10),
	@pwd varchar(20),
	@ID varchar(10) OUTPUT
as
begin
begin tran
	if not exists(select * from NhanVien where IDnhanvien = @IDnhanvien)
	begin
		print 'Khong co thanh vien nay'
		rollback tran
		return
	end
	if((select pwd from NhanVien where IDnhanvien = @IDnhanvien) != @pwd)
	begin
		print 'Ban nhap sai mat khau'
		rollback tran
		return
	end
	set @ID = @IDnhanvien
commit tran
end
go
declare @ID varchar(10)
exec dangnhapnhanvien 'NV1', '190499', @ID OUTPUT
select @ID

--17. khách hang theo doi trang thai don hang
create proc theodoidonhang
	@madonhang varchar(10)
as
begin
	if not exists(select * from DonHang where MaDonHang = @madonhang)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end
	select TrangThai from DonHang where MaDonHang = @madonhang
end
go 
exec theodoidonhang 'DH3'

--18. Huy don hang o trang thai tiep nhan
create proc HuyDonHang
	@madonhang varchar(10)
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @madonhang)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end
	if(((select TrangThai from DonHang where MaDonHang = @madonhang) != 'Tiep nhan') or ((select TrangThai from DonHang where MaDonHang = @madonhang)  = null ))
	begin
		print 'Ban khong the huy don hang nay'
		rollback tran
		return
	end
	--huy don hang thi cap nhat so luong mon an cua chi nhanh lai
	declare CS_DonHang cursor for select IDmon, soluongdat from ChiTietDonHang where MaDonHang = @madonhang
	open CS_DonHang
	declare @soluongdat int
	declare @IDmon varchar(10)
	fetch next from CS_DonHang into @IDmon, @soluongdat
	while (@@FETCH_STATUS = 0)
	begin
		update SLMonAnTrongNgay set soluong = soluong + @soluongdat where IDmon = @IDmon
		fetch next from CS_DonHang into @IDmon, @soluongdat
	end
	close CS_DonHang
	deallocate CS_DonHang
	if exists(select * from DonHang where TrangThai is null and MaDonHang = @madonhang)
	begin
		if not exists(select * from HoaDon where MaDonHang = @madonhang)
		begin
			declare CS_DonHang cursor for select IDmon from ChiTietDonHang where MaDonHang =  @madonhang
			open CS_DonHang
			declare @IDmonan varchar(10)
			fetch next from CS_DonHang into @IDmonan
			while (@@FETCH_STATUS = 0)
			begin
				delete from ChiTietDonHang where IDmon = @IDmonan and MaDonHang =  @madonhang
				fetch next from CS_DonHang into @IDmonan
			end
			close CS_DonHang
			deallocate CS_DonHang
			delete from ThongTinGiaoHang where MaDonHang =  @madonhang
			declare @count int = (select COUNT(MaHoaDon) from HoaDon)
			delete from DonHang where MaDonHang =  @madonhang
		end
		else 
		begin
			update DonHang set TrangThai = 'Huy' where MaDonHang = @madonhang
		end
	end
	else
	begin
		update DonHang set TrangThai = 'Huy' where MaDonHang = @madonhang
	end
	If (@@error <> 0)  
		Begin        
			Print 'Khong the huy don hang'         
			Rollback tran  
			return
		End
commit tran
end
go 

exec HuyDonHang 'DH5'

go

---19. Xem thong tin KH
create proc XemThongTinKH
	@CMND varchar(10)
as
begin	
	if not exists(select * from ThanhVien where CMND = @CMND)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end
	select * from ThanhVien where CMND = @CMND
end
go
---20. them chi nhanh moi
create proc themchinhanh
	@TenChiNhanh varchar(20),
	@SDT varchar(20),
	@ThanhPho varchar(20),
	@Quan varchar(20),
	@Phuong varchar(20),
	@Duong varchar(20)
as
begin
begin tran
	if(@TenChiNhanh is null or @SDT is null or @ThanhPho is null or @Quan is null or @Duong is null or @Phuong is null)
	begin
		print 'Chua nhap day du thong tin chi nhanh'
		rollback tran
		return
	end
	if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan and Phuong = @Phuong and @Duong = Duong)
	begin
		print 'Ban nhap trung dia chi chi nhanh moi voi chi nhanh da co'
		rollback tran
		return
	end

	declare @count int = 1
	while exists(select * from  ChiNhanh where 'CN' + CONVERT(varchar(3),@count) = IDchinhanh)
	begin
		set @count = @count + 1;
	end

	insert into ChiNhanh values('CN' + CONVERT(varchar(3),@count), @TenChiNhanh, @SDT, @ThanhPho, @Quan, @Phuong, @Duong)

	--xai cursor de them chi nhanh moi vao bang SLMonAnTrongNgay
	declare CS_MonAn cursor for select IDmon from MonAn
	open CS_MonAn 
	declare @IDmon varchar(10)
	fetch next from CS_MonAn into @IDmon
	while (@@FETCH_STATUS = 0)
	begin
		insert into SLMonAnTrongNgay values ('CN' + CONVERT(varchar(3),@count), @IDmon, 0)
		fetch next from CS_MonAn into @IDmon
	end
	close CS_MonAn
	deallocate CS_MonAn

commit tran
end
go
exec themchinhanh 'Huong Viet Que', '0289292922', 'Ho Chi Minh', 'Thu Duc', 'Binh Tho', '2 Thong Nhat'
select * from ChiNhanh
go
---xoa chi nhanh
/*create proc xoachinhanh
	@IDchinhanh varchar(10)
as
begin
begin tran
	if not exists(select * from ChiNhanh where IDchinhanh = @IDchinhanh)
	begin
		print 'Khong co chi nhanh nay'
		rollback tran
		return
	end
	--xai cursor de xoa chi nhanh khoi bang SLMonAnTrongNgay
	declare CS_MonAn cursor for select IDmon from MonAn
	open CS_MonAn 
	declare @IDmon varchar(10)
	fetch next from CS_MonAn into @IDmon
	while (@@FETCH_STATUS = 0)
	begin
		delete from SLMonAnTrongNgay where IDchinhanh = @IDchinhanh and IDmon = @IDmon
		fetch next from CS_MonAn into @IDmon
	end
	close CS_MonAn
	deallocate CS_MonAn

	delete from ChiNhanh where IDchinhanh = @IDchinhanh
	If (@@error <> 0)  
		Begin        
			Print 'Khong the xoa chi nhanh nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec xoachinhanh 'CN4'
go*/


---cap nhat chi nhanh
create proc capnhatchinhanh
	@IDchinhanh varchar(10),
	@TenChiNhanh varchar(20),
	@SDT varchar(20),
	@ThanhPho varchar(20),
	@Quan varchar(20),
	@Phuong varchar(20),
	@Duong varchar(20)
as
begin
begin tran
	if not exists(select * from ChiNhanh where IDchinhanh = @IDchinhanh)
	begin
		print 'Khong co chi nhanh nay'
		rollback tran
		return
	end

	if(@TenChiNhanh is null and @SDT is null and @ThanhPho is null and @Quan is null and @Phuong is null and @Duong is null)
	begin
		print 'Ban chua nhap thong tin can thay doi'
		rollback tran
		return
	end
	
	if(@TenChiNhanh is not null)
	begin
		update ChiNhanh set TenChiNhanh = @TenChiNhanh where IDchinhanh = @IDchinhanh
	end

	if(@SDT is not null)
	begin
		update ChiNhanh set SDT = @SDT where IDchinhanh = @IDchinhanh
	end

	if(@ThanhPho is not null)
	begin
		update ChiNhanh set ThanhPho = @ThanhPho where IDchinhanh = @IDchinhanh
	end

	if(@Quan is not null)
	begin
		update ChiNhanh set Quan = @Quan where IDchinhanh = @IDchinhanh
	end

	if(@Duong is not null)
	begin
		update ChiNhanh set Duong = @Duong where IDchinhanh = @IDchinhanh
	end

	if(@Phuong is not null)
	begin
		update ChiNhanh set Phuong = @Phuong where IDchinhanh = @IDchinhanh
	end

	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat thong tin chi nhanh nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec capnhatchinhanh 'CN1','Huong Viet HCM',null,null,null,null,null
select * from ChiNhanh
go
select * from ChiNhanh
----22. Cap nhat trang thai don hang
create proc CapNhatTrangThaiDonHang
	@idDH varchar(10),
	@trangthai varchar(20)
as
begin
begin tran
	if not exists (select * from DonHang where MaDonHang = @idDH)
	begin
		print 'Don hang khong ton tai'
		rollback tran
	end
	update DonHang set TrangThai = @trangthai where MaDonHang = @idDH
	--waitfor delay '00:00:10'
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat don hang'         
			Rollback tran  
		End
commit tran
end
go


--Them uu dai moi
create proc themuudai
	@LoaiUuDai varchar(20),
	@tiengiamgia float
as
begin
begin tran
	if exists(select * from UuDai where LoaiUuDai = @LoaiUuDai)
	begin
		print 'Uu dai nay da co'
		rollback tran
		return
	end
	if(@tiengiamgia is null or @LoaiUuDai is null)
	begin
		print 'Ban chua nhap thong tin uu dai day du'
		rollback tran
		return
	end
	if(@tiengiamgia < 0)
	begin
		print 'Ban nhap khong hop le'
		rollback tran
		return
	end

	declare @count int = 1
	while exists(select * from  ChiNhanh where 'CN' + CONVERT(varchar(3),@count) = IDchinhanh)
	begin
		set @count = @count + 1;
	end

	insert into UuDai values('UD' + CONVERT(varchar(3),@count), @LoaiUuDai, @tiengiamgia, 'Valid')

	If (@@error <> 0)  
		Begin        
			Print 'Khong the them uu dai'         
			Rollback tran  
			return
		End
commit tran
end
go
--Tang uu dai cho tat ca khach hang
create proc tanguudai
	@mauudai varchar(10)
as
begin
begin tran
	if not exists(select * from UuDai where MaUuDai = @mauudai)
	begin
		print 'Ma uu dai khong ton tai'
		rollback tran
	end
	--tang uu dai moi cho tat ca cac thanh vien
	declare CS_ThanhVien cursor for select CMND from ThanhVien
	open CS_ThanhVien
	declare @CMND varchar(10)
	fetch next from CS_ThanhVien into @CMND
	while (@@FETCH_STATUS = 0)
	begin
		if not exists (select * from NhanUuDai where MaUuDai = @mauudai and CMND = @CMND)
		begin
			insert into NhanUuDai values(@CMND, @mauudai, 1)
		end
		else
		begin
			update NhanUuDai set SoLuong = SoLuong + 1 where MaUuDai = @mauudai and CMND = @CMND
		end
		fetch next from CS_ThanhVien into @CMND
	end
	close CS_ThanhVien
	deallocate CS_ThanhVien
	If (@@error <> 0)  
		Begin        
			Print 'Khong the them uu dai'         
			Rollback tran  
			return
		End
commit tran
end
go
--cap nhat tinh trang uu dai
create proc capnhattinhtranguudai
	@mauudai varchar(10),
	@tinhtrang varchar(20)
as
begin
begin tran
	if not exists(select * from UuDai where MaUuDai = @mauudai)
	begin
		print 'Ma uu dai khong ton tai'
		rollback tran
	end

	update UuDai set TinhTrangUuDai = @tinhtrang where MaUuDai = @mauudai

	If (@@error <> 0)  
		Begin        
			Print 'Khong the them uu dai'         
			Rollback tran  
			return
		End

commit tran
end
go

--thong ke doanh thu theo mon an
create proc thongkedoanhthutheomonan
	@idmon varchar(10),
	@tong float OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	if not exists (select * from MonAn where IDmon = @idmon)
	begin
		print 'Mon an khong ton tai'
		rollback tran
	end
	select * from ChiTietDonHang ct, DonHang dh where IDmon = @idmon and ct.MaDonHang = dh.MaDonHang and dh.TrangThai = 'Hoan tat'

	
	declare @tongdoanhthu float = 0
	declare @tmp float
	declare CS_HD cursor for select MaHoaDon from HoaDon
	open CS_HD 
	declare @MaHoaDon varchar(10)
	fetch next from CS_HD into @MaHoaDon
	while (@@FETCH_STATUS = 0)
	begin
		if exists(select * from DonHang dh, HoaDon hd where dh.MaDonHang = hd.MaDonHang and dh.TrangThai = 'Hoan tat' and hd.MaHoaDon = @MaHoaDon)
		begin
			if exists(select * from HoaDon hd, ChiTietDonHang ct, MonAn mon 
				where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = ct.MaDonHang and ct.IDmon = mon.IDmon and mon.IDmon = @idmon)
			begin
				set @tongdoanhthu = @tongdoanhthu + (select ct.TongTien1Mon from HoaDon hd, ChiTietDonHang ct, MonAn mon 
				where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = ct.MaDonHang and ct.IDmon = mon.IDmon and mon.IDmon = @idmon)
			end
		end
		fetch next from CS_HD into @MaHoaDon
	end
	close CS_HD
	deallocate CS_HD 

	set @tong = @tongdoanhthu
commit tran
end
go
declare @tong float
exec thongkedoanhthutheomonan 'Mon1', @tong OUTPUT
select @tong
go

--thong ke doanh thu theo chi nhanh
create proc thongkedoanhthutheochinhanh
	@idchinhanh varchar(10),
	@tong float OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	if not exists (select * from ChiNhanh where IDchinhanh = @idchinhanh)
	begin
		print 'Chi nhanh khong ton tai'
		rollback tran
	end
	
	select * from HoaDon hd, DonHang dh where hd.MaDonHang = dh.MaDonHang and dh.ChiNhanhDuocChon = @idchinhanh and dh.TrangThai = 'Hoan tat'

	declare @tongdoanhthu float = 0
	declare CS_HD cursor for select MaHoaDon from HoaDon
	open CS_HD 
	declare @MaHoaDon varchar(10)
	fetch next from CS_HD into @MaHoaDon
	while (@@FETCH_STATUS = 0)
	begin
		if exists(select * from DonHang dh, HoaDon hd where dh.MaDonHang = hd.MaDonHang and dh.TrangThai = 'Hoan tat' and hd.MaHoaDon = @MaHoaDon)
		begin
			if exists(select * from HoaDon hd, DonHang dh where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = dh.MaDonHang and dh.ChiNhanhDuocChon = @idchinhanh)
			begin
				set @tongdoanhthu = @tongdoanhthu + (select ThanhTien from HoaDon hd, DonHang dh where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = dh.MaDonHang and dh.ChiNhanhDuocChon = @idchinhanh)
			end
		end
		fetch next from CS_HD into @MaHoaDon
	end
	close CS_HD 
	deallocate CS_HD 

	set @tong = @tongdoanhthu
commit tran
end
go
declare @tong float
exec thongkedoanhthutheochinhanh 'CN1', @tong OUTPUT
select @tong
go

--thong ke doanh thu theo loai KH
create proc thongkedoanhthutheoloaiKH
	@loaiKH varchar(20),
	@tong float OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	if not exists (select * from DonHang where LoaiKhachHang = @loaiKH)
	begin
		print 'Khong dung loai KH'
		rollback tran
	end
	
	select * from HoaDon hd, DonHang dh where hd.MaDonHang = dh.MaDonHang and dh.LoaiKhachHang = @loaiKH and dh.TrangThai = 'Hoan tat'
	waitfor delay '00:00:05'
	declare @tongdoanhthu float = 0
	declare CS_HD cursor for select MaHoaDon from HoaDon
	open CS_HD 
	declare @MaHoaDon varchar(10)
	fetch next from CS_HD into @MaHoaDon
	while (@@FETCH_STATUS = 0)
	begin
		if exists(select * from DonHang dh, HoaDon hd where dh.MaDonHang = hd.MaDonHang and dh.TrangThai = 'Hoan tat' and hd.MaHoaDon = @MaHoaDon)
		begin
			if exists(select * from HoaDon hd, DonHang dh where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = dh.MaDonHang and dh.LoaiKhachHang = @loaiKH)
			begin
				set @tongdoanhthu = @tongdoanhthu + (select ThanhTien from HoaDon hd, DonHang dh where hd.MaHoaDon = @MaHoaDon and hd.MaDonHang = dh.MaDonHang and dh.LoaiKhachHang = @loaiKH)
			end
			print @MaHoaDon
		end
		fetch next from CS_HD into @MaHoaDon
	end
	close CS_HD 
	deallocate CS_HD 
	
	set @tong = @tongdoanhthu
commit tran
end
go
declare @tong float
exec thongkedoanhthutheoloaiKH 'Thanh vien', @tong OUTPUT
select @tong
go
--thong ke doanh thu theo loai mon
create proc thongkedoanhthutheoloaimon
	@loaimon varchar(20),
	@tong float OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	if not exists (select * from MonAn where LoaiMon = @loaimon)
	begin
		print 'Khong ton tai'
		rollback tran
	end
	
	select ct.MaDonHang, ct.IDmon, ct.tenmon, mon.LoaiMon, ct.soluongdat, ct.TongTien1Mon, dh.TrangThai from HoaDon hd, ChiTietDonHang ct, DonHang dh, MonAn mon 
	where hd.MaDonHang = ct.MaDonHang and ct.IDmon = mon.IDmon and mon.LoaiMon = @loaimon and dh.MaDonHang = hd.MaDonHang and dh.TrangThai = 'Hoan tat'
	waitfor delay '00:00:05'
	declare @tongdoanhthu float = 0
	declare @tmp float
	declare CS_CTDH cursor for select MaDonHang, IDmon from ChiTietDonHang
	open CS_CTDH 
	declare @MaDH varchar(10)
	declare @IDmon varchar(10)
	fetch next from CS_CTDH into @MaDH, @IDmon
	while (@@FETCH_STATUS = 0)
	begin
		if exists(select * from DonHang dh, HoaDon hd, ChiTietDonHang ct, MonAn mon where hd.MaDonHang = dh.MaDonHang and dh.MaDonHang = ct.MaDonHang and dh.TrangThai = 'Hoan tat' and 
			ct.MaDonHang = @MaDH and ct.IDmon = @IDmon and ct.IDmon = mon.IDmon and mon.LoaiMon = @loaimon)
		begin
				set @tongdoanhthu = @tongdoanhthu + (select ct.TongTien1Mon from DonHang dh, ChiTietDonHang ct, MonAn mon where dh.MaDonHang = ct.MaDonHang and dh.MaDonHang = @MaDH 
				and ct.IDmon = @IDmon and mon.IDmon = ct.IDmon and mon.LoaiMon = @loaimon)	
				
		end
		print @tongdoanhthu
		fetch next from CS_CTDH into @MaDH, @IDmon
	end
	close CS_CTDH
	deallocate CS_CTDH 
	
	set @tong = @tongdoanhthu
commit tran
end
go
declare @tong float 
exec thongkedoanhthutheoloaimon 'Mon nuoc', @tong OUTPUT
select @tong
go
--xem chi nhanh de dat hang
create proc XemChiNhanhDeDatHang
	@count int OUTPUT
as 
begin
begin tran
	set tran isolation level serializable
	select * from ChiNhanh
	waitfor delay '00:00:05'
	set @count = (select COUNT(IDchinhanh) from ChiNhanh)
commit tran
end
go
declare @count int
exec XemChiNhanhDeDatHang @count OUTPUT
select @count
go
--thong ke ti le huy don hang theo loai khach hang
create proc thongketilehuyDHtheoloaiKH
	@loaiKH varchar(20),
	@tilehuy float OUTPUT
as
begin
begin tran
	set tran isolation level repeatable read
	select MaDonHang, TrangThai from DonHang where LoaiKhachHang = @loaiKH
	waitfor delay '00:00:05'
	
	declare @soluongHuy int = (select COUNT(MaDonHang) from DonHang where LoaiKhachHang = @loaiKH and TrangThai = 'Huy')
	set @tilehuy = (@soluonghuy*1.0/(select COUNT(MaDonHang) from DonHang where LoaiKhachHang = @loaiKH)) * 100
	
commit tran
end
go

declare @tile float
exec thongketilehuyDHtheoloaiKH 'Vang lai', @tile OUTPUT
select @tile
go
--xem danh sach thanh vien
create proc XemThanhVien
	@count int OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	select * from ThanhVien
	waitfor delay '00:00:05'
	set @count = (select COUNT(CMND) from ThanhVien)
commit
end 
go
declare @count int
exec XemThanhVien @count OUTPUT
select @count
