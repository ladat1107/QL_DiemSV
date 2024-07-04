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
    public partial class FMessageBox : Form
    {
        public FMessageBox(string tb, string tit)
        {
            InitializeComponent();
            lblTitle.Text = tit;
            lblNd.Text = tb;
            if (tit == "ANNOUNCEMENT")
                pbIcon.Image = Properties.Resources.information;
            else if (tit == "CONFIRM")
                pbIcon.Image = Properties.Resources.question;
            else
                pbIcon.Image = Properties.Resources.warning;
        }
        private void btnYes_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }
        private void btnNo_Click(object sender, EventArgs e)
        {
            Close();
        }
        public static void Show(string mess,string tit)
        {
            FMessageBox frmMessageBox = new FMessageBox(mess, tit);
            frmMessageBox.ShowDialog();
        }

        public static void Show(string mess)
        {
            FMessageBox frmMessageBox = new FMessageBox(mess, "ANNOUNCEMENT");
            frmMessageBox.ShowDialog();
        }
    }
}
