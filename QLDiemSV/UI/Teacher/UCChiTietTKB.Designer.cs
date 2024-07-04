namespace QLDiemSV.UI.Teacher
{
    partial class UCChiTietTKB
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
            this.lblTG = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.lblPhong = new System.Windows.Forms.Label();
            this.lblMonHoc = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblTG
            // 
            this.lblTG.AutoSize = true;
            this.lblTG.Location = new System.Drawing.Point(9, 30);
            this.lblTG.Name = "lblTG";
            this.lblTG.Size = new System.Drawing.Size(85, 16);
            this.lblTG.TabIndex = 11;
            this.lblTG.Text = "9:00  ->  10:30";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(9, 52);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(49, 16);
            this.label4.TabIndex = 9;
            this.label4.Text = "Phòng:";
            // 
            // lblPhong
            // 
            this.lblPhong.AutoSize = true;
            this.lblPhong.Location = new System.Drawing.Point(58, 51);
            this.lblPhong.Name = "lblPhong";
            this.lblPhong.Size = new System.Drawing.Size(30, 16);
            this.lblPhong.TabIndex = 7;
            this.lblPhong.Text = "A12";
            // 
            // lblMonHoc
            // 
            this.lblMonHoc.AutoSize = true;
            this.lblMonHoc.Font = new System.Drawing.Font("Segoe UI Semibold", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblMonHoc.Location = new System.Drawing.Point(5, 4);
            this.lblMonHoc.Name = "lblMonHoc";
            this.lblMonHoc.Size = new System.Drawing.Size(158, 17);
            this.lblMonHoc.TabIndex = 6;
            this.lblMonHoc.Text = "Hệ quản trị cơ sở dữ liệu";
            this.lblMonHoc.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // UCChiTietTKB
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightSkyBlue;
            this.Controls.Add(this.lblTG);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.lblPhong);
            this.Controls.Add(this.lblMonHoc);
            this.Margin = new System.Windows.Forms.Padding(0);
            this.Name = "UCChiTietTKB";
            this.Size = new System.Drawing.Size(169, 98);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTG;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblPhong;
        private System.Windows.Forms.Label lblMonHoc;
    }
}
