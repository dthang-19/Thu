using System;
using System.Web;

namespace Demo_btl_10_10
{
    public class Global : HttpApplication
    {
        // Chạy một lần khi website khởi động: nạp sản phẩm và khách hàng vào Application
        protected void Application_Start(object sender, EventArgs e)
        {
            AppData.Init(Application);
        }
    }
}
