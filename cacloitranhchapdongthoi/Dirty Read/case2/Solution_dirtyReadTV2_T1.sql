use HeThongNhaHangHuongViet
go

alter proc ThemMonAn
	@TenMon nvarchar(20),
	@dongia float,
	@Loaimon nvarchar(20)
as
begin
begin tran
	if exists (select TenMon from MonAn where TenMon = @TenMon)
	begin
		print 'Mon an nay da co trong menu'
		rollback tran
		return
	end
	--id mon an duoc tao tu dong
	declare @count int = 1
	while exists(select * from  MonAn where 'Mon' + CONVERT(varchar(3),@count) = IDmon)
	begin
		set @count = @count + 1;
	end

	insert into MonAn values ('Mon' + CONVERT(varchar(3),@count), @TenMon, @dongia, @Loaimon)
	--xai cursor de them mon an moi cho tung chi nhanh
	declare CS_chinhanh cursor for select IDchinhanh from ChiNhanh
	open CS_chinhanh 
	declare @idchinhanh varchar(10)
	fetch next from CS_chinhanh into @idchinhanh
	while (@@FETCH_STATUS = 0)
	begin
		insert into SLMonAnTrongNgay values (@idchinhanh,'Mon' + CONVERT(varchar(3),@count),0)
		fetch next from CS_chinhanh into @idchinhanh
	end
	close CS_chinhanh
	deallocate CS_chinhanh
	waitfor delay '00:00:10'

	if(@TenMon is null or @dongia is null or @Loaimon is null)
	begin
		print 'Ban chua nhap thong tin mon day du'
		rollback tran
		return
	end
	
	if(@dongia <= 0)
	begin
		print 'Don gia khong hop le'
		rollback tran
		return
	end

	

	If (@@error <> 0)  
	Begin        
		Print 'Khong the them mon an'         
		Rollback tran  
		return
	End
commit tran
end
go
exec ThemMonAn 'Mien xao chay', null, null
select * from MonAn
select * from SLMonAnTrongNgay