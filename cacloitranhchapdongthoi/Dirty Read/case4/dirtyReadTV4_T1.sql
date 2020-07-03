use HeThongNhaHangHuongViet
go
alter proc GhiNhanDiemTichLuy
	@CMND varchar(10),
	@MaDonHang varchar(10)
as
begin
begin tran
	if not exists (select * from ThanhVien where CMND = @CMND)
	begin
		print 'Thanh vien khong ton tai'
		rollback tran
		return
	end
	
	update ThanhVien set DiemTichLuy = DiemTichLuy + (select ThanhTien from HoaDon where MaDonHang = @MaDonHang) where CMND = @CMND
	
	waitfor delay '00:00:10'

	if not exists (select * from DonHang where MaDonHang = @MaDonHang and TrangThai = 'Hoan tat')
	begin
		print 'Don hang chua hoan tat'
		rollback tran
		return
	end

	declare @diemtichluy float = (select DiemTichLuy from ThanhVien where CMND = @CMND)
	if(@diemtichluy > 20000000)
	begin
		update ThanhVien set Hang = 'Diammond' where CMND = @CMND
	end
	if(@diemtichluy > 5000000 and @diemtichluy <= 20000000) 
	begin
		update ThanhVien set Hang = 'Gold' where CMND = @CMND
	end
	if(@diemtichluy <= 5000000)
	begin
		update ThanhVien set Hang = 'Silver' where CMND = @CMND
	end
	If (@@error <> 0)  
		Begin        
			Print 'Khong the ghi nhan diem tich luy'         
			Rollback tran  
			return
		End
commit tran
end
exec GhiNhanDiemTichLuy '0258887895', 'DH3'
select * from ThanhVien
