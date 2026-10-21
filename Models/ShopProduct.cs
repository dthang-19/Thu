using System.Collections.Generic;

namespace Demo_btl_10_10
{
    /// <summary>Một sản phẩm của cửa hàng (lưu trong Application).</summary>
    public class ShopProduct
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public long Price { get; set; }
        public long OldPrice { get; set; }          // 0 = không giảm giá
        public string Cat { get; set; }             // mã loại: leu, den, ba-lo, thiet-bi, xe-dap
        public List<string> Images { get; set; }    // ảnh đầu tiên là ảnh đại diện
        public string Description { get; set; }
        public string Material { get; set; }
        public string Sizes { get; set; }
        public string Status { get; set; }

        public ShopProduct()
        {
            Images = new List<string>();
        }

        public string Thumb
        {
            get { return Images.Count > 0 ? Images[0] : "Images/product1.jpg"; }
        }

        public ShopProduct Clone()
        {
            ShopProduct c = (ShopProduct)MemberwiseClone();
            c.Images = new List<string>(Images);
            return c;
        }
    }
}
