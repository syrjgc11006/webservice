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

public partial class EditContent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //若页面首次加载，显示帖子标题内容
        if (!IsPostBack)
        {
            localhost.Service service = new localhost.Service();
            //显示当前主题的标题以及内容
            DataSet titleListDS = service.GetTitle(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
            DataRowView mydrview = titleListDS.Tables["TitleList"].DefaultView[0];
            //获取主题的内容
            txtContent.Text = Convert.ToString(mydrview.Row["noteContent"]);
            //获取主题的标题
            titleTbx.Text = Convert.ToString(mydrview.Row["noteTitle"]);
            //获取用户名
            lblUser.Text = Convert.ToString(mydrview.Row["userNick"]);
            //获取内容发表的日期
            lblTime.Text = Convert.ToString(mydrview.Row["contTime"]);
        }
    }

    //更新编辑后的帖子
    protected void editBtn_Click(object sender, EventArgs e)
    {
        //更新编辑后帖子（内容、时间）
        localhost.Service service = new localhost.Service();

        //Request.QueryString.GetValues(0)[0]获取上一页面中点击“站点文化”的id
        int state = service.AlterNote(Convert.ToInt32(Request.QueryString.GetValues(0)[0]), titleTbx.Text.ToString(), txtContent.Text.ToString());
        
        if (state == 1)
        {
            lblMsg.Text = "更新成功！";
            
            //更新时间
        }
        
        
        //将更新成功后的信息展现在我们的页面上    
        DataSet titleListDS = service.GetTitle(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
        //
        DataRowView mydrview = titleListDS.Tables["TitleList"].DefaultView[0];
        //更新内容
        txtContent.Text = Convert.ToString(mydrview.Row["noteContent"]);
        //更新标题
        titleTbx.Text = Convert.ToString(mydrview.Row["noteTitle"]);

    }

    //返回论坛首页
    protected void backBtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Welcome.aspx");
    }
}
