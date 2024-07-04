using QLDiemSV.BLL;
using QLDiemSV.UI.Student;
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
    public partial class UCThoiKhoaBieuGV : UserControl
    {
        GiangVienBLL gvBLL = new GiangVienBLL();
        DateTime today = DateTime.Today;
        GIANGVIEN giangVien = new GIANGVIEN();
        int hk = 1;
        List<ft_TKBLopGVDangDayResult> listTKB = new List<ft_TKBLopGVDangDayResult>();
        int flag = 0;
        public UCThoiKhoaBieuGV(GIANGVIEN gv)
        {
            InitializeComponent();
            giangVien = gv;
            if (today.Month > 0 && today.Month < 8) hk = 2;
            else hk = 1;
            lblHK.Text = hk.ToString();
            lblNam.Text = today.Year.ToString();
            
              
        }

        private void UCThoiKhoaBieuGV_Load(object sender, EventArgs e)
        {
            HienTKB();
        }
        public void HienTKB()
        {
            flpTBK.Controls.Clear();
            listTKB = gvBLL.GetTKBGV(giangVien.MaGV, hk, today.Year);

            for (int j = 1; j < 8; j++)
            {
                for (int i = 2; i < 8; i++)
                {
                    flag = 0;
                    foreach (ft_TKBLopGVDangDayResult tkb in listTKB)
                    {
                        if (tkb.MaCa.Equals(j.ToString()) && tkb.Thu == i)
                        {
                            flag = 1;
                            UCChiTietTKB uCChiTietTKB = new UCChiTietTKB(tkb);
                            flpTBK.Controls.Add(uCChiTietTKB);
                            break;
                        }
                    }
                    if (flag == 0)
                    {
                        UCTKBBlank uCTKB = new UCTKBBlank();
                        flpTBK.Controls.Add(uCTKB);
                    }
                }
            }
        }
    }
}
