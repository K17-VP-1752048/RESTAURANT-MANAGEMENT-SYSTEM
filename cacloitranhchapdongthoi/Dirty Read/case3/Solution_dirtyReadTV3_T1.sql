use HeThongNhaHangHuongViet
go
create proc dangky
	@CMND varchar(10),
	@NgaySinh date,
	@DiaChi nvarchar(20),
	@SDT varchar(20),
	@ChiNhanhDangKy varchar(10), --IDchinhanh
	@Email varchar(20),
	@pwd varchar(20)
as
begin
begin tran
	if exists (select CMND from ThanhVien where CMND = @CMND)
	begin
		print 'CMND da su dung'
		rollback tran
		return
	end
	if not exists (select IDchinhanh from ChiNhanh where IDchinhanh = @ChiNhanhDangKy)
	begin
		print 'Khong co chi nhanh nay'
		rollback tran
		return
	end
	insert into ThanhVien values(@CMND, @NgaySinh, @DiaChi, @SDT, @ChiNhanhDangKy, 0, 'Silver', @Email, @pwd)

	if(@pwd is null or @Email is null or @SDT is null)
	Begin        
			Print 'Ban chua nhap du thong tin dang ky'         
			Rollback tran  
			return
		End
	If (@@error <> 0)  
		Begin        
			Print 'Khong the dang ky thanh vien'         
			Rollback tran  
			return
		End
commit tran
end
exec dangky '0259777777','1999-10-11','Quan 9 TPHCM', '0909090900', 'CN1', null, null
go
