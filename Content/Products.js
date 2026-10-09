// Danh sách sản phẩm dùng chung cho toàn site (tìm kiếm, thẻ sản phẩm, chi tiết, giỏ hàng).
// Muốn thêm ảnh phụ: bỏ file vào thư mục Images rồi thêm đường dẫn vào mảng "images".
// Ảnh đầu tiên trong "images" là ảnh đại diện (hiện ở thẻ sản phẩm và giỏ hàng).
window.SHOP_CATEGORIES = {
    'quan-ao': 'Quần áo',
    'gang-tay': 'Găng tay',
    'giay-dep': 'Giày - dép',
    'mu': 'Mũ',
    'kinh': 'Kính'
};

window.SHOP_PRODUCTS = [
    {
        id: 1, name: 'Quần đùi phối lưới', price: 150000, old: 400000, cat: 'quan-ao',
        images: ['Images/product1.jpg', 'Images/product1-2.jpg', 'Images/product1-3.jpg', 'Images/product1-4.jpg'],
        desc: 'Quần đùi thể thao chất liệu lưới thoáng khí, co giãn tốt, nhanh khô. Phù hợp chạy bộ, tập gym và mặc hằng ngày.',
        material: 'Polyester lưới', sizes: 'M, L, XL', status: 'Còn hàng'
    },
    {
        id: 2, name: 'Áo phông ngắn tay có in hình thể thao', price: 200000, old: 350000, cat: 'quan-ao',
        images: ['Images/product2.jpg'],
        desc: 'Áo phông ngắn tay in hình thể thao, vải mềm mịn, thấm hút mồ hôi tốt. Dễ phối đồ, mặc thoải mái cả ngày.',
        material: 'Cotton pha', sizes: 'S, M, L, XL', status: 'Còn hàng'
    },
    {
        id: 3, name: 'Găng tay thể thao chống trượt', price: 90000, cat: 'gang-tay',
        images: ['Images/product1.jpg', 'Images/product1-2.jpg', 'Images/product1-3.jpg'],
        desc: 'Găng tay thể thao lòng bàn tay có hạt cao su chống trượt, ôm tay, thoáng khí khi tập luyện.',
        material: 'Vải thun + hạt cao su', sizes: 'M, L', status: 'Còn hàng'
    },
    {
        id: 4, name: 'Mũ lưỡi trai thời trang', price: 120000, cat: 'mu',
        images: ['Images/product2.jpg'],
        desc: 'Mũ lưỡi trai kiểu dáng trẻ trung, khóa chỉnh size phía sau, che nắng tốt khi đi chơi và vận động ngoài trời.',
        material: 'Kaki', sizes: 'Free size', status: 'Còn hàng'
    },
    {
        id: 5, name: 'Giày chạy bộ nhẹ', price: 450000, old: 690000, cat: 'giay-dep',
        images: ['Images/product1.jpg', 'Images/product1-2.jpg', 'Images/product1-3.jpg', 'Images/product1-4.jpg'],
        desc: 'Giày chạy bộ trọng lượng nhẹ, đế êm giúp giảm chấn, lưới thoáng khí. Phù hợp chạy đường dài và tập luyện hằng ngày.',
        material: 'Lưới + đế EVA', sizes: '39 - 43', status: 'Còn hàng'
    },
    {
        id: 6, name: 'Áo khoác gió nam', price: 320000, old: 450000, cat: 'quan-ao',
        images: ['Images/product2.jpg'],
        desc: 'Áo khoác gió nam chống gió, chống nước nhẹ, gấp gọn dễ mang theo. Thích hợp đi làm, đi phượt và chơi thể thao.',
        material: 'Dù chống thấm', sizes: 'M, L, XL, XXL', status: 'Còn hàng'
    },
    {
        id: 7, name: 'Quần jogger thể thao', price: 210000, old: 300000, cat: 'quan-ao',
        images: ['Images/product1.jpg', 'Images/product1-2.jpg', 'Images/product1-3.jpg'],
        desc: 'Quần jogger thể thao bo gấu, cạp thun có dây rút, co giãn bốn chiều, thoải mái khi vận động.',
        material: 'Thun poly', sizes: 'M, L, XL', status: 'Còn hàng'
    },
    {
        id: 8, name: 'Kính râm gọng tròn', price: 250000, cat: 'kinh',
        images: ['Images/product2.jpg'],
        desc: 'Kính râm gọng tròn phong cách retro, tròng chống tia UV400, gọng nhẹ đeo không bị đau mũi.',
        material: 'Gọng kim loại, tròng UV400', sizes: 'Free size', status: 'Còn hàng'
    }
];