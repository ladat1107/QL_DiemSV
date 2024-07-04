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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Tab;

namespace QLDiemSV.UI.Student
{
    public partial class UCThongTinLopSV : UserControl
    {
        DiemBLL diemBLL = new DiemBLL();
        LopBLL lopBLL = new LopBLL();
        DateTime today = DateTime.Today;
        SINHVIEN sinhVien = new SINHVIEN();
        int hk = 1;
        public UCThongTinLopSV(SINHVIEN sv)
        {
            InitializeComponent();
            sinhVien = sv;
            for (int i = sinhVien.NamNhapHoc; i < sinhVien.NamNhapHoc + 4; i++)
                cmbNH.Items.Add(i.ToString());
            if (today.Month > 0 && today.Month < 8) hk = 2;
            else hk = 1;
            cmbHK.Text = hk.ToString();
            cmbNH.Text = today.Year.ToString();
            gvThongTin.DataSource = lopBLL.FindByID_HK_NHvi(sv.MaSV, int.Parse(cmbHK.Text), int.Parse(cmbNH.Text));
            lblTBTL.Text = diemBLL.TinhDiemTBTichLuy(sv.MaSV).ToString();
        }
        private void cmbNH_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbHK.SelectedIndex != -1)
                gvThongTin.DataSource = lopBLL.FindByID_HK_NHvi(sinhVien.MaSV, int.Parse(cmbHK.Text), int.Parse(cmbNH.Text));
        }
        private void cmbHK_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbNH.SelectedIndex != -1)
                gvThongTin.DataSource = lopBLL.FindByID_HK_NHvi(sinhVien.MaSV, int.Parse(cmbHK.Text), int.Parse(cmbNH.Text));
        }
    }
}
