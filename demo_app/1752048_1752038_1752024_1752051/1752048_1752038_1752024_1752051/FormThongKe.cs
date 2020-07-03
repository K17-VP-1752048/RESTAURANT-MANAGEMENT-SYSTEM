using _1752048_1752038_1752024_1752051;
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

namespace DangKy
{
    public partial class FormThongKe : Form
    {
        //HeThongNhaHangHuongVietEntities4 data = new HeThongNhaHangHuongVietEntities4();
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");

        public FormThongKe()
        {
            InitializeComponent();
            con.Open();

            String query1 = "select distinct LoaiMon from MonAn";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            cbLoaiMon.DisplayMember = "LoaiMon";
            cbLoaiMon.ValueMember = "LoaiMon";
            cbLoaiMon.DataSource = dt1;

            String query2 = "select IDmon from MonAn";
            SqlCommand com2 = new SqlCommand(query2, con);
            com2.CommandType = CommandType.Text;
            SqlDataAdapter da2 = new SqlDataAdapter(com2);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            cbTKMonAn.DisplayMember = "IDmon";
            cbTKMonAn.ValueMember = "IDmon";
            cbTKMonAn.DataSource = dt2;

            String query3 = "select IDchinhanh from ChiNhanh";
            SqlCommand com3 = new SqlCommand(query3, con);
            com3.CommandType = CommandType.Text;
            SqlDataAdapter da3 = new SqlDataAdapter(com3);
            DataTable dt3 = new DataTable();
            da3.Fill(dt3);
            comboBoxChiNhanh.DisplayMember = "IDchinhanh";
            comboBoxChiNhanh.ValueMember = "IDchinhanh";
            comboBoxChiNhanh.DataSource = dt3;

            con.Close();
        }

        private void BtnLoaiMon_Click(object sender, EventArgs e)
        {
            //dataGridView1.DataSource = data.thongkedoanhthutheoloaimon(cbLoaiMon.SelectedValue.ToString());
            try{
                con.Open();
                String query1 = "exec thongkedoanhthutheoloaimon @loaimon, @tong OUTPUT";
                SqlCommand com1 = new SqlCommand(query1, con);
                com1.CommandType = CommandType.Text;
                com1.Parameters.Add("@loaimon", SqlDbType.VarChar, 10).Value = cbLoaiMon.SelectedValue.ToString();
                com1.Parameters.Add("@tong", SqlDbType.Float).Direction = ParameterDirection.Output;
                SqlDataAdapter da1 = new SqlDataAdapter(com1);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                dataGridView1.DataSource = dt1;
                string  kq = com1.Parameters["@tong"].Value.ToString();
                
                lblTongDoanhThuLoaiMon.Text = "Tong doanh thu theo loai mon: " + kq;
                con.Close();
            } catch (Exception)
            {
                MessageBox.Show("Error");
            }
}

        private void Button1_Click(object sender, EventArgs e)
        {
            try{
                if (string.IsNullOrEmpty(comboBoxKH.Text))
                MessageBox.Show("Ban chua chon loai KH de thong ke");
                else //dataGridView2.DataSource = data.thongkedoanhthutheoloaiKH(comboBoxKH.SelectedItem.ToString());
                {
                    con.Open();
                    String query1 = "exec thongkedoanhthutheoloaiKH @loaiKH, @tong OUTPUT";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    com1.Parameters.Add("@loaiKH", SqlDbType.VarChar, 10).Value = comboBoxKH.SelectedItem.ToString();
                    com1.Parameters.Add("@tong", SqlDbType.Float).Direction = ParameterDirection.Output;
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView2.DataSource = dt1;
                    string kq = com1.Parameters["@tong"].Value.ToString();
                    
                    lblTongDoanhThuKH.Text = "Tong doanh thu theo loai khach hang: " + kq;
                    con.Close();
                }
            } catch (Exception)
            {
                MessageBox.Show("Error");
            }
}

        private void Button2_Click(object sender, EventArgs e)
        {
            //dataGridView3.DataSource = data.thongkedoanhthutheomonan(cbTKMonAn.SelectedValue.ToString());
            try {  
                con.Open();
                String query1 = "exec thongkedoanhthutheomonan @idmon, @tong OUTPUT";
                SqlCommand com1 = new SqlCommand(query1, con);
                com1.CommandType = CommandType.Text;
                com1.Parameters.Add("@idmon", SqlDbType.VarChar, 10).Value = cbTKMonAn.SelectedValue.ToString();
                com1.Parameters.Add("@tong", SqlDbType.Float).Direction = ParameterDirection.Output;
                SqlDataAdapter da1 = new SqlDataAdapter(com1);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                dataGridView3.DataSource = dt1;
                string kq = com1.Parameters["@tong"].Value.ToString();
                
                lblTongDoanhThuTheoMon.Text = "Tong doanh thu theo mon an: " + kq;

                con.Close();
            } catch (Exception)
            {
                MessageBox.Show("Error");
            }
}

        private void Button3_Click(object sender, EventArgs e)
        {
            //dataGridView4.DataSource = data.thongkedoanhthutheochinhanh(comboBoxChiNhanh.SelectedValue.ToString());
            try{
                con.Open();
                String query1 = "exec thongkedoanhthutheochinhanh @idchinhanh, @tong OUTPUT";
                SqlCommand com1 = new SqlCommand(query1, con);
                com1.CommandType = CommandType.Text;
                com1.Parameters.Add("@idchinhanh", SqlDbType.VarChar, 10).Value = comboBoxChiNhanh.SelectedValue.ToString();
                com1.Parameters.Add("@tong", SqlDbType.Float).Direction = ParameterDirection.Output;
                SqlDataAdapter da1 = new SqlDataAdapter(com1);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                dataGridView4.DataSource = dt1;
                string kq = com1.Parameters["@tong"].Value.ToString();
                
                lblTongDoanhThuTheoCN.Text = "Tong doanh thu theo chi nhanh: " + kq;

                con.Close();
            } catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

        private void Button5_Click(object sender, EventArgs e)
        {
            try {
                if (string.IsNullOrEmpty(comboBox3.Text))
                    MessageBox.Show("Ban chua chon loai KH de thong ke");
                else //dataGridView5.DataSource = data.thongketilehuyDHtheoloaiKH(comboBox3.SelectedItem.ToString());
                {
                    con.Open();
                    String query1 = "exec thongketilehuyDHtheoloaiKH @loaiKH, @tong OUTPUT";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    com1.Parameters.Add("@loaiKH", SqlDbType.VarChar, 10).Value = comboBox3.SelectedItem.ToString();
                    com1.Parameters.Add("@tong", SqlDbType.Float).Direction = ParameterDirection.Output;
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView5.DataSource = dt1;
                    string kq = com1.Parameters["@tong"].Value.ToString();
                    
                    lblTiLeHuyDH.Text = "Ti le huy don hang: " + kq;

                    con.Close();
                }
            } catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

       
    }
}
