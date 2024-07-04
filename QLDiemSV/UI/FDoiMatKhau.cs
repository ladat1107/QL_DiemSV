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
    public partial class FDoiMatKhau : Form
    {
        TaiKhoanBLL tkBLL = new TaiKhoanBLL();
        public FDoiMatKhau()
        {
            InitializeComponent();
        }

        private void btnDoi_Click(object sender, EventArgs e)
        {
            string mkcu = txtMKCu.Text;
            string mkmoi = txtMKmoi.Text;
            string mkxacnhan = txtMKXN.Text;
            if(tkBLL.DoiMatKhau(mkcu, mkmoi, mkxacnhan))
                this.Close();
            
        }
    }
}
