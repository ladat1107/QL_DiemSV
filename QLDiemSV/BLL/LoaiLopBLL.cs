using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLDiemSV.BLL
{
    internal class LoaiLopBLL
    {
        QLSinhVienDataContext db;
        public LoaiLopBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<LOAILOP> FindAll()
        {
            return db.LOAILOPs.ToList();
        }

        public LOAILOP FindByID(string maLoaiLop)
        {
            return db.LOAILOPs.FirstOrDefault(ll => ll.MaLoaiLop.Equals(maLoaiLop));
        }
    }
}
