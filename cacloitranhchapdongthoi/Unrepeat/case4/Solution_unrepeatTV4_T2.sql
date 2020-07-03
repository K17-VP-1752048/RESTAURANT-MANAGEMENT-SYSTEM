use HeThongNhaHangHuongViet
go

create proc XemChiNhanhfix
as
begin 
begin tran
	set tran isolation level repeatable read
	select * from ChiNhanh
	waitfor delay '00:00:05'
	select * from ChiNhanh
commit tran
end 
go
exec XemChiNhanhfix