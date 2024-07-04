using QLDiemSV.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLDiemSV.UI
{
    public partial class FQuenMatKhau : Form
    {
        QLSinhVienDataContext db = new QLSinhVienDataContext();
        public FQuenMatKhau()
        {
            InitializeComponent();
        }

        private void btnDoi_Click(object sender, EventArgs e)
        {
            string mkmoi = txtMKM.Text;
            string tk = txttendn.Text;
            string email = txtEmail.Text;
            string cccd = txtCMND.Text;
            int loai = radGV.Checked ? 2 : radHV.Checked ? 1 : -1;
            if (loai != -1 && radGV.Checked && (bool)db.ft_ChkQuenMatKhau(tk,email,cccd,loai))
            {
                TAIKHOAN taikhoan = new TAIKHOAN();
                taikhoan.TaiKhoan1 = tk;
                taikhoan.MatKhau = mkmoi;
                taikhoan.Loai = loai;
                db.pr_UpdateTaiKhoan(tk, mkmoi, loai);
                //FrmMessageBox frmMessageBox = new FrmMessageBox("The password has been successfully changed", "ANNOUNCEMENT");
                //DialogResult result = frmMessageBox.ShowDialog();
                FMessageBox.Show("Cập nhật thành công");
                this.Close();
            }
            else
            {
                //FrmMessageBox frmMessageBox = new FrmMessageBox("The information is not valid", "WARNING");
                //DialogResult result = frmMessageBox.ShowDialog();
                FMessageBox.Show("thông tin không đúng");
            }
        }
    }
}
