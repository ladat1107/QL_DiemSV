using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI.Student
{
    public partial class UCChiTietTKBSV : UserControl
    {
        public UCChiTietTKBSV(ft_TKBSVTheoHKResult tkb)
        {
            InitializeComponent();
            lblGV.Text = tkb.TenGV;
            lblMonHoc.Text = tkb.TenMon;
            lblPhong.Text = tkb.Toa + tkb.MaPhong;
            lblTG.Text = tkb.TGBatDau.ToString(@"hh\:mm") + " -> " + tkb.TGKetThuc.ToString(@"hh\:mm");
        }
    }
}
