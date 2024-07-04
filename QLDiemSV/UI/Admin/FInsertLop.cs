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
    public partial class FInsertLop : Form
    {
        LopBLL lopBLL = new LopBLL();
        MonHocBLL mhBLL = new MonHocBLL();
        GiangVienBLL gvBLL = new GiangVienBLL();
        PhongHocBLL phBLL = new PhongHocBLL();
        BuoiHocBLL bhBLL = new BuoiHocBLL();
        
        public FInsertLop()
        {
            InitializeComponent();
        }

        private void FInsertLop_Load(object sender, EventArgs e)
        {
            List<Tuple<int, string>> listLoaiLop = new List<Tuple<int, string>>();
            listLoaiLop.Add(new Tuple<int, string>(1, "Offline"));
            listLoaiLop.Add(new Tuple<int, string>(2, "Online"));

            cmbLoaiLop.DataSource = listLoaiLop;
            cmbLoaiLop.DisplayMember = "Item2";
            cmbLoaiLop.ValueMember = "Item1";

            cmbPhongHoc.DataSource = phBLL.FindAll();
            cmbPhongHoc.DisplayMember = "MaPhong";
            cmbPhongHoc.ValueMember = "MaPhong";

            cmbGV.DataSource = gvBLL.FindAllThongTinGV();
            cmbGV.DisplayMember = "TenGV";
            cmbGV.ValueMember = "MaGV";

            cmbMH.DataSource = mhBLL.FindAllMonHoc();
            cmbMH.DisplayMember = "TenMon";
            cmbMH.ValueMember = "MaMon";

            gvDiemLop.DataSource = bhBLL.FindThongTinLop();
            gvDiemLop.ScrollBars = ScrollBars.Both;
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            LOP lop = new LOP();
            //lop.MaLop = "00000000";
            lop.TenLop = txtTenLop.Text;
            lop.MaLoaiLop = int.Parse(cmbLoaiLop.SelectedValue.ToString());
            lop.SL = int.Parse(txtSoHV.Text);
            lop.HK = int.Parse(txtHocKy.Text);
            lop.Namhoc = int.Parse(txtKH.Text);
            lop.MaGV = cmbGV.SelectedValue.ToString();
            lop.MaMon = cmbMH.SelectedValue.ToString();

            BUOIHOC buoihoc = new BUOIHOC();
            buoihoc.MaCa = cmbCaHoc.Text;
            buoihoc.MaPhong = cmbPhongHoc.SelectedValue.ToString();
            buoihoc.Thu = int.Parse(cmbThu.Text);
            lopBLL.InsertLop(lop, buoihoc);
            Close();
        }
    }
}
