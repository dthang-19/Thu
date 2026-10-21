<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Demo_btl_10_10._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <section class="banner">
            <img src="Images/banner1.jpg" alt="Khuyến mãi" />
        </section>

        <h2 class="section-title">Sản phẩm nổi bật</h2>
        <div class="p-grid" data-first="4"></div>

        <h2 class="section-title">Ưu đãi trong tuần</h2>
        <div class="p-grid" data-latest="4"></div>

    </div>

</asp:Content>
