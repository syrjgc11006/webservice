<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Passport.aspx.cs" Inherits="Passport" Title="个人信息" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
<asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible="false"></asp:Label>
    个人信息：<br />
    <asp:DataList ID="DataList1" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            用户姓名：<asp:Label ID="lblName" runat="server" Text='<%# Eval("userName") %>'></asp:Label><br />
            用户昵称：<asp:Label ID="lblNick" runat="server" Text='<%# Eval("userNick") %>'></asp:Label><br />
            Email： &nbsp; &nbsp; &nbsp;&nbsp;
            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("userEmail") %>'></asp:Label><br />
            个人说明：<asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" Text='<%# Eval("userMark") %>'
                TextMode="MultiLine"></asp:TextBox>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList>
    <asp:Button ID="ModBtn" runat="server" OnClick="ModBtn_Click" Text="修改个人信息" />
   <hr />  
    最近发布的帖子列表：<br />
   <hr />  
    站务通知：<br />
    <asp:DataList ID="DataList2" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "Content.aspx?"+Eval("noteId") %>' Text='<%# Eval("noteTitle") %>'></asp:HyperLink>
            <asp:Label ID="lblTime" runat="server" Text='<%# Eval("contTime") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList>
   <hr />  
   文化艺术：<br />
    <asp:DataList ID="DataList4" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "Content.aspx?"+Eval("noteId") %>'
                Text='<%# Eval("noteTitle") %>'></asp:HyperLink>
            <asp:Label ID="lblTime" runat="server" Text='<%# Eval("contTime") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList> 
   <hr />  
   休闲娱乐：<br />
    <asp:DataList ID="DataList5" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "Content.aspx?"+Eval("noteId") %>'
                Text='<%# Eval("noteTitle") %>'></asp:HyperLink>
            <asp:Label ID="lblTime" runat="server" Text='<%# Eval("contTime") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList> 
   <hr />  
   学习天地：<br />
    <asp:DataList ID="DataList6" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "Content.aspx?"+Eval("noteId") %>'
                Text='<%# Eval("noteTitle") %>'></asp:HyperLink>
            <asp:Label ID="lblTime" runat="server" Text='<%# Eval("contTime") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList> 
   <hr />  
   信息技术：<br />
    <asp:DataList ID="DataList7" runat="server" CellPadding="4" ForeColor="#333333">
        <ItemTemplate>
            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "Content.aspx?"+Eval("noteId") %>'
                Text='<%# Eval("noteTitle") %>'></asp:HyperLink>
            <asp:Label ID="lblTime" runat="server" Text='<%# Eval("contTime") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <AlternatingItemStyle BackColor="White" />
        <ItemStyle BackColor="#EFF3FB" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    </asp:DataList>
</asp:Content>

