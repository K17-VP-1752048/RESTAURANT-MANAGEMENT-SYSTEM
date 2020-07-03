use HeThongNhaHangHuongViet
go

alter proc DatMon
	@MaDonHang varchar(10), 
	@IDmon varchar(10), 
	@soluongdat int
as
begin
begin tran
	set tran isolation level repeatable read
	if not exists(select * from DonHang where MaDonHang = @MaDonHang)
	begin
		print 'Khong ton tai ma don hang'
		rollback tran
		return
	end

	if(@soluongdat < 0)
	begin
		print 'So luong dat khong hop le'
		rollback tran
		return
	end

	declare @tenmon nvarchar(20) = (select TenMon from MonAn where IDmon = @IDmon)
	declare @dongia nvarchar(20) = (select DonGia from MonAn where IDmon = @IDmon)
	
	insert into ChiTietDonHang values (@MaDonHang, @IDmon, @tenmon, @dongia, @soluongdat, @dongia*@soluongdat)
	

	--mon an duoc them vao don hang, thi cap nhat lai so luong phan an mon nay o chi nhanh
	declare @chinhanh varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)

	declare @soluong int = (select soluong from SLMonAnTrongNgay where IDmon = @IDmon and IDchinhanh = @chinhanh)
	waitfor delay '00:00:05'
	update SLMonAnTrongNgay set soluong = @soluong - @soluongdat where IDmon = @IDmon and IDchinhanh = @chinhanh
	
	If (@@error <> 0)  
		Begin        
			Print 'Khong the dat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec DatMon 'DH1', 'Mon2', 3
select * from SLMonAnTrongNgay where IDchinhanh = 'CN1' and IDmon = 'Mon2'
