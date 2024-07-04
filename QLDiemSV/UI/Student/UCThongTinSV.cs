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

namespace QLDiemSV.UI.Student
{
    public partial class UCThongTinSV : UserControl
    {
        SinhVienBLL svBLL = new SinhVienBLL();
        string maSV = "";
        public UCThongTinSV(SINHVIEN sinhvien)
        {
            InitializeComponent();
            maSV = sinhvien.MaSV;
            FillControl();
        }

        private void pbUpdate_Click(object sender, EventArgs e)
        {
            this.Hide();
            FUpdateThongTinSV fUpdateThongTinSV = new FUpdateThongTinSV(maSV);
            fUpdateThongTinSV.ShowDialog();
            this.Show();
            FillControl();
        }
        private void FillControl()
        {
            vi_ThongTinSV sv = svBLL.FindByIDvi(maSV);
            btnMaSV.Text = sv.MaSV;
            lblHoTen.Text = sv.HoTenSV;
            lblNgaySinh.Text = sv.NgaySinh.ToString("dd/MM/yyyy");
            lblGioiTinh.Text = sv.GioiTinh;
            lblDiaChi.Text = sv.DiaChi;
            lblCCCD.Text = sv.CCCD;
            lblNamHoc.Text = sv.NamNhapHoc.ToString();
            btnSDT.Text = sv.SDT;
            btnEmail.Text = sv.Email;
        }

        private void pbUpdateMK_Click(object sender, EventArgs e)
        {
            this.Hide();
            FDoiMatKhau fdoimk = new FDoiMatKhau();
            fdoimk.ShowDialog();
            this.Show();
            svBLL = new SinhVienBLL();
            FillControl();
        }
    }
}
