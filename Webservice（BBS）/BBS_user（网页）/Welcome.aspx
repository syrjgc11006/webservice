<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="Welcome" Title="欢迎界面" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
<!--提示每次进入系统时欢迎界面的图标及提示语-->
 <asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
 <%--<asp:Label ID="lblImgUrl" runat="server" Text="~App_Themes/image/Smile.bmp" Visible="False"></asp:Label>--%>
 <asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible ="false"></asp:Label>
<%-- <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/App_Themes/image/appear.gif" />--%>
    今天发布的帖子列表<br />
</div>    
<div>
<!--站务管理模块信息-->  
  <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="bbs.aspx?zw">站务管理</asp:HyperLink><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty" >
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
<!--文化艺术模块信息-->
  <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="bbs.aspx?wh">文化艺术</asp:HyperLink><asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />   
<!--信息技术模块信息--> 
<asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="bbs.aspx?js">信息技术</asp:HyperLink><br />
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
<!--休闲娱乐模块信息--> 
 <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="bbs.aspx?xx">休闲娱乐</asp:HyperLink><br />
    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
<!--学习天地模块信息--> 
<asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="bbs.aspx?td">学习天地</asp:HyperLink><br />
    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="noteId" DataNavigateUrlFormatString="Content.aspx?{0}"
                DataTextField="noteTitle" HeaderText="主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="userNick" HeaderText="作者">
                <ItemStyle Width="90px" />
            </asp:BoundField>
            <asp:BoundField DataField="contTime" HeaderText="发表时间">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
<!--在线投票模块信息--> 
     在线投票<br />
      <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" CssClass="GridViewSty">
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="SubjectId" DataNavigateUrlFormatString="ballot.aspx?{0}"
                DataTextField="SubjectName" HeaderText="投票主题">
                <ItemStyle Width="600px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="SumNumber" HeaderText="投票数">
                <ItemStyle Width="90px" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <EditRowStyle BackColor="#999999" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <asp:ImageButton ID="ImageButton1" runat="server" 
        ImageUrl="~/App_Themes/image/toupiao.gif" onclick="ImageButton1_Click" 
        style="width: 72px"/>
</div>
    
</asp:Content>

