using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

    public class AlertMessage
    {
        public AlertMessage()
        {
        }
        public void ShowMsg(Page ThisPage, String AlertMessage)
        {
            Literal txtMsg = new Literal();
            txtMsg.Text = "<script>alert('" + AlertMessage + "')</script>" + "<BR/>";
            ThisPage.Controls.Add(txtMsg);
        }
        public void ShowConfirm(Page ThisPage, String ConfirmMessage)
        {
            Literal txtMsg = new Literal();
            txtMsg.Text = "<script>confirm('" + ConfirmMessage + "')</script>" + "<BR/>";
            ThisPage.Controls.Add(txtMsg);
        }

    }
