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
    public partial class FInsertGV : Form
    {
        GiangVienBLL gvBll = new GiangVienBLL();
        KhoaBLL khoaBLL = new KhoaBLL();
        public FInsertGV()
        {
            InitializeComponent();
        }

        private void FUserControl_Load(object sender, EventArgs e)
        {
            List<Tuple<bool, string>> listGioiTinh = new List<Tuple<bool, string>>();
            listGioiTinh.Add(new Tuple<bool, string>(false, "Nam"));
            listGioiTinh.Add(new Tuple<bool, string>(true, "Nữ"));

            List<Tuple<int, string>> listLoaiGV = new List<Tuple<int, string>>();
            listLoaiGV.Add(new Tuple<int, string>(1, "Cơ hữu"));
            listLoaiGV.Add(new Tuple<int, string>(2, "Thỉnh giảng"));

            cmbKhoa.DataSource = khoaBLL.FindAllKhoa();
            cmbKhoa.DisplayMember = "TenKhoa";
            cmbKhoa.ValueMember = "MaKhoa";

            cmbGioiTinh.DataSource = listGioiTinh;
            cmbGioiTinh.DisplayMember = "Item2";
            cmbGioiTinh.ValueMember = "Item1";

            cmbLoaiGV.DataSource = listLoaiGV;
            cmbLoaiGV.DisplayMember = "Item2";
            cmbLoaiGV.ValueMember = "Item1";
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            GIANGVIEN gv = new GIANGVIEN();
            gv.MaGV = "0000000";
            gv.HoGV = txtHo.Text;
            gv.TenlotGV = txtTenlot.Text;
            gv.TenGV = txtTen.Text;
            gv.CCCD = txtCMND.Text;
            gv.DiaChi = txtDiaChi.Text;
            gv.Gioitinh = (bool) cmbGioiTinh.SelectedValue;
            gv.NgaySinh = DateTime.Parse(dtNgaySinh.Text).Date;
            gv.SDT = txtSDT.Text;
            gv.Email = txtEmail.Text;
            gv.MaLoaiGV = int.Parse(cmbLoaiGV.SelectedValue.ToString());
            gv.MaKhoa = cmbKhoa.SelectedValue.ToString();
            gv.TaiKhoan = null;
            gv.TrangThai = true;

            gvBll.InsertGiangVien(gv);
            Close();
        }
    }
}
