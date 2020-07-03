use HeThongNhaHangHuongViet
go
create proc themchinhanh
	@TenChiNhanh nvarchar(20),
	@SDT varchar(20),
	@ThanhPho nvarchar(20),
	@Quan nvarchar(20),
	@Phuong nvarchar(20),
	@Duong nvarchar(20)
as
begin
begin tran
	if(@TenChiNhanh is null or @SDT is null or @ThanhPho is null or @Quan is null or @Duong is null or @Phuong is null)
	begin
		print 'Chua nhap day du thong tin chi nhanh'
		rollback tran
		return
	end
	if exists(select * from ChiNhanh where ThanhPho = @ThanhPho and Quan = @Quan and Phuong = @Phuong and @Duong = Duong)
	begin
		print 'Ban nhap trung dia chi chi nhanh moi voi chi nhanh da co'
		rollback tran
		return
	end

	declare @count int = 1
	while exists(select * from  ChiNhanh where 'CN' + CONVERT(varchar(3),@count) = IDchinhanh)
	begin
		set @count = @count + 1;
	end

	insert into ChiNhanh values('CN' + CONVERT(varchar(3),@count), @TenChiNhanh, @SDT, @ThanhPho, @Quan, @Phuong, @Duong)

	--xai cursor de them chi nhanh moi vao bang SLMonAnTrongNgay
	declare CS_MonAn cursor for select IDmon from MonAn
	open CS_MonAn 
	declare @IDmon varchar(10)
	fetch next from CS_MonAn into @IDmon
	while (@@FETCH_STATUS = 0)
	begin
		insert into SLMonAnTrongNgay values ('CN' + CONVERT(varchar(3),@count), @IDmon, 0)
		fetch next from CS_MonAn into @IDmon
	end
	close CS_MonAn
	deallocate CS_MonAn

commit tran
end
go
exec themchinhanh 'Huong Viet Que', '0289292922', 'Ho Chi Minh', 'Thu Duc', 'Binh Tho', '2 Thong Nhat'
select * from ChiNhanh