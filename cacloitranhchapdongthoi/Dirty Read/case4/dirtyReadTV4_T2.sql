use HeThongNhaHangHuongViet
go

create proc XemThanhViendirtyread
as
begin
begin tran
	set tran isolation level read uncommitted
	waitfor delay '00:00:05'
	select * from ThanhVien
	select COUNT(CMND) as 'So luong thanh vien' from ThanhVien
commit tran
end 
go
exec XemThanhViendirtyread