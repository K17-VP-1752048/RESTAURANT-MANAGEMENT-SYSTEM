use HeThongNhaHangHuongViet
go

create proc XemThanhViendirtyreadfix
as
begin
begin tran
	set tran isolation level read committed
	waitfor delay '00:00:05'
	select * from ThanhVien
	select COUNT(CMND) as 'So luong thanh vien' from ThanhVien
commit tran
end 
go
exec XemThanhViendirtyreadfix