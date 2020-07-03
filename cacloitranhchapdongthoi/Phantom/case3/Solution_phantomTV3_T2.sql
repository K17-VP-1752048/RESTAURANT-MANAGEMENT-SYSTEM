use HeThongNhaHangHuongViet
go

create proc XemThanhVienfix
	@count int OUTPUT
as
begin
begin tran
	set tran isolation level serializable
	select * from ThanhVien
	waitfor delay '00:00:05'
	set @count = (select COUNT(CMND) from ThanhVien)
commit
end 
go
declare @count int
exec XemThanhVienfix @count OUTPUT
select @count