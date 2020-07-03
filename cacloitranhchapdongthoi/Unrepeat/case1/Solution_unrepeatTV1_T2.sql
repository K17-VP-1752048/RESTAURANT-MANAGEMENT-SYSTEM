use HeThongNhaHangHuongViet
go

--thong ke ti le huy don hang theo loai khach hang
alter proc thongketilehuyDHtheoloaiKHfix
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
exec thongketilehuyDHtheoloaiKHfix 'Vang lai', @tile OUTPUT
select @tile
