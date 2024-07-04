using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLDiemSV.BLL
{
    internal class PhongHocBLL
    {
        QLSinhVienDataContext db;
        public PhongHocBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<PHONGHOC> FindAll()
        {
            return db.PHONGHOCs.ToList();
        }
        public PHONGHOC FindByID(String maPhong)
        {
            return db.PHONGHOCs.FirstOrDefault(ph => ph.MaPhong.Equals(maPhong));
        }
    }
}
