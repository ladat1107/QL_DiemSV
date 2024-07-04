using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLDiemSV.BLL
{
    internal class LoaiGVBLL
    {
        QLSinhVienDataContext db;
        public LoaiGVBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<LOAIGV> FindAll()
        {
            return db.LOAIGVs.ToList();
        }

        public LOAIGV FindByID(string maLoaiGV)
        {
            return db.LOAIGVs.FirstOrDefault(lgv => lgv.MaLoaiGV.Equals(maLoaiGV));
        }
    }
}
