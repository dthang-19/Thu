<%@ Page Title="Đăng nhập"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="Demo_btl_10_10.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .login-page {
            min-height: 70vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 16px;
            background: #f5f7fb;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 32px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
        }

        .login-card h2 {
            margin: 0 0 8px;
            text-align: center;
            color: #222;
        }

        .login-subtitle {
            margin-bottom: 28px;
            text-align: center;
            color: #777;
        }

        .login-group {
            margin-bottom: 18px;
        }

        .login-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .login-input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d5d9df;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .login-input:focus {
            outline: none;
            border-color: #2563eb;
        }

        .login-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #1d4ed8;
        }

        .login-message {
            display: block;
            margin-top: 16px;
            text-align: center;
        }

        .login-links {
            margin-top: 20px;
            text-align: center;
        }

        .login-links a {
            color: #2563eb;
            text-decoration: none;
        }

        .login-error {
            color: #dc2626;
        }
    </style>

    <div class="login-page">
        <div class="login-card">
            <h2>Đăng nhập</h2>
            <p class="login-subtitle">Chào mừng bạn đến với MyShop</p>

            <div class="login-group">
                <label for="<%= txtUsername.ClientID %>">
                    Tên đăng nhập
                </label>

                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="login-input"
                    placeholder="Nhập tên đăng nhập" />

                <asp:RequiredFieldValidator ID="valUsername"
                    runat="server"
                    ControlToValidate="txtUsername"
                    ErrorMessage="Vui lòng nhập tên đăng nhập."
                    CssClass="login-error"
                    Display="Dynamic"
                    ValidationGroup="Login" />
            </div>

            <div class="login-group">
                <label for="<%= txtPassword.ClientID %>">
                    Mật khẩu
                </label>

                <asp:TextBox ID="txtPassword" runat="server"
                    TextMode="Password"
                    CssClass="login-input"
                    placeholder="Nhập mật khẩu" />

                <asp:RequiredFieldValidator ID="valPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Vui lòng nhập mật khẩu."
                    CssClass="login-error"
                    Display="Dynamic"
                    ValidationGroup="Login" />
            </div>

            <asp:Button ID="btnLogin" runat="server"
                Text="Đăng nhập"
                CssClass="login-btn"
                ValidationGroup="Login"
                OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server"
                CssClass="login-message" />

            <div class="login-links">
                Chưa có tài khoản?
                <a href="Signup.aspx">Đăng ký ngay</a>
            </div>
        </div>
    </div>

</asp:Content>