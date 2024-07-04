using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLDiemSV.BLL
{
    internal class LoaiPhongBLL
    {
        QLSinhVienDataContext db;
        public LoaiPhongBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<LOAIPHONG> FindAll()
        {
            return db.LOAIPHONGs.ToList();
        }

        public LOAIPHONG FindByID(string maLoaiPhong)
        {
            return db.LOAIPHONGs.FirstOrDefault(lp => lp.MaLoaiPhong.Equals(maLoaiPhong));
        }
    }
}
