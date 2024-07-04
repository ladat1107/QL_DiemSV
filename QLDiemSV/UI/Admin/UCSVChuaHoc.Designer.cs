namespace QLDiemSV.UI.Admin
{
    partial class UCSVChuaHoc
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.guna2Panel2 = new Guna.UI2.WinForms.Guna2Panel();
            this.lblTen = new System.Windows.Forms.Label();
            this.lblKhoa = new System.Windows.Forms.Label();
            this.lblMa = new System.Windows.Forms.Label();
            this.btnThem = new Guna.UI2.WinForms.Guna2Button();
            this.SuspendLayout();
            // 
            // guna2Panel2
            // 
            this.guna2Panel2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(166)))), ((int)(((byte)(170)))), ((int)(((byte)(236)))));
            this.guna2Panel2.Location = new System.Drawing.Point(-1, 41);
            this.guna2Panel2.Name = "guna2Panel2";
            this.guna2Panel2.Size = new System.Drawing.Size(1156, 3);
            this.guna2Panel2.TabIndex = 584;
            // 
            // lblTen
            // 
            this.lblTen.AutoSize = true;
            this.lblTen.Font = new System.Drawing.Font("Segoe UI", 12F);
            this.lblTen.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblTen.Location = new System.Drawing.Point(408, 6);
            this.lblTen.Name = "lblTen";
            this.lblTen.Size = new System.Drawing.Size(122, 28);
            this.lblTen.TabIndex = 589;
            this.lblTen.Text = "Tên sinh viên";
            // 
            // lblKhoa
            // 
            this.lblKhoa.AutoSize = true;
            this.lblKhoa.Font = new System.Drawing.Font("Segoe UI", 12F);
            this.lblKhoa.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblKhoa.Location = new System.Drawing.Point(767, 6);
            this.lblKhoa.Name = "lblKhoa";
            this.lblKhoa.Size = new System.Drawing.Size(89, 28);
            this.lblKhoa.TabIndex = 588;
            this.lblKhoa.Text = "Tên khoa";
            // 
            // lblMa
            // 
            this.lblMa.AutoSize = true;
            this.lblMa.Font = new System.Drawing.Font("Segoe UI", 12F);
            this.lblMa.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblMa.Location = new System.Drawing.Point(81, 6);
            this.lblMa.Name = "lblMa";
            this.lblMa.Size = new System.Drawing.Size(121, 28);
            this.lblMa.TabIndex = 587;
            this.lblMa.Text = "Mã sinh viên";
            // 
            // btnThem
            // 
            this.btnThem.BorderRadius = 10;
            this.btnThem.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnThem.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnThem.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnThem.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnThem.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(255)))));
            this.btnThem.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Bold);
            this.btnThem.ForeColor = System.Drawing.Color.White;
            this.btnThem.Location = new System.Drawing.Point(1030, 6);
            this.btnThem.Name = "btnThem";
            this.btnThem.Size = new System.Drawing.Size(100, 30);
            this.btnThem.TabIndex = 590;
            this.btnThem.Text = "THÊM";
            this.btnThem.Click += new System.EventHandler(this.btnThem_Click);
            // 
            // UCSVChuaHoc
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.btnThem);
            this.Controls.Add(this.lblTen);
            this.Controls.Add(this.lblKhoa);
            this.Controls.Add(this.lblMa);
            this.Controls.Add(this.guna2Panel2);
            this.Name = "UCSVChuaHoc";
            this.Size = new System.Drawing.Size(1156, 46);
            this.Load += new System.EventHandler(this.UCSVChuaHoc_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Guna.UI2.WinForms.Guna2Panel guna2Panel2;
        private System.Windows.Forms.Label lblTen;
        private System.Windows.Forms.Label lblKhoa;
        private System.Windows.Forms.Label lblMa;
        private Guna.UI2.WinForms.Guna2Button btnThem;
    }
}
