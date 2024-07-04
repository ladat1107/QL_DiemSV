using QLDiemSV.UI;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace QLDiemSV.BLL
{
    internal class SinhVienBLL
    {
        QLSinhVienDataContext db;
        public SinhVienBLL()
        {
            string conn = "Data Source = (localdb)\\mssqllocaldb; Initial Catalog = QLDiemSV;" +
                "User Id=" + FDangNhap.taikhoan + ";Password= " + FDangNhap.matkhau + ";";
            db = new QLSinhVienDataContext(conn);
        }

        public void Insert(SINHVIEN sv)
        {
            try
            {
                db.pr_InsertSinhVien(sv.HoSV,sv.TenlotSV,sv.TenSV,sv.CCCD,sv.DiaChi,sv.Gioitinh, sv.NgaySinh, sv.SDT,sv.Email, sv.NamNhapHoc, sv.MaKhoa,null,true);
               
            }
            catch (SqlException ex)
            {
                FMessageBox.Show(ex.ToString());
            }
        }
        public void Update(SINHVIEN sv)
        {
            try
            {
                db.pr_UpdateSinhVien(sv.MaSV,sv.HoSV,sv.TenlotSV,sv.TenSV,sv.CCCD,sv.DiaChi,sv.Gioitinh,sv.NgaySinh,sv.SDT,sv.Email,sv.NamNhapHoc,sv.MaKhoa,sv.TaiKhoan,sv.TrangThai);
                
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public void Delete(SINHVIEN sv)
        {
            try
            {
                db.pr_DeleteSinhVien(sv.MaSV);
               
            }
            catch (SqlException e)
            {
                FMessageBox.Show(e.Message);
            }
        }
        public SINHVIEN FindByID(string id)
        {
            return db.SINHVIENs.FirstOrDefault(e => e.MaSV.Equals(id));
        }
        public List<SINHVIEN> FindAll()
        {
            return db.SINHVIENs.ToList();
        }

            public List<ft_TimSVTheoKhoaResult> FindSinhVienbyKhoa(string maKhoa)
            {
                return db.ft_TimSVTheoKhoa(maKhoa).ToList();
            }

        public List<vi_ThongTinSV> FindAllThongTinSV()
        {
            return db.vi_ThongTinSVs.ToList();
        }

        public List<ft_LayDanhSachLopSinhVienDaHocCoDiemResult> FindLopSVHoc(string maSV)
        {
            return db.ft_LayDanhSachLopSinhVienDaHocCoDiem(maSV).ToList();
        }
        public vi_ThongTinSV FindByIDvi(string id)
        {
            return db.vi_ThongTinSVs.FirstOrDefault(e => e.MaSV.Equals(id));
        }
        public List<ft_TKBSVTheoHKResult> LayTKB(string maSV, int hk, int nam)
        {
            return db.ft_TKBSVTheoHK(maSV, hk, nam).ToList();
        }

        public List<ft_ThongTinSVChuaHocResult> LayDSSVChuaHoc(string maLop)
        {
            return db.ft_ThongTinSVChuaHoc(maLop).ToList();
        }

        public List<ft_ThongKeSVResult> ThongKeSV(string maSV)
        {
            return db.ft_ThongKeSV(maSV).ToList();
        }
    }
}
