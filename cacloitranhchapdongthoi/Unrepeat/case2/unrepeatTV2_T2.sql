use HeThongNhaHangHuongViet
go

create proc XemMenuTheoChiNhanh
	@idchinhanh varchar(10)
as
begin
begin tran
	select * from SLMonAnTrongNgay where IDchinhanh = @idchinhanh
	waitfor delay '00:00:05'
	select * from SLMonAnTrongNgay where IDchinhanh = @idchinhanh
commit tran
end 
go
exec XemMenuTheoChiNhanh 'CN1'