(function () {
    var KEY = 'myshop_cart';
    var PRODUCTS = window.SHOP_PRODUCTS || [];
    var CATS = window.SHOP_CATEGORIES || {};

    // ===== Tiện ích =====
    function byId(id) { return document.getElementById(id); }
    function money(n) { return n.toLocaleString('vi-VN') + 'đ'; }
    function esc(s) {
        return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;')
            .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }
    function getParam(name) {
        var m = new RegExp('[?&]' + name + '=([^&]*)').exec(location.search);
        return m ? decodeURIComponent(m[1].replace(/\+/g, ' ')) : '';
    }
    function findProduct(id) {
        for (var i = 0; i < PRODUCTS.length; i++) {
            if (String(PRODUCTS[i].id) === String(id)) return PRODUCTS[i];
        }
        return null;
    }

    // ===== Giỏ hàng (localStorage) =====
    function load() {
        try { return JSON.parse(localStorage.getItem(KEY)) || []; }
        catch (e) { return []; }
    }
    function save(cart) {
        try {
            localStorage.setItem(KEY, JSON.stringify(cart));
        } catch (e) {
            alert('Trình duyệt không cho lưu giỏ hàng (chế độ riêng tư hoặc bị chặn).');
            return false;
        }
        updateCount();
        return true;
    }
    function updateCount() {
        var el = byId('cartCount');
        if (!el) return;
        var total = load().reduce(function (s, i) { return s + i.qty; }, 0);
        el.textContent = total;
        el.style.display = total ? 'inline-block' : 'none';
    }
    function addToCart(p, qty) {
        var cart = load();
        var id = String(p.id);
        var item = cart.find(function (i) { return i.id === id; });
        if (item) {
            item.qty += qty;
        } else {
            cart.push({ id: id, name: p.name, price: p.price, img: p.images[0], qty: qty });
        }
        return save(cart);
    }
    updateCount();

    // ===== Tìm kiếm =====
    // Bỏ dấu + chữ thường để gõ "quan ao" vẫn tìm ra "Quần áo"
    function norm(s) {
        return String(s || '').toLowerCase().normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '').replace(/đ/g, 'd');
    }
    function searchProducts(q) {
        var words = norm(q).split(/\s+/).filter(Boolean);
        if (!words.length) return PRODUCTS.slice();
        return PRODUCTS.filter(function (p) {
            var hay = norm(p.name + ' ' + (CATS[p.cat] || ''));
            return words.every(function (w) { return hay.indexOf(w) > -1; });
        });
    }

    var searchInput = byId('searchInput'), searchBtn = byId('searchBtn');
    if (searchInput && searchBtn) {
        function goSearch() {
            var q = searchInput.value.trim();
            location.href = 'Products.aspx' + (q ? '?q=' + encodeURIComponent(q) : '');
        }
        searchBtn.onclick = goSearch;
        searchInput.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // tránh postback của <form runat="server">
                goSearch();
            }
        });
        searchInput.value = getParam('q'); // giữ lại từ khóa trên ô tìm kiếm
    }

    // ===== Thẻ sản phẩm dùng chung =====
    function cardHtml(p) {
        return '<div class="p-card">' +
            '<a class="p-link" href="ProductDetail.aspx?id=' + p.id + '">' +
            (p.old ? '<span class="badge-sale">Sale</span>' : '') +
            '<img src="' + esc(p.images[0]) + '" alt="' + esc(p.name) + '" />' +
            '<h3 class="p-name">' + esc(p.name) + '</h3>' +
            '<div class="p-price"><span class="p-now">' + money(p.price) + '</span>' +
            (p.old ? '<span class="p-old">' + money(p.old) + '</span>' : '') + '</div>' +
            '</a>' +
            '<button type="button" class="btn btn-add" data-add="' + p.id + '">Thêm</button>' +
            '</div>';
    }
    function renderGrid(grid, list) {
        grid.innerHTML = list.map(cardHtml).join('');
    }

    // Nút "Thêm vào giỏ" trên thẻ (bắt sự kiện chung, dùng được cho thẻ sinh bằng JS)
    document.addEventListener('click', function (e) {
        var b = e.target.closest ? e.target.closest('button[data-add]') : null;
        if (!b) return;
        var p = findProduct(b.dataset.add);
        if (!p || !addToCart(p, 1)) return;
        b.textContent = 'Đã thêm ✓';
        b.classList.add('added');
        clearTimeout(b._t);
        b._t = setTimeout(function () {
            b.textContent = 'Thêm';
            b.classList.remove('added');
        }, 1200);
    });

    // Lưới theo danh sách id cố định, vd: <div class="p-grid" data-ids="1,2,3,4">
    Array.prototype.forEach.call(document.querySelectorAll('.p-grid[data-ids]'), function (g) {
        var list = g.dataset.ids.split(',').map(findProduct).filter(Boolean);
        renderGrid(g, list);
    });

    // ===== Trang sản phẩm: danh sách + tìm kiếm + lọc theo loại =====
    var productGrid = byId('productGrid');
    if (productGrid) {
        var q = getParam('q').trim();
        var loai = getParam('loai');
        var result = searchProducts(q);
        if (loai) {
            result = result.filter(function (p) { return p.cat === loai; });
        }

        // Tô đậm mục danh mục đang chọn ở sidebar
        Array.prototype.forEach.call(document.querySelectorAll('.cat-list a'), function (a) {
            a.classList.toggle('active', (a.dataset.cat || '') === loai);
        });

        // Dòng thông tin kết quả
        var info = byId('resultInfo');
        var text = '';
        if (loai && CATS[loai]) {
            text += 'Danh mục <strong>' + esc(CATS[loai]) + '</strong>. ';
        }
        if (q) {
            text += 'Từ khóa “<strong>' + esc(q) + '</strong>”. ';
        }
        if (text) {
            info.innerHTML = text + 'Tìm thấy <strong>' + result.length + '</strong> sản phẩm. ' +
                '<a href="Products.aspx">Xem tất cả sản phẩm</a>';
            info.style.display = 'block';
        }

        if (result.length) {
            renderGrid(productGrid, result);
        } else {
            productGrid.style.display = 'none';
            byId('noResult').style.display = 'block';
        }
    }
    // ===== Trang chi tiết =====
    var detail = byId('detail');
    if (detail) {
        var prod = findProduct(getParam('id'));
        if (!prod) {
            detail.style.display = 'none';
            byId('detailNotFound').style.display = 'block';
            var rel = byId('relatedBlock');
            if (rel) rel.style.display = 'none';
        } else {
            document.title = prod.name + ' - MyShop';
            byId('crumbName').textContent = prod.name;
            byId('dName').textContent = prod.name;
            byId('dNow').textContent = money(prod.price);
            if (prod.old) { byId('dOld').textContent = money(prod.old); } else { byId('dOld').style.display = 'none'; }
            byId('dBadge').style.display = prod.old ? '' : 'none';
            byId('dDesc').textContent = prod.desc;
            byId('dMeta').innerHTML =
                '<li>Chất liệu: ' + esc(prod.material) + '</li>' +
                '<li>Kích cỡ: ' + esc(prod.sizes) + '</li>' +
                '<li>Tình trạng: ' + esc(prod.status) + '</li>';

            // Ảnh chính + ảnh phụ (thumbnail)
            var main = byId('dMainImg'), thumbs = byId('dThumbs');
            function show(idx) {
                main.src = prod.images[idx];
                main.alt = prod.name;
                Array.prototype.forEach.call(thumbs.children, function (t, i) {
                    t.classList.toggle('active', i === idx);
                });
            }
            if (prod.images.length > 1) {
                thumbs.innerHTML = prod.images.map(function (src, i) {
                    return '<button type="button" class="thumb" data-idx="' + i + '" title="Ảnh ' + (i + 1) + '">' +
                        '<img src="' + esc(src) + '" alt="' + esc(prod.name) + ' - ảnh ' + (i + 1) + '" /></button>';
                }).join('');
                thumbs.addEventListener('click', function (e) {
                    var t = e.target.closest('.thumb');
                    if (t) show(+t.dataset.idx);
                });
            } else {
                thumbs.style.display = 'none';
            }
            show(0);

            // Số lượng + thêm vào giỏ
            var qty = byId('qty');
            byId('qtyMinus').onclick = function () { qty.value = Math.max(1, +qty.value - 1); };
            byId('qtyPlus').onclick = function () { qty.value = +qty.value + 1; };
            byId('btnAdd').onclick = function () {
                if (addToCart(prod, +qty.value)) byId('addMsg').style.display = 'block';
            };

            // Sản phẩm liên quan: ưu tiên cùng danh mục, đủ 4 sản phẩm
            var others = PRODUCTS.filter(function (p) { return p.id !== prod.id; });
            var same = others.filter(function (p) { return p.cat === prod.cat; });
            var rest = others.filter(function (p) { return p.cat !== prod.cat; });
            renderGrid(byId('relatedGrid'), same.concat(rest).slice(0, 4));
        }
    }

    // ===== Trang giỏ hàng =====
    var body = byId('cartBody');
    if (body) {
        function render() {
            var cart = load(), html = '', sum = 0;
            byId('cartFilled').style.display = cart.length ? '' : 'none';
            byId('cartEmpty').style.display = cart.length ? 'none' : 'block';

            cart.forEach(function (i, idx) {
                sum += i.price * i.qty;
                html += '<tr>' +
                    '<td><div class="cart-item"><img src="' + esc(i.img) + '" alt="" /><span>' + esc(i.name) + '</span></div></td>' +
                    '<td>' + money(i.price) + '</td>' +
                    '<td><div class="qty">' +
                    '<button type="button" data-act="minus" data-idx="' + idx + '">−</button>' +
                    '<span>' + i.qty + '</span>' +
                    '<button type="button" data-act="plus" data-idx="' + idx + '">+</button></div></td>' +
                    '<td>' + money(i.price * i.qty) + '</td>' +
                    '<td><button type="button" class="cart-remove" data-act="del" data-idx="' + idx + '" title="Xóa">×</button></td>' +
                    '</tr>';
            });
            body.innerHTML = html;
            byId('sumSub').textContent = money(sum);
            byId('sumTotal').textContent = money(sum);
        }

        body.addEventListener('click', function (e) {
            var b = e.target.closest('button[data-act]');
            if (!b) return;
            var cart = load(), idx = +b.dataset.idx;
            if (b.dataset.act === 'plus') cart[idx].qty++;
            if (b.dataset.act === 'minus' && cart[idx].qty > 1) cart[idx].qty--;
            if (b.dataset.act === 'del') cart.splice(idx, 1);
            save(cart);
            render();
        });

        byId('btnCheckout').onclick = function () {
            alert('Cảm ơn bạn đã đặt hàng!');
            save([]);
            render();
        };

        render();
    }
})();