<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebForm0501.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" 
                SelectCommand="SELECT * FROM [訂購資料主表]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT * FROM [Order_body] WHERE ([order_id] = @order_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="order_id" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT * FROM [product]"></asp:SqlDataSource>
            <br />
            <br />
            View 檢視<br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="訂單編號" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="訂單編號" HeaderText="訂單編號" InsertVisible="False" ReadOnly="True" SortExpression="訂單編號" />
                    <asp:BoundField DataField="客戶編號" HeaderText="客戶編號" SortExpression="客戶編號" />
                    <asp:BoundField DataField="客戶姓名" HeaderText="客戶姓名" SortExpression="客戶姓名" />
                    <asp:BoundField DataField="客戶電話" HeaderText="客戶電話" SortExpression="客戶電話" />
                    <asp:BoundField DataField="客戶地址" HeaderText="客戶地址" SortExpression="客戶地址" />
                    <asp:BoundField DataField="訂貨日期" HeaderText="訂貨日期" SortExpression="訂貨日期" />
                    <asp:BoundField DataField="處理人員ID" HeaderText="處理人員ID" SortExpression="處理人員ID" />
                    <asp:BoundField DataField="處理人員姓名" HeaderText="處理人員姓名" SortExpression="處理人員姓名" />
                    <asp:BoundField DataField="處理日期" HeaderText="處理日期" SortExpression="處理日期" />
                </Columns>
                <SelectedRowStyle BackColor="Blue" ForeColor="White" />
            </asp:GridView>
            <br />
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="body_id" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="order_id" HeaderText="訂單編號" SortExpression="order_id" />
                    <asp:BoundField DataField="body_id" HeaderText="單身編號" InsertVisible="False" ReadOnly="True" SortExpression="body_id" />
                    <asp:TemplateField HeaderText="產品ID" SortExpression="product_id">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource3" DataTextField="product_item" DataValueField="product_id" SelectedValue='<%# Bind("product_id") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="product_item" DataValueField="product_id" Enabled="False" SelectedValue='<%# Bind("product_id") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="product_amount" HeaderText="訂購數量" SortExpression="product_amount" />
                    <asp:BoundField DataField="count_price" HeaderText="金額小計" SortExpression="count_price" />
                </Columns>
                <SelectedRowStyle BackColor="Black" ForeColor="#FF6600" />
            </asp:GridView>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
            <br />
        </div>
    </form>
</body>
</html>
