use HeThongNhaHangHuongViet
go

alter proc CapNhatMonAn
	@IDmon varchar(10),
	@TenMon varchar(20),
	@dongia float
as
begin
begin tran
	if not exists (select * from MonAn where IDmon = @IDmon)
	begin
		print 'Mon an ban muon cap nhat khong co trong menu'
		rollback tran
		return
	end
	if((@TenMon is null and @dongia is null) or (@TenMon = '' and @dongia = '')
		or (@TenMon is null and @dongia = '') or (@TenMon = '' and @dongia is null))
	begin
		print 'Ban khong nhap thong tin can cap nhat'
		rollback tran
		return
	end
	
	if(@TenMon is not null)
	begin
		update MonAn set TenMon = @TenMon where IDmon = @IDmon
	end
	
	if(@dongia is not null)
	begin
		update MonAn set DonGia = @dongia where IDmon = @IDmon
	end
	waitfor delay '00:00:10'
	if(@dongia <= 0)
	begin
		print 'Don gia khong hop le'
		rollback tran
		return
	end
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec CapNhatMonAn 'Mon3', null, -30000
select * from MonAn