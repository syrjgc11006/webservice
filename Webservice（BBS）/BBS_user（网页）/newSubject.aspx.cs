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

public partial class newSubject : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //添加新投票事件
    protected void btnNewSubject_Click(object sender, EventArgs e)
    {
        localhost.Service myBBS = new localhost.Service();

        //若投票标题不为空，检查该投票项目是否存在，如果存在则不会更新
        //如果该项已经存在则为false，否则为true，如果该项不存在

        if (myBBS.CheckSubject(SubNameTbx.Text.Trim()) == true && SubNameTbx.Text.Trim()!="")
        {
            //新增投票主题

            //更新subject表
            myBBS.NewSubject(SubNameTbx.Text.Trim());

            //根据投票项目名称来获取投票项目的id号，自增的
            int subjectId = myBBS.GetSubjectID(SubNameTbx.Text.Trim());

            //用‘|’代替"\r\n"，然后分割
            string[] OptionNameList = OptionNameTbx.Text.Replace("\r\n", "|").Split('|');
            //添加新投票项
            for (int i = 0; i < OptionNameList.Length; i++)
            {
                if (!OptionNameList[i].Trim().Equals(""))
                {
                    //添加投票主题

                    //更新ballot表
                    myBBS.AddBallotItem(subjectId, OptionNameList[i]);
                }
            }
            //清空文本框
            SubNameTbx.Text = "";
            OptionNameTbx.Text = "";
            //显示操作结果信息
            Response.Write("<script>window.alert('新投票添加成功！')</script>");
        }
        else
        {
            lblcheck.Visible = true;
        }
    }
}
