<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <h1 class="page-title">Giỏ hàng</h1>

        <!-- Có sản phẩm: các dòng trong cartBody do shop.js điền -->
        <div class="cart-layout" id="cartFilled">
            <div class="cart-table-wrap">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="cartBody"></tbody>
                </table>
            </div>

            <aside class="cart-summary">
                <h2>Tóm tắt đơn hàng</h2>
                <div class="summary-row"><span>Tạm tính</span><span id="sumSub">0đ</span></div>
                <div class="summary-row"><span>Vận chuyển</span><span>Miễn phí</span></div>
                <div class="summary-row summary-total"><span>Tổng cộng</span><span id="sumTotal">0đ</span></div>
                <button type="button" class="btn" id="btnCheckout">Thanh toán</button>
            </aside>
        </div>

        <!-- Giỏ trống -->
        <div class="cart-empty" id="cartEmpty">
            <p>Giỏ hàng của bạn đang trống.</p>
            <a class="btn" href="Products.aspx">Tiếp tục mua sắm</a>
        </div>
    </div>

</asp:Content>
