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

namespace QLDiemSV.UI.Teacher
{
    public partial class UCThongTinGV : UserControl
    {
        GiangVienBLL gvBLL = new GiangVienBLL();
        GIANGVIEN giangVien = new GIANGVIEN();
        public UCThongTinGV(GIANGVIEN gv)
        {
            InitializeComponent();
            giangVien = gv;            
        }
        
        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void UCThongTinGV_Load(object sender, EventArgs e)
        {
            LoadThongTin(giangVien);
        }

        private void pbSua_Click(object sender, EventArgs e)
        {
            FCapNhatThongTinGV form = new FCapNhatThongTinGV(giangVien);
            form.ShowDialog();
            UCThongTinGV_Load(sender, e);
        }
        void LoadThongTin(GIANGVIEN gv)
        {
            vi_ThongTinGV viewGV = gvBLL.FindViewByID(gv.MaGV);
            btnMaGV.Text = gv.MaGV;
            lblTenGV.Text = viewGV.TenGV;
            lblDiaChi.Text = viewGV.DiaChi;
            lblCCCD.Text = viewGV.CCCD;
            lblNgaySinh.Text = viewGV.NgaySinh.ToString();
            lblGioiTinh.Text = viewGV.GioiTinh;
            lblKhoa.Text = viewGV.TenKhoa;
            btnEmail.Text = viewGV.Email;
            btnSDT.Text = viewGV.SDT;
        }

        private void pbSuaMK_Click(object sender, EventArgs e)
        {
            this.Hide();
            FDoiMatKhau fdoimk = new FDoiMatKhau();
            fdoimk.ShowDialog();
            this.Show();
            gvBLL = new GiangVienBLL();
            giangVien = gvBLL.FindGiangVienByID(giangVien.MaGV);
            LoadThongTin(giangVien);
        }
    }
}
