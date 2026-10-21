using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Demo_btl_10_10
{
    /// <summary>
    /// Kho dữ liệu dùng chung cho cả website, lưu trong Application (khởi tạo ở Global.asax).
    /// Mọi thao tác đọc/ghi đều Lock/UnLock để nhiều người truy cập cùng lúc không bị lỗi.
    /// Lưu ý: dữ liệu nằm trong bộ nhớ, khi ứng dụng khởi động lại sẽ quay về dữ liệu mẫu.
    /// </summary>
    public static class AppData
    {
        public const string RoleAdmin = "admin";
        public const string RoleCustomer = "customer";

        const string KProducts = "MyShop.Products";
        const string KNextProductId = "MyShop.NextProductId";
        const string KCustomers = "MyShop.Customers";
        const string KNextCustomerId = "MyShop.NextCustomerId";

        public static readonly Dictionary<string, string> Categories = new Dictionary<string, string>
        {
            { "leu", "Lều cắm trại" },
            { "den", "Đèn chiếu sáng" },
            { "ba-lo", "Ba lô - túi" },
            { "thiet-bi", "Thiết bị cắm trại" },
            { "xe-dap", "Xe đạp" },
        };

        static HttpApplicationState App
        {
            get { return HttpContext.Current.Application; }
        }

        // ===== Khởi tạo (gọi từ Application_Start trong Global.asax.cs) =====
        public static void Init(HttpApplicationState app)
        {
            app.Lock();
            try
            {
                List<ShopProduct> products = SeedProducts();
                app[KProducts] = products;
                app[KNextProductId] = products.Max(p => p.Id) + 1;

                List<Customer> customers = new List<Customer>();
                customers.Add(new Customer
                {
                    Id = 1,
                    FullName = "Quản trị viên",
                    Email = "admin@mycamp.vn",
                    Username = "admin",
                    PasswordHash = Hash("admin"),
                    Role = RoleAdmin,
                    CreatedAt = DateTime.Now
                });
                app[KCustomers] = customers;
                app[KNextCustomerId] = 2;
            }
            finally
            {
                app.UnLock();
            }
        }

        // ===== Tiện ích =====
        public static string Hash(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password ?? string.Empty));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        public static bool IsAdmin(HttpSessionState session)
        {
            return session != null &&
                   string.Equals(session["Role"] as string, RoleAdmin, StringComparison.OrdinalIgnoreCase);
        }

        // ===== Sản phẩm =====
        static List<ShopProduct> ProductList()
        {
            return (List<ShopProduct>)App[KProducts];
        }

        public static List<ShopProduct> GetProducts()
        {
            App.Lock();
            try { return ProductList().Select(p => p.Clone()).ToList(); }
            finally { App.UnLock(); }
        }

        public static ShopProduct GetProduct(int id)
        {
            App.Lock();
            try
            {
                ShopProduct p = ProductList().FirstOrDefault(x => x.Id == id);
                return p == null ? null : p.Clone();
            }
            finally { App.UnLock(); }
        }

        /// <summary>Id = 0 là thêm mới, Id &gt; 0 là cập nhật.</summary>
        public static void SaveProduct(ShopProduct product)
        {
            App.Lock();
            try
            {
                List<ShopProduct> list = ProductList();
                if (product.Id <= 0)
                {
                    int next = (int)App[KNextProductId];
                    product.Id = next;
                    App[KNextProductId] = next + 1;
                    list.Add(product.Clone());
                }
                else
                {
                    int idx = list.FindIndex(x => x.Id == product.Id);
                    if (idx >= 0) list[idx] = product.Clone();
                    else list.Add(product.Clone());
                }
            }
            finally { App.UnLock(); }
        }

        public static bool DeleteProduct(int id)
        {
            App.Lock();
            try { return ProductList().RemoveAll(x => x.Id == id) > 0; }
            finally { App.UnLock(); }
        }

        // ===== Khách hàng =====
        static List<Customer> CustomerList()
        {
            return (List<Customer>)App[KCustomers];
        }

        public static List<Customer> GetCustomers()
        {
            App.Lock();
            try { return CustomerList().Select(c => c.Clone()).ToList(); }
            finally { App.UnLock(); }
        }

        public static Customer GetCustomer(int id)
        {
            App.Lock();
            try
            {
                Customer c = CustomerList().FirstOrDefault(x => x.Id == id);
                return c == null ? null : c.Clone();
            }
            finally { App.UnLock(); }
        }

        /// <summary>Trả về tài khoản nếu đúng tên đăng nhập + mật khẩu, ngược lại trả về null.</summary>
        public static Customer Authenticate(string username, string password)
        {
            string hash = Hash(password);
            App.Lock();
            try
            {
                Customer c = CustomerList().FirstOrDefault(x =>
                    string.Equals(x.Username, username, StringComparison.OrdinalIgnoreCase) &&
                    x.PasswordHash == hash);
                return c == null ? null : c.Clone();
            }
            finally { App.UnLock(); }
        }

        static bool IsDuplicate(List<Customer> list, int ignoreId, string username, string email, out string error)
        {
            foreach (Customer x in list)
            {
                if (x.Id == ignoreId) continue;
                if (string.Equals(x.Username, username, StringComparison.OrdinalIgnoreCase))
                {
                    error = "Tên đăng nhập đã tồn tại.";
                    return true;
                }
                if (string.Equals(x.Email, email, StringComparison.OrdinalIgnoreCase))
                {
                    error = "Email đã được sử dụng.";
                    return true;
                }
            }
            error = null;
            return false;
        }

        public static bool AddCustomer(Customer customer, string plainPassword, out string error)
        {
            App.Lock();
            try
            {
                List<Customer> list = CustomerList();
                if (IsDuplicate(list, 0, customer.Username, customer.Email, out error)) return false;

                int next = (int)App[KNextCustomerId];
                App[KNextCustomerId] = next + 1;

                Customer c = customer.Clone();
                c.Id = next;
                c.PasswordHash = Hash(plainPassword);
                c.CreatedAt = DateTime.Now;
                if (c.Role != RoleAdmin) c.Role = RoleCustomer;
                list.Add(c);

                customer.Id = next;
                error = null;
                return true;
            }
            finally { App.UnLock(); }
        }

        /// <summary>Cập nhật khách hàng. newPassword để trống = giữ nguyên mật khẩu cũ.</summary>
        public static bool UpdateCustomer(Customer customer, string newPassword, out string error)
        {
            App.Lock();
            try
            {
                List<Customer> list = CustomerList();
                Customer c = list.FirstOrDefault(x => x.Id == customer.Id);
                if (c == null)
                {
                    error = "Không tìm thấy khách hàng.";
                    return false;
                }
                if (IsDuplicate(list, c.Id, customer.Username, customer.Email, out error)) return false;

                string role = customer.Role == RoleAdmin ? RoleAdmin : RoleCustomer;
                if (c.Role == RoleAdmin && role != RoleAdmin && list.Count(x => x.Role == RoleAdmin) <= 1)
                {
                    error = "Phải còn ít nhất một quản trị viên.";
                    return false;
                }

                c.FullName = customer.FullName;
                c.Email = customer.Email;
                c.Username = customer.Username;
                c.Role = role;
                if (!string.IsNullOrEmpty(newPassword)) c.PasswordHash = Hash(newPassword);
                error = null;
                return true;
            }
            finally { App.UnLock(); }
        }

        public static bool DeleteCustomer(int id, out string error)
        {
            App.Lock();
            try
            {
                List<Customer> list = CustomerList();
                Customer c = list.FirstOrDefault(x => x.Id == id);
                if (c == null)
                {
                    error = "Không tìm thấy khách hàng.";
                    return false;
                }
                if (c.Role == RoleAdmin && list.Count(x => x.Role == RoleAdmin) <= 1)
                {
                    error = "Không thể xóa quản trị viên cuối cùng.";
                    return false;
                }
                list.Remove(c);
                error = null;
                return true;
            }
            finally { App.UnLock(); }
        }

        // ===== Dữ liệu mẫu ban đầu =====
        static ShopProduct Seed(int id, string name, long price, long oldPrice, string cat,
            string[] images, string description, string material, string sizes, string status)
        {
            ShopProduct p = new ShopProduct
            {
                Id = id, Name = name, Price = price, OldPrice = oldPrice, Cat = cat,
                Description = description, Material = material, Sizes = sizes, Status = status
            };
            p.Images.AddRange(images);
            return p;
        }

        static List<ShopProduct> SeedProducts()
        {
            return new List<ShopProduct>
            {
                Seed(1, "Lều vòm dựng nhanh Ozark Trail 6 người", 3500000, 4800000, "leu",
                    new[] { "Images/sp1_1.jpg", "Images/sp1_2.jpg", "Images/sp1_3.jpg", "Images/sp1_4.jpg" },
                    "Lều vòm dựng nhanh với khung gập sẵn, một người cũng dựng được trong vài phút. Có cửa lưới thoáng khí, cổng luồn dây điện tiện sạc thiết bị và túi lưới đựng đồ cá nhân bên trong.",
                    "Vải polyester chống thấm, khung sợi thủy tinh", "Rộng 3,0 x 2,7 m, ngủ thoải mái 6 người", "Còn hàng"),
                Seed(2, "Quạt cắm trại Panergy có đèn LED", 1800000, 0, "thiet-bi",
                    new[] { "Images/sp2_1.jpg", "Images/sp2_2.jpg", "Images/sp2_3.jpg", "Images/sp2_4.jpg" },
                    "Quạt sạc pin dung lượng lớn kèm đèn LED viền xung quanh, có móc treo trong lều. Nhiều tốc độ gió, dùng được cả ban ngày lẫn ban đêm.",
                    "Nhựa ABS, pin lithium sạc lại", "Đường kính cánh quạt 20 cm", "Còn hàng"),
                Seed(3, "Ba lô Ozark Trail 20,5 lít", 300000, 600000, "ba-lo",
                    new[] { "Images/sp3_1.jpg", "Images/sp3_2.jpg", "Images/sp3_3.jpg", "Images/sp3_4.jpg" },
                    "Ba lô dã ngoại 20,5 lít gọn nhẹ, dây rút chun phía trước để buộc thêm đồ, ngăn lưới hai bên đựng chai nước, quai đeo êm vai.",
                    "Vải polyester bền chống nước nhẹ", "Dung tích 20,5 lít", "Còn hàng"),
                Seed(4, "Đèn pha đa màu Ozark Trail", 130000, 180000, "den",
                    new[] { "Images/sp4_1.jpg", "Images/sp4_2.jpg", "Images/sp4_3.jpg", "Images/sp4_4.jpg" },
                    "Đèn đeo đầu nhỏ gọn, nhiều chế độ sáng và nhiều màu ánh sáng. Dây đeo co giãn, chỉnh được góc chiếu, phù hợp đi bộ đêm, dựng lều và sửa chữa.",
                    "Nhựa ABS, dây đeo thun dệt", "Free size, dùng 3 pin AAA", "Còn hàng"),
                Seed(5, "Đèn pin LED Ozark Trail 420", 250000, 600000, "den",
                    new[] { "Images/sp5_1.jpg", "Images/sp5_2.jpg", "Images/sp5_3.jpg", "Images/sp5_4.jpg" },
                    "Đèn pin LED 420 lumen, vặn đầu để thu phóng chùm sáng. Thân nhôm chắc chắn, chống nước bắn, cầm gọn trong tay.",
                    "Nhôm hợp kim", "Dài 14 cm, 420 lumen", "Còn hàng"),
                Seed(6, "Lều vòm cắm trại 3 người Alpha Camp", 3800000, 0, "leu",
                    new[] { "Images/sp6_1.jpg", "Images/sp6_2.jpg", "Images/sp6_3.jpg", "Images/sp6_4.jpg" },
                    "Lều vòm 2 lớp cho 3 người, cửa sổ lưới thông gió, lớp ngoài chống nước. Gọn nhẹ, dễ dựng và dễ mang theo khi đi dã ngoại.",
                    "Vải polyester 190T chống thấm, khung sợi thủy tinh", "Rộng 2,1 x 2,1 m, cho 3 người", "Còn hàng"),
                Seed(7, "Xe đạp leo núi 6 tốc độ", 1800000, 0, "xe-dap",
                    new[] { "Images/sp7_1.jpg", "Images/sp7_2.jpg", "Images/sp7_3.jpg", "Images/sp7_4.jpg" },
                    "Xe đạp leo núi cỡ nhỏ 6 tốc độ, lốp địa hình bám đường tốt, khung thép chắc chắn. Phù hợp thiếu niên đạp quanh khu cắm trại hay đường đất.",
                    "Khung thép, lốp địa hình", "Bánh 20 inch", "Còn hàng"),
                Seed(8, "Xe đạp leo núi dành cho người lớn", 4000000, 6000000, "xe-dap",
                    new[] { "Images/sp8_1.jpg", "Images/sp8_2.jpg", "Images/sp8_3.jpg", "Images/sp8_4.jpg" },
                    "Xe đạp leo núi người lớn với phuộc giảm xóc trước, phanh đĩa và bộ truyền động nhiều tốc độ. Chạy êm trên đường đồi dốc và đường mòn.",
                    "Khung hợp kim nhôm, phanh đĩa", "Bánh 26 inch", "Còn hàng")
            };
        }
    }
}
