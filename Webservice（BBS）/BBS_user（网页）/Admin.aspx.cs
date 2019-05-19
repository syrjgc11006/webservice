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

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //显示各个论坛分区的帖子列表
        //获取特定组的主题帖
        localhost.Service myBBS = new localhost.Service();
        DataSet titleListDS1 = myBBS.GetSortList("站务通知");
        GridView1.DataSource = titleListDS1.Tables["TitleList"].DefaultView;
        GridView1.DataBind();
        DataSet titleListDS2 = myBBS.GetSortList("文化艺术");
        GridView2.DataSource = titleListDS2.Tables["TitleList"].DefaultView;
        GridView2.DataBind();
        DataSet titleListDS3 = myBBS.GetSortList("信息技术");
        GridView3.DataSource = titleListDS3.Tables["TitleList"].DefaultView;
        GridView3.DataBind();
        DataSet titleListDS4 = myBBS.GetSortList("休闲娱乐");
        GridView4.DataSource = titleListDS4.Tables["TitleList"].DefaultView;
        GridView4.DataBind();
        DataSet titleListDS5 = myBBS.GetSortList("学习天地");
        GridView5.DataSource = titleListDS5.Tables["TitleList"].DefaultView;
        GridView5.DataBind();
        //显示投票列表
        DataSet BallotList = myBBS.ShowSubjects();
        GridView6.DataSource = BallotList.Tables["Subject"].DefaultView;
        GridView6.DataBind();            
    }
      //GridView分页代码
    public void GridView_PageIndexChanging(GridView newGirdView, string sec, object sender, GridViewPageEventArgs e)
    {
        newGirdView.PageIndex = e.NewPageIndex;

        localhost.Service myBBS = new localhost.Service();
        //获取讨论分区的主题
        DataSet titleListDS = myBBS.GetSortList(sec);

        newGirdView.DataSource = titleListDS.Tables["TitleList"].DefaultView;
        newGirdView.DataBind();
    }

    //主要是为了满足实现翻页的效果
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_PageIndexChanging(GridView1, "站务通知", sender, e);
    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_PageIndexChanging(GridView2, "文化艺术", sender, e);
    }
    protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_PageIndexChanging(GridView3, "信息技术", sender, e);
    }
    protected void GridView4_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_PageIndexChanging(GridView4, "休闲娱乐", sender, e);
    }
    protected void GridView5_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView_PageIndexChanging(GridView5, "学习天地", sender, e);
    }

    //GridView删除代码
    public void GridView_RowDeleting(GridView newGridView, string sec, object sender, GridViewDeleteEventArgs e)
    {
        localhost.Service myBBS = new localhost.Service();

        DataSet titleListDS = myBBS.GetSortList(sec);
        //获得删除帖子Id
        int id = Convert.ToInt32(titleListDS.Tables["TitleList"].Rows[e.RowIndex].ItemArray[3].ToString());
        try
        {
            myBBS.DelNote(id);
            lblMsg.Text = "删除成功！";
        }
        catch
        {
            lblMsg.Text = "删除失败！";

        }
        titleListDS = myBBS.GetSortList(sec);
        newGridView.DataSource = titleListDS.Tables["TitleList"].DefaultView;
        //绑定并显示留言贴标题
        newGridView.DataBind();
    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView_RowDeleting(GridView1, "站务通知", sender, e);
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView_RowDeleting(GridView2, "文化艺术", sender, e);
    }
    protected void GridView3_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView_RowDeleting(GridView3, "信息技术", sender, e);
    }
    protected void GridView4_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView_RowDeleting(GridView4, "休闲娱乐", sender, e);
    }
    protected void GridView5_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView_RowDeleting(GridView5, "学习天地", sender, e);
    }

    //删除投票
    protected void GridView6_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
             localhost.Service myBBS = new localhost.Service();
            DataSet SubjectsListDS = myBBS.ShowSubjects();
            //获得删除投票Id
            int id = Convert.ToInt32(SubjectsListDS.Tables["Subject"].Rows[e.RowIndex].ItemArray[0].ToString());
            try
            {
                myBBS.DeleteSubject(id);
                lblMsg.Text = "删除成功！";
            }
            catch
            {
                lblMsg.Text = "删除失败！";

            }
            SubjectsListDS = myBBS.ShowSubjects();
            GridView6.DataSource = SubjectsListDS.Tables["Subject"].DefaultView;
            //绑定并显示投票标题
            GridView6.DataBind();
        }
    }
