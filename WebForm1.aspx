<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebForm0501.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" 
         SelectCommand="SELECT [emp001],[emp002],[emp003],[emp004],[emp005] ,[emp006],[emp008],[emp009],[emptest]
  FROM [dbo].[Employee] WHERE ([emp001] = @emp001)" 
         DeleteCommand="DELETE FROM [Employee] WHERE [emp001] = @emp001" 
         InsertCommand="INSERT INTO [Employee] ([emp002], [emp003], [emp004], [emp005], [emp006], [emp007], [emp008], [emp009], [emptest]) VALUES (@emp002, @emp003, @emp004, @emp005, @emp006, @emp007, @emp008, @emp009, @emptest)" 
         UpdateCommand="UPDATE [Employee] SET [emp002] = @emp002, [emp003] = @emp003,
         [emp004] = @emp004, [emp005] = @emp005, [emp006] = @emp006,  
         [emp008] = @emp008, [emp009] = @emp009, [emptest] = getdate() WHERE [emp001] = @emp001">
         <DeleteParameters>
             <asp:Parameter Name="emp001" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
             <asp:Parameter Name="emp002" Type="String" />
             <asp:Parameter Name="emp003" Type="String" />
             <asp:Parameter Name="emp004" Type="String" />
             <asp:Parameter Name="emp005" Type="DateTime" />
             <asp:Parameter Name="emp006" Type="String" />
             <asp:Parameter Name="emp007" Type="Object" />
             <asp:Parameter Name="emp008" Type="String" />
             <asp:Parameter Name="emp009" Type="Int32" />
             <asp:Parameter Name="emptest" Type="DateTime" />
         </InsertParameters>
         <SelectParameters>
             <asp:ControlParameter ControlID="TextBox1" Name="emp001" PropertyName="Text" />
         </SelectParameters>
         <UpdateParameters>
             <asp:Parameter Name="emp002" Type="String" />
             <asp:Parameter Name="emp003" Type="String" />
             <asp:Parameter Name="emp004" Type="String" />
             <asp:Parameter Name="emp005" Type="DateTime" />
             <asp:Parameter Name="emp006" Type="String" />
             <asp:Parameter Name="emp008" Type="String" />
             <asp:Parameter Name="emp009" Type="Int32" />
             <asp:Parameter Name="emp001" Type="Int32" />
         </UpdateParameters>
     </asp:SqlDataSource>
       <div class="container-fluid">
           <div class="row">
               <div class="col-sm-12 col-md-6 col-lg-6">

                   <h2> 
                       <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT [emp001], [emp002] FROM [Employee]"></asp:SqlDataSource>
                       <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT  emp004
  FROM [dbo].[Employee] group by emp004"></asp:SqlDataSource>
                       <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                           ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" 
                           DeleteCommand="DELETE FROM [Employee] WHERE [emp001] = @emp001" 
                           InsertCommand="INSERT INTO [Employee] ([emp002], [emp003], [emp004], [emp005], [emp006], [emp007], [emp008], [emp009], [emptest]) VALUES (@emp002, @emp003, @emp004, @emp005, @emp006, null, @emp008, @emp009,getdate())" 
                           SelectCommand="SELECT [emp001], [emp002], [emp003], [emp004], [emp005], [emp006], [emp007], [emp008], [emp009], [emptest] FROM [Employee]" 
                           UpdateCommand="UPDATE [Employee] SET [emp002] = @emp002, [emp003] = @emp003, [emp004] = @emp004, [emp005] = @emp005, [emp006] = @emp006, [emp007] = @emp007, [emp008] = @emp008, [emp009] = @emp009, [emptest] = @emptest WHERE [emp001] = @emp001">
                           <DeleteParameters>
                               <asp:Parameter Name="emp001" Type="Int32" />
                           </DeleteParameters>
                           <InsertParameters>
                               <asp:Parameter Name="emp002" Type="String" />
                               <asp:Parameter Name="emp003" Type="String" />
                               <asp:Parameter Name="emp004" Type="String" />
                               <asp:Parameter Name="emp005" Type="DateTime" />
                               <asp:Parameter Name="emp006" Type="String" />                      
                               <asp:Parameter Name="emp008" Type="String" />
                               <asp:Parameter Name="emp009" Type="Int32" />                              
                           </InsertParameters>
                           <UpdateParameters>
                               <asp:Parameter Name="emp002" Type="String" />
                               <asp:Parameter Name="emp003" Type="String" />
                               <asp:Parameter Name="emp004" Type="String" />
                               <asp:Parameter Name="emp005" Type="DateTime" />
                               <asp:Parameter Name="emp006" Type="String" />
                               <asp:Parameter Name="emp007" Type="Object" />
                               <asp:Parameter Name="emp008" Type="String" />
                               <asp:Parameter Name="emp009" Type="Int32" />
                               <asp:Parameter Name="emptest" Type="DateTime" />
                               <asp:Parameter Name="emp001" Type="Int32" />
                           </UpdateParameters>
                       </asp:SqlDataSource>
                       <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MYDBConnectionString %>" SelectCommand="SELECT [emptitle_000], [emptitle_001], [emptitle_002] FROM [EmpTitle]" OnSelecting="SqlDataSource2_Selecting"></asp:SqlDataSource>
                   </h2>
                   <h2> 員工資料<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                       <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                   </h2>
                </div>
            </div>
            <div class="row">
              <div class="col-sm-10 col-md-8 col-lg-10">
                  <div class="table-responsive">
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="emp001" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CssClass="table table-bordered table-striped table-hover table-success text-center" PageSize="5">
                          <HeaderStyle CssClass="table-dark" ForeColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:CommandField ShowEditButton="True" />
                                <asp:CommandField ShowDeleteButton="True" />
                                <asp:BoundField DataField="emp001" HeaderText="emp001" InsertVisible="False" ReadOnly="True" SortExpression="emp001" />
                                <asp:BoundField DataField="emp002" HeaderText="emp002" SortExpression="emp002" />
                                <asp:BoundField DataField="emp003" HeaderText="emp003" SortExpression="emp003" />
                                <asp:TemplateField HeaderText="emp004" SortExpression="emp004">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource4" DataTextField="emp004" DataValueField="emp004" SelectedValue='<%# Bind("emp004") %>'>
                                            <asp:ListItem>男</asp:ListItem>
                                            <asp:ListItem>女</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("emp004") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="emp005" HeaderText="生日" SortExpression="emp005" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="False" >
                                <ItemStyle Width="120px" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="emp006" SortExpression="emp006">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="emptitle_002" DataValueField="emptitle_001" SelectedValue='<%# bind("emp006") %>'>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="emptitle_002" DataValueField="emptitle_001" Enabled="False" SelectedValue='<%# bind("emp006") %>'>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="emp008" HeaderText="emp008" SortExpression="emp008" />
                                <asp:TemplateField HeaderText="emp009" SortExpression="emp009">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource3" DataTextField="emp002" DataValueField="emp001" SelectedValue='<%# Bind("emp009") %>'>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="emp002" DataValueField="emp001" Enabled="False" SelectedValue='<%# Bind("emp009") %>'>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="emptest" HeaderText="最後修改時間" SortExpression="emptest" />
                            </Columns>
                          </asp:GridView>
                  </div>
              </div>
           </div>
       </div>    
 
        <br />
        <asp:Label ID="Label2" runat="server" Text="新增資料"></asp:Label>
        <br />
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="emp001" DataSourceID="SqlDataSource5" DefaultMode="Insert">
            <EditItemTemplate>
                emp001:
                <asp:Label ID="emp001Label1" runat="server" Text='<%# Eval("emp001") %>' />
                <br />
                emp002:
                <asp:TextBox ID="emp002TextBox" runat="server" Text='<%# Bind("emp002") %>' />
                <br />
                emp003:
                <asp:TextBox ID="emp003TextBox" runat="server" Text='<%# Bind("emp003") %>' />
                <br />
                emp004:
                <asp:TextBox ID="emp004TextBox" runat="server" Text='<%# Bind("emp004") %>' />
                <br />
                emp005:
                <asp:TextBox ID="emp005TextBox" runat="server" Text='<%# Bind("emp005") %>' />
                <br />
                emp006:
                <asp:TextBox ID="emp006TextBox" runat="server" Text='<%# Bind("emp006") %>' />
                <br />
                emp007:
                <asp:TextBox ID="emp007TextBox" runat="server" Text='<%# Bind("emp007") %>' />
                <br />
                emp008:
                <asp:TextBox ID="emp008TextBox" runat="server" Text='<%# Bind("emp008") %>' />
                <br />
                emp009:
                <asp:TextBox ID="emp009TextBox" runat="server" Text='<%# Bind("emp009") %>' />
                <br />
                emptest:
                <asp:TextBox ID="emptestTextBox" runat="server" Text='<%# Bind("emptest") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
            </EditItemTemplate>
            <InsertItemTemplate>
                姓名
                <asp:TextBox ID="emp002TextBox" runat="server" Text='<%# Bind("emp002") %>' />
                <br />
                身份ID
                <asp:TextBox ID="emp003TextBox" runat="server" Text='<%# Bind("emp003") %>' />
                <br />
                性別 
                <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="SqlDataSource4" DataTextField="emp004" DataValueField="emp004" SelectedValue='<%# Bind("emp004") %>'>
                </asp:DropDownList>
                <br />
                生日
                <asp:TextBox ID="emp005TextBox" runat="server" Text='<%# Bind("emp005") %>' />
                <br />
                職級
                <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="SqlDataSource2" DataTextField="emptitle_002" DataValueField="emptitle_001"  SelectedValue='<%# Bind("emp006") %>'>
                </asp:DropDownList>
                <br />
                地址
                <asp:TextBox ID="emp008TextBox" runat="server" Text='<%# Bind("emp008") %>'></asp:TextBox>
                <br />
                直屬主管&nbsp;<asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="SqlDataSource3" DataTextField="emp002" DataValueField="emp001"  SelectedValue='<%# Bind("emp009") %>'>
                </asp:DropDownList>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="插入" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
            </InsertItemTemplate>
            <ItemTemplate>
                emp001:
                <asp:Label ID="emp001Label" runat="server" Text='<%# Eval("emp001") %>' />
                <br />
                emp002:
                <asp:Label ID="emp002Label" runat="server" Text='<%# Bind("emp002") %>' />
                <br />
                emp003:
                <asp:Label ID="emp003Label" runat="server" Text='<%# Bind("emp003") %>' />
                <br />
                emp004:
                <asp:Label ID="emp004Label" runat="server" Text='<%# Bind("emp004") %>' />
                <br />
                emp005:
                <asp:Label ID="emp005Label" runat="server" Text='<%# Bind("emp005") %>' />
                <br />
                emp006:
                <asp:Label ID="emp006Label" runat="server" Text='<%# Bind("emp006") %>' />
                <br />
                emp007:
                <asp:Label ID="emp007Label" runat="server" Text='<%# Bind("emp007") %>' />
                <br />
                emp008:
                <asp:Label ID="emp008Label" runat="server" Text='<%# Bind("emp008") %>' />
                <br />
                emp009:
                <asp:Label ID="emp009Label" runat="server" Text='<%# Bind("emp009") %>' />
                <br />
                emptest:
                <asp:Label ID="emptestLabel" runat="server" Text='<%# Bind("emptest") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="刪除" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="新增" />
            </ItemTemplate>
        </asp:FormView>
     </form>
</body>
</html>
