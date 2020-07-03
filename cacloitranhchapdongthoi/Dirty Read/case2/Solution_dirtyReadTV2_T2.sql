use HeThongNhaHangHuongViet
go


--2. KH lua chon chi nhanh hoac chi nhanh khach dky doi voi thanh vien . Truong hop KH khong chon chi nhanh thi he thong chon chi nhanh cung TP voi dia chi giao hang
alter proc xemmenutheochinhanhfix
	@CMND varchar(10),
	@chinhanhluachon varchar(10),
	---dia chi nhan
	@ThanhPho varchar(20),
	@Quan varchar(20),
	@Phuong varchar(20)
as
begin
begin tran
	set tran isolation level read committed
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
		waitfor delay '00:00:05'
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
				declare @chinhanhgannhat varchar(10)
				if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan and Phuong = @Phuong)
				begin
					set @chinhanhgannhat = (select IDchinhanh from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan and Phuong = @Phuong)
				end
				else if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan)
				begin
					set @chinhanhgannhat = (select IDchinhanh from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan)
				end
				else
				begin
					set @chinhanhgannhat = (select IDchinhanh from ChiNhanh where ThanhPho = @ThanhPho)
				end
				select distinct sl.IDchinhanh, sl.IDmon, sl.soluong as 'So luong cung cap trong ngay', mon.TenMon, mon.DonGia, mon.LoaiMon 
					from SLMonAnTrongNgay sl, MonAn mon, ChiNhanh cn where  sl.IDchinhanh = @chinhanhgannhat and sl.IDmon = mon.IDmon 
			end
		end
	end
commit tran
end
exec xemmenutheochinhanhfix null, 'CN1', null, null, null
go