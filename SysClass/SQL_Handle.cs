using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing.Imaging;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization;
using System.Net;
using System.Configuration;

/// <summary>
/// SQL_Handle 的摘要描述
///         //'參數
//'myConnect -->web.config連線字串
//'Insert_command -->SQL插入命令
//'FileUpload1 -->頁面使用之fileupload物件的名稱
//'SQL_filed -->要插入的SQL image的image欄位 名稱

//'SQL命令使用@參數方式
//'例如:update employee set emp007=@emp007 where emp001=@emp001"

//'TextBox 無限制輸入,使用二進位存到Image欄位中
//'Dim text_array() As Char = Me.TextBox7.Text.ToCharArray
//'Dim VR009 As New Data.SqlClient.SqlParameter("R009", System.Text.UnicodeEncoding.Unicode.GetBytes(text_array)) '檔案以二進位陣列回傳

//'用fileupload把檔案存入到二進位欄位中
/// </summary>
public class SQL_Handle
{
    public enum ContentImageType : int { Jpg = 1, Png = 2, Gif = 3, Bmp = 4 }
    public String _errstr;
    private String _myConnectSettingName;
    private String _myConnectString;
    private Page _mypage;
    private String _LastPK;

    public String myConnectString { get; set; }
    public String LastPK { get; set; }
    public String errstr { get; set; }
    private String myConnectSettingName { get; set; }
    private Page mypage { get; set; }

    public SQL_Handle(Page now_page, String Connect_str)
    {
        //傳入this.page/Me.page, web.config連線字串now
        this.myConnectSettingName = Connect_str;
        this.mypage = now_page;
        this.myConnectString = ConfigurationManager.ConnectionStrings[Connect_str].ConnectionString;
    }

    public Boolean Insert_Image(String Insert_Command, FileUpload FileUpload1, String SQL_Para_Filed)
    {
        AlertMessage sysmsg = new AlertMessage();
        System.Data.SqlClient.SqlConnection cn = new System.Data.SqlClient.SqlConnection(this.myConnectString);
        Boolean return_val = false;
        try
        {
            //開啟連線
            cn.Open();
            //sqlclient的sqlcommand 
            System.Data.SqlClient.SqlCommand sc1 = new System.Data.SqlClient.SqlCommand(Insert_Command, cn);
            //'定義SQL參數,@符號的都要定義，把資料轉入
            //這裡使用fileupload,如果要用textbox請自己抓上面程式
            System.Data.SqlClient.SqlParameter para1 = new System.Data.SqlClient.SqlParameter(SQL_Para_Filed, FileUpload1.FileBytes);
            //取代SQL參數@
            sc1.Parameters.Add(para1);
            //執行
            sc1.ExecuteNonQuery();
            //關閉連線
            cn.Close();
            return_val = true;
            sysmsg.ShowMsg(mypage, "上傳完成!");
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            return_val = false;
            this.errstr = ex.ErrorCode.ToString();
            sysmsg.ShowMsg(mypage, "新增失敗" + this.errstr.ToString());
        }
        catch (Exception ex)
        {
            return_val = false;
            this.errstr = ex.Message.ToString();
            sysmsg.ShowMsg(mypage, "新增失敗" + this.errstr.ToString());
        }
        return return_val;
    }

