using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _1752048_1752038_1752024_1752051
{
    public partial class FormTTGH : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");
        string madonhang;
        string cmndnguodat;
        public FormTTGH(string cmnd, string madonhang)
        {
            this.madonhang = madonhang;
            this.cmndnguodat = cmnd;
            InitializeComponent();
            
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            con.Open();
            String query = "exec HuyDonHang @MaDonHang";
            SqlCommand com = new SqlCommand(query, con);
            com.CommandType = CommandType.Text;
            com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
            com.ExecuteNonQuery();
            con.Close();
            this.Close();
        }

        private void btnClick_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                if (!string.IsNullOrEmpty(txtTen.Text) && !string.IsNullOrEmpty(txtSDT.Text) && !string.IsNullOrEmpty(txtTP.Text)
                    && !string.IsNullOrEmpty(txtQuan.Text) && !string.IsNullOrEmpty(txtPhuong.Text) && !string.IsNullOrEmpty(txtDuong.Text) && !string.IsNullOrEmpty(cbHinhThuc.Text))
                {
                     String query = "exec KHnhapthongtingiaohang @TenNguoiNhan, @SDTnguoinhan, @ThanhPho, @Quan, @Phuong, @Duong, @MaGiamGia, @MaDonHang";
                     SqlCommand com = new SqlCommand(query, con);
                     com.CommandType = CommandType.Text;
                     com.Parameters.Add("@TenNguoiNhan", SqlDbType.VarChar, 20).Value = txtTen.Text;
                     com.Parameters.Add("@SDTnguoinhan", SqlDbType.VarChar, 20).Value = txtSDT.Text;
                     com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtTP.Text;
                     com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = txtQuan.Text;
                     com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = txtPhuong.Text;
                     com.Parameters.Add("@Duong", SqlDbType.VarChar, 20).Value = txtDuong.Text;
                     if (string.IsNullOrEmpty(txtUuDai.Text))
                         com.Parameters.Add("@MaGiamGia", SqlDbType.VarChar, 10).Value = DBNull.Value;
                     else
                         com.Parameters.Add("@MaGiamGia", SqlDbType.VarChar, 10).Value = txtUuDai.Text;
                     com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
                     com.ExecuteNonQuery();

                     String query1 = "exec LapHoaDon @MaDonHang, @HinhThucThanhToan";
                     SqlCommand com1 = new SqlCommand(query1, con);
                     com1.CommandType = CommandType.Text;
                     com1.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
                     com1.Parameters.Add("@HinhThucThanhToan", SqlDbType.VarChar, 20).Value = cbHinhThuc.SelectedItem.ToString();
                     com1.ExecuteNonQuery();

                     String query2 = "select * from HoaDon where MaDonHang = @madh";
                     SqlCommand com2 = new SqlCommand(query2, con);
                     com2.CommandType = CommandType.Text;
                     com2.Parameters.Add("@madh", SqlDbType.VarChar, 10).Value = this.madonhang;
                     SqlDataAdapter da = new SqlDataAdapter(com2);
                     DataTable dt = new DataTable();
                     da.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
                else MessageBox.Show("Nhap thieu thong tin");
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Nhap sai thong tin");
            }
            
        }

        private void btnThanhToan_Click(object sender, EventArgs e)
        {

            /*if (string.IsNullOrEmpty(this.cmndnguodat))
                MessageBox.Show("Thanh toan don hang thanh cong");
            else
            {
                con.Open();
                String query = "exec GhiNhanDiemTichLuyfix @CMND, @MaDonHang";
                SqlCommand com = new SqlCommand(query, con);
                com.CommandType = CommandType.Text;
                com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = this.cmndnguodat;
                com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
                com.ExecuteNonQuery();
                con.Close();
                MessageBox.Show("Thanh toan don hang thanh cong. Da ghi nhan diem tich luy");
            }*/
            if (dataGridView1.DataSource == null)
            {
                MessageBox.Show("Ban chua co hoa don. Hay nhap thong tin giao hang va click vao nut dat hang de xem hoa don");
            }
            else
            {
                MessageBox.Show("Thanh toan thanh cong");
                this.Close();

            }
        }
    }
}
