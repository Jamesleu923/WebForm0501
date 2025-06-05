using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace WebForm0501
{
    public class Get_DataSet
    {
        private string cn;
        private string sqlcmd;
        private string TableName;

        public Get_DataSet(string Tname)
        {
            this.cn = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnectionString"].ConnectionString;
            this.TableName = Tname;
        }
        public Get_DataSet(string user_sqlcmd, string Tname)
        {
            this.cn = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnectionString"].ConnectionString;
            this.sqlcmd = user_sqlcmd;
            this.TableName = Tname;
        }
        public DataSet SelectDB()
        {
            SqlDataAdapter MyAdapter = new SqlDataAdapter(this.sqlcmd, this.cn);
            DataSet vDataSet = new DataSet();
            try
            {
                MyAdapter.Fill(vDataSet, this.TableName);
            }
            catch (Exception)
            {
                // error message

            }
            return vDataSet;
        }
    }
}