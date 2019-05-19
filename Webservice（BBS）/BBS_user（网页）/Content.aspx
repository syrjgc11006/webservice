<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Content.aspx.cs" Inherits="Content" Title="回复用户信息" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
     <asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
    <asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible="False"></asp:Label><br />
</div>
<div>
    <asp:DataList ID="DataList1" runat="server">
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" class="table" >
                <tr>
                    <td align="left" colspan="2" class="td1">
                        <asp:Label ID="lblTitle" runat="server" Font-Size="9pt" Text='<%# Eval("noteTitle") %>' ></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" class="td2">
                        <asp:Label ID="lblName" runat="server" Font-Size="9pt" Text='<%# Eval("userNick") %>' ></asp:Label></td>
                    <td align="left" class="td3">
                        <asp:Label ID="lblTime" runat="server" Font-Size="9pt" Text='<%# "发布于 "+Eval("contTime") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" class="td4"></td>
                    <td align="left" class="td5">
                        <asp:TextBox ID="ContentTbx" runat="server" Enabled="False" Height="162px" TextMode="MultiLine"
                                    Width="500px" Text='<%# Eval("noteContent") %>' ForeColor="Black" ReadOnly="True"></asp:TextBox></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <hr />
    <asp:Button ID="editBtn" runat="server" Text="修改主题" onclick="editBtn_Click" 
        Visible="False" />
     <hr />
    <asp:DataList ID="DataList2" runat="server">
        <ItemTemplate>
            <div >
                <table cellpadding="0" cellspacing="0" class="table">
                    <tr>
                        <td align="center" class="td4">
                            <asp:Label ID="lblName" runat="server" Font-Size="9pt" Text='<%# Eval("userNick") %>' ></asp:Label></td>
                        <td align="left" class="td3">
                            <asp:Label ID="lblTime" runat="server" Font-Size="9pt" Text='<%# "回复于 "+Eval("noteTime") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="center" class="td2"></td>
                        <td align="left" class="td5">
                            <asp:TextBox ID="ContentTbx" runat="server" Enabled="False" Height="100px" TextMode="MultiLine"
                                    Width="500px" Text='<%# Eval("noteContent") %>'></asp:TextBox></td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <hr />
    <asp:TextBox ID="ContentTbx" runat="server" TextMode="MultiLine" CssClass="contentTbx" ></asp:TextBox><br />
    <asp:ImageButton ID="ImageButton1" ImageUrl="~/App_Themes/image/reply.gif" runat="server" OnClick="ImageButton1_Click"/>
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
</div>
</asp:Content>
