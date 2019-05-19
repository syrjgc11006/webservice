<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="ballot.aspx.cs" Inherits="ballot" Title="投票页面" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="lblName" runat="server" Text="Welcome" Visible="False"></asp:Label>
<asp:Label ID="lblImgUrl" runat="server" Text="~/App_Themes/image/Smile.bmp" Visible="false"></asp:Label>
    <asp:GridView ID="BallotGV" runat="server" AutoGenerateColumns="False" Font-Size="10pt" Width="531px"
       >
        <Columns>
            <asp:BoundField DataField="OptionID" Visible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="checkBallot" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="OPTIONNAME" HeaderText="投票选项">
            </asp:BoundField>
        </Columns>
        <PagerStyle HorizontalAlign="Left" Wrap="False" />
        <HeaderStyle BackColor="#336699" />
    </asp:GridView>
    <asp:GridView ID="balResult" runat="server" AutoGenerateColumns="False" Font-Size="10pt" Width="532px" >
        <Columns>
            <asp:BoundField DataField="OptionName" HeaderText="投票选项">
            </asp:BoundField>
            <asp:BoundField DataField="CountNumber" HeaderText="票数">
            </asp:BoundField>
        </Columns>
        <PagerStyle  Wrap="False" />
        <HeaderStyle BackColor="#336699" />
    </asp:GridView>
    <asp:Button ID="btnBallot" runat="server" OnClick="btnBallot_Click" Text="我要投票" />
</asp:Content>

