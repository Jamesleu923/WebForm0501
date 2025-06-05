using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebForm0501;

namespace WebForm0501
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            AlertMessage mymsg= new AlertMessage();
            mymsg.ShowMsg(this.Page, "hello");
          
        }
    }
}