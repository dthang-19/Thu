<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Demo_btl_10_10._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <section class="banner">
            <img src="Images/banner1.jpg" alt="Khuyến mãi" />
        </section>

        <h2 class="section-title">Sản phẩm nổi bật</h2>
        <div class="p-grid" data-ids="1,2,3,4"></div>

        <h2 class="section-title">Ưu đãi trong tuần</h2>
        <div class="p-grid" data-ids="5,6,7,8"></div>

    </div>

</asp:Content>
