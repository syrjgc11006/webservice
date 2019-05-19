<%@ Control Language="C#" AutoEventWireup="true" CodeFile="bbsSide.ascx.cs" Inherits="UserControl_bbsSide" %>
<asp:Panel ID="Panel1" runat="server" CssClass="SidePanel" >
    <asp:Panel ID="MenuPanel" runat="server" >
            <hr /> 
        链接：<br />
        <hr /> 
        <asp:SiteMapDataSource ID="SiteData" runat="server" />
        <asp:Menu ID="Menu1" runat="server" CssClass="Menu" DataSourceID="SiteData" 
                StaticDisplayLevels="2" StaticSubMenuIndent="10px" BackColor="#FFFBD6" 
                DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="0.8em" 
                ForeColor="#990000" >
            <StaticSelectedStyle BackColor="#FFCC66" />
            <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <DynamicHoverStyle BackColor="#990000" ForeColor="White" />
            <DynamicMenuStyle BackColor="#FFFBD6" />
            <DynamicSelectedStyle BackColor="#FFCC66" />
            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <StaticHoverStyle BackColor="#990000" ForeColor="White" />
        </asp:Menu>
    </asp:Panel> 
   <hr />  
    <asp:Panel ID="LoginPanel" runat="server" >
        
        <asp:Label ID="Label1" runat="server" Text="用户登录">
        </asp:Label>
        <hr />
        <br />
        <asp:Label ID="Label2" runat="server" Text="用户名：" CssClass="LeftLabel"></asp:Label><br />
        <asp:TextBox ID="nameTbx" runat="server" CssClass="TextBox"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="密码：" CssClass="LeftLabel"></asp:Label><br />
        <asp:TextBox ID="passTbx" runat="server" CssClass="TextBox" TextMode="Password"></asp:TextBox>        
        <br />
        <br />
        <asp:RequiredFieldValidator ID="usernameValidator" runat="server" ControlToValidate="nameTbx" ErrorMessage="用户名不能为空" ValidationGroup="masterCheck" CssClass="FieldValidator"></asp:RequiredFieldValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="passTbx"
            CssClass="FieldValidator" ErrorMessage="密码不能为空" ValidationGroup="masterCheck"></asp:RequiredFieldValidator><br />
        <asp:Button ID="loginBtn" runat="server" Text="登录" ValidationGroup="masterCheck" OnClick="loginBtn_Click" />
        <asp:Button ID="regBtn" runat="server" Text="注册" CausesValidation="False" OnClick="regBtn_Click" /><br />
        <asp:Label ID="lblErr" runat="server" CssClass="ErrMsg" Visible="False"></asp:Label></asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Height="50px" Visible="False" Width="125px">
        <asp:Label ID="lblWel" runat="server" Text="Welcome !" Visible="False"></asp:Label>
        <asp:Label ID="lblFal" runat="server"></asp:Label><br />
        <asp:Label ID="lblIp" runat="server"></asp:Label><br />
        <br />
        Your Level<hr/>
        <asp:Image ID="LevelImg" runat="server" /><br />
        <asp:Label ID="lblexp" runat="server" ></asp:Label><br />
        <asp:Button ID="ModBtn" runat="server" Text="个人中心" OnClick="ModBtn_Click" /><br />
        <asp:Button ID="adminBtn" runat="server" Text="发帖管理" Visible="False" 
            OnClick="adminBtn_Click" Height="26px" /><br />
        <asp:Button ID="outBtn" runat="server" OnClick="outBtn_Click" Text="注销" /></asp:Panel>
</asp:Panel>
