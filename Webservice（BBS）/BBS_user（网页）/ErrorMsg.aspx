<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="ErrorMsg.aspx.cs" Inherits="ErrorMsg" Title="错误页面" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
    <asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible="False"></asp:Label>
  <%--  <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/App_Themes/image/Smile.bmp" />--%>
    <asp:Label ID="Label1" runat="server">对不起 您没有权限 请先注册！</asp:Label>
</asp:Content>

