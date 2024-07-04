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
    internal class TaiKhoanBLL
    {
        QLSinhVienDataContext db;
        public TaiKhoanBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<TAIKHOAN> FindAll()
        {
            return db.TAIKHOANs.ToList();
        }

        public TAIKHOAN FindByID(string taikhoan)
        {
            return db.TAIKHOANs.FirstOrDefault(tk => tk.TaiKhoan1.Equals(taikhoan));
        }

        public List<vi_taikhoangiangvien> FindTKGV()
        {
            return db.vi_taikhoangiangviens.ToList();
        }

        public List<vi_taikhoansinhvien> FindTKSV()
        {
            return db.vi_taikhoansinhviens.ToList();
        }

        public void Insert(TAIKHOAN taikhoan)
        {
            try
            {
                db.TAIKHOANs.InsertOnSubmit(taikhoan);
                db.SubmitChanges();
            }
            catch (SqlException e) 
            {
                FMessageBox.Show(e.Message);
            }
        }

        public void Update(TAIKHOAN taikhoan)
        {
            try
            {
                TAIKHOAN uptaikhoan = db.TAIKHOANs.FirstOrDefault(tk => tk.TaiKhoan1.Equals(taikhoan.TaiKhoan1));
                uptaikhoan.MatKhau = taikhoan.MatKhau;
                db.SubmitChanges();
            }
            catch (SqlException e) 
            {
                FMessageBox.Show(e.Message); 
            }
        }

        public void Delete(string taikhoan)
        {
            try
            {
                TAIKHOAN deltaikhoan = db.TAIKHOANs.FirstOrDefault(tk => tk.TaiKhoan1.Equals(taikhoan));
                db.TAIKHOANs.DeleteOnSubmit(deltaikhoan);
                db.SubmitChanges();
            }
            catch (SqlException e) 
            {
                FMessageBox.Show(e.Message);
            }
        }

        public bool DoiMatKhau(string mkcu, string mkmoi, string mkxacnhan)
        {
            try
            {
                db.pr_DoiMK(mkcu,mkmoi,mkxacnhan);
                FDangNhap.matkhau = mkxacnhan;
                return true;
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
                return false;
            }
        }
    }
}
