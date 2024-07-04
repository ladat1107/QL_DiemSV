using QLDiemSV.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI.Admin
{
    public partial class UCQuanTriTK : UserControl
    {
        TaiKhoanBLL tkBLL = new TaiKhoanBLL();
        public UCQuanTriTK()
        {
            InitializeComponent();
        }

        private void gvSinhVien_DoubleClick(object sender, EventArgs e)
        {
            txtTen.Text = gvSinhVien.CurrentRow.Cells[0].Value.ToString();
            txtTaiKhoan.Text = gvSinhVien.CurrentRow.Cells[1].Value.ToString();
            txtMK.Text = gvSinhVien.CurrentRow.Cells[2].Value.ToString();
            txtTT.Text = gvSinhVien.CurrentRow.Cells[3].Value.ToString();
        }

        private void gvGiangVien_DoubleClick(object sender, EventArgs e)
        {
            txtTen.Text = gvGiangVien.CurrentRow.Cells[0].Value.ToString();
            txtTaiKhoan.Text = gvGiangVien.CurrentRow.Cells[1].Value.ToString();
            txtMK.Text = gvGiangVien.CurrentRow.Cells[2].Value.ToString();
            txtTT.Text = gvGiangVien.CurrentRow.Cells[3].Value.ToString();
        }

        private void UCQuanTriTaiKhoan_Load(object sender, EventArgs e)
        {
            this.gvGiangVien.DataSource = tkBLL.FindTKGV();
            this.gvSinhVien.DataSource = tkBLL.FindTKSV();
            gvGiangVien.ScrollBars = ScrollBars.Both;
            gvSinhVien.ScrollBars = ScrollBars.Both;
        }

        private void pbSua_Click(object sender, EventArgs e)
        {
            if (txtTaiKhoan.Text != "")
            {
                FUpdateTK form = new FUpdateTK(txtTaiKhoan.Text);
            form.ShowDialog();
            UCQuanTriTaiKhoan_Load(sender, e);
            }
            else FMessageBox.Show("Vui lòng chọn tài khoản");
        }

        private void pbXoa_Click(object sender, EventArgs e)
        {
            if (txtTaiKhoan.Text != "")
            {
                tkBLL.Delete(txtTaiKhoan.Text);
                UCQuanTriTaiKhoan_Load(sender, e);
            }
            else FMessageBox.Show("Vui lòng chọn tài khoản");
            UCQuanTriTaiKhoan_Load(sender, e);


        }
    }
}
