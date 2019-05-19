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

public partial class ballot : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //若页面首次加载 如果用户没有登陆 跳转到错误页面
        if (IsPostBack == false)
        {
            if (Session["usernick"] == null)
            {
                Response.Redirect("ErrorMsg.aspx");
            }
            //Request.QueryString.GetValues(0)[0])获取的是subjectid，即投票项的id号

            BallotBind(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));

            BallotItemsBind(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
        }
    }

    // 投票选项GridView绑定
    private void BallotItemsBind(int id)
    {
        localhost.Service myBBS = new localhost.Service();
        //BBS_DataBase myBBS = new BBS_DataBase();
        // 数据绑定
        DataSet myDataSet = new DataSet();
        myDataSet = myBBS.GetBallotRes(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
        BallotGV.DataSource = myDataSet.Tables["Ballot"];
        BallotGV.DataBind();
        ViewState["Ballot"] = myDataSet;
    }


    // 投票结果GridView绑定
    private void BallotBind(int subjectId)
    {
        // 数据绑定
        localhost.Service myBBS = new localhost.Service();
        DataSet myDataSet = new DataSet();
        myDataSet = myBBS.GetBallotRes(subjectId);
        balResult.DataSource = myDataSet.Tables["Ballot"];
        balResult.DataBind();
    }  
  
    //投票按钮事件
    protected void btnBallot_Click(object sender, EventArgs e)
    {
        localhost.Service myBBS = new localhost.Service();
        
        for (int i = 0; i < BallotGV.Rows.Count; i++)
        {
            // 获取模版列中的CheckBox控件
            CheckBox BallotCbx = (CheckBox)BallotGV.Rows[i].Cells[0].FindControl("checkBallot");
            if (BallotCbx.Checked == true)
            {
                //更新投票

                // 摘要:
                //     获取状态信息的字典，这些信息使您可以在同一页的多个请求间保存和还原服务器控件的视图状态。
                //
                // 返回结果:
                //     包含服务器控件视图状态信息的 System.Web.UI.StateBag 类的实例。
                DataSet myDataSet = (DataSet)ViewState["Ballot"];
                //绑定到的字段，选择的是数据绑定控件中绑定到的字段，选择的是第i行中标识为OptionID在Ballot中的元素
                int BallotId = Convert.ToInt32(myDataSet.Tables["Ballot"].Rows[i]["OptionID"]);
                //获取投票项目的id（subjectId），获取绑定到字段，这里为投票分区的subjectId
                myBBS.UpdateBallot(BallotId, Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
            }
        }
        //重新显示投票
        BallotBind(Convert.ToInt32(Request.QueryString.GetValues(0)[0]));
    }
}
