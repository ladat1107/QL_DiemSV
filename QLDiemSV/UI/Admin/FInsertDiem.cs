using QLDiemSV.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.Design.Serialization;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI.Admin
{
    public partial class FInsertDiem : Form
    {
        LopBLL lopBLL = new LopBLL();
        SinhVienBLL svBLL = new SinhVienBLL();
        string MaLop;
        public FInsertDiem(string maLop)
        {
            InitializeComponent();
            this.MaLop = maLop;
        }

        private void FInsertDiem_Load(object sender, EventArgs e)
        {
            FillSV();
        }

        public delegate void reload();

        private void FillSV()
        {
            List<ft_TimTTLopTheoIDResult> TTLopList = lopBLL.FindThongTinLopByID(MaLop);
            ft_TimTTLopTheoIDResult TTLop = TTLopList[0];
            txtMaLop.Text = TTLop.MaLop;
            txtTenLop.Text = TTLop.TenLop;
            txtSL.Text = TTLop.SoLuongSV.ToString() + " / " + TTLop.SoLuongMax.ToString();
            txtThu.Text = TTLop.Thu.ToString();
            txtCa.Text = TTLop.MaCa.ToString();
            txtPhong.Text = TTLop.MaPhong.ToString();

            flpSVChuaHoc.Controls.Clear();
            List<ft_ThongTinSVChuaHocResult> ttsv = svBLL.LayDSSVChuaHoc(MaLop);
            foreach(ft_ThongTinSVChuaHocResult t in ttsv)
            {
                UCSVChuaHoc uc = new UCSVChuaHoc(t, MaLop, FillSV);
                flpSVChuaHoc.Controls.Add(uc);
            }
        }
    }
}