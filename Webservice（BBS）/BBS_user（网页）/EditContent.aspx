<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="EditContent.aspx.cs" Inherits="EditContent" Title="修改主题信息" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
   <asp:Label id="lblName" runat="server" Visible="False" Text="Welcome"></asp:Label>
   <asp:Label id="lblImgUrl" runat="server" Visible="False" Text="~/App_Themes/image/Smile.bmp"></asp:Label>
</div>

<div>
     <table cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td align="left" colspan="2" class="td1">
                        <asp:TextBox ID="titleTbx" runat="server" Width="478px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td align="center" class="td2">
                        <asp:Label ID="lblUser" runat="server" Font-Size="9pt"></asp:Label></td>
                    <td align="left" class="td3">
                        <asp:Label ID="lblTime" runat="server" Font-Size="9pt"></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" class="td2">
                    </td>
                    <td align="left" class="td5">
                        <asp:TextBox ID="txtContent" runat="server" Height="121px" Width="391px" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
            </table>
</div>

<div>
    <asp:Button ID="editBtn" runat="server" Text="修改主题" onclick="editBtn_Click" />
    <asp:Button ID="backBtn" runat="server" Text="返回列表" onclick="backBtn_Click" /><br />
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
</div>
</asp:Content>

