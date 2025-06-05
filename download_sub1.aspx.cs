using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebForm0501
{
    public partial class download_sub1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SQL_Handle JPG_View = new SQL_Handle(this.Page, "MYDBConnectionString");
            JPG_View.DownloadImageFile("select emp007 from Employee where emp001=" + Request.QueryString["pid"], Request.QueryString["pid"] + ".jpg", 1);
        }
    }
}