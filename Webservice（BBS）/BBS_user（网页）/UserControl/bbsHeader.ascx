<%@ Control Language="C#" AutoEventWireup="true" CodeFile="bbsHeader.ascx.cs" Inherits="UserControl_bbsHeader" %>
<asp:Panel ID="headPanel1" runat="server" CssClass="HeadPanel">
    欢迎大家来到BBS论坛<asp:Image ID="rightImage" runat="server" CssClass="RightImage" 
        ImageUrl="~/App_Themes/image/internet.bmp" /><br />
    </asp:Panel>
<asp:Panel ID="headPanel2" runat="server" CssClass="HeadPanelLeft">
<asp:Image ID="ImgIcon" runat="server" CssClass="LeftImage" />
    <asp:Label ID="lblWelcome" runat="server" CssClass="LeftLabel"></asp:Label>
    <asp:SiteMapPath ID="crumb" runat="server" CssClass="HeadPanelPath">
    </asp:SiteMapPath>
</asp:Panel>
