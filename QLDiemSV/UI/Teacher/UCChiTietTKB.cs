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
    public partial class UCChiTietTKB : UserControl
    {
        public UCChiTietTKB(ft_TKBLopGVDangDayResult tkb)
        {
            InitializeComponent();            
            lblMonHoc.Text = tkb.TenMon;
            lblPhong.Text = tkb.MaPhong + " "+ tkb.Toa;
            lblTG.Text = tkb.TGBatDau.ToString(@"hh\:mm") + " -> " + tkb.TGKetThuc.ToString(@"hh\:mm");
        }
    }
}
