using System;
using System.Web;
using System.Web.UI;

namespace Demo_btl_10_10
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected bool IsLoggedIn
        {
            get { return HttpContext.Current.Session["User"] != null; }
        }

        protected bool IsAdmin
        {
            get { return AppData.IsAdmin(HttpContext.Current.Session); }
        }

        protected string DisplayName
        {
            get { return Convert.ToString(HttpContext.Current.Session["FullName"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
