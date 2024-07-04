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

namespace QLDiemSV.UI.Admin
{
    public partial class FInsertSV : Form
    {
        SinhVienBLL sinhVienBLL = new SinhVienBLL();
        KhoaBLL khoaBLL = new KhoaBLL();
        public FInsertSV()
        {
            InitializeComponent();
        }

        private void FInsertSV_Load(object sender, EventArgs e)
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
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            SINHVIEN sv = new SINHVIEN();
            sv.MaSV = "00000000";
            sv.HoSV = txtHo.Text;
            sv.TenlotSV = txtTenlot.Text;
            sv.TenSV = txtTen.Text;
            sv.CCCD = txtCMND.Text;
            sv.DiaChi = txtDiaChi.Text;
            sv.Gioitinh = (bool)cmbGioiTinh.SelectedValue;
            sv.NgaySinh = DateTime.Parse(dtNgaySinh.Text).Date;
            sv.SDT = txtSDT.Text;
            sv.Email = txtEmail.Text;
            sv.NamNhapHoc = int.Parse(txtNienKhoa.Text);
            sv.MaKhoa = cmbKhoa.SelectedValue.ToString();
            sv.TaiKhoan = null;
            sv.TrangThai = true;

            sinhVienBLL.Insert(sv);
            Close();
        }
    }
}
