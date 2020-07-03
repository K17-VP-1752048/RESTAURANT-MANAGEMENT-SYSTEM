use HeThongNhaHangHuongViet
go
create proc GhiNhanDiemTichLuy
	@CMND varchar(10),
	@MaDonHang varchar(10)
as
begin
begin tran
	set tran isolation level repeatable read
	if not exists (select * from ThanhVien where CMND = @CMND)
	begin
		print 'Thanh vien khong ton tai'
		rollback tran
		return
	end
	if not exists (select * from DonHang where MaDonHang = @MaDonHang and TrangThai = 'Hoan tat')
	begin
		print 'Don hang chua hoan tat'
		rollback tran
		return
	end

	declare @diemtichluy float = (select DiemTichLuy from ThanhVien where CMND = @CMND)
	waitfor delay '00:00:05'
	update ThanhVien 
	set DiemTichLuy = @diemtichluy + (select ThanhTien from HoaDon where MaDonHang = @MaDonHang) 
	where CMND = @CMND
	
	set @diemtichluy = (select DiemTichLuy from ThanhVien where CMND = @CMND)
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
exec GhiNhanDiemTichLuy '0259777777', 'DH2'
select * from ThanhVien
