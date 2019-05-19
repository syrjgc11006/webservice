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

public partial class Passport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //显示用户信息
        localhost.Service myBBS = new localhost.Service();

        DataSet userInforDS = myBBS.GetUserInfo(Session["username"].ToString());
        DataList1.DataSource = userInforDS.Tables["UserInfor"].DefaultView;
        DataList1.DataBind();

        //显示所有用户发表的帖子
        DataSet titleListDS1 = myBBS.GetUserTitle(Session["username"].ToString(), "站务通知");
        DataList2.DataSource = titleListDS1.Tables["TitleList"].DefaultView;
        DataList2.DataBind();
        DataSet titleListDS2 = myBBS.GetUserTitle(Session["username"].ToString(), "文化艺术");
        DataList4.DataSource = titleListDS2.Tables["TitleList"].DefaultView;
        DataList4.DataBind();
        DataSet titleListDS3 = myBBS.GetUserTitle(Session["username"].ToString(), "休闲娱乐");
        DataList5.DataSource = titleListDS3.Tables["TitleList"].DefaultView;
        DataList5.DataBind();
        DataSet titleListDS4 = myBBS.GetUserTitle(Session["username"].ToString(), "学习天地");
        DataList6.DataSource = titleListDS4.Tables["TitleList"].DefaultView;
        DataList6.DataBind();
        DataSet titleListDS5 = myBBS.GetUserTitle(Session["username"].ToString(), "信息技术");
        DataList7.DataSource = titleListDS5.Tables["TitleList"].DefaultView;
        DataList7.DataBind();
    }


    //修改个人信息，导航到修改个人信息的页面
    protected void ModBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Modify.aspx");
    }
}
