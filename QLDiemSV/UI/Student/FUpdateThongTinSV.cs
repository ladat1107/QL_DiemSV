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
    public partial class FUpdateThongTinSV : Form
    {
        SinhVienBLL svBLL = new SinhVienBLL();
        SINHVIEN sinhvien = new SINHVIEN();
        string maSV;
        public FUpdateThongTinSV(string maSV)
        {
            InitializeComponent();
            this.maSV = maSV;
        }
        private void FUpdateThongTinSV_Load(object sender, EventArgs e)
        {
            List<Tuple<bool, string>> listGioiTinh = new List<Tuple<bool, string>>();
            listGioiTinh.Add(new Tuple<bool, string>(false, "Nam"));
            listGioiTinh.Add(new Tuple<bool, string>(true, "Nữ"));

            cmbGioiTinh.DataSource = listGioiTinh;
            cmbGioiTinh.DisplayMember = "Item2";
            cmbGioiTinh.ValueMember = "Item1";
            FillControl();
        }

        private void btnChinhSua_Click(object sender, EventArgs e)
        {
            SINHVIEN sv = svBLL.FindByID(maSV);
            sv.HoSV = txtHo.Text;
            sv.TenlotSV = txtTenlot.Text;
            sv.TenSV = txtTen.Text;
            sv.CCCD = txtCMND.Text;
            sv.DiaChi = txtDiaChi.Text;
            sv.Gioitinh = (bool)cmbGioiTinh.SelectedValue;
            sv.NgaySinh = DateTime.Parse(dtNgaySinh.Text).Date;
            sv.SDT = txtSDT.Text;
            sv.Email = txtEmail.Text;
            svBLL.Update(sv);
            Close();
        }

        private void FillControl()
        {
            SINHVIEN sv = svBLL.FindByID(maSV);
            txtHo.Text = sv.HoSV.ToString();
            txtTenlot.Text = sv.TenlotSV.ToString();
            txtTen.Text = sv.TenSV.ToString();
            txtCMND.Text = sv.CCCD.ToString();
            txtDiaChi.Text = sv.DiaChi.ToString();
            cmbGioiTinh.SelectedValue = sv.Gioitinh;
            dtNgaySinh.Value = sv.NgaySinh;
            txtSDT.Text = sv.SDT.ToString();
            txtEmail.Text = sv.Email.ToString();
        }
    }
}
