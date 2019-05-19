<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Regedit.aspx.cs" Inherits="Regedit" Title="登录注册页面" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblName" runat="server" Text="Regedit" Visible="false"></asp:Label>
   <%-- <asp:Label ID="lblImgUrl" runat="server" Text="~App_Themes/image/Smile.bmp" Visible="false"></asp:Label>--%>
    <asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible=false></asp:Label>
    <%--<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App_Themes/image/Smile.bmp" />--%>
    <br />
    以下为必填项目：<hr />
    <br />
<div>
    <table align="center" 
    style="width: auto; text-align: center; ">
    <tr>
        <td style="height: 30px">
            用户名:</td>
        <td style="height: 30px">
            <asp:TextBox ID="nametxt" runat="server"></asp:TextBox>
        </td>
        <td style="height: 30px">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="nametxt" ErrorMessage="用户名不能为空" SetFocusOnError="True"></asp:RequiredFieldValidator>
        </td>
        <td style="width: 1px; height: 30px;">
            <asp:Button ID="cheknamebtn" runat="server" Text="检查用户是否被使用" 
                onclick="cheknamebtn_Click" CausesValidation="False" />
        </td>
        <td style="width: 1px; height: 30px;">
            <asp:Label ID="msgLable" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="height: 23px">
            昵称:</td>
        <td style="height: 23px">
            <asp:TextBox ID="nicknametxt" runat="server"></asp:TextBox>
        </td>
        <td style="height: 23px">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="nicknametxt" ErrorMessage="昵称不能为空"></asp:RequiredFieldValidator>
        </td>
        <td style="height: 23px; width: 1px">
            </td>
        <td style="height: 23px; width: 1px">
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            密码:</td>
        <td>
            <asp:TextBox ID="keytbx" runat="server"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="keytbx" ErrorMessage="密码不能为空"></asp:RequiredFieldValidator>
        </td>
        <td style="width: 1px">
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            重新输入密码:</td>
        <td>
            <asp:TextBox ID="keyagtxt" runat="server"></asp:TextBox>
        </td>
        <td>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToCompare="keytbx" ControlToValidate="keyagtxt" ErrorMessage="两次密码不一致" 
                SetFocusOnError="True"></asp:CompareValidator>
        </td>
        <td style="width: 1px">
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 26px">
            电子邮件地址:</td>
        <td style="height: 26px">
            <asp:TextBox ID="emailtxt" runat="server"></asp:TextBox>
        </td>
        <td style="height: 26px">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="emailtxt" ErrorMessage="电子邮件不能为空"></asp:RequiredFieldValidator>
        </td>
        <td style="width: 1px; height: 26px;">
            </td>
        <td style="width: 1px; height: 26px;">
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            备注:</td>
        <td>
            <asp:TextBox ID="remarktxt" runat="server"></asp:TextBox>
        </td>
        <td>
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="regbtn" runat="server" Text="注册" onclick="regbtn_Click" 
                CausesValidation="False" />
        </td>
        <td>
            <asp:Label ID="lblReg" runat="server"></asp:Label>
        </td>
        <td>
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
        <td style="width: 1px">
            &nbsp;</td>
    </tr>
</table>
</div>
</asp:Content>

