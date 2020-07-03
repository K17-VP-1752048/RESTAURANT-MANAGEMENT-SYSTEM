use HeThongNhaHangHuongViet
go

create proc XemThanhVien
as
begin
begin tran
	select * from ThanhVien
	waitfor delay '00:00:05'
	select COUNT(CMND) as 'So luong thanh vien' from ThanhVien
commit
end 
go
exec XemThanhVien