using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.BLL
{
    internal class DiemBLL
    {
        QLSinhVienDataContext db;
        public DiemBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public void InsertDiem(DIEM diem)
        {
            try
            {
                db.pr_InsertDiem(diem.MaSV,diem.MaLop,diem.DiemQT,diem.DiemCK);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void UpdateDiem(DIEM diemUpdate)
        {
            try
            {
                db.pr_UpdateDiem(diemUpdate.MaSV,diemUpdate.MaLop,diemUpdate.DiemQT,diemUpdate.DiemCK);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void DeleteDiem(DIEM diemDelete)
        {
            try
            {
                db.pr_DeleteDiem(diemDelete.MaSV, diemDelete.MaLop);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public List<DIEM> FindAllDiem()
        {
            return db.DIEMs.ToList();
        }

        public DIEM FindDiemByID(string maSV, string maLop)
        {
            return db.DIEMs.FirstOrDefault(e => e.MaSV.Equals(maSV) && e.MaLop.Equals(maLop));
        }

        public List<vi_DiemSVTheoLop> FindDiemSVTheoLop()
        {
            return db.vi_DiemSVTheoLops.ToList();
        }

        public List<vi_DiemSVTheoMon> FindDiemSVTheoMon()
        {
            return db.vi_DiemSVTheoMons.ToList();
        }
        public double TinhDiemTBTichLuy(string maSV)
        {
            decimal? diem = db.ft_TinhTBTL(maSV);
            return (double)(diem.HasValue ? diem.Value : 0);
        }

        public List<ft_FindDiemSVTheoLopResult> FindDiemSVTheoMaLop (string maLop)
        {
            return db.ft_FindDiemSVTheoLop(maLop).ToList();
        }
    }

}
