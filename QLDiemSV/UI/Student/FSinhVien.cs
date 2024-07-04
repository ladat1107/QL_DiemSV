using QLDiemSV.BLL;
using QLDiemSV.UI.Teacher;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI.Student
{
    public partial class FSinhVien : Form
    {
        SinhVienBLL svBLL = new SinhVienBLL();
        SINHVIEN sinhvien;
        public FSinhVien(string maSV)
        {
            InitializeComponent();
            this.sinhvien = svBLL.FindByID(maSV);
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            FMessageBox frmMessageBox = new FMessageBox("Are you sure you want to log out?", "CONFIRM");
            DialogResult result = frmMessageBox.ShowDialog();
            if (result == DialogResult.OK)
                this.Close();
        }

        private void btnKetQua_Click(object sender, EventArgs e)
        {

        }

        private void btnTKB_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThoiKhoaBieuSV uCChiTietTKBSV = new UCThoiKhoaBieuSV(sinhvien);
            pnlNoiDung.Controls.Add(uCChiTietTKBSV);
        }

        private void btnThongTinCaNhan_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThongTinSV ucTTGV = new UCThongTinSV(sinhvien);
            pnlNoiDung.Controls.Add(ucTTGV);
        }

        private void btnPhongHoc_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThongTinLopSV ucTTGV = new UCThongTinLopSV(sinhvien);
            pnlNoiDung.Controls.Add(ucTTGV);
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThongKeDiemSV ucTTGV = new UCThongKeDiemSV(sinhvien);
            pnlNoiDung.Controls.Add(ucTTGV);
        }
    }
}
