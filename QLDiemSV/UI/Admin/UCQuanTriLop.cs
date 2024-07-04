using QLDiemSV.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.AccessControl;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI.Admin
{
    public partial class UCQuanTriLop : UserControl
    {
        LopBLL lopBLL = new LopBLL();
        public UCQuanTriLop()
        {
            InitializeComponent();
        }

        private void pbThem_Click(object sender, EventArgs e)
        {
            FInsertLop form = new FInsertLop();
            form.ShowDialog();
            UCQuanTriLop_Load(sender, e);
            ClearControl();
        }

        private void pbXoa_Click(object sender, EventArgs e)
        {
            lopBLL.DeleteLop(txtMaLop.Text);
            UCQuanTriLop_Load(sender, e);
            ClearControl();
        }

        private void UCQuanTriLop_Load(object sender, EventArgs e)
        {
            this.gvLop.DataSource = lopBLL.FindAllThongTinLop();
            gvLop.ScrollBars = ScrollBars.Both;
        }

        private void gvLop_DoubleClick(object sender, EventArgs e)
        {
            txtMaLop.Text = gvLop.CurrentRow.Cells[0].Value.ToString();
            txtTenLop.Text = gvLop.CurrentRow.Cells[1].Value.ToString();
            txtMonHoc.Text = gvLop.CurrentRow.Cells[2].Value.ToString();
            txtLoaiLop.Text = gvLop.CurrentRow.Cells[3].Value.ToString();
            txtSSV.Text = gvLop.CurrentRow.Cells[4].Value.ToString() + " / " + gvLop.CurrentRow.Cells[5].Value.ToString();
            txtHK.Text = gvLop.CurrentRow.Cells[6].Value.ToString();
            txtNamHoc.Text = gvLop.CurrentRow.Cells[8].Value.ToString();
            txtGiangVien.Text = gvLop.CurrentRow.Cells[9].Value.ToString();
        }

        private void ptbThemSV_Click(object sender, EventArgs e)
        {
            if (txtMaLop.Text != "")
            {
                FInsertDiem form = new FInsertDiem(txtMaLop.Text);
                form.ShowDialog();
                UCQuanTriLop_Load(sender, e);
            }
            else FMessageBox.Show("Vui lòng chọn lớp");
        }

        private void ClearControl()
        {
            txtMaLop.Clear();
            txtTenLop.Clear();
            txtMonHoc.Clear();
            txtLoaiLop.Clear();
            txtSSV.Clear();
            txtHK.Clear();
            txtNamHoc.Clear();
            txtGiangVien.Clear();
        }
    }
}
