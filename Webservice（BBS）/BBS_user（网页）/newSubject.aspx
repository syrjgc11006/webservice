<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="newSubject.aspx.cs" Inherits="newSubject" Title="添加投票项目" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
<asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible="false"></asp:Label>
    <table style="width: 800px">
        <tr>
            <td align="right" style="width: 15%; height: 29px;" valign="top">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="10pt" Text="新主题："></asp:Label>
            </td>
            <td align="left" colspan="2" valign="top" style="height: 29px">
                <asp:TextBox ID="SubNameTbx" runat="server" Width="300px"></asp:TextBox>
                <asp:Label ID="lblcheck" runat="server" Font-Size="9pt" ForeColor="Red" Text="**主题名称已经存在或者投票项目不存在！"
                    Visible="False"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 15%" valign="top">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="10pt" Text="投票选项："></asp:Label>
                <br />
            </td>
            <td align="left" style="width: 65%" valign="top">
                <asp:TextBox ID="OptionNameTbx" runat="server" Rows="10" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
            <td align="left" style="width: 20%" valign="top">
                &nbsp;<asp:Label ID="Label3" runat="server" Font-Size="9pt" Text="*每一行为一个选项"></asp:Label></td>
        </tr>
        <tr>
            <td align="center" colspan="3" valign="middle">
                <asp:Button ID="btnNewSubject" runat="server" OnClick="btnNewSubject_Click" Text="发布新话题" /></td>
        </tr>
    </table>
</asp:Content>

