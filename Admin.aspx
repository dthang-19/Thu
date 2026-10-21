<%@ Page Title="Quản trị" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Demo_btl_10_10.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <h1 class="page-title">Quản trị</h1>

        <div class="admin-tabs">
            <asp:HyperLink ID="tabProducts" runat="server" NavigateUrl="~/Admin.aspx?tab=sp" CssClass="admin-tab active">Sản phẩm</asp:HyperLink>
            <asp:HyperLink ID="tabCustomers" runat="server" NavigateUrl="~/Admin.aspx?tab=kh" CssClass="admin-tab">Khách hàng</asp:HyperLink>
        </div>

        <%-- ================= SẢN PHẨM ================= --%>
        <asp:Panel ID="pnlProducts" runat="server">

            <div class="admin-bar">
                <h2>Danh sách sản phẩm (<asp:Literal ID="litProductCount" runat="server" />)</h2>
                <asp:Button ID="btnNewProduct" runat="server" Text="+ Thêm sản phẩm" CssClass="btn" OnClick="btnNewProduct_Click" />
            </div>

            <asp:Label ID="lblProductMsg" runat="server" EnableViewState="false" />

            <asp:Panel ID="pnlProductForm" runat="server" Visible="false" CssClass="admin-form" DefaultButton="btnSaveProduct">
                <h3>
                    <asp:Literal ID="litProductFormTitle" runat="server" /></h3>
                <asp:HiddenField ID="hfProductId" runat="server" Value="0" />

                <div class="form-grid">
                    <div class="field full">
                        <label for="<%= txtPName.ClientID %>">Tên sản phẩm</label>
                        <asp:TextBox ID="txtPName" runat="server" CssClass="input" MaxLength="200" />
                    </div>
                    <div class="field">
                        <label for="<%= ddlPCat.ClientID %>">Loại sản phẩm</label>
                        <asp:DropDownList ID="ddlPCat" runat="server" CssClass="input" />
                    </div>
                    <div class="field">
                        <label for="<%= ddlPStatus.ClientID %>">Tình trạng</label>
                        <asp:DropDownList ID="ddlPStatus" runat="server" CssClass="input">
                            <asp:ListItem Text="Còn hàng" Value="Còn hàng" />
                            <asp:ListItem Text="Hết hàng" Value="Hết hàng" />
                        </asp:DropDownList>
                    </div>
                    <div class="field">
                        <label for="<%= txtPPrice.ClientID %>">Giá bán (đ)</label>
                        <asp:TextBox ID="txtPPrice" runat="server" CssClass="input" TextMode="Number" />
                    </div>
                    <div class="field">
                        <label for="<%= txtPOld.ClientID %>">Giá cũ (đ)</label>
                        <asp:TextBox ID="txtPOld" runat="server" CssClass="input" TextMode="Number" />
                        <span class="hint">Để trống nếu không giảm giá.</span>
                    </div>
                    <div class="field full">
                        <label for="<%= txtPImages.ClientID %>">Đường dẫn ảnh</label>
                        <asp:TextBox ID="txtPImages" runat="server" CssClass="input" TextMode="MultiLine" Rows="4" />
                        <span class="hint">Mỗi dòng một ảnh, ví dụ Images/sp1_1.jpg. Ảnh đầu tiên là ảnh đại diện.</span>
                    </div>
                    <div class="field full">
                        <label for="<%= txtPDesc.ClientID %>">Mô tả</label>
                        <asp:TextBox ID="txtPDesc" runat="server" CssClass="input" TextMode="MultiLine" Rows="3" />
                    </div>
                    <div class="field">
                        <label for="<%= txtPMaterial.ClientID %>">Chất liệu</label>
                        <asp:TextBox ID="txtPMaterial" runat="server" CssClass="input" MaxLength="200" />
                    </div>
                    <div class="field">
                        <label for="<%= txtPSizes.ClientID %>">Kích cỡ</label>
                        <asp:TextBox ID="txtPSizes" runat="server" CssClass="input" MaxLength="200" />
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu sản phẩm" CssClass="btn" OnClick="btnSaveProduct_Click" />
                    <asp:Button ID="btnCancelProduct" runat="server" Text="Hủy" CssClass="btn btn-ghost" OnClick="btnCancelProduct_Click" />
                </div>
            </asp:Panel>

            <div class="table-scroll">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Loại</th>
                            <th>Giá bán</th>
                            <th>Giá cũ</th>
                            <th>Tình trạng</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Id") %></td>
                                    <td>
                                        <img class="admin-thumb" src='<%#: Eval("Thumb") %>' alt="" /></td>
                                    <td><%#: Eval("Name") %></td>
                                    <td><%#: CatName(Eval("Cat")) %></td>
                                    <td><%# Money(Eval("Price")) %></td>
                                    <td><%# Money(Eval("OldPrice")) %></td>
                                    <td><%#: Eval("Status") %></td>
                                    <td class="admin-actions">
                                        <asp:LinkButton runat="server" CssClass="link-btn" CommandName="edit" CommandArgument='<%# Eval("Id") %>'>Sửa</asp:LinkButton>
                                        <asp:LinkButton runat="server" CssClass="link-btn danger" CommandName="delete" CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('Xóa sản phẩm này?');">Xóa</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </asp:Panel>

        <%-- ================= KHÁCH HÀNG ================= --%>
        <asp:Panel ID="pnlCustomers" runat="server">

            <div class="admin-bar">
                <h2>Danh sách khách hàng (<asp:Literal ID="litCustomerCount" runat="server" />)</h2>
                <asp:Button ID="btnNewCustomer" runat="server" Text="+ Thêm khách hàng" CssClass="btn" OnClick="btnNewCustomer_Click" />
            </div>

            <asp:Label ID="lblCustomerMsg" runat="server" EnableViewState="false" />

            <asp:Panel ID="pnlCustomerForm" runat="server" Visible="false" CssClass="admin-form" DefaultButton="btnSaveCustomer">
                <h3>
                    <asp:Literal ID="litCustomerFormTitle" runat="server" /></h3>
                <asp:HiddenField ID="hfCustomerId" runat="server" Value="0" />

                <div class="form-grid">
                    <div class="field">
                        <label for="<%= txtCName.ClientID %>">Họ và tên</label>
                        <asp:TextBox ID="txtCName" runat="server" CssClass="input" MaxLength="100" />
                    </div>
                    <div class="field">
                        <label for="<%= txtCEmail.ClientID %>">Email</label>
                        <asp:TextBox ID="txtCEmail" runat="server" CssClass="input" TextMode="Email" MaxLength="254" />
                    </div>
                    <div class="field">
                        <label for="<%= txtCUser.ClientID %>">Tên đăng nhập</label>
                        <asp:TextBox ID="txtCUser" runat="server" CssClass="input" MaxLength="50" />
                    </div>
                    <div class="field">
                        <label for="<%= ddlCRole.ClientID %>">Vai trò</label>
                        <asp:DropDownList ID="ddlCRole" runat="server" CssClass="input">
                            <asp:ListItem Text="Khách hàng" Value="customer" />
                            <asp:ListItem Text="Quản trị viên" Value="admin" />
                        </asp:DropDownList>
                    </div>
                    <div class="field full">
                        <label for="<%= txtCPass.ClientID %>">Mật khẩu</label>
                        <asp:TextBox ID="txtCPass" runat="server" CssClass="input" TextMode="Password" MaxLength="128" autocomplete="new-password" />
                        <span class="hint">Tối thiểu 8 ký tự. Khi sửa, để trống nếu không muốn đổi mật khẩu.</span>
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnSaveCustomer" runat="server" Text="Lưu khách hàng" CssClass="btn" OnClick="btnSaveCustomer_Click" />
                    <asp:Button ID="btnCancelCustomer" runat="server" Text="Hủy" CssClass="btn btn-ghost" OnClick="btnCancelCustomer_Click" />
                </div>
            </asp:Panel>

            <div class="table-scroll">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Tên đăng nhập</th>
                            <th>Vai trò</th>
                            <th>Ngày tạo</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptCustomers" runat="server" OnItemCommand="rptCustomers_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Id") %></td>
                                    <td><%#: Eval("FullName") %></td>
                                    <td><%#: Eval("Email") %></td>
                                    <td><%#: Eval("Username") %></td>
                                    <td><span class='<%# RoleCss(Eval("Role")) %>'><%# RoleName(Eval("Role")) %></span></td>
                                    <td><%# ((DateTime)Eval("CreatedAt")).ToString("dd/MM/yyyy HH:mm") %></td>
                                    <td class="admin-actions">
                                        <asp:LinkButton runat="server" CssClass="link-btn" CommandName="edit" CommandArgument='<%# Eval("Id") %>'>Sửa</asp:LinkButton>
                                        <asp:LinkButton runat="server" CssClass="link-btn danger" CommandName="delete" CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('Xóa khách hàng này?');">Xóa</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
