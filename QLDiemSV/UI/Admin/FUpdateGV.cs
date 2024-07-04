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
    public partial class FUpdateGV : Form
    {
        GiangVienBLL gvBll = new GiangVienBLL();
        KhoaBLL khoaBLL = new KhoaBLL();
        string maGV;
        public FUpdateGV(string maGV)
        {
            InitializeComponent();
            this.maGV = maGV;
        }

        private void FUpdateGV_Load(object sender, EventArgs e)
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

            FillControl();
        }

        private void btnChinhSua_Click(object sender, EventArgs e)
        {
            GIANGVIEN gv = gvBll.FindGiangVienByID(maGV);
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

            gvBll.UpdateGiangVien(gv);
            Close();
        }

        private void FillControl()
        {
            GIANGVIEN gv = gvBll.FindGiangVienByID(maGV);
            txtHo.Text = gv.HoGV.ToString();
            txtTenlot.Text = gv.TenlotGV.ToString();
            txtTen.Text = gv.TenGV.ToString();
            txtCMND.Text = gv.CCCD.ToString();
            txtDiaChi.Text = gv.DiaChi.ToString();
            cmbGioiTinh.SelectedValue = gv.Gioitinh;
            dtNgaySinh.Value = gv.NgaySinh;
            txtSDT.Text = gv.SDT.ToString();
            txtEmail.Text = gv.Email.ToString();
            cmbLoaiGV.SelectedValue = gv.MaLoaiGV;
            cmbKhoa.SelectedValue = gv.MaKhoa;
        }
    }
}
