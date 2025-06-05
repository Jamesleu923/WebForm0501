using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebForm0501
{
    public partial class AppendEMP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void Clear_Textbox(object sender, EventArgs e)//委派這個方法給SQLDataSource Inserted(插入後事件觸發)呼叫清空輸入資料
        {
            TextBox[] ThisPageTextBox = { this.TextBox1, this.TextBox2, this.TextBox3, this.TextBox4 };
            foreach (TextBox t in ThisPageTextBox)
                t.Text = "";
        }
        public void AppendMsg(object sender, EventArgs e)
        {
            AlertMessage sysmsg = new AlertMessage();
            sysmsg.ShowMsg(this.Page, "新增完成!");
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            AlertMessage sysmsg = new AlertMessage();
            SysDb append_data = new SysDb("MYDBConnectionString");
     
            //委派 upload_img()方法給Inserted-->新增完成後幫我執行upload_img()方法,若新增失敗則不用理
            append_data.Inserted += new SqlDataSourceStatusEventHandler(this.upload_img);
            //append_data.Inserted +=  new SqlDataSourceStatusEventHandler(this.Clear_Textbox);
            append_data.Inserted += new SqlDataSourceStatusEventHandler(this.AppendMsg);


            append_data.InsertCommand = "INSERT INTO [Employee] ([emp002], [emp003], [emp004], [emp005], [emp006], [emp008], [emp009]) " +
                " VALUES  (@emp002, @emp003, @emp004, @emp005 ,@emp006, @emp008, @emp009)";

            append_data.InsertParameters.Add(new Parameter("emp002", TypeCode.String, TextBox1.Text.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp003", TypeCode.String, TextBox2.Text.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp004", TypeCode.String, DropDownList3.SelectedValue.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp005", TypeCode.String, TextBox4.Text.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp006", TypeCode.String, DropDownList1.SelectedValue.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp008", TypeCode.String, TextBox3.Text.ToString()));
            append_data.InsertParameters.Add(new Parameter("emp009", TypeCode.String, DropDownList2.SelectedValue.ToString()));

            //append_data.Insert();
            try
            {
                append_data.Insert();
                //sysmsg.ShowMsg(this.Page,"新增完成!");
            }
            catch (Exception)
            {
                sysmsg.ShowMsg(this.Page, "新增失敗" + e.ToString() + append_data.InsertCommand.ToString());
            }
        }
        public void upload_img(object sender, EventArgs e)
        {
            if (!this.FileUpload1.HasFile)
                return;

            String SQLUpdatedCommand;
            String PK_value;
            AlertMessage mymsg = new AlertMessage();
            SQL_Handle JPG_Upload = new SQL_Handle(this.Page, "MYDBConnectionString");
            PK_value = JPG_Upload.GetLastPK("employee", "emp001");
            if (PK_value != null && PK_value != "")
            {

                SQLUpdatedCommand = "update employee set emp007=@emp007 where emp001=" + PK_value;
                if (this.FileUpload1.FileName.ToString().Trim().Length > 3)
                    JPG_Upload.Insert_Image(SQLUpdatedCommand, this.FileUpload1, "emp007");
                else
                    mymsg.ShowMsg(this.Page, "沒有指定圖檔!");
            }
            else
            {
                mymsg.ShowMsg(this.Page, "查不到資料或者沒有選擇資料");
            }
        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            upload_img(sender, e);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            SQL_Handle JPG_Upload = new SQL_Handle(this.Page, "MYDBConnectionString");
            String PK_value = JPG_Upload.GetLastPK("employee", "emp001");
            AlertMessage sysmsg = new AlertMessage();
            //要查到資料才能上傳照片,且有選擇資料,才能上傳
            if (PK_value != null && PK_value != "")
            {
                this.Image1.Visible = true;
                Image1.ImageUrl = "Download_Sub1.aspx?pid=" + PK_value;

            }
            else
            {
                sysmsg.ShowMsg(this.Page, "沒有查到資料或沒有選擇資料");
                this.Image1.ImageUrl = "";
                this.Image1.Visible = false;
            }
        }
    }
}