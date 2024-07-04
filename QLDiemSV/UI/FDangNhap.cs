using QLDiemSV.BLL;
using QLDiemSV.UI.Student;
using QLDiemSV.UI.Teacher;
using QLDiemSV.UI.Admin;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI
{
    public partial class FDangNhap : Form
    {
        public static string taikhoan;
        public static string matkhau;
        QLSinhVienDataContext db = new QLSinhVienDataContext();
        public FDangNhap()
        {
            InitializeComponent();
        }
        private void btnQuen_Click(object sender, EventArgs e)
        {
            this.Hide();
            FQuenMatKhau fQuenMK = new FQuenMatKhau();
            fQuenMK.ShowDialog();
            this.Show();
        }

        private void btnDN_Click(object sender, EventArgs e)
        {
            string tk = txtTenTaiKhoan.Text;
            string mk = txtMatKhau.Text;
            if (radQTV.Checked)
            {
                string ma = db.ft_ChkDangNhap(tk, mk, 0);
                if ("admin".Equals(ma))
                {
                    this.Hide();
                    taikhoan = txtTenTaiKhoan.Text;
                    matkhau = txtMatKhau.Text;
                    FAdmin fadmin = new FAdmin();
                    fadmin.ShowDialog();
                    this.Show();
                    return;
                }
            }
            if (radHV.Checked)
            {
                string ma = db.ft_ChkDangNhap(tk, mk, 1);
                if (ma != null)
                {
                    this.Hide();
                    taikhoan = txtTenTaiKhoan.Text;
                    matkhau = txtMatKhau.Text;
                    FSinhVien fSV = new FSinhVien(txtTenTaiKhoan.Text);
                    fSV.ShowDialog();
                    this.Show();
                    return;
                }
            }
            if (radGV.Checked)
            {
                string ma = db.ft_ChkDangNhap(tk, mk, 2);
                if (ma != null)
                {
                    this.Hide();
                    taikhoan = txtTenTaiKhoan.Text;
                    matkhau = txtMatKhau.Text;
                    FGiangVien fGV = new FGiangVien(txtTenTaiKhoan.Text);
                    fGV.ShowDialog();
                    this.Show();
                    return;
                }
            }
            FMessageBox.Show("DangNhapLai");
        }

        private void cbHide_CheckedChanged(object sender, EventArgs e)
        {
            if (cbHide.Checked)
                txtMatKhau.PasswordChar = '●';
            else
                txtMatKhau.PasswordChar = '\0';
        }
    }
}
