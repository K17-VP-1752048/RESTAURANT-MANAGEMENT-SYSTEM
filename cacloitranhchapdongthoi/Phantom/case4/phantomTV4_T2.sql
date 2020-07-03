use HeThongNhaHangHuongViet
go

alter proc thongkedoanhthutheoloaiKH
	@loaiKH varchar(20),
	@tong float OUTPUT
as
begin
begin tran
	--set tran isolation level serializable
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