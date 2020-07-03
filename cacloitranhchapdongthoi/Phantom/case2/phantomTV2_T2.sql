use HeThongNhaHangHuongViet
go

alter proc thongkedoanhthutheoloaimon
	@loaimon varchar(20),
	@tong float OUTPUT
as
begin
begin tran
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