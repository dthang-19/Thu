using System;
using System.Drawing;
using System.Web.UI;

namespace Demo_btl_10_10
{
    public partial class Signup : Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            // Kiểm tra dữ liệu nhập vào
            Page.Validate("Signup");

            if (!Page.IsValid)
            {
                return;
            }

            // Lấy thông tin người dùng nhập
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();

            // Website minh họa: không lưu dữ liệu,
            // không tạo tài khoản và không kết nối database.
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text =
                "Đăng ký thành công! Xin chào " +
                Server.HtmlEncode(fullName);

            // Xóa dữ liệu nhạy cảm sau khi xử lý
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
        }
    }
}
