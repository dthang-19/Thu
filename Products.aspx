<%@ Page Title="Sản phẩm" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container shop-layout">

        <aside>
            <div class="side-box">
                <h2 class="side-title">Danh mục sản phẩm</h2>
                <ul class="cat-list">
                    <li><a href="Products.aspx" data-cat="">Tất cả sản phẩm</a></li>
                    <li><a href="Products.aspx?loai=leu" data-cat="leu">Lều cắm trại</a></li>
                    <li><a href="Products.aspx?loai=den" data-cat="den">Đèn chiếu sáng</a></li>
                    <li><a href="Products.aspx?loai=ba-lo" data-cat="ba-lo">Ba lô - túi</a></li>
                    <li><a href="Products.aspx?loai=thiet-bi" data-cat="thiet-bi">Thiết bị cắm trại</a></li>
                    <li><a href="Products.aspx?loai=xe-dap" data-cat="xe-dap">Xe đạp</a></li>
                </ul>
            </div>

            <div class="side-box">
                <h2 class="side-title">Bộ lọc sản phẩm</h2>
                <details class="filter-group">
                    <summary>Chọn mức giá</summary>
                    <ul class="filter-options">
                        <li><label><input type="radio" name="gia" data-gia="" /> Tất cả mức giá</label></li>
                        <li><label><input type="radio" name="gia" data-gia="duoi-500" /> Dưới 500.000đ</label></li>
                        <li><label><input type="radio" name="gia" data-gia="500-2000" /> 500.000đ - 2.000.000đ</label></li>
                        <li><label><input type="radio" name="gia" data-gia="tren-2000" /> Trên 2.000.000đ</label></li>
                    </ul>
                </details>
            </div>
        </aside>

        <section>
            <div class="shop-toolbar">
                <div class="sort">
                    <span>Sắp xếp:</span>
                    <div class="sort-dropdown">
                        <button type="button" class="sort-toggle">Mặc định</button>
                        <div class="sort-menu">
                            <a href="Products.aspx?sort=default" class="active">Mặc định</a>
                            <a href="Products.aspx?sort=az">A → Z</a>
                            <a href="Products.aspx?sort=za">Z → A</a>
                            <a href="Products.aspx?sort=gia-tang">Giá tăng dần</a>
                            <a href="Products.aspx?sort=gia-giam">Giá giảm dần</a>
                            <a href="Products.aspx?sort=moi-nhat">Hàng mới nhất</a>
                            <a href="Products.aspx?sort=cu-nhat">Hàng cũ nhất</a>
                        </div>
                    </div>
                </div>
            </div>

            <p class="result-info" id="resultInfo"></p>
            <div class="p-grid" id="productGrid"></div>
            <p class="no-result" id="noResult">Không tìm thấy sản phẩm phù hợp. <a href="Products.aspx">Xem tất cả sản phẩm</a></p>
        </section>

    </div>

</asp:Content>