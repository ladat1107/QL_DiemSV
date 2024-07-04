using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV
{
    internal class KhoaBLL
    {
        QLSinhVienDataContext db;
        public KhoaBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public void InsertKhoa(KHOA khoa)
        {
            try
            {
                db.pr_InsertKhoa(khoa.MaKhoa, khoa.TenKhoa, khoa.MaTrKhoa, khoa.TrangThai);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void UpdateKhoa(KHOA khoa)
        {
            try
            {
                db.pr_UpdateKhoa(khoa.MaKhoa, khoa.TenKhoa, khoa.MaTrKhoa, khoa.TrangThai);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void DeleteKhoa(string maKhoa)
        {
            try
            {
                db.pr_DeleteKhoa(maKhoa);
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public List<KHOA> FindAllKhoa()
        {
            return db.KHOAs.ToList();
        }
        public KHOA FindOneByID(string maKhoa)
        {
            return db.KHOAs.FirstOrDefault(e => e.MaKhoa.Equals(maKhoa));
        }

        
    }
}
