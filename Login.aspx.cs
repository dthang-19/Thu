using System;
using System.Drawing;
using System.Web.UI;

namespace Demo_btl_10_10
{
    public partial class Login : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (username == "admin" && password == "admin")
            {
                lblMessage.ForeColor = Color.Green;
                lblMessage.Text = "Đăng nhập thành công!";

                Response.Redirect("~/default.aspx");
            }
            else
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Tên đăng nhập hoặc mật khẩu không đúng.";
            }
        }
    }
}