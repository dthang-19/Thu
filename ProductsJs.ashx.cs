using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace Demo_btl_10_10
{
    /// <summary>
    /// Trả về danh sách sản phẩm trong Application dưới dạng file JavaScript
    /// (window.SHOP_CATEGORIES, window.SHOP_PRODUCTS) để shop.js dùng như trước đây.
    /// Admin sửa sản phẩm trong Application thì trang web tự cập nhật theo.
    /// </summary>
    public class ProductsJs : IHttpHandler
    {
        public bool IsReusable
        {
            get { return false; }
        }

        public void ProcessRequest(HttpContext context)
        {
            List<Dictionary<string, object>> items = new List<Dictionary<string, object>>();
            foreach (ShopProduct p in AppData.GetProducts())
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                d["id"] = p.Id;
                d["name"] = p.Name;
                d["price"] = p.Price;
                if (p.OldPrice > 0) d["old"] = p.OldPrice;
                d["cat"] = p.Cat;
                d["images"] = p.Images;
                d["desc"] = p.Description;
                d["material"] = p.Material;
                d["sizes"] = p.Sizes;
                d["status"] = p.Status;
                items.Add(d);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            HttpResponse r = context.Response;
            r.ContentType = "application/javascript";
            r.ContentEncoding = Encoding.UTF8;
            r.Cache.SetCacheability(HttpCacheability.NoCache);
            r.Write("window.SHOP_CATEGORIES = " + js.Serialize(AppData.Categories) + ";\n");
            r.Write("window.SHOP_PRODUCTS = " + js.Serialize(items) + ";\n");
        }
    }
}
