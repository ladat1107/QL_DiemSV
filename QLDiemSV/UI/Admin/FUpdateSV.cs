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

namespace QLDiemSV.UI.Admin
{
    public partial class FUpdateSV : Form
    {
        KhoaBLL khoaBLL = new KhoaBLL();
        SinhVienBLL sinhVienBLL = new SinhVienBLL();
        string maSV;
        public FUpdateSV(string maSV)
        {
            InitializeComponent();
            this.maSV = maSV;
        }

        private void FUpdateSV_Load(object sender, EventArgs e)
        {
            List<Tuple<bool, string>> listGioiTinh = new List<Tuple<bool, string>>();
            listGioiTinh.Add(new Tuple<bool, string>(false, "Nam"));
            listGioiTinh.Add(new Tuple<bool, string>(true, "Nữ"));

            cmbKhoa.DataSource = khoaBLL.FindAllKhoa();
            cmbKhoa.DisplayMember = "TenKhoa";
            cmbKhoa.ValueMember = "MaKhoa";

            cmbGioiTinh.DataSource = listGioiTinh;
            cmbGioiTinh.DisplayMember = "Item2";
            cmbGioiTinh.ValueMember = "Item1";

            FillControl();
        }

        private void FillControl()
        {
            SINHVIEN sv = sinhVienBLL.FindByID(maSV);
            txtHo.Text = sv.HoSV;
            txtTenlot.Text = sv.TenlotSV;
            txtTen.Text = sv.TenSV;
            txtCMND.Text = sv.CCCD;
            txtDiaChi.Text = sv.DiaChi;
            cmbGioiTinh.SelectedValue = sv.Gioitinh;
            dtNgaySinh.Value = sv.NgaySinh;
            txtSDT.Text = sv.SDT.ToString();
            txtEmail.Text = sv.Email;
            txtKhoa.Text = sv.NamNhapHoc.ToString();
            cmbKhoa.SelectedValue = sv.MaKhoa;
        }

        private void btnChinhSua_Click(object sender, EventArgs e)
        {
            SINHVIEN sv = sinhVienBLL.FindByID(maSV);
            sv.HoSV = txtHo.Text;
            sv.TenlotSV = txtTenlot.Text;
            sv.TenSV = txtTen.Text;
            sv.CCCD = txtCMND.Text;
            sv.DiaChi = txtDiaChi.Text;
            sv.Gioitinh = (bool)cmbGioiTinh.SelectedValue;
            sv.NgaySinh = DateTime.Parse(dtNgaySinh.Text).Date;
            sv.SDT = txtSDT.Text;
            sv.Email = txtEmail.Text;
            sv.NamNhapHoc = int.Parse(txtKhoa.Text);
            sv.MaKhoa = cmbKhoa.SelectedValue.ToString();

            sinhVienBLL.Update(sv);
            Close();
        }
    }
}
