use HeThongNhaHangHuongViet
go

create proc XemMenuTheoChiNhanhfix
	@idchinhanh varchar(10)
as
begin
begin tran
	set tran isolation level repeatable read
	select * from SLMonAnTrongNgay where IDchinhanh = @idchinhanh
	waitfor delay '00:00:05'
	select * from SLMonAnTrongNgay where IDchinhanh = @idchinhanh
commit tran
end 
go
exec XemMenuTheoChiNhanhfix 'CN1' 
