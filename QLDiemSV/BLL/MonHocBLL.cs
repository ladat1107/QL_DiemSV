using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Routing;
using System.Windows.Forms;

namespace QLDiemSV.BLL
{
    internal class MonHocBLL
    {
        QLSinhVienDataContext db;
        public MonHocBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<MONHOC> FindAllMonHoc()
        {
            return db.MONHOCs.ToList();
        }
        public MONHOC FindByID(string maMon)
        {
            return db.MONHOCs.FirstOrDefault(e => e.Equals(maMon));
        }
        public void InsertMonHoc(MONHOC monHoc)
        {
            try
            {
                db.PR_InsertMONHOC(monHoc.MaMon, monHoc.TenMon, monHoc.SoTinChi, monHoc.MaKhoa, true);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void UpdateMonHoc(MONHOC monHoc)
        {
            try
            {
                MONHOC updateMonHoc = db.MONHOCs.FirstOrDefault(e=>e.MaMon.Equals(monHoc.MaMon));
                db.PR_UpdateMONHOC(updateMonHoc.MaMon, updateMonHoc.TenMon, updateMonHoc.SoTinChi, updateMonHoc.MaKhoa, true);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }

        public void DeleteMonHoc(string maMonHoc)
        {
            try
            {
                MONHOC deleteMonHoc = db.MONHOCs.FirstOrDefault(e => e.Equals(maMonHoc));
                db.PR_DeleteMONHOC(deleteMonHoc.MaMon);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
    }
}
