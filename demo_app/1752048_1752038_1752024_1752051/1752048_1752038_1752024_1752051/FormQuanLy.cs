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
    public partial class FormQuanLy : Form
    {
        //HeThongNhaHangHuongVietEntities4 data = new HeThongNhaHangHuongVietEntities4();
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");
        string cmnd;

        public FormQuanLy(string cmnd)
        {
            this.cmnd = cmnd;
            InitializeComponent();
            String query1 = "select * from MonAn";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView2.DataSource = dt1;
            LoadChiNhanh();
            LoadMonAn();
            LoadDonHang();
        }
        public void LoadMonAn()
        {
            con.Open();
            String query1 = "select * from MonAn";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            cbMonAn.DisplayMember = "TenMon";
            cbMonAn.ValueMember = "IDmon";
            cbMonAn.DataSource = dt1;
            comboBox2.DisplayMember = "TenMon";
            comboBox2.ValueMember = "IDmon";
            comboBox2.DataSource = dt1;

            String query2 = "select * from MonAn";
            SqlCommand com2 = new SqlCommand(query2, con);
            com2.CommandType = CommandType.Text;
            SqlDataAdapter da2 = new SqlDataAdapter(com2);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            dataGridView1.DataSource = dt2;



            con.Close();
        }
        public void LoadChiNhanh()
        {
            con.Open();

            String query = "select * from ChiNhanh";
            SqlCommand com = new SqlCommand(query, con);
            com.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            cbChiNhanh.DisplayMember = "TenChiNhanh";
            cbChiNhanh.ValueMember = "IDChiNhanh";
            cbChiNhanh.DataSource = dt;
            comboBox1.DisplayMember = "TenChiNhanh";
            comboBox1.ValueMember = "IDChiNhanh";
            comboBox1.DataSource = dt;

            String query1 = "select * from ChiNhanh";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView4.DataSource = dt1;
            dataGridView5.DataSource = dt1;
            con.Close();
        }
        private void LoadDonHang()
        {
            con.Open();
            String query1 = "select * from DonHang";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView3.DataSource = dt1;

            con.Close();
        }
        private void btnCapnhatMon_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtTenMon.Text) && string.IsNullOrEmpty(txtDonGia.Text))
                    MessageBox.Show("Ban chua nhap thong tin can cap nhat");
                else {
                    if(!string.IsNullOrEmpty(txtDonGia.Text) && float.Parse(txtDonGia.Text) <= 0)
                    {
                        con.Open();
                        String query = "exec CapNhatMonAn @IDmon, @TenMon, @dongia";
                        SqlCommand com = new SqlCommand(query, con);
                        com.CommandType = CommandType.Text;
                        com.Parameters.Add("@IDmon", SqlDbType.VarChar, 10).Value = cbMonAn.SelectedValue.ToString();
                        if(string.IsNullOrEmpty(txtTenMon.Text))
                            com.Parameters.Add("@TenMon", SqlDbType.VarChar, 20).Value = DBNull.Value;
                        else com.Parameters.Add("@TenMon", SqlDbType.VarChar, 20).Value = txtTenMon.Text;
                        if(string.IsNullOrEmpty(txtDonGia.Text))
                            com.Parameters.Add("@dongia", SqlDbType.Float).Value = DBNull.Value;
                        else com.Parameters.Add("@dongia", SqlDbType.Float).Value = float.Parse(txtDonGia.Text);
                        com.ExecuteNonQuery();

                        

                        con.Close();
                        MessageBox.Show("Don gia <= 0");
                    }
                    else
                    {
                            con.Open();
                            String query = "exec CapNhatMonAn @IDmon, @TenMon, @dongia";
                            SqlCommand com = new SqlCommand(query, con);
                            com.CommandType = CommandType.Text;
                            com.Parameters.Add("@IDmon", SqlDbType.VarChar, 10).Value = cbMonAn.SelectedValue.ToString();
                            if (string.IsNullOrEmpty(txtTenMon.Text))
                                com.Parameters.Add("@TenMon", SqlDbType.VarChar, 20).Value = DBNull.Value;
                            else com.Parameters.Add("@TenMon", SqlDbType.VarChar, 20).Value = txtTenMon.Text;
                            if (string.IsNullOrEmpty(txtDonGia.Text))
                                com.Parameters.Add("@dongia", SqlDbType.Float).Value = DBNull.Value;
                            else com.Parameters.Add("@dongia", SqlDbType.Float).Value = float.Parse(txtDonGia.Text);
                            com.ExecuteNonQuery();

                           

                            con.Close();
                        }
                }
                LoadMonAn();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtTenMonInsert.Text) || string.IsNullOrEmpty(txtGiaInsert.Text) || string.IsNullOrEmpty(txtLoai.Text))
                    MessageBox.Show("Ban chua nhap day du thong tin");
                else
                {
                    con.Open();
                    
                    String query = "exec ThemMonAn @TenMon, @dongia, @Loaimon";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@TenMon", SqlDbType.VarChar, 20).Value = txtTenMonInsert.Text;
                    com.Parameters.Add("@dongia", SqlDbType.Float).Value = float.Parse(txtGiaInsert.Text);
                    com.Parameters.Add("@Loaimon", SqlDbType.VarChar, 20).Value = txtLoai.Text;

                    com.ExecuteNonQuery();

                    /*String query1 = "select * from MonAn";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView2.DataSource = dt1;*/

                    con.Close();
                }
                LoadMonAn();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }
        
        private void btnCapNhatTT_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtIDDH.Text) || string.IsNullOrEmpty(cbTT.SelectedItem.ToString()))
                    MessageBox.Show("Ban chua nhap day du thong tin");
                else
                {
                    con.Open();
                    
                    String query = "exec CapNhatTrangThaiDonHang @idDH, @trangthai";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@idDH", SqlDbType.VarChar, 10).Value = txtIDDH.Text;
                    com.Parameters.Add("@trangthai", SqlDbType.VarChar, 20).Value = cbTT.SelectedItem.ToString();

                    com.ExecuteNonQuery();
                    if (cbTT.SelectedItem.ToString().Equals("Hoan tat") && !string.IsNullOrEmpty(this.cmnd))
                    {
                        String query1 = "exec GhiNhanDiemTichLuy @CMND, @MaDonHang";
                        SqlCommand com1 = new SqlCommand(query1, con);
                        com1.CommandType = CommandType.Text;
                        com1.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = this.cmnd;
                        com1.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = txtIDDH.Text;
                        com1.ExecuteNonQuery();
                        MessageBox.Show("Don hang da hoan tat. Ghi nhan diem tich luy cho khach hang");
                    }
                    con.Close();

                }
                LoadDonHang();
            }
            catch (Exception)
            {
               MessageBox.Show("Error");
            }
        }

        private void btnInsertCN_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtTenCN.Text) || string.IsNullOrEmpty(txtSDTCN.Text) ||
                    string.IsNullOrEmpty(txtTPCN.Text) || string.IsNullOrEmpty(txtQuanCN.Text) ||
                    string.IsNullOrEmpty(txtPhuongCN.Text) || string.IsNullOrEmpty(txtDuongCN.Text))
                    MessageBox.Show("Ban chua nhap day du thong tin");
                else
                {
                    con.Open();
                   
                    String query = "exec themchinhanh @TenChiNhanh, @SDT, @ThanhPho, @Quan, @Phuong, @Duong";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@TenChiNhanh", SqlDbType.VarChar, 20).Value = txtTenCN.Text;
                    com.Parameters.Add("@SDT", SqlDbType.VarChar, 20).Value = txtSDTCN.Text;
                    com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtTPCN.Text;
                    com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = txtQuanCN.Text;
                    com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = txtPhuongCN.Text;
                    com.Parameters.Add("@Duong", SqlDbType.VarChar, 20).Value = txtDuongCN.Text;

                    com.ExecuteNonQuery();

                    /*String query1 = "select * from ChiNhanh";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView4.DataSource = dt1;*/
                    con.Close();
                }
                LoadChiNhanh();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

        private void btnUpdateCN_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtUpTenCN.Text) && string.IsNullOrEmpty(txtUpSDT.Text) &&
                    string.IsNullOrEmpty(txtUpTP.Text) && string.IsNullOrEmpty(txtUpQuan.Text) &&
                    string.IsNullOrEmpty(txtUpPhuong.Text) && string.IsNullOrEmpty(txtUpDuong.Text))
                    MessageBox.Show("Ban chua nhap thong tin can cap nhat");
                else
                {
                    con.Open();

                    String query = "exec capnhatchinhanh @IDchinhanh, @TenChiNhanh, @SDT, @ThanhPho, @Quan, @Phuong, @Duong";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@IDchinhanh", SqlDbType.VarChar, 20).Value = cbChiNhanh.SelectedValue.ToString();
                    if(string.IsNullOrEmpty(txtUpTenCN.Text))
                        com.Parameters.Add("@TenChiNhanh", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@TenChiNhanh", SqlDbType.VarChar, 20).Value = txtUpTenCN.Text;

                    if (string.IsNullOrEmpty(txtUpSDT.Text))
                        com.Parameters.Add("@SDT", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@SDT", SqlDbType.VarChar, 20).Value = txtUpSDT.Text;

                    if (string.IsNullOrEmpty(txtUpTP.Text))
                        com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = txtUpTP.Text;

                    if (string.IsNullOrEmpty(txtUpQuan.Text))
                        com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = txtUpQuan.Text;

                    if (string.IsNullOrEmpty(txtUpPhuong.Text))
                        com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = txtUpPhuong.Text;

                    if (string.IsNullOrEmpty(txtUpDuong.Text))
                        com.Parameters.Add("@Duong", SqlDbType.VarChar, 20).Value = DBNull.Value;
                    else com.Parameters.Add("@Duong", SqlDbType.VarChar, 20).Value = txtUpDuong.Text;

                    com.ExecuteNonQuery();

                    /*String query1 = "select * from ChiNhanh";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView5.DataSource = dt1;*/

                    con.Close();
                }
                LoadChiNhanh();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

        private void btnUpSoLuong_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                if (numericUpDown1.Value != 0)
                {
                    String query = "exec SLMonAnTrongNgayDuocCungCap @IDchinhanh, @IDmon, @soluongphan";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@IDchinhanh", SqlDbType.VarChar, 10).Value = comboBox1.SelectedValue.ToString();
                    com.Parameters.Add("@IDmon", SqlDbType.VarChar, 10).Value = comboBox2.SelectedValue.ToString();
                    com.Parameters.Add("@soluongphan", SqlDbType.Int).Value = numericUpDown1.Value;
                    com.ExecuteNonQuery();

                    String query1 = "select * from SLMonAnTrongNgay where IDchinhanh = @idchinhanh";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    com1.Parameters.Add("@idchinhanh", SqlDbType.VarChar, 10).Value = comboBox1.SelectedValue.ToString();
                    SqlDataAdapter da1 = new SqlDataAdapter(com1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView6.DataSource = dt1;

                }
                else MessageBox.Show("Nhap sai so luong");
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }

        

        private void button1_Click(object sender, EventArgs e)
        {
            con.Open();
            String query1 = "exec XemThanhVien @count OUTPUT";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            com1.Parameters.Add("@count", SqlDbType.Float).Direction = ParameterDirection.Output;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            dataGridView7.DataSource = dt1;
            //com1.ExecuteNonQuery();
            string kq = com1.Parameters["@count"].Value.ToString();
            
           
            lblSLThanhVien.Text = "Tong so luong thanh vien: " + kq;
            con.Close();
        }
    }
}
