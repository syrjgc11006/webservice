<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Modify.aspx.cs" Inherits="Modify" Title="修改用户信息" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
    <asp:Label ID="lblImgUrl" runat="server" Text="~/Image/Smile.bmp" Visible="False"></asp:Label>
<div>
    <asp:GridView ID="GridView1" runat="server">
    </asp:GridView>如果要修改信息 请重新填写如下信息：<br />
        昵称： &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:TextBox ID="nickTbx" runat="server" ValidationGroup="ModInfor"></asp:TextBox>
        <asp:RequiredFieldValidator ID="nickValidator" runat="server" ControlToValidate="nickTbx"
            ErrorMessage="昵称不能为空" ValidationGroup="ModInfor"></asp:RequiredFieldValidator><br />
        密码： &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:TextBox ID="keyTbx" runat="server" TextMode="Password" ValidationGroup="ModInfor"></asp:TextBox>&nbsp;
        <asp:RequiredFieldValidator ID="KeyValidator1" runat="server" ControlToValidate="keyTbx"
            ErrorMessage="密码不能为空" ValidationGroup="ModInfor"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="KeyCompareValidator1" runat="server" ControlToCompare="keyTbx"
            ControlToValidate="keyAgTbx" ErrorMessage="密码错误" ValidationGroup="ModInfor"></asp:CompareValidator><br />
        再次输入密码：<asp:TextBox ID="keyAgTbx" runat="server" TextMode="Password" ValidationGroup="ModInfor"></asp:TextBox><br />
        Emai： &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:TextBox ID="emailTbx"
            runat="server" ValidationGroup="ModInfor"></asp:TextBox>&nbsp;
        <asp:RequiredFieldValidator ID="emailVali" runat="server" ControlToValidate="emailTbx"
            ErrorMessage="Email不能为空" ValidationGroup="ModInfor"></asp:RequiredFieldValidator><br />
        备注： &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:TextBox ID="markTbx" runat="server"></asp:TextBox>
    &nbsp; &nbsp; &nbsp;
        <asp:Button ID="modifyBtn" runat="server" Text="修改信息" ValidationGroup="ModInfor" OnClick="modifyBtn_Click" />
    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;<asp:Button ID="backBtn" runat="server" OnClick="backBtn_Click"
        Text="返回" /><br />
    &nbsp;<br />
    <br />
</div>
</asp:Content>

