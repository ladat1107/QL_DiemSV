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
using System.Windows.Forms.DataVisualization.Charting;

namespace QLDiemSV.UI.Teacher
{
    public partial class UCXemDiemGV : UserControl
    {
        GiangVienBLL gvBLL = new GiangVienBLL();
        GIANGVIEN giangVien = new GIANGVIEN();
        List<ft_GVXemDiemResult> listDiem = new List<ft_GVXemDiemResult>();
        List<ft_TKBLopGVDangDayResult> listLop = new List<ft_TKBLopGVDangDayResult>();
        DiemBLL diemBLL = new DiemBLL();
        DateTime date = DateTime.Today;
        int hk = 1;
        public UCXemDiemGV(GIANGVIEN gv)
        {
            InitializeComponent();
            giangVien = gv;
            if (date.Month > 0 && date.Month < 8) hk = 2;
            else hk = 1;
            listLop = gvBLL.GetTKBGV(giangVien.MaGV, hk, date.Year);
            cmbLop.DataSource = listLop;
            cmbLop.ValueMember = "MaLop";
            cmbLop.DisplayMember = "TenLop";
        }

        private void cmbLop_SelectedIndexChanged(object sender, EventArgs e)
        {
            int[] SLDiem = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            listDiem = gvBLL.GVXemDiem(giangVien.MaGV, cmbLop.SelectedValue.ToString());
            foreach (ft_GVXemDiemResult diem in listDiem)
                if (diem.DiemTB != null)
                    SLDiem[(int)(double)diem.DiemTB / 1]++;
            var KhoangDiem = new Guna.Charts.WinForms.GunaBarDataset();

            for (int i = 0; i <= 10; i++)
                KhoangDiem.DataPoints.Add(i.ToString(), SLDiem[i]);

            gunaChart1.Legend.Display = false;
            gunaChart1.Datasets.Clear();
            if (KhoangDiem.DataPointCount > 0)
            {
                gunaChart1.Datasets.Add(KhoangDiem);
            }
            gvBangDiem.DataSource = listDiem;
        }

        private void gvBangDiem_DoubleClick(object sender, EventArgs e)
        {
            LamSach();
            lblMaSV.Text = gvBangDiem.CurrentRow.Cells[3].Value.ToString();
            lblHoTen.Text = gvBangDiem.CurrentRow.Cells[4].Value.ToString();
            if (gvBangDiem.CurrentRow.Cells[6].Value != null) txtDiemGK.Text = gvBangDiem.CurrentRow.Cells[6].Value.ToString();
            if (gvBangDiem.CurrentRow.Cells[7].Value != null) txtDiemCK.Text = gvBangDiem.CurrentRow.Cells[7].Value.ToString();
        }

        private void btnCapNhat_Click(object sender, EventArgs e)
        {
            if (lblMaSV.Text == "")
                FMessageBox.Show("Thiếu dữ liệu");
            else
            {
                DIEM diem = new DIEM();
                diem.MaSV = lblMaSV.Text;
                diem.MaLop = cmbLop.SelectedValue.ToString();
                if (txtDiemGK.Text != "") diem.DiemQT = decimal.Parse(txtDiemGK.Text);
                if (txtDiemCK.Text != "") diem.DiemCK = decimal.Parse(txtDiemCK.Text);
                diemBLL.UpdateDiem(diem);
                LamSach();
                cmbLop_SelectedIndexChanged(sender, new EventArgs());
            }
        }
       
        public void LamSach()
        {
            lblHoTen.Text = "";
            lblMaSV.Text = "";
            txtDiemGK.Text = "";
            txtDiemCK.Text = "";
        }
    }
}