    public Boolean DownloadImageFile(string seleCommand, string fname, int ImageType)
    {
        AlertMessage sysmsg = new AlertMessage();
        SysDb db = new SysDb(this.myConnectString);
        bool return_val = false;
        System.Data.SqlClient.SqlConnection cn =
                new System.Data.SqlClient.SqlConnection(this.myConnectString.ToString());
        System.Data.SqlClient.SqlCommand cmd 
              = new System.Data.SqlClient.SqlCommand(seleCommand, cn);
        try
          {
           cn.Open();
           System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
            // 103-134列if ,新的寫法,支援vs 2022+sql server 2022
           if (reader.Read() && reader.HasRows)
            {
                try
                {
                    this.mypage.Response.Clear();
                    this.mypage.Response.Buffer = true;
                    this.mypage.Response.Charset = "utf-8";
                    this.mypage.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    this.mypage.Response.AppendHeader("content-disposition", "attachment; filename="
                        + System.Web.HttpUtility.UrlEncode(fname, System.Text.Encoding.UTF8));
                    this.mypage.Response.ContentType = GetImageType(ImageType);

                    long len = reader.GetBytes(0, 0, null, 0, 0);
                    Byte[] buffer = new Byte[len];
                    reader.GetBytes(0, 0, buffer, 0, (int)len); // 修正欄位索引
                    this.mypage.Response.BinaryWrite(buffer);
                    this.mypage.Response.Flush();

                    // 不建議使用 Response.End()
                    // this.mypage.Response.End();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();

                    return_val = true;
                }
                catch (WebException ex)
                {
                    return_val = false;
                    errstr = ex.Message.ToString();
                    sysmsg.ShowMsg(mypage, "讀圖錯誤,錯誤代碼:" + this.errstr.ToString());
                }
            }

            cn.Close();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return_val = false;
                this.errstr = ex.ErrorCode.ToString();
                sysmsg.ShowMsg(mypage, "sql失敗" + this.errstr.ToString());
            }
            catch (Exception ex)
            {
                return_val = false;
                this.errstr = ex.Message.ToString();
                sysmsg.ShowMsg(mypage, "失敗" + this.errstr.ToString());
            }

      
         return return_val;
    }
    public Boolean DownloadImageFile01(String seleCommand, int ImageType)
    {
        AlertMessage sysmsg = new AlertMessage();

        Boolean return_val = false;
        System.Data.SqlClient.SqlConnection cn = new System.Data.SqlClient.SqlConnection(this.myConnectString.ToString());
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(seleCommand, cn);

        try
        {
            cn.Open();
            System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read() && reader.HasRows)
            {
                try
                {
                    mypage.Response.ContentType = GetImageType(ImageType);
                    //GetBytes (int ordinal, long dataIndex, byte[] buffer, int bufferIndex, int length)
                    // ordinal   Int32 以零為基底的資料行序數。
                    long len = reader.GetBytes(0, 0, null, 0, 0);
                    Byte[] buffer = new Byte[len];
                    //資料放入buffer中
                    reader.GetBytes(1, 0, buffer, 0, (int)len);
                    //buffer寫入檔案
                    mypage.Response.BinaryWrite(buffer);
                    return_val = true;

                }
                catch (WebException ex)
                {
                    return_val = false;
                    errstr = ex.Message.ToString();
                    sysmsg.ShowMsg(mypage, "讀圖錯誤,錯誤代碼:" + this.errstr.ToString());
                }
                reader.Close();
            }
            cn.Close();

        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            return_val = false;
            this.errstr = ex.ErrorCode.ToString();
            sysmsg.ShowMsg(mypage, "新增失敗" + this.errstr.ToString());
        }
        catch (Exception ex)
        {
            return_val = false;
            this.errstr = ex.Message.ToString();
            sysmsg.ShowMsg(mypage, "新增失敗" + this.errstr.ToString());
        }
        return return_val;
    }
    public string GetLastPK(string DBTableName, string PKFieldName)
    {
        string return_str = "";
        SysDb db = new SysDb(this.myConnectSettingName);

        // db.SelectCommand = @" SELECT  top 1 [@PKFieldName]  FROM [dbo].[@DBTableName] order by @PKFieldName desc ";
        //db.SelectParameters.Add("@PKfield", PKFieldName.ToString());
        //db.SelectParameters.Add("@DBTableName", DBTableName.ToString());   
        db.SelectCommand = " SELECT top 1 [" + PKFieldName.ToString()+"]  FROM [dbo].["+DBTableName.ToString()+
                            "] order by "+PKFieldName.ToString()+ " desc";

        DataSourceSelectArguments para = new DataSourceSelectArguments();
        System.Data.DataView dv = (System.Data.DataView)db.Select(para);
        if ((dv is null) || (dv.Count == 0))
            return_str = "";
        else
            return_str = dv.Table.Rows[0][PKFieldName].ToString();

        this.LastPK = return_str.ToString();
        return this.LastPK;
    }
    public string GetImageType(int TypeCode)
    {
        string rtn_string = "image/jpeg";
        switch (TypeCode)
        {
            case 1:
                rtn_string = "image/jpeg";
                break;
            case 2:
                rtn_string = "image/png";
                break;
            case 3:
                rtn_string = "image/gif";
                break;
            case 4:
                rtn_string = "image/bmp";
                break;
            default:
                //throw new NotImplementedException();
                break;
        }
        return rtn_string;

    }
}
/* backup 舊式寫法..vs2017+sql server 2019可用.
           if (reader.Read() && reader.HasRows)
                {
                  try{
                        this.mypage.Response.AppendHeader("content-disposition", "attachment; filename="
               + System.Web.HttpUtility.UrlEncode(fname, System.Text.Encoding.UTF8));
                        this.mypage.Response.ContentType = GetImageType(ImageType);
                        //GetBytes (int ordinal, long dataIndex, byte[] buffer, int bufferIndex, int length)
                        // ordinal   Int32 以零為基底的資料行序數。
                        long len = reader.GetBytes(0, 0, null, 0, 0);
                        Byte[] buffer = new Byte[len];
                        //資料放入buffer中
                        reader.GetBytes(1, 0, buffer, 0, (int)len);
                        //buffer寫入檔案
                        this.mypage.Response.BinaryWrite(buffer);
                        this.mypage.Response.Flush();
                        this.mypage.Response.End();
                        return_val = true;

                    }
                    catch (WebException ex)
                    {
                        return_val = false;
                        errstr = ex.Message.ToString();
                        sysmsg.ShowMsg(mypage, "讀圖錯誤,錯誤代碼:" + this.errstr.ToString());
                    }
                    reader.Close();
                }
*/