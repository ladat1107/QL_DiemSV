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
    internal class BuoiHocBLL
    {
        QLSinhVienDataContext db;
        public BuoiHocBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public void InsertBuoiHoc(BUOIHOC bh)
        {
            try
            {
                db.pr_InsertBuoiHoc(bh.MaLop, bh.MaCa, bh.MaPhong, bh.Thu);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void UpdateBuoiHoc(BUOIHOC bhUpdate)
        {
            try
            {
                db.pr_UpdateBuoiHoc(bhUpdate.MaLop, bhUpdate.MaCa, bhUpdate.MaPhong, bhUpdate.Thu);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void DeleteBuoiHoc(BUOIHOC bhDelete)
        {
            try
            {
                db.pr_DeleteBuoiHoc(bhDelete.MaLop, bhDelete.MaCa, bhDelete.MaPhong, bhDelete.Thu);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public List<BUOIHOC> FindAllBuoiHoc()
        {
            return db.BUOIHOCs.ToList();
        }

        public List<vi_LopCaPhong> FindThongTinLop()
        {
            return db.vi_LopCaPhongs.ToList();
        }
    }
}
