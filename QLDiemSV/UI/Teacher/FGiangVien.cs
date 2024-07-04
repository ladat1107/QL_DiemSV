using QLDiemSV.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Windows.Forms;

namespace QLDiemSV.UI.Teacher
{
    
    public partial class FGiangVien : Form
    {
        public Form currentFormChild;
        GiangVienBLL gvBLL = new GiangVienBLL();
        GIANGVIEN giangVien = new GIANGVIEN();
        public FGiangVien(string maGV)
        {
            InitializeComponent();
            giangVien = gvBLL.FindGiangVienByID(maGV);
        }
        private void FThongTinGiangVien_Load(object sender, EventArgs e)
        {

        }
        private void btnThongTinCaNhan_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThongTinGV ucTTGV = new UCThongTinGV(giangVien);
            pnlNoiDung.Controls.Add(ucTTGV);
        }
        private void btnTKB_Click_1(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCThoiKhoaBieuGV ucTKBGV = new UCThoiKhoaBieuGV(giangVien);
            pnlNoiDung.Controls.Add(ucTKBGV);
        }
        private void btnXemDiem_Click(object sender, EventArgs e)
        {
            pnlNoiDung.Controls.Clear();
            UCXemDiemGV ucXemDiem = new UCXemDiemGV(giangVien);
            pnlNoiDung.Controls.Add(ucXemDiem);
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
