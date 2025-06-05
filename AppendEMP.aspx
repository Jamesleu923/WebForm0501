<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppendEMP.aspx.cs" Inherits="WebForm0501.AppendEMP" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head runat="server">
    <meta charset="utf-8" />
    <title>員工資料新增</title>
    <!-- 引入 Bootstrap 5.2.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .form-container {
            max-width: 800px;
            margin: auto;
        }
        .image-preview {
            max-width: 100%;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-container">
        <h2 class="mb-4">員工資料新增</h2>
        
        <div class="mb-3">
            <label for="TextBox1" class="form-label">姓名</label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="TextBox2" class="form-label">身份證字號</label>
            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
         <div class="mb-3">
            <label for="TextBox21" class="form-label">性別</label>       
                <asp:DropDownList ID="DropDownList3" runat="server"  CssClass="form-select" DataSourceID="SqlDataSource2" DataTextField="emp004" DataValueField="emp004">
                </asp:DropDownList>
          </div>
   
        <div class="mb-3">
            <label for="TextBox4" class="form-label">生日</label>
            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <label for="DropDownList1" class="form-label">職稱代碼</label>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select" DataSourceID="SqlDataSource3" DataTextField="emptitle_002" DataValueField="emptitle_001"></asp:DropDownList>
       
        </div>
        <div class="mb-3">
            <label for="TextBox3" class="form-label">地址</label>
            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label for="DropDownList2" class="form-label">上級主管</label>
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select" DataSourceID="SqlDataSource1" DataTextField="emp002" DataValueField="emp001"></asp:DropDownList>
        </div>

        <div class="mb-3">
            <label for="FileUpload1" class="form-label">上傳照片</label>
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control"></asp:FileUpload>
        </div>
        <div class="mb-3">
            <asp:Image ID="Image1" runat="server" CssClass="image-preview" Height="233px" Width="193px" />
        </div>

        <!-- 移除原有按鈕 OnClick，改用純 HTML 或其他方式觸發 -->
        <div class="d-flex gap-2 flex-wrap">
            <asp:Button ID="Button1" runat="server" Text="新增" CssClass="btn btn-primary" OnClick="Button1_Click" />
            <asp:Button ID="Button3" runat="server" Text="上傳" CssClass="btn btn-secondary" OnClick="Button3_Click" />
            <asp:Button ID="Button4" runat="server" Text="顯示圖片" CssClass="btn btn-info" OnClick="Button4_Click" />
            <asp:Button ID="Button5" runat="server" Text="下載圖片" CssClass="btn btn-success" />
        </div>

        <!-- 保留 SQL Data Source 宣告 -->
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>"
            SelectCommand="SELECT [emp001], [emp002] FROM [Employee]">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT [emptitle_001], [emptitle_002] FROM [EmpTitle]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT   [emp004]   FROM [dbo].[Employee] group by emp004"></asp:SqlDataSource>

        <br />

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
