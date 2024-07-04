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
    internal class MonTienQuyet
    {
        QLSinhVienDataContext db;
        public MonTienQuyet()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }
        public void InsertMonTienQuyet(MONTIENQUYET monTienQuyet)
        {
            try
            {
                db.PR_InsertMONTQ(monTienQuyet.MaMon, monTienQuyet.MaMonTQ);
            }
            catch (SqlException e) { 
                FMessageBox.Show(e.Message); 
            }
        }

        public void DeleteMonTienQyet(MONTIENQUYET monTienQuyet)
        {
            try
            {
                MONTIENQUYET deleteMonTienQuyet = db.MONTIENQUYETs.FirstOrDefault(e => e.Equals(monTienQuyet.MaMon) && e.Equals(monTienQuyet.MaMonTQ));
                db.PR_DeleteMONTQ(deleteMonTienQuyet.MaMon, deleteMonTienQuyet.MaMonTQ);
            }
            catch (SqlException e) 
            { 
                FMessageBox.Show(e.Message); 
            }
        }
    }
}
