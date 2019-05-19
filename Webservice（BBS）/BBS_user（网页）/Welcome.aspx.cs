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

public partial class Welcome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //如果是首次进入页面，设置全局变量的时间为30s
        if (!IsPostBack)
        {
            Session.Timeout = 30;
        }

        //获得论坛各分区当天最新的帖子 绑定到gridview中去
        localhost.Service Service = new localhost.Service();
//------------------------------------站务通知信息------------------------
        
        //如果当天没有更新的帖子,则不会显示信息，
        DataSet titleListDS1 = Service.GetNewList("站务通知");
        GridView1.DataSource = titleListDS1.Tables["TitleList"];
        GridView1.DataBind();
//------------------------------------文化艺术信息------------------------

        DataSet titleListDS2 = Service.GetNewList("文化艺术");
        GridView2.DataSource = titleListDS2.Tables["TitleList"].DefaultView;
        GridView2.DataBind();
//------------------------------------信息技术信息------------------------
        DataSet titleListDS3 = Service.GetNewList("信息技术");
        GridView3.DataSource = titleListDS3.Tables["TitleList"].DefaultView;
        GridView3.DataBind();
//------------------------------------休闲娱乐信息------------------------
        DataSet titleListDS4 = Service.GetNewList("休闲娱乐");
        GridView4.DataSource = titleListDS4.Tables["TitleList"].DefaultView;
        GridView4.DataBind();
//------------------------------------学习天地信息------------------------
        DataSet titleListDS5 = Service.GetNewList("学习天地");
        GridView5.DataSource = titleListDS5.Tables["TitleList"].DefaultView;
        GridView5.DataBind();
//------------------------------------显示当前投票信息------------------------
        DataSet BallotList = Service.ShowSubjects();
        GridView6.DataSource = BallotList.Tables["Subject"];
        GridView6.DataBind();
    }

    //点击发起投票事件
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //如果没有用户登录，转到错误页面
        if (Session["usernick"] == null)
        {
            Response.Redirect("ErrorMsg.aspx");
            return;
        }
        //重定向到发表投票页面
        Response.Redirect("newSubject.aspx");
    }
}
