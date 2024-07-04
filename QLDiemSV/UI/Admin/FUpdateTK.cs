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

namespace QLDiemSV.UI.Admin
{
    public partial class FUpdateTK : Form
    {
        TaiKhoanBLL tkBLL = new TaiKhoanBLL();
        string taiKhoan;
        public FUpdateTK(string taiKhoan)
        {
            InitializeComponent();
            this.taiKhoan = taiKhoan;
        }

        private void btnChinhSua_Click(object sender, EventArgs e)
        {
            bool result = string.Equals(txtMK.Text, txtMK2.Text, StringComparison.Ordinal);
            if (result)
            {
                if(chkRobot.Checked)
                {
                    TAIKHOAN tk = tkBLL.FindByID(taiKhoan);
                    tk.TaiKhoan1 = taiKhoan;
                    tk.MatKhau = txtMK.Text;
                    tkBLL.Update(tk);
                }
                else
                {
                    FMessageBox.Show("Bạn là robot!!");
                }
            }
            else
            {
                FMessageBox.Show("Nhập lại mật khẩu!!");
            }
        }

        private void FInsertTK_Load(object sender, EventArgs e)
        {
            txtTK.Text = taiKhoan;
        }
    }
}
