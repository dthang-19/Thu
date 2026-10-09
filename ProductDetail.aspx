<%@ Page Title="Chi tiết sản phẩm" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

        <p class="breadcrumb"><a href="Default.aspx">Trang chủ</a> / <a href="Products.aspx">Sản phẩm</a> / <span id="crumbName"></span></p>

        <!-- Nội dung được shop.js điền theo ?id= từ Content/products.js -->
        <div class="detail" id="detail">

            <div class="detail-gallery">
                <div class="detail-img">
                    <span class="badge-sale" id="dBadge">Sale</span>
                    <img id="dMainImg" src="" alt="" />
                </div>
                <!-- Ảnh phụ: bấm vào để đổi ảnh chính -->
                <div class="thumbs" id="dThumbs"></div>
            </div>

            <div class="detail-info">
                <h1 id="dName"></h1>
                <div class="p-price">
                    <span class="p-now" id="dNow"></span>
                    <span class="p-old" id="dOld"></span>
                </div>

                <p class="detail-desc" id="dDesc"></p>
                <ul class="detail-meta" id="dMeta"></ul>

                <div class="detail-actions">
                    <div class="qty">
                        <button type="button" id="qtyMinus">−</button>
                        <input type="text" id="qty" value="1" readonly />
                        <button type="button" id="qtyPlus">+</button>
                    </div>
                    <button type="button" class="btn" id="btnAdd">Thêm vào giỏ</button>
                </div>
                <p class="add-msg" id="addMsg">Đã thêm vào giỏ hàng. <a href="Cart.aspx">Xem giỏ hàng</a></p>
            </div>
        </div>

        <p class="no-result" id="detailNotFound">Không tìm thấy sản phẩm này. <a href="Products.aspx">Quay lại danh sách sản phẩm</a></p>

        <div id="relatedBlock">
            <h2 class="section-title">Sản phẩm liên quan</h2>
            <div class="p-grid" id="relatedGrid"></div>
        </div>

    </div>

</asp:Content>
