use HeThongNhaHangHuongViet
go

alter proc CapNhatTrangThaiDonHang
	@idDH varchar(10),
	@trangthai varchar(20)
as
begin
begin tran
	if not exists (select * from DonHang where MaDonHang = @idDH)
	begin
		print 'Don hang khong ton tai'
		rollback tran
	end
	update DonHang set TrangThai = @trangthai where MaDonHang = @idDH
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat don hang'         
			Rollback tran  
		End
commit tran
end
go
exec CapNhatTrangThaiDonHang 'DH9', 'Hoan tat'