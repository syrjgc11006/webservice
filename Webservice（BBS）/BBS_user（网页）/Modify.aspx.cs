using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Modify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string username;
        //获得用户名
        username = Session["username"].ToString();
        //显示用户名
        localhost.Service myBBS = new localhost.Service();
        //获得用户表信息
        DataSet myDataSet = myBBS.GetUserInfo(username);

        GridView1.DataSource = myDataSet.Tables["UserInfor"].DefaultView;
        //使用该信息与表格绑定
        GridView1.DataBind();
    }

    //确认修改该信息
    protected void modifyBtn_Click(object sender, EventArgs e)
    {
        //更新用户信息
        localhost.Service myBBS = new localhost.Service();

        string[] userMsg = { Session["username"].ToString(), nickTbx.Text.ToString(), keyTbx.Text.ToString(), emailTbx.Text.ToString(), markTbx.Text.ToString() };
        int state = myBBS.UpdateUser(userMsg);
        //如果成功显示 成功更新
        if (state == 1)
        {
            Response.Write("更新成功!");
        }
        else
        {
            Response.Write("更新失败!");
        }
    }
    //返回
    protected void backBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Welcome.aspx");
    }
}
