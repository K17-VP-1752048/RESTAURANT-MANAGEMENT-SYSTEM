use HeThongNhaHangHuongViet
go

create proc XemThanhVienfix
as
begin
begin tran
	set tran isolation level repeatable read
	select * from ThanhVien
	waitfor delay '00:00:05'
	select * from ThanhVien
commit tran
end 
go
exec XemThanhVienfix