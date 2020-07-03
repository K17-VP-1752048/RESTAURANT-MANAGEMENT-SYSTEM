use HeThongNhaHangHuongViet
go
create proc XemChiNhanhDeDatHangfix
	@count int OUTPUT
as 
begin
begin tran
	set tran isolation level serializable
	select * from ChiNhanh
	waitfor delay '00:00:05'
	set @count = (select COUNT(IDchinhanh) from ChiNhanh)
commit tran
end
go
declare @count int
exec XemChiNhanhDeDatHangfix @count OUTPUT
select @count