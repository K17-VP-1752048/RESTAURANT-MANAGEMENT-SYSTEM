use HeThongNhaHangHuongViet
go
---cap nhat chi nhanh
create proc capnhatchinhanh
	@IDchinhanh varchar(10),
	@TenChiNhanh nvarchar(20),
	@SDT varchar(20),
	@ThanhPho nvarchar(20),
	@Quan nvarchar(20),
	@Phuong nvarchar(20),
	@Duong nvarchar(20)
as
begin
begin tran
	if not exists(select * from ChiNhanh where IDchinhanh = @IDchinhanh)
	begin
		print 'Khong co chi nhanh nay'
		rollback tran
		return
	end

	if(@TenChiNhanh is null and @SDT is null and @ThanhPho is null and @Quan is null and @Phuong is null and @Duong is null)
	begin
		print 'Ban chua nhap thong tin can thay doi'
		rollback tran
		return
	end
	
	if(@TenChiNhanh is not null)
	begin
		update ChiNhanh set TenChiNhanh = @TenChiNhanh where IDchinhanh = @IDchinhanh
	end

	if(@SDT is not null)
	begin
		update ChiNhanh set SDT = @SDT where IDchinhanh = @IDchinhanh
	end

	if(@ThanhPho is not null)
	begin
		update ChiNhanh set ThanhPho = @ThanhPho where IDchinhanh = @IDchinhanh
	end

	if(@Quan is not null)
	begin
		update ChiNhanh set Quan = @Quan where IDchinhanh = @IDchinhanh
	end

	if(@Duong is not null)
	begin
		update ChiNhanh set Duong = @Duong where IDchinhanh = @IDchinhanh
	end

	if(@Phuong is not null)
	begin
		update ChiNhanh set Phuong = @Phuong where IDchinhanh = @IDchinhanh
	end

	If (@@error <> 0)  
		Begin        
			Print 'Khong the cap nhat thong tin chi nhanh nay'         
			Rollback tran  
			return
		End
commit tran
end
go
exec capnhatchinhanh 'CN1','Huong Viet TQK',null,null,null,null,null
select * from ChiNhanh
