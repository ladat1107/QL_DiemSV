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
    public partial class UCQuanTriSV : UserControl
    {
        SinhVienBLL sinhVienBLL = new SinhVienBLL();
        KhoaBLL khoaBLL = new KhoaBLL();
        public UCQuanTriSV()
        {
            InitializeComponent();
        }

        private void UCQuanTriSV_Load(object sender, EventArgs e)
        {
            this.gvSinhVien.DataSource = sinhVienBLL.FindAllThongTinSV();
            gvSinhVien.ScrollBars = ScrollBars.Both;

            List<TenKhoaModel> listKhoa = new List<TenKhoaModel>();
            TenKhoaModel tckh = new TenKhoaModel();
            tckh.Ma = "0";
            tckh.Ten = "Tất cả";
            listKhoa.Add(tckh);

            foreach (KHOA khoa in khoaBLL.FindAllKhoa())
            {
                TenKhoaModel kh = new TenKhoaModel { Ma = khoa.MaKhoa, Ten = khoa.TenKhoa };
                listKhoa.Add(kh);
            }
            cmbKhoa.DataSource = listKhoa;
            cmbKhoa.DisplayMember = "Ten";
            cmbKhoa.ValueMember = "Ma";
        }

        private void pbThem_Click(object sender, EventArgs e)
        {
            FInsertSV form = new FInsertSV();
            form.ShowDialog();
            UCQuanTriSV_Load(sender, e);
        }

        private void pbSua_Click(object sender, EventArgs e)
        {
            if (txtMaSV.Text != "")
            {
                FUpdateSV form = new FUpdateSV(txtMaSV.Text);
                form.ShowDialog();
                UCQuanTriSV_Load(sender, e);
            }
            else FMessageBox.Show("Vui lòng chọn sinh viên");
            ClearControl();
        }

        private void pbXoa_Click(object sender, EventArgs e)
        {
            SINHVIEN sv = sinhVienBLL.FindByID(txtMaSV.Text);
            sinhVienBLL.Delete(sv);
            UCQuanTriSV_Load(sender, e);
            ClearControl();
        }

        private void cmbKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbKhoa.Text.ToString() == "Tất cả")
                gvSinhVien.DataSource = sinhVienBLL.FindAllThongTinSV();
            else
                gvSinhVien.DataSource = sinhVienBLL.FindSinhVienbyKhoa(cmbKhoa.Text);
            gvSinhVien.ScrollBars = ScrollBars.Both;
        }

        private void gvSinhVien_DoubleClick(object sender, EventArgs e)
        {
            txtMaSV.Text = gvSinhVien.CurrentRow.Cells[0].Value.ToString();
            txtHoTen.Text = gvSinhVien.CurrentRow.Cells[1].Value.ToString();
            txtCMND.Text = gvSinhVien.CurrentRow.Cells[2].Value.ToString();
            txtDiaChi.Text = gvSinhVien.CurrentRow.Cells[3].Value.ToString();
            txtGioiTinh.Text = gvSinhVien.CurrentRow.Cells[4].Value.ToString();
            dtpNgaySinh.Text = gvSinhVien.CurrentRow.Cells[5].Value.ToString();
            txtSDT.Text = gvSinhVien.CurrentRow.Cells[6].Value.ToString();
            txtEmail.Text = gvSinhVien.CurrentRow.Cells[7].Value.ToString();
            txtKhoa.Text = gvSinhVien.CurrentRow.Cells[9].Value.ToString();
            txtNienKhoa.Text = gvSinhVien.CurrentRow.Cells[8].Value.ToString();

            gvLopSV.DataSource = sinhVienBLL.FindLopSVHoc(txtMaSV.Text);
            gvLopSV.ScrollBars = ScrollBars.Both;
        }

        private void ClearControl()
        {
            txtMaSV.Clear();
            txtHoTen.Clear();
            txtCMND.Clear();
            txtDiaChi.Clear();
            txtGioiTinh.Clear();
            txtSDT.Clear();
            txtEmail.Clear();
            txtKhoa.Clear();
            txtNienKhoa.Clear();
        }
    }
}
