use HeThongNhaHangHuongViet
go
create proc XemChiNhanhDeDatHang
as 
begin
begin tran
	select * from ChiNhanh
	waitfor delay '00:00:05'
	select COUNT(idchinhanh) as 'So luong chi nhanh' from ChiNhanh
commit tran
end
go
exec XemChiNhanhDeDatHang