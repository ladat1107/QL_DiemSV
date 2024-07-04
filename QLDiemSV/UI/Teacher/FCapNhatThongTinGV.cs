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

    public partial class FCapNhatThongTinGV : Form
    {
        List<Tuple<bool, string>> listGioiTinh = new List<Tuple<bool, string>>();
        GiangVienBLL gvBLL = new GiangVienBLL();
        public FCapNhatThongTinGV(GIANGVIEN gv)
        {
            InitializeComponent();
            listGioiTinh.Clear();
            listGioiTinh.Add(new Tuple<bool, string>(true, "Nữ"));
            listGioiTinh.Add(new Tuple<bool, string>(false, "Nam"));
            cmbGioiTinh.DataSource = listGioiTinh;
            cmbGioiTinh.DisplayMember = "Item2";
            cmbGioiTinh.ValueMember = "Item1";
            btnMaGV.Text = gv.MaGV;
            txtCCCD.Text = gv.CCCD;
            txtDiaChi.Text = gv.DiaChi;
            txtEmail.Text = gv.Email;
            txtSDT.Text = gv.SDT;
            txtHo.Text = gv.HoGV;
            txtTenLot.Text = gv.TenlotGV;
            txtTen.Text = gv.TenGV;
            dtNgaySinh.Text = gv.NgaySinh.ToString();
        }

        private void btnCapNhat_Click(object sender, EventArgs e)
        {
            GIANGVIEN gv = gvBLL.FindGiangVienByID(btnMaGV.Text);
            gv.MaGV = btnMaGV.Text;
            gv.CCCD = txtCCCD.Text;
            gv.DiaChi = txtDiaChi.Text;
            gv.Email = txtEmail.Text;
            gv.SDT = txtSDT.Text;
            gv.HoGV = txtHo.Text;
            gv.TenlotGV = txtTenLot.Text;
            gv.TenGV = txtTen.Text;
            gv.Gioitinh = (bool)cmbGioiTinh.SelectedValue;
            gv.NgaySinh = DateTime.Parse(dtNgaySinh.Text).Date;
            gvBLL.UpdateGiangVien(gv);
            this.Close();
        }
    }

}
