using Guna.UI2.AnimatorNS;
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

namespace QLDiemSV.UI.Student
{
    public partial class UCThoiKhoaBieuSV : UserControl
    {
        SinhVienBLL svBLL = new SinhVienBLL();
        DateTime today = DateTime.Today;
        SINHVIEN sinhVien = new SINHVIEN();
        int hk = 1;
        List<ft_TKBSVTheoHKResult> listTKB = new List<ft_TKBSVTheoHKResult>();
        int flag = 0;
        public UCThoiKhoaBieuSV(SINHVIEN sv)
        {
            InitializeComponent();
            sinhVien = sv;
            for (int i = sinhVien.NamNhapHoc; i < sinhVien.NamNhapHoc + 4; i++)
                cmbNH.Items.Add(i.ToString());
            if (today.Month > 0 && today.Month < 8) hk = 1;
            else hk = 2;
            cmbHK.Text = hk.ToString();
            cmbNH.Text = today.Year.ToString();
        }

        private void cmbNH_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbHK.SelectedIndex != -1)
                HienTKB();
        }

        private void UCThoiKhoaBieuSV_Load(object sender, EventArgs e)
        {
           
        }
        public void HienTKB()
        {
            flpTBK.Controls.Clear();
           listTKB = svBLL.LayTKB(sinhVien.MaSV, int.Parse(cmbHK.Text), int.Parse(cmbNH.Text)); 
           
            for (int j = 1; j < 8; j++)
            {
                for (int i = 2; i < 8; i++)
                {
                    flag = 0;
                    foreach (ft_TKBSVTheoHKResult tkb in listTKB)
                    {
                        if (tkb.MaCa.Equals(j.ToString()) && tkb.Thu == i)
                        {
                            flag = 1;
                            UCChiTietTKBSV uCChiTietTKBSV = new UCChiTietTKBSV(tkb);
                            flpTBK.Controls.Add(uCChiTietTKBSV);
                            break;
                        }
                    }
                    if (flag == 0)
                    {
                        UCChiTietTKBSVBlank uCThongTinLopSVBlank = new UCChiTietTKBSVBlank();
                        flpTBK.Controls.Add(uCThongTinLopSVBlank);
                    }
                }
            }
        }

        private void cmbHK_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbNH.SelectedIndex != -1)               
            HienTKB();
        }
    }
}
