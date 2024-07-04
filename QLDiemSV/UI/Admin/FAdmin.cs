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
    public partial class FAdmin : Form
    {
        public FAdmin()
        {
            InitializeComponent();
        }

        private void btnHocVien_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCQuanTriSV uc = new UCQuanTriSV();
            pnlNoiDung.Controls.Add(uc);
        }

        private void btnGiaoVien_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCQuanTriGV uc = new UCQuanTriGV();
            pnlNoiDung.Controls.Add(uc);
        }

        private void btnLop_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCQuanTriLop uc = new UCQuanTriLop();
            pnlNoiDung.Controls.Add(uc);
        }

        private void btnTaiKhoan_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCQuanTriTK uc = new UCQuanTriTK();
            pnlNoiDung.Controls.Add(uc);
        }

        private void btnKhoaHoc_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCQuanTriDiem uc = new UCQuanTriDiem();
            pnlNoiDung.Controls.Add(uc);
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            FMessageBox frmMessageBox = new FMessageBox("Are you sure you want to log out?", "CONFIRM");
            DialogResult result = frmMessageBox.ShowDialog();
            if (result == DialogResult.OK)
                this.Close();
        }
    }
}
