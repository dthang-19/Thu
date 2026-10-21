(function () {
    var body = document.body;
    var nav = document.getElementById('mainNav');
    var toggle = document.getElementById('navToggle');
    var closeBtn = document.getElementById('navClose');
    var overlay = document.getElementById('navOverlay');
    if (!nav || !toggle) return;

    // ===== Menu trượt trên mobile =====
    function setOpen(open) {
        body.classList.toggle('nav-open', open);
        toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    }
    toggle.addEventListener('click', function () {
        setOpen(!body.classList.contains('nav-open'));
    });
    if (closeBtn) closeBtn.addEventListener('click', function () { setOpen(false); });
    if (overlay) overlay.addEventListener('click', function () { setOpen(false); });
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') setOpen(false);
    });
    window.addEventListener('resize', function () {
        if (window.innerWidth > 900) setOpen(false);
    });

    // Mũi tên mở/đóng danh mục con (chỉ hiện trên mobile)
    Array.prototype.forEach.call(nav.querySelectorAll('.dd-toggle'), function (b) {
        b.addEventListener('click', function () {
            var li = b.closest('.has-dropdown');
            var open = li.classList.toggle('open');
            b.setAttribute('aria-expanded', open ? 'true' : 'false');
        });
    });

    // ===== Đánh dấu mục menu của trang hiện tại =====
    var page = (location.pathname.split('/').pop() || 'default.aspx').toLowerCase();
    if (page === 'productdetail.aspx') page = 'products.aspx';
    Array.prototype.forEach.call(nav.querySelectorAll('.nav-list > .nav-item > .nav-link'), function (a) {
        var target = (a.getAttribute('href') || '').split('?')[0].toLowerCase();
        if (target === page) a.classList.add('active');
    });
})();
