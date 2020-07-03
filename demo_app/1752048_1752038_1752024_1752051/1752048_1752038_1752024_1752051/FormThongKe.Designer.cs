namespace DangKy
{
    partial class FormThongKe
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.tab = new System.Windows.Forms.TabControl();
            this.tabLoaiMon = new System.Windows.Forms.TabPage();
            this.btnLoaiMon = new System.Windows.Forms.Button();
            this.cbLoaiMon = new System.Windows.Forms.ComboBox();
            this.tabLoaiKH = new System.Windows.Forms.TabPage();
            this.comboBoxKH = new System.Windows.Forms.ComboBox();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.tabMonAn = new System.Windows.Forms.TabPage();
            this.cbTKMonAn = new System.Windows.Forms.ComboBox();
            this.dataGridView3 = new System.Windows.Forms.DataGridView();
            this.button2 = new System.Windows.Forms.Button();
            this.tabChiNhanh = new System.Windows.Forms.TabPage();
            this.dataGridView4 = new System.Windows.Forms.DataGridView();
            this.button3 = new System.Windows.Forms.Button();
            this.comboBoxChiNhanh = new System.Windows.Forms.ComboBox();
            this.tabHuyDon = new System.Windows.Forms.TabPage();
            this.comboBox3 = new System.Windows.Forms.ComboBox();
            this.button5 = new System.Windows.Forms.Button();
            this.dataGridView5 = new System.Windows.Forms.DataGridView();
            this.lblTongDoanhThuLoaiMon = new System.Windows.Forms.Label();
            this.lblTongDoanhThuKH = new System.Windows.Forms.Label();
            this.lblTongDoanhThuTheoMon = new System.Windows.Forms.Label();
            this.lblTongDoanhThuTheoCN = new System.Windows.Forms.Label();
            this.lblTiLeHuyDH = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.tab.SuspendLayout();
            this.tabLoaiMon.SuspendLayout();
            this.tabLoaiKH.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.tabMonAn.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).BeginInit();
            this.tabChiNhanh.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView4)).BeginInit();
            this.tabHuyDon.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView5)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(658, 62);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(144, 38);
            this.button1.TabIndex = 0;
            this.button1.Text = "Thống kê";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(70, 116);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 62;
            this.dataGridView1.Size = new System.Drawing.Size(960, 452);
            this.dataGridView1.TabIndex = 3;
            // 
            // tab
            // 
            this.tab.Controls.Add(this.tabLoaiMon);
            this.tab.Controls.Add(this.tabLoaiKH);
            this.tab.Controls.Add(this.tabMonAn);
            this.tab.Controls.Add(this.tabChiNhanh);
            this.tab.Controls.Add(this.tabHuyDon);
            this.tab.Location = new System.Drawing.Point(0, 3);
            this.tab.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tab.Name = "tab";
            this.tab.SelectedIndex = 0;
            this.tab.Size = new System.Drawing.Size(1202, 692);
            this.tab.TabIndex = 4;
            // 
            // tabLoaiMon
            // 
            this.tabLoaiMon.Controls.Add(this.lblTongDoanhThuLoaiMon);
            this.tabLoaiMon.Controls.Add(this.btnLoaiMon);
            this.tabLoaiMon.Controls.Add(this.cbLoaiMon);
            this.tabLoaiMon.Controls.Add(this.dataGridView1);
            this.tabLoaiMon.Location = new System.Drawing.Point(4, 29);
            this.tabLoaiMon.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabLoaiMon.Name = "tabLoaiMon";
            this.tabLoaiMon.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabLoaiMon.Size = new System.Drawing.Size(1194, 659);
            this.tabLoaiMon.TabIndex = 0;
            this.tabLoaiMon.Text = "Theo loại món";
            this.tabLoaiMon.UseVisualStyleBackColor = true;
            // 
            // btnLoaiMon
            // 
            this.btnLoaiMon.Location = new System.Drawing.Point(696, 43);
            this.btnLoaiMon.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnLoaiMon.Name = "btnLoaiMon";
            this.btnLoaiMon.Size = new System.Drawing.Size(122, 35);
            this.btnLoaiMon.TabIndex = 5;
            this.btnLoaiMon.Text = "Thống kê";
            this.btnLoaiMon.UseVisualStyleBackColor = true;
            this.btnLoaiMon.Click += new System.EventHandler(this.BtnLoaiMon_Click);
            // 
            // cbLoaiMon
            // 
            this.cbLoaiMon.FormattingEnabled = true;
            this.cbLoaiMon.Items.AddRange(new object[] {
            "Món nước",
            "Gỏi",
            "Cơm",
            "Món chay"});
            this.cbLoaiMon.Location = new System.Drawing.Point(406, 46);
            this.cbLoaiMon.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.cbLoaiMon.Name = "cbLoaiMon";
            this.cbLoaiMon.Size = new System.Drawing.Size(262, 28);
            this.cbLoaiMon.TabIndex = 4;
            // 
            // tabLoaiKH
            // 
            this.tabLoaiKH.Controls.Add(this.lblTongDoanhThuKH);
            this.tabLoaiKH.Controls.Add(this.comboBoxKH);
            this.tabLoaiKH.Controls.Add(this.dataGridView2);
            this.tabLoaiKH.Controls.Add(this.button1);
            this.tabLoaiKH.Location = new System.Drawing.Point(4, 29);
            this.tabLoaiKH.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabLoaiKH.Name = "tabLoaiKH";
            this.tabLoaiKH.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabLoaiKH.Size = new System.Drawing.Size(1194, 659);
            this.tabLoaiKH.TabIndex = 1;
            this.tabLoaiKH.Text = "Theo khách hàng";
            this.tabLoaiKH.UseVisualStyleBackColor = true;
            // 
            // comboBoxKH
            // 
            this.comboBoxKH.FormattingEnabled = true;
            this.comboBoxKH.Items.AddRange(new object[] {
            "Vang lai",
            "Thanh vien"});
            this.comboBoxKH.Location = new System.Drawing.Point(387, 66);
            this.comboBoxKH.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.comboBoxKH.Name = "comboBoxKH";
            this.comboBoxKH.Size = new System.Drawing.Size(248, 28);
            this.comboBoxKH.TabIndex = 5;
            // 
            // dataGridView2
            // 
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Location = new System.Drawing.Point(87, 142);
            this.dataGridView2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.RowHeadersWidth = 62;
            this.dataGridView2.Size = new System.Drawing.Size(978, 417);
            this.dataGridView2.TabIndex = 4;
            // 
            // tabMonAn
            // 
            this.tabMonAn.Controls.Add(this.lblTongDoanhThuTheoMon);
            this.tabMonAn.Controls.Add(this.cbTKMonAn);
            this.tabMonAn.Controls.Add(this.dataGridView3);
            this.tabMonAn.Controls.Add(this.button2);
            this.tabMonAn.Location = new System.Drawing.Point(4, 29);
            this.tabMonAn.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabMonAn.Name = "tabMonAn";
            this.tabMonAn.Size = new System.Drawing.Size(1194, 659);
            this.tabMonAn.TabIndex = 2;
            this.tabMonAn.Text = "Theo món ăn";
            this.tabMonAn.UseVisualStyleBackColor = true;
            // 
            // cbTKMonAn
            // 
            this.cbTKMonAn.FormattingEnabled = true;
            this.cbTKMonAn.Location = new System.Drawing.Point(337, 62);
            this.cbTKMonAn.Name = "cbTKMonAn";
            this.cbTKMonAn.Size = new System.Drawing.Size(273, 28);
            this.cbTKMonAn.TabIndex = 11;
            // 
            // dataGridView3
            // 
            this.dataGridView3.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView3.Location = new System.Drawing.Point(75, 122);
            this.dataGridView3.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView3.Name = "dataGridView3";
            this.dataGridView3.RowHeadersWidth = 62;
            this.dataGridView3.Size = new System.Drawing.Size(980, 446);
            this.dataGridView3.TabIndex = 10;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(662, 58);
            this.button2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(130, 35);
            this.button2.TabIndex = 7;
            this.button2.Text = "Thống kê";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.Button2_Click);
            // 
            // tabChiNhanh
            // 
            this.tabChiNhanh.Controls.Add(this.lblTongDoanhThuTheoCN);
            this.tabChiNhanh.Controls.Add(this.dataGridView4);
            this.tabChiNhanh.Controls.Add(this.button3);
            this.tabChiNhanh.Controls.Add(this.comboBoxChiNhanh);
            this.tabChiNhanh.Location = new System.Drawing.Point(4, 29);
            this.tabChiNhanh.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabChiNhanh.Name = "tabChiNhanh";
            this.tabChiNhanh.Size = new System.Drawing.Size(1194, 659);
            this.tabChiNhanh.TabIndex = 3;
            this.tabChiNhanh.Text = "Theo chi nhánh";
            this.tabChiNhanh.UseVisualStyleBackColor = true;
            // 
            // dataGridView4
            // 
            this.dataGridView4.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView4.Location = new System.Drawing.Point(66, 125);
            this.dataGridView4.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView4.Name = "dataGridView4";
            this.dataGridView4.RowHeadersWidth = 62;
            this.dataGridView4.Size = new System.Drawing.Size(975, 443);
            this.dataGridView4.TabIndex = 11;
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(663, 55);
            this.button3.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(122, 35);
            this.button3.TabIndex = 7;
            this.button3.Text = "Thống kê";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.Button3_Click);
            // 
            // comboBoxChiNhanh
            // 
            this.comboBoxChiNhanh.FormattingEnabled = true;
            this.comboBoxChiNhanh.Items.AddRange(new object[] {
            "CN1",
            "CN2",
            "CN3",
            "CN4"});
            this.comboBoxChiNhanh.Location = new System.Drawing.Point(374, 58);
            this.comboBoxChiNhanh.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.comboBoxChiNhanh.Name = "comboBoxChiNhanh";
            this.comboBoxChiNhanh.Size = new System.Drawing.Size(262, 28);
            this.comboBoxChiNhanh.TabIndex = 6;
            // 
            // tabHuyDon
            // 
            this.tabHuyDon.Controls.Add(this.lblTiLeHuyDH);
            this.tabHuyDon.Controls.Add(this.comboBox3);
            this.tabHuyDon.Controls.Add(this.button5);
            this.tabHuyDon.Controls.Add(this.dataGridView5);
            this.tabHuyDon.Location = new System.Drawing.Point(4, 29);
            this.tabHuyDon.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tabHuyDon.Name = "tabHuyDon";
            this.tabHuyDon.Size = new System.Drawing.Size(1194, 659);
            this.tabHuyDon.TabIndex = 4;
            this.tabHuyDon.Text = "Tỉ lệ hủy đơn";
            this.tabHuyDon.UseVisualStyleBackColor = true;
            // 
            // comboBox3
            // 
            this.comboBox3.FormattingEnabled = true;
            this.comboBox3.Items.AddRange(new object[] {
            "Vang lai",
            "Thanh vien"});
            this.comboBox3.Location = new System.Drawing.Point(370, 69);
            this.comboBox3.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.comboBox3.Name = "comboBox3";
            this.comboBox3.Size = new System.Drawing.Size(248, 28);
            this.comboBox3.TabIndex = 12;
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(642, 65);
            this.button5.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(144, 38);
            this.button5.TabIndex = 11;
            this.button5.Text = "Thống kê";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.Button5_Click);
            // 
            // dataGridView5
            // 
            this.dataGridView5.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView5.Location = new System.Drawing.Point(105, 171);
            this.dataGridView5.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView5.Name = "dataGridView5";
            this.dataGridView5.RowHeadersWidth = 62;
            this.dataGridView5.Size = new System.Drawing.Size(978, 417);
            this.dataGridView5.TabIndex = 8;
            // 
            // lblTongDoanhThuLoaiMon
            // 
            this.lblTongDoanhThuLoaiMon.AutoSize = true;
            this.lblTongDoanhThuLoaiMon.Location = new System.Drawing.Point(66, 587);
            this.lblTongDoanhThuLoaiMon.Name = "lblTongDoanhThuLoaiMon";
            this.lblTongDoanhThuLoaiMon.Size = new System.Drawing.Size(184, 20);
            this.lblTongDoanhThuLoaiMon.TabIndex = 6;
            this.lblTongDoanhThuLoaiMon.Text = "Tong doanh thu loai mon";
            // 
            // lblTongDoanhThuKH
            // 
            this.lblTongDoanhThuKH.AutoSize = true;
            this.lblTongDoanhThuKH.Location = new System.Drawing.Point(83, 578);
            this.lblTongDoanhThuKH.Name = "lblTongDoanhThuKH";
            this.lblTongDoanhThuKH.Size = new System.Drawing.Size(175, 20);
            this.lblTongDoanhThuKH.TabIndex = 7;
            this.lblTongDoanhThuKH.Text = "Tong doanh thu loai KH";
            // 
            // lblTongDoanhThuTheoMon
            // 
            this.lblTongDoanhThuTheoMon.AutoSize = true;
            this.lblTongDoanhThuTheoMon.Location = new System.Drawing.Point(71, 589);
            this.lblTongDoanhThuTheoMon.Name = "lblTongDoanhThuTheoMon";
            this.lblTongDoanhThuTheoMon.Size = new System.Drawing.Size(121, 20);
            this.lblTongDoanhThuTheoMon.TabIndex = 12;
            this.lblTongDoanhThuTheoMon.Text = "Tong doanh thu";
            // 
            // lblTongDoanhThuTheoCN
            // 
            this.lblTongDoanhThuTheoCN.AutoSize = true;
            this.lblTongDoanhThuTheoCN.Location = new System.Drawing.Point(62, 604);
            this.lblTongDoanhThuTheoCN.Name = "lblTongDoanhThuTheoCN";
            this.lblTongDoanhThuTheoCN.Size = new System.Drawing.Size(230, 20);
            this.lblTongDoanhThuTheoCN.TabIndex = 13;
            this.lblTongDoanhThuTheoCN.Text = "Tong doanh thu theo chi nhanh";
            // 
            // lblTiLeHuyDH
            // 
            this.lblTiLeHuyDH.AutoSize = true;
            this.lblTiLeHuyDH.Location = new System.Drawing.Point(101, 606);
            this.lblTiLeHuyDH.Name = "lblTiLeHuyDH";
            this.lblTiLeHuyDH.Size = new System.Drawing.Size(145, 20);
            this.lblTiLeHuyDH.TabIndex = 14;
            this.lblTiLeHuyDH.Text = "Ti le huy don hang: ";
            // 
            // FormThongKe
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1200, 692);
            this.Controls.Add(this.tab);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "FormThongKe";
            this.Text = "FormThongKe";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.tab.ResumeLayout(false);
            this.tabLoaiMon.ResumeLayout(false);
            this.tabLoaiMon.PerformLayout();
            this.tabLoaiKH.ResumeLayout(false);
            this.tabLoaiKH.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.tabMonAn.ResumeLayout(false);
            this.tabMonAn.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).EndInit();
            this.tabChiNhanh.ResumeLayout(false);
            this.tabChiNhanh.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView4)).EndInit();
            this.tabHuyDon.ResumeLayout(false);
            this.tabHuyDon.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView5)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.TabControl tab;
        private System.Windows.Forms.TabPage tabLoaiMon;
        private System.Windows.Forms.TabPage tabLoaiKH;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.Button btnLoaiMon;
        private System.Windows.Forms.ComboBox cbLoaiMon;
        private System.Windows.Forms.TabPage tabMonAn;
        private System.Windows.Forms.DataGridView dataGridView3;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.TabPage tabChiNhanh;
        private System.Windows.Forms.TabPage tabHuyDon;
        private System.Windows.Forms.DataGridView dataGridView4;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.ComboBox comboBoxChiNhanh;
        private System.Windows.Forms.ComboBox comboBoxKH;
        private System.Windows.Forms.ComboBox comboBox3;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.DataGridView dataGridView5;
        private System.Windows.Forms.ComboBox cbTKMonAn;
        private System.Windows.Forms.Label lblTongDoanhThuLoaiMon;
        private System.Windows.Forms.Label lblTongDoanhThuKH;
        private System.Windows.Forms.Label lblTongDoanhThuTheoMon;
        private System.Windows.Forms.Label lblTongDoanhThuTheoCN;
        private System.Windows.Forms.Label lblTiLeHuyDH;
    }
}