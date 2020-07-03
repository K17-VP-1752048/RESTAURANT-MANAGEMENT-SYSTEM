use HeThongNhaHangHuongViet
go
--thong ke ti le huy don hang theo loai khach hang
create proc thongketilehuyDHtheoloaiKH
	@loaiKH varchar(20)
as
begin
begin tran
	select MaDonHang, TrangThai from DonHang where LoaiKhachHang = @loaiKH
	waitfor delay '00:00:05'
	
	declare @soluongHuy int = (select COUNT(MaDonHang) from DonHang where LoaiKhachHang = @loaiKH and TrangThai = 'Huy')
	declare @tile float = (@soluonghuy*1.0/(select COUNT(MaDonHang) from DonHang where LoaiKhachHang = @loaiKH)) * 100
	select @tile as 'Ti le huy don hang'
commit tran
end
go
exec thongketilehuyDHtheoloaiKH 'Vang lai' 
select * from DonHang