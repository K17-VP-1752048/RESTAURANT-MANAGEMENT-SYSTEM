use HeThongNhaHangHuongViet
go

create proc XemThanhVien
as
begin
begin tran
	select * from ThanhVien
	waitfor delay '00:00:05'
	select * from ThanhVien
commit tran
end 
go
exec XemThanhVien