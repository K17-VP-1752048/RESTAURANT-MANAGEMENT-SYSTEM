using DangKy;
using DatMon;
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
    public partial class FormChonChiNhanh : Form
    {
        //HeThongNhaHangHuongVietEntities4 model = new HeThongNhaHangHuongVietEntities4();
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");
      
        public FormChonChiNhanh()
        {
            con.Open();
            InitializeComponent();

            String query1 = "exec XemChiNhanhDeDatHang @count OUTPUT";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            com1.Parameters.Add("@count", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
            com1.ExecuteNonQuery();
            String kq = (String)com1.Parameters["@count"].Value;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridViewChiNhanh.DataSource = dt1;
            lblTongCN.Text = "Tong so luong chi nhanh: " + kq; 

            String query = "select * from ChiNhanh";
            SqlCommand com = new SqlCommand(query, con);
            com.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cbChiNhanh.DisplayMember = "TenChiNhanh";
            cbChiNhanh.ValueMember = "IDChiNhanh";
            cbChiNhanh.DataSource = dt;
            con.Close();
        }

        private void btnClick_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                String query = "exec xemmenutheochinhanh @CMND, @chinhanhluachon, @ThanhPho, @Quan, @Phuong";
                SqlCommand com = new SqlCommand(query, con);
                com.CommandType = CommandType.Text;
                
                if (string.IsNullOrEmpty(txtChinhanh.Text))
                {
                    if (!(string.IsNullOrEmpty(txtTP.Text)) && !(string.IsNullOrEmpty(txtQuan.Text)) && !(string.IsNullOrEmpty(txtPhuong.Text)))
                    {
                        com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@chinhanhluachon", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtTP.Text;
                        com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = txtQuan.Text;
                        com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = txtPhuong.Text;
                    }
                    //dataGridViewChiNhanh.DataSource = model.xemmenutheochinhanh(null, null, txtTP.Text, txtQuan.Text, txtPhuong.Text);

                    else if (!(string.IsNullOrEmpty(txtTP.Text)) && !(string.IsNullOrEmpty(txtQuan.Text)))
                    {
                        com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@chinhanhluachon", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtTP.Text;
                        com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = txtQuan.Text;
                        com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    }
                    //dataGridViewChiNhanh.DataSource = model.xemmenutheochinhanh(null, null, txtTP.Text, txtQuan.Text, null);
                    else
                    {
                        com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@chinhanhluachon", SqlDbType.VarChar, 10).Value = DBNull.Value;
                        com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtTP.Text;
                        com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = DBNull.Value;
                        com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    }
                        //dataGridViewChiNhanh.DataSource = model.xemmenutheochinhanh(null, null, txtTP.Text, null, null);
                }
                else
                {
                    com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = DBNull.Value;
                    com.Parameters.Add("@chinhanhluachon", SqlDbType.VarChar, 10).Value = txtChinhanh.Text;
                    com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = DBNull.Value;
                }
                //dataGridViewChiNhanh.DataSource = model.xemmenutheochinhanh(null, txtChinhanh.Text, null, null, null);
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridViewChiNhanh.DataSource = dt;
                dataGridViewChiNhanh.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                con.Close();
                lblTongCN.Text = "";
                txtChinhanh.Text = "";
                txtTP.Text = "";
                txtQuan.Text = "";
                txtPhuong.Text = "";
            }
            catch (Exception)
            {
                MessageBox.Show("Nhap sai thong tin!!!");
            }
        }


        private void btn_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(cbKenh.Text.Trim()))
                {
                    con.Open();
                    String query = "exec taodonhang @CMNDNguoiDat, @IDnhanvien, @ChiNhanhDuocChon, @KenhDatHang, @MaDonHang OUTPUT";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    if (string.IsNullOrEmpty(txtTV.Text))
                        com.Parameters.Add("@CMNDNguoiDat", SqlDbType.VarChar, 10).Value = DBNull.Value;
                    else
                        com.Parameters.Add("@CMNDNguoiDat", SqlDbType.VarChar, 10).Value = txtTV.Text;
                    if (string.IsNullOrEmpty(txtNV.Text))
                        com.Parameters.Add("@IDnhanvien", SqlDbType.VarChar, 10).Value = DBNull.Value;
                    else
                        com.Parameters.Add("@IDnhanvien", SqlDbType.VarChar, 10).Value = txtNV.Text;
                    com.Parameters.Add("@ChiNhanhDuocChon", SqlDbType.VarChar, 10).Value = cbChiNhanh.SelectedValue.ToString();
                    com.Parameters.Add("@KenhDatHang", SqlDbType.VarChar, 20).Value = cbKenh.Text.Trim();
                    com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
                    com.ExecuteNonQuery();
                    String kq = (String)com.Parameters["@MaDonHang"].Value;
                    con.Close();
                    FormDatMon datmon = new FormDatMon(txtTV.Text, kq, cbChiNhanh.SelectedValue.ToString());
                    datmon.Show();
                }
                else
                    MessageBox.Show("Chua chon kenh dat hang!!!");
            }catch (Exception)
            {
                MessageBox.Show("Error!!!");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FormThongKe formTK = new FormThongKe();
            formTK.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            FormQuanLy formQL = new FormQuanLy(txtTV.Text);
            formQL.Show();
        }

        private void btnDangKi_Click(object sender, EventArgs e)
        {
            FormDangKy form = new FormDangKy();
            form.Show();
        }
    }
}

