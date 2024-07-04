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
using System.Windows.Forms.DataVisualization.Charting;

namespace QLDiemSV.UI.Student
{
    public partial class UCThongKeDiemSV : UserControl
    {
        SinhVienBLL svBLL = new SinhVienBLL();
        LopBLL lopBLL = new LopBLL();
        SINHVIEN sv;
        public UCThongKeDiemSV(SINHVIEN sinhvien)
        {
            InitializeComponent();
            sv = sinhvien;
            
        }

        private void gunaChart1_Load(object sender, EventArgs e)
        {
            List<ft_ThongKeSVResult> list = svBLL.ThongKeSV(sv.MaSV);
            int dau = 0;
            int rot = 0;
            if (list.Count > 0)
            {
                foreach (ft_ThongKeSVResult point in list)
                {
                    if (point.TB != null)
                    {
                        DiemTheoKy.DataPoints.Add("HK " + point.HK.ToString() +
                            "/" + point.Namhoc.ToString()
                             , (double)point.TB);
                        DiemCanhBao.DataPoints.Add("HK " + point.HK.ToString() +
                            "/" + point.Namhoc.ToString(), 5);
                        List<ft_ThongTinLopTheoHSResult> listDiemTheoLop = lopBLL.FindByID_HK_NHvi(sv.MaSV, point.HK, point.Namhoc);
                        if (listDiemTheoLop.Count > 0)
                            foreach (ft_ThongTinLopTheoHSResult diem in listDiemTheoLop)
                            {
                                if ("✔".Equals(diem.QUAMON)) dau++;
                                if ("✘".Equals(diem.QUAMON)) rot++;
                            }
                    }
           

                }
                gunaChart1.YAxes.Ticks.HasMaximum = true;
                gvThongTin.DataSource = DiemTheoKy.DataPoints;

                var Daurot = new Guna.Charts.WinForms.GunaPieDataset();
                Daurot.DataPoints.Add("Số môn đậu", dau);
                Daurot.DataPoints.Add("Số môn rớt", rot);

                gunaChart2.Legend.Display = false;
                gunaChart2.XAxes.Display = false;
                gunaChart2.YAxes.Display = false;
                gunaChart2.Datasets.Add(Daurot);
                gunaChart2.Update();
                guna2DataGridView1.DataSource = Daurot.DataPoints;
            }

            

        }

        private void guna2DataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void gunaChart2_Load_1(object sender, EventArgs e)
        {

        }
    }
}
