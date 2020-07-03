using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace _1752048_1752038_1752024_1752051
{

    public partial class FormDangKy : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8O8PRFM;Initial Catalog=HeThongNhaHangHuongViet;Integrated Security=True");
        public FormDangKy()
        {
            InitializeComponent();
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
            con.Close();
        }


        private void btnSignup_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                if (string.IsNullOrEmpty(txtCMND.Text) || string.IsNullOrEmpty(txtDiaChi.Text) ||
                    string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtDiaChi.Text) || string.IsNullOrEmpty(txtPwd.Text))
                    MessageBox.Show("Ban chua nhap du thong tin");
                else
                {
                    String query1 = "exec dangky @CMND, @NgaySinh, @DiaChi, @SDT, @ChiNhanhDangKy, @Email, @pwd";
                    SqlCommand com1 = new SqlCommand(query1, con);
                    com1.CommandType = CommandType.Text;
                    com1.Parameters.Add("@CMND", SqlDbType.VarChar, 10).Value = txtCMND.Text;
                    com1.Parameters.Add("@NgaySinh", SqlDbType.Date).Value = date.Value;
                    com1.Parameters.Add("@DiaChi", SqlDbType.VarChar, 20).Value = txtDiaChi.Text;
                    com1.Parameters.Add("@SDT", SqlDbType.VarChar, 20).Value = txtSDT.Text;
                    com1.Parameters.Add("@ChiNhanhDangKy", SqlDbType.VarChar, 10).Value = cbChiNhanh.SelectedValue.ToString();
                    com1.Parameters.Add("@Email", SqlDbType.VarChar, 20).Value = txtEmail.Text;
                    com1.Parameters.Add("@pwd", SqlDbType.VarChar, 20).Value = txtPwd.Text;
                    com1.ExecuteNonQuery();
                    MessageBox.Show("Dang Ky Thanh Cong");
                    this.Close();
                }

                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error");
            }
        }
    }
}
