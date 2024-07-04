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
    internal class CaHocBLL
    {
        QLSinhVienDataContext db;
        public CaHocBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public List<CAHOC> FindAllCaHoc()
        {
            return db.CAHOCs.ToList();
        }
        public CAHOC FindByID(string maCaHoc)
        {
            return db.CAHOCs.FirstOrDefault(e => e.Equals(maCaHoc));
        }  
    }
}
