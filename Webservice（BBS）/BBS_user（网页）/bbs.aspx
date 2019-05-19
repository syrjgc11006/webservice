<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="bbs.aspx.cs" Inherits="bbs" Title="讨论区" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
      <asp:Label ID="lblName" runat="server" Text="站务通知" Visible="False"></asp:Label>
      <asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" 
          Visible="False"></asp:Label>
    &nbsp;<br />
</div>
<!--主题列表的详细信息-->
主题列表：
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True"  
        CssClass="GridViewSty" onpageindexchanging="GridView1_PageIndexChanging">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Wrap="False" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <PagerSettings Mode="NumericFirstLast" />
    </asp:GridView>
    <hr /> 
<!--发表主题的详细信息-->    
     <asp:Label ID="lblMsg" runat="server"></asp:Label><br />
       发表新主题：<br /><asp:TextBox ID="titleTbx" runat="server" CssClass="titleTbx" ></asp:TextBox><br />
       内容：<br />
    <asp:TextBox ID="contTbx" runat="server" TextMode="MultiLine" CssClass="contentTbx" ></asp:TextBox><br />
    <asp:ImageButton ID="ImageButton1" ImageUrl="~/App_Themes/image/appear.gif" 
        runat=server onclick="ImageButton1_Click" style="height: 30px"/>
</asp:Content>

