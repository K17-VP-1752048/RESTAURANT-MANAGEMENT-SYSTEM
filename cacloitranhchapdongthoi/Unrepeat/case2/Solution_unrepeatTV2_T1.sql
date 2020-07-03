use HeThongNhaHangHuongViet
go

--12. cap nhat so luong mon an trong ngay theo chi nhanh
create proc SLMonAnTrongNgayDuocCungCap
	@IDchinhanh varchar(10),
	@IDmon varchar(10),
	@soluongphan int
as
begin
begin tran
	if not exists (select * from MonAn where IDmon = @IDmon)
	begin
		Print 'Mon an nay khong co trong thuc don'         
		Rollback tran  
		return
	end
	if not exists (select * from ChiNhanh where IDchinhanh = @IDchinhanh)
	begin
		Print 'Nha hang khong co chi nhanh nay'         
		Rollback tran  
		return
	end
	
	if (@soluongphan is null or (@soluongphan < 0))
	begin
		Print 'So luong phan an cap nhat khong hop le'         
		Rollback tran  
		return
	end

	update SLMonAnTrongNgay set soluong = @soluongphan where IDchinhanh = @IDchinhanh and IDmon = @IDmon

	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat so luong phan mon an nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec SLMonAnTrongNgayDuocCungCap 'CN1', 'Mon2', 105