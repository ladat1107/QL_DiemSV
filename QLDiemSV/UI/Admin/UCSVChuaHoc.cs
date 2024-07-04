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
    public partial class UCSVChuaHoc : UserControl
    {
        ft_ThongTinSVChuaHocResult ttsv;
        DiemBLL diemBLL = new DiemBLL();
        string MaLop;
        FInsertDiem.reload reload;
        public UCSVChuaHoc(ft_ThongTinSVChuaHocResult ttsv, string maLop, FInsertDiem.reload reload)
        {
            InitializeComponent();
            this.ttsv = ttsv;
            this.MaLop = maLop;
            this.reload = reload;
        }

        private void UCSVChuaHoc_Load(object sender, EventArgs e)
        {
            lblMa.Text = ttsv.MaSV;
            lblTen.Text = ttsv.HoTenSV;
            lblKhoa.Text = ttsv.TenKhoa;
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            DIEM diem = new DIEM();
            diem.MaSV = lblMa.Text;
            diem.MaLop = MaLop;

            diemBLL.InsertDiem(diem);
            reload();
        }
    }
}
