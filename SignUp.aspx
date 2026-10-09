
<%@ Page Title="Đăng ký tài khoản" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Signup.aspx.cs"
    Inherits="Demo_btl_10_10.Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .signup-container {
            max-width: 480px;
            margin: 50px auto;
            padding: 35px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,.08);
        }

        .signup-title {
            text-align: center;
            font-size: 28px;
            margin-bottom: 8px;
            color: #222;
        }

        .signup-subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 28px;
        }

        .signup-field {
            margin-bottom: 18px;
        }

        .signup-field label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
        }

        .signup-input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
        }

        .signup-input:focus {
            outline: none;
            border-color: #2563eb;
        }

        .signup-button {
            width: 100%;
            padding: 13px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .signup-button:hover {
            background: #1d4ed8;
        }

        .signup-login {
            text-align: center;
            margin-top: 20px;
        }

        .signup-login a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-message {
            display: block;
            margin-top: 15px;
        }

        @media (max-width: 600px) {
            .signup-container {
                margin: 25px 15px;
                padding: 25px 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="signup-container">
            <h1 class="signup-title">Tạo tài khoản</h1>
            <p class="signup-subtitle">
                Đăng ký để trải nghiệm mua sắm tại MyShop
            </p>

            <asp:ValidationSummary ID="ValidationSummary1"
                runat="server"
                ForeColor="Red"
                HeaderText="Vui lòng kiểm tra lại:"
                ValidationGroup="Signup" />

            <div class="signup-field">
                <label for="<%= txtFullName.ClientID %>">Họ và tên</label>
                <asp:TextBox ID="txtFullName" runat="server"
                    CssClass="signup-input"
                    MaxLength="100"
                    placeholder="Nhập họ và tên" />
                <asp:RequiredFieldValidator ID="valFullName"
                    runat="server"
                    ControlToValidate="txtFullName"
                    ErrorMessage="Vui lòng nhập họ và tên."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="signup-field">
                <label for="<%= txtEmail.ClientID %>">Email</label>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="signup-input"
                    TextMode="Email"
                    MaxLength="254"
                    placeholder="example@email.com" />
                <asp:RequiredFieldValidator ID="valEmailRequired"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Vui lòng nhập email."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="valEmailFormat"
                    runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Email không hợp lệ."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="signup-field">
                <label for="<%= txtUsername.ClientID %>">Tên đăng nhập</label>
                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="signup-input"
                    MaxLength="50"
                    placeholder="Nhập tên đăng nhập" />
                <asp:RequiredFieldValidator ID="valUsername"
                    runat="server"
                    ControlToValidate="txtUsername"
                    ErrorMessage="Vui lòng nhập tên đăng nhập."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="signup-field">
                <label for="<%= txtPassword.ClientID %>">Mật khẩu</label>
                <asp:TextBox ID="txtPassword" runat="server"
                    CssClass="signup-input"
                    TextMode="Password"
                    MaxLength="128"
                    placeholder="Ít nhất 8 ký tự" />
                <asp:RequiredFieldValidator ID="valPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Vui lòng nhập mật khẩu."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="valPasswordLength"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ValidationExpression="^[\s\S]{8,128}$"
                    ErrorMessage="Mật khẩu phải có từ 8 đến 128 ký tự."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="signup-field">
                <label for="<%= txtConfirmPassword.ClientID %>">
                    Xác nhận mật khẩu
                </label>
                <asp:TextBox ID="txtConfirmPassword" runat="server"
                    CssClass="signup-input"
                    TextMode="Password"
                    MaxLength="128"
                    placeholder="Nhập lại mật khẩu" />
                <asp:CompareValidator ID="valConfirmPassword"
                    runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ErrorMessage="Mật khẩu xác nhận không khớp."
                    ValidationGroup="Signup"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <asp:Button ID="btnSignup" runat="server"
                Text="Đăng ký tài khoản"
                CssClass="signup-button"
                ValidationGroup="Signup"
                OnClick="btnSignup_Click" />

            <asp:Label ID="lblMessage" runat="server"
                CssClass="signup-message"
                EnableViewState="false" />

            <div class="signup-login">
                Đã có tài khoản?
                <a href="Login.aspx">Đăng nhập</a>
            </div>
        </div>
    </div>
</asp:Content>