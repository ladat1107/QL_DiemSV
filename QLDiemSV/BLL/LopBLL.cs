using QLDiemSV.UI;
using QLDiemSV.UI.Teacher;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.BLL
{
    internal class LopBLL
    {
        QLSinhVienDataContext db;
        public LopBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<LOP> FindAllLop()
        {
            try
            {                
                return db.LOPs.ToList();
            } catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
                return null;
            }
        }

        public LOP FindByID(string maLop)
        {            
            return db.LOPs.FirstOrDefault(e=>e.Equals(maLop));
        }

        public List<vi_ThongTinLop> FindAllThongTinLop()
        {            
            return db.vi_ThongTinLops.ToList();
        }

        public void InsertLop(LOP lop, BUOIHOC buoiHoc)
        {            
            try
            {
                db.pr_InsertLop(lop.TenLop, lop.MaLoaiLop, lop.SL, lop.HK, lop.Namhoc, lop.MaGV, lop.MaMon, buoiHoc.MaCa, buoiHoc.MaPhong, buoiHoc.Thu);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }

        public void UpdateLop(LOP lop)
        {            
            try
            {
                LOP updateLop = db.LOPs.FirstOrDefault(e => e.MaLop.Equals(lop.MaLop));
                db.PR_UpdateLOP(updateLop.MaLop, updateLop.TenLop, updateLop.MaLoaiLop, updateLop.SL, updateLop.HK, updateLop.Namhoc, updateLop.MaGV, updateLop.MaMon);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }

        public void DeleteLop(string maLop)
        {            
            try
            {
                LOP deleteLop = db.LOPs.FirstOrDefault(e => e.MaLop.Equals(maLop));
                db.PR_DeleteLOP(deleteLop.MaLop);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public List<ft_ThongTinLopTheoHSResult> FindByID_HK_NHvi(string maSV, int hk, int nh)
        {            
            return db.ft_ThongTinLopTheoHS(maSV,hk,nh).ToList();
        }

        public List<ft_TimTTLopTheoIDResult> FindThongTinLopByID(string maLop)
        {
            return db.ft_TimTTLopTheoID(maLop).ToList();
        }
    }
}
