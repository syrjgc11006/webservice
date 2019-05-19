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

public partial class Content : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //访问webservice数据
        localhost.Service Service = new localhost.Service();

        //显示帖子标题,通过主题的nodeId属性来获得，该nodeId在数据空中有
        DataSet titleListDS = Service.GetTitle(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
        DataList1.DataSource = titleListDS.Tables["TitleList"].DefaultView;
        DataList1.DataBind();

        //显示帖子内容
        DataSet ContentDS = Service.GetContent(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
        DataList2.DataSource = ContentDS.Tables["NoteContent"].DefaultView;
        DataList2.DataBind();

        //如果该帖子由用户发布，则编辑帖子按钮可见
        //if ((Session["username"] != null) && (Session["username"].ToString() == titleListDS.Tables["TitleList"].Rows[0].ItemArray[4].ToString().Trim().ToLower()))
        //{
        //    editBtn.Visible = true;
        //}
        if ((Session["username"] != null) && Session["username"].ToString().Equals(titleListDS.Tables["TitleList"].Rows[0].ItemArray[4].ToString().Trim(), StringComparison.OrdinalIgnoreCase))
        {
            editBtn.Visible = true;
        }
    }

    //编辑帖子按钮
    protected void editBtn_Click(object sender, EventArgs e)
    {
        //将帖子ID作为参数，重定向到编辑页面,在编辑页面中修改帖子内容
        Response.Redirect("EditContent.aspx?" + Request.QueryString.GetValues(0)[0]);
    }

    //回复帖子
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
            //若用户没有登陆　跳转到错误页面
            if (Session["usernick"] == null)
            {
                Response.Redirect("ErrorMsg.aspx");
                return;
            }

            //添加留言
            
            localhost.Service myBBS = new localhost.Service();
            
            //通过选择不同的分区来获得分区的id，并且通过当前的用户名、昵称名来更新数据库中的信息
            int state = myBBS.AppearRes(Convert.ToInt32(Request.QueryString.GetValues(0)[0]), ContentTbx.Text.ToString(), Session["usernick"].ToString(), Session["username"].ToString());
            
            if (state == 1)
            {
                //显示留言成功 并重新显示用户回复
                lblMsg.Text = "留言成功";

                localhost.Service bbsDb = new localhost.Service();
                //获取更新后的回复内容
                DataSet ContentDS = bbsDb.GetContent(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
                DataList2.DataSource = ContentDS.Tables["NoteContent"].DefaultView;
                DataList2.DataBind();
            }
            else
                lblMsg.Text = "留言失败";
            return;
        }
}