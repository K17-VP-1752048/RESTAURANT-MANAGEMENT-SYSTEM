use HeThongNhaHangHuongViet
go
--18. Huy don hang o trang thai tiep nhan
create proc HuyDonHang
	@madonhang varchar(10)
as
begin
begin tran
	if not exists(select * from DonHang where MaDonHang = @madonhang)
	begin
		print 'Khong co don hang nay'
		rollback tran
		return
	end
	if((select TrangThai from DonHang where MaDonHang = @madonhang) != 'Tiep nhan')
	begin
		print 'Ban khong the huy don hang nay'
		rollback tran
		return
	end

	--huy don hang thi cap nhat so luong mon an cua chi nhanh lai
	declare CS_DonHang cursor for select IDmon, soluongdat from ChiTietDonHang where MaDonHang = @madonhang
	open CS_DonHang
	declare @soluongdat int
	declare @IDmon varchar(10)
	fetch next from CS_DonHang into @IDmon, @soluongdat
	while (@@FETCH_STATUS = 0)
	begin
		update SLMonAnTrongNgay set soluong = soluong + @soluongdat where IDmon = @IDmon
		fetch next from CS_DonHang into @IDmon, @soluongdat
	end
	close CS_DonHang
	deallocate CS_DonHang

	update DonHang set TrangThai = 'Huy' where MaDonHang = @madonhang
	If (@@error <> 0)  
		Begin        
			Print 'Khong the huy don hang'         
			Rollback tran  
			return
		End
commit tran
end
go 
exec HuyDonHang 'DH5'