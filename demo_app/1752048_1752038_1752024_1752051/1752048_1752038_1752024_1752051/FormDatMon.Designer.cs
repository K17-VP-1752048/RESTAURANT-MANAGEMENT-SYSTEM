namespace DatMon
{
    partial class FormDatMon
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
            this.numeric = new System.Windows.Forms.NumericUpDown();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.btnDel = new System.Windows.Forms.Button();
            this.btnDone = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.cbMon = new System.Windows.Forms.ComboBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label9 = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.btnOrder = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.numeric)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.SuspendLayout();
            // 
            // numeric
            // 
            this.numeric.Location = new System.Drawing.Point(972, 59);
            this.numeric.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.numeric.Name = "numeric";
            this.numeric.Size = new System.Drawing.Size(105, 26);
            this.numeric.TabIndex = 11;
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(51, 60);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 62;
            this.dataGridView1.Size = new System.Drawing.Size(567, 360);
            this.dataGridView1.TabIndex = 13;
            // 
            // btnDel
            // 
            this.btnDel.BackColor = System.Drawing.Color.Black;
            this.btnDel.ForeColor = System.Drawing.Color.White;
            this.btnDel.Location = new System.Drawing.Point(846, 385);
            this.btnDel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnDel.Name = "btnDel";
            this.btnDel.Size = new System.Drawing.Size(112, 35);
            this.btnDel.TabIndex = 18;
            this.btnDel.Text = "Xóa";
            this.btnDel.UseVisualStyleBackColor = false;
            this.btnDel.Click += new System.EventHandler(this.BtnDel_Click);
            // 
            // btnDone
            // 
            this.btnDone.BackColor = System.Drawing.Color.Blue;
            this.btnDone.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDone.ForeColor = System.Drawing.Color.White;
            this.btnDone.Location = new System.Drawing.Point(503, 453);
            this.btnDone.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnDone.Name = "btnDone";
            this.btnDone.Size = new System.Drawing.Size(225, 55);
            this.btnDone.TabIndex = 19;
            this.btnDone.Text = "Dat Giao Hang";
            this.btnDone.UseVisualStyleBackColor = false;
            this.btnDone.Click += new System.EventHandler(this.btnDone_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft YaHei", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Red;
            this.label1.Location = new System.Drawing.Point(840, 103);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(128, 31);
            this.label1.TabIndex = 20;
            this.label1.Text = "Gio Hang";
            // 
            // cbMon
            // 
            this.cbMon.FormattingEnabled = true;
            this.cbMon.Location = new System.Drawing.Point(716, 59);
            this.cbMon.Name = "cbMon";
            this.cbMon.Size = new System.Drawing.Size(249, 28);
            this.cbMon.TabIndex = 21;
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Black;
            this.panel1.Controls.Add(this.label9);
            this.panel1.Location = new System.Drawing.Point(-1, -1);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1194, 48);
            this.panel1.TabIndex = 22;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.ForeColor = System.Drawing.Color.White;
            this.label9.Location = new System.Drawing.Point(3, 10);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(357, 29);
            this.label9.TabIndex = 1;
            this.label9.Text = "He Thong Nha Hang Huong Viet";
            // 
            // btnCancel
            // 
            this.btnCancel.BackColor = System.Drawing.Color.Black;
            this.btnCancel.ForeColor = System.Drawing.Color.White;
            this.btnCancel.Location = new System.Drawing.Point(13, 469);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(82, 39);
            this.btnCancel.TabIndex = 23;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = false;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // dataGridView2
            // 
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Location = new System.Drawing.Point(640, 139);
            this.dataGridView2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.RowHeadersWidth = 62;
            this.dataGridView2.Size = new System.Drawing.Size(540, 236);
            this.dataGridView2.TabIndex = 25;
            // 
            // btnOrder
            // 
            this.btnOrder.BackColor = System.Drawing.Color.Black;
            this.btnOrder.ForeColor = System.Drawing.Color.White;
            this.btnOrder.Image = global::_1752048_1752038_1752024_1752051.Properties.Resources.add1;
            this.btnOrder.Location = new System.Drawing.Point(1085, 55);
            this.btnOrder.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnOrder.Name = "btnOrder";
            this.btnOrder.Size = new System.Drawing.Size(52, 35);
            this.btnOrder.TabIndex = 15;
            this.btnOrder.UseVisualStyleBackColor = false;
            this.btnOrder.Click += new System.EventHandler(this.BtnOrder_Click);
            // 
            // FormDatMon
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1193, 522);
            this.Controls.Add(this.dataGridView2);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.cbMon);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnDone);
            this.Controls.Add(this.btnDel);
            this.Controls.Add(this.btnOrder);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.numeric);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "FormDatMon";
            this.Text = "Đặt Món";
            ((System.ComponentModel.ISupportInitialize)(this.numeric)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.NumericUpDown numeric;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button btnOrder;
        private System.Windows.Forms.Button btnDel;
        private System.Windows.Forms.Button btnDone;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cbMon;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.DataGridView dataGridView2;
    }
}

