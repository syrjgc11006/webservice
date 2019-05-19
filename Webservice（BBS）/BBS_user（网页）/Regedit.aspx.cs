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

public partial class Regedit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    //注册页面
    protected void regbtn_Click(object sender, EventArgs e)
    {
        localhost.Service Service = new localhost.Service();
        //如果用户名已经被注册则报错后返回
        int state = Service.CheckUser(nametxt.Text.ToString().Trim());
        if (state == 1)
        {
            msgLable.Text = "用户已经被注册！";
            return;
        }
        //将用户信息放入字符串数组中进行注册
        else
        {
            string[] userMsg = new string[]
            { 
                nametxt.Text.ToString().Trim(),
                nicknametxt.Text .ToString().Trim(),
                keytbx.Text.ToString().Trim(),
                emailtxt.Text.ToString().Trim(),
                remarktxt.Text.ToString().Trim()
            };
            state = Service.Register(userMsg);

            //如果注册成功
            if (state == 1)
            {
                //注册成功后清空文本框
                lblReg.Text = "注册成功，请登录！";
                nametxt.Text = "";
                nicknametxt.Text = "";
                keytbx.Text = "";
                keyagtxt.Text = "";
                emailtxt.Text = "";
                remarktxt.Text = "";
            }
            else
            {
                //若注册失败则显示信息
                lblReg.Text = "注册失败！";
                return;
            }
        }
    }

    //检查用户名是否被注册
    protected void cheknamebtn_Click(object sender, EventArgs e)
    {
        //访问webservice数据层
        localhost.Service Service = new localhost.Service();
        //如果用户名已经被注册则报错后返回
        int state = Service.CheckUser(nametxt.Text.ToString().Trim());
        //如果查找到了该用户
        if (state == 1)
        {
            msgLable.Text = "用户名已经被注册！";
        }
        else
        {
            msgLable.Text = "用户名尚未被注册！";
        }
    }
}
