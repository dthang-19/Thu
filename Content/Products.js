// Danh sách sản phẩm dùng chung cho toàn site (tìm kiếm, thẻ sản phẩm, chi tiết, giỏ hàng).
// Ảnh đặt trong thư mục Images, tên theo mẫu product{id}_{số thứ tự}.jpg
// Ảnh đầu tiên trong "images" là ảnh đại diện (hiện ở thẻ sản phẩm và giỏ hàng).
window.SHOP_CATEGORIES = {
    'leu': 'Lều cắm trại',
    'den': 'Đèn chiếu sáng',
    'ba-lo': 'Ba lô - túi',
    'thiet-bi': 'Thiết bị cắm trại',
    'xe-dap': 'Xe đạp'
};

window.SHOP_PRODUCTS = [
    {
        id: 1, name: 'Lều vòm dựng nhanh Ozark Trail 6 người', price: 3500000, old: 4800000, cat: 'leu',
        images: ['Images/sp1_1.jpg', 'Images/sp1_2.jpg', 'Images/sp1_3.jpg', 'Images/sp1_4.jpg'],
        desc: 'Lều vòm dựng nhanh với khung gập sẵn, một người cũng dựng được trong vài phút. Có cửa lưới thoáng khí, cổng luồn dây điện tiện sạc thiết bị và túi lưới đựng đồ cá nhân bên trong.',
        material: 'Vải polyester chống thấm, khung sợi thủy tinh', sizes: 'Rộng 3,0 x 2,7 m, ngủ thoải mái 6 người', status: 'Còn hàng'
    },
    {
        id: 2, name: 'Quạt cắm trại Panergy có đèn LED', price: 1800000, cat: 'thiet-bi',
        images: ['Images/sp2_1.jpg', 'Images/sp2_2.jpg', 'Images/sp2_3.jpg', 'Images/sp2_4.jpg'],
        desc: 'Quạt sạc pin dung lượng lớn kèm đèn LED viền xung quanh, có móc treo trong lều. Nhiều tốc độ gió, dùng được cả ban ngày lẫn ban đêm.',
        material: 'Nhựa ABS, pin lithium sạc lại', sizes: 'Đường kính cánh quạt 20 cm', status: 'Còn hàng'
    },
    {
        id: 3, name: 'Ba lô Ozark Trail 20,5 lít', price: 300000, old: 600000, cat: 'ba-lo',
        images: ['Images/sp3_1.jpg', 'Images/sp3_2.jpg', 'Images/sp3_3.jpg', 'Images/sp3_4.jpg'],
        desc: 'Ba lô dã ngoại 20,5 lít gọn nhẹ, dây rút chun phía trước để buộc thêm đồ, ngăn lưới hai bên đựng chai nước, quai đeo êm vai.',
        material: 'Vải polyester bền chống nước nhẹ', sizes: 'Dung tích 20,5 lít', status: 'Còn hàng'
    },
    {
        id: 4, name: 'Đèn pha đa màu Ozark Trail', price: 130000, old: 180000, cat: 'den',
        images: ['Images/sp4_1.jpg', 'Images/sp4_2.jpg', 'Images/sp4_3.jpg', 'Images/sp4_4.jpg'],
        desc: 'Đèn đeo đầu nhỏ gọn, nhiều chế độ sáng và nhiều màu ánh sáng. Dây đeo co giãn, chỉnh được góc chiếu, phù hợp đi bộ đêm, dựng lều và sửa chữa.',
        material: 'Nhựa ABS, dây đeo thun dệt', sizes: 'Free size, dùng 3 pin AAA', status: 'Còn hàng'
    },
    {
        id: 5, name: 'Đèn pin LED Ozark Trail 420', price: 250000, old: 600000, cat: 'den',
        images: ['Images/sp5_1.jpg', 'Images/sp5_2.jpg', 'Images/sp5_3.jpg', 'Images/sp5_4.jpg'],
        desc: 'Đèn pin LED 420 lumen, vặn đầu để thu phóng chùm sáng. Thân nhôm chắc chắn, chống nước bắn, cầm gọn trong tay.',
        material: 'Nhôm hợp kim', sizes: 'Dài 14 cm, 420 lumen', status: 'Còn hàng'
    },
    {
        id: 6, name: 'Lều vòm cắm trại 3 người Alpha Camp', price: 3800000, cat: 'leu',
        images: ['Images/sp6_1.jpg', 'Images/sp6_2.jpg', 'Images/sp6_3.jpg', 'Images/sp6_4.jpg'],
        desc: 'Lều vòm 2 lớp cho 3 người, cửa sổ lưới thông gió, lớp ngoài chống nước. Gọn nhẹ, dễ dựng và dễ mang theo khi đi dã ngoại.',
        material: 'Vải polyester 190T chống thấm, khung sợi thủy tinh', sizes: 'Rộng 2,1 x 2,1 m, cho 3 người', status: 'Còn hàng'
    },
    {
        id: 7, name: 'Xe đạp leo núi 6 tốc độ', price: 1800000, cat: 'xe-dap',
        images: ['Images/sp7_1.jpg', 'Images/sp7_2.jpg', 'Images/sp7_3.jpg', 'Images/sp7_4.jpg'],
        desc: 'Xe đạp leo núi cỡ nhỏ 6 tốc độ, lốp địa hình bám đường tốt, khung thép chắc chắn. Phù hợp thiếu niên đạp quanh khu cắm trại hay đường đất.',
        material: 'Khung thép, lốp địa hình', sizes: 'Bánh 20 inch', status: 'Còn hàng'
    },
    {
        id: 8, name: 'Xe đạp leo núi dành cho người lớn', price: 4000000, old: 6000000, cat: 'xe-dap',
        images: ['Images/sp8_1.jpg', 'Images/sp8_2.jpg', 'Images/sp8_3.jpg', 'Images/sp8_4.jpg'],
        desc: 'Xe đạp leo núi người lớn với phuộc giảm xóc trước, phanh đĩa và bộ truyền động nhiều tốc độ. Chạy êm trên đường đồi dốc và đường mòn.',
        material: 'Khung hợp kim nhôm, phanh đĩa', sizes: 'Bánh 26 inch', status: 'Còn hàng'
    }
];