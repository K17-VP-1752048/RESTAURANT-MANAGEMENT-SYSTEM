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

namespace DatMon
{
    public partial class FormDatMon : Form
    {
        //HeThongNhaHangHuongVietEntities4 data = new HeThongNhaHangHuongVietEntities4();
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");
        string madonhang;
        string cmndnguoidat;
        string chinhanh;
        public object Database { get; private set; }

        public FormDatMon(String cmnd, String kq, String chinhanh)
        {
            InitializeComponent();
            this.madonhang = kq;
            this.cmndnguoidat = cmnd;
            this.chinhanh = chinhanh;
            //dataGridView1.DataSource = data.xemmenutheochinhanh(null, chinhanh, null, null, null);
            con.Open();
            String query = "exec xemmenutheochinhanh @CMND, @chinhanhluachon, @ThanhPho, @Quan, @Phuong";
            SqlCommand com = new SqlCommand(query, con);
            com.CommandType = CommandType.Text;
            com.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = DBNull.Value;
            com.Parameters.Add("@chinhanhluachon", SqlDbType.VarChar, 10).Value = chinhanh;
            com.Parameters.Add("@ThanhPho", SqlDbType.VarChar, 20).Value = DBNull.Value;
            com.Parameters.Add("@Quan", SqlDbType.VarChar, 20).Value = DBNull.Value;
            com.Parameters.Add("@Phuong", SqlDbType.VarChar, 20).Value = DBNull.Value;
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            String query1 = "select * from MonAn";
            SqlCommand com1 = new SqlCommand(query1, con);
            com1.CommandType = CommandType.Text;
            SqlDataAdapter da1 = new SqlDataAdapter(com1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            cbMon.DisplayMember = "TenMon";
            cbMon.ValueMember = "IDmon";
            cbMon.DataSource = dt1;
            con.Close();
        }



        private void BtnOrder_Click(object sender, EventArgs e)
        {
            //try
            //{
                if (numeric.Value != 0)
                {
                    con.Open();

                    String query = "exec DatMon @MaDonHang, @IDmon, @soluongdat";
                    SqlCommand com = new SqlCommand(query, con);
                    com.CommandType = CommandType.Text;
                    com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
                    com.Parameters.Add("@IDmon", SqlDbType.VarChar, 10).Value = cbMon.SelectedValue.ToString();
                    com.Parameters.Add("@soluongdat", SqlDbType.Int).Value = numeric.Value;
                    com.ExecuteNonQuery();
                    String query1 = "select * from ChiTietDonHang where MaDonHang = @madonhang";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    com1.Parameters.Add("@madonhang", SqlDbType.VarChar, 10).Value = this.madonhang;
                    SqlDataAdapter da = new SqlDataAdapter(com1);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView2.DataSource = dt;

                    String query2 = "select * from SLMonAnTrongNgay where IDchinhanh = @chinhanh";
                    SqlCommand com2 = new SqlCommand(query2, con);
                    com2.CommandType = CommandType.Text;
                    com2.Parameters.Add("@chinhanh", SqlDbType.VarChar, 10).Value = this.chinhanh;
                    SqlDataAdapter da1 = new SqlDataAdapter(com2);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    dataGridView1.DataSource = dt1;

                    con.Close();
                    numeric.Value = 0;


                }
                else MessageBox.Show("Ban chua nhap so luong");
            //}
            //catch (Exception)
            //{
              //  MessageBox.Show("Nhap sai thong tin");
            //}
        }

        private void BtnDel_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow row in dataGridView2.SelectedRows)
            {
                string idmon = dataGridView2.CurrentRow.Cells[1].Value.ToString();
                con.Open();
                String query = "exec XoaMonVuaDat @MaDonHang, @IDmon";
                SqlCommand com = new SqlCommand(query, con);
                com.CommandType = CommandType.Text;
                com.Parameters.Add("@MaDonHang", SqlDbType.VarChar, 10).Value = this.madonhang;
                com.Parameters.Add("@IDmon", SqlDbType.VarChar, 10).Value = idmon;
                com.ExecuteNonQuery();
                String query2 = "select * from SLMonAnTrongNgay where IDchinhanh = @chinhanh";
                SqlCommand com2 = new SqlCommand(query2, con);
                com2.CommandType = CommandType.Text;
                com2.Parameters.Add("@chinhanh", SqlDbType.VarChar, 10).Value = this.chinhanh;
                SqlDataAdapter da1 = new SqlDataAdapter(com2);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                dataGridView1.DataSource = dt1;

                con.Close();
                dataGridView2.Rows.RemoveAt(row.Index);
            }
        }

        private void btnDone_Click(object sender, EventArgs e)
        {
            if (dataGridView2.DataSource != null)
            {
                FormTTGH form = new FormTTGH(this.cmndnguoidat, this.madonhang);
                form.Show();
                this.Close();
            }
            else MessageBox.Show("Ban chua dat mon");
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
    }
}
