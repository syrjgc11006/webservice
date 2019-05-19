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

public partial class bbs : System.Web.UI.Page
{
    //获得讨论分区
    public string GetSection(string se)
    {
        //获得讨论分区名
        switch (se)
        {
            case "zw":
                return "站务通知"; 
            case "wh":
                return "文化艺术";
            case "xx":
                return "休闲娱乐"; 
            case "td":
                return "学习天地"; 
            case "js":
                return "信息技术";
        }
        return "";
    }

    //根据论坛分区选择不同的图标
    public void IconImage()
    {
        //根据论坛分区选择不同的图标
        switch (Session["section"].ToString())
        {
            case "td":
                lblImgUrl.Text = "~/App_Themes/image/study.gif";
                break;
            case "zw":
                lblImgUrl.Text = "~/App_Themes/image/zw.JPG";
                break;
            case "wh":
                lblImgUrl.Text = "~/App_Themes/image/wh.JPG";
                break;
            case "xx":
                lblImgUrl.Text = "~/App_Themes/image/xx.gif";
                break;
            case "js":
                lblImgUrl.Text = "~/App_Themes/image/js.JPG";
                break;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string sec;
        //若是页面首次被加载，获得讨论分区
        if (!IsPostBack)
        {
            //赋值，保存在服务端作为全局变量，当浏览器关闭时session失效
            //获取HTTP查询字符串变量集合
            Session["section"] = Request.QueryString.GetValues(0)[0].ToString ();
        }
        sec = GetSection(Session["section"].ToString());
        //显示论坛分区
        lblName.Text = sec;
        //根据不同的论坛分区显示不同的图标
        IconImage();
        //显示相应的论坛分区帖子列表
        localhost.Service Service = new localhost.Service();
        DataSet titleListDS = Service.GetSortList(sec);
        GridView1.DataSource = titleListDS.Tables["TitleList"].DefaultView;

        //绑定并显示留言帖标题
        GridView1.DataBind();
    }

    //当前索引正在改变时激发，换到新一页中
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridView换页代码
        //获取或设置当前显示页的索引
        GridView1.PageIndex = e.NewPageIndex;
       
        localhost.Service Service = new localhost.Service();
        
        //获取特定组的主题帖，获取的是当前的分区getsetction（）是方法，
        DataSet titleListDS = Service.GetSortList(GetSection(Session["section"].ToString()));
        //将当天分区内的所有信息显示在数据绑定控件中，当我们点击分区时通过导航直接到下一个页面
        GridView1.DataSource = titleListDS.Tables["TitleList"].DefaultView;
        GridView1.DataBind();
    }

    //发表新主题按钮（该主题是一个新区里面的主题，因此当我们要发表新主题时，应该是先获取新区的id号，根据id号来更改数据库中的内容）
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //如果用户没有登陆 跳转到错误页面
        if (Session["usernick"] == null)
        {
            Response.Redirect("ErrorMsg.aspx");
            return;
        }
        //获得用户的经验值
        int exp = Convert.ToInt32(Session["userLevel"]);

        localhost.Service myBBS = new localhost.Service();
        
        //发表主题
        int state = myBBS.AppearTitle(Session["username"].ToString(), titleTbx.Text.ToString(), contTbx.Text.ToString(), GetSection(Session["section"].ToString()), Session["usernick"].ToString(), exp);
        //若成功发表 用户经验值加1 

        if (state == 1)
        {
            lblMsg.Text = "发布成功";
            
            //更新该分区讨论区的内容
            DataSet titleListDS = myBBS.GetSortList(GetSection(Session["section"].ToString()));

            GridView1.DataSource = titleListDS.Tables["TitleList"].DefaultView;

            GridView1.DataBind();
            titleTbx.Text = "";
            contTbx.Text = "";

            //经验值加1
            Session["userLevel"] = exp + 1;
        }
        //否则显示发布失败
        else
            lblMsg.Text = "发布失败";
        return;
    }
}
