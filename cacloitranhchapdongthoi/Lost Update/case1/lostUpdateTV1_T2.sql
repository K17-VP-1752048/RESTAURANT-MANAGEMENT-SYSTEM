use HeThongNhaHangHuongViet
go
alter proc DatMon
	@MaDonHang varchar(10), 
	@IDmon varchar(10), 
	@soluongdat int
as
begin
begin tran
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

	declare @chinhanhduocchon varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)
	if((@soluongdat < 0))
	begin
		print 'So luong dat khong hop le'
		rollback tran
		return
	end

	declare @tenmon nvarchar(20) = (select TenMon from MonAn where IDmon = @IDmon)
	declare @dongia nvarchar(20) = (select DonGia from MonAn where IDmon = @IDmon)
	declare @chinhanh varchar(10) = (select ChiNhanhDuocChon from DonHang where MaDonHang = @MaDonHang)
	if not exists (select * from ChiTietDonHang where IDmon = @IDmon and MaDonHang = @MaDonHang)
	begin
		insert into ChiTietDonHang values (@MaDonHang, @IDmon, @tenmon, @dongia, @soluongdat, @dongia*@soluongdat)
	end
	else
	begin
		--cap nhat lai so luong dat thi phai tra lai so luong cu cho chi nhanh
		declare @soluong int = (select soluongdat from ChiTietDonHang where MaDonHang = @MaDonHang and IDmon = @IDmon)
		update SLMonAnTrongNgay set soluong = soluong + @soluong where IDmon = @IDmon and IDchinhanh = @chinhanh
		update ChiTietDonHang set soluongdat = @soluongdat where IDmon = @IDmon and MaDonHang = @MaDonHang
	end
	--mon an duoc them vao don hang, thi cap nhat lai so luong phan an mon nay o chi nhanh
	set @soluong = (select soluong from SLMonAnTrongNgay where  IDchinhanh = @chinhanhduocchon and IDmon = @IDmon)
	print @soluong
	waitfor delay '00:00:05'
	update SLMonAnTrongNgay set soluong = @soluong - @soluongdat where IDmon = @IDmon and IDchinhanh = @chinhanh
	
	if((select soluong from SLMonAnTrongNgay where IDmon = @IDmon and IDchinhanh = @chinhanh) < 0)
	begin
		print 'So luong dat khong hop le'
		rollback tran
		return
	end

	If (@@error <> 0)  
		Begin        
			Print 'Khong the dat mon an'         
			Rollback tran  
			return
		End
commit tran
end
go
exec DatMon 'DH5', 'Mon1', 5
select * from SLMonAnTrongNgay where IDchinhanh = 'CN1' and IDmon = 'Mon1'
select * from DonHang