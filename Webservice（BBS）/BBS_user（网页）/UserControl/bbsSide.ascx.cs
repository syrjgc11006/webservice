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

public partial class UserControl_bbsSide : System.Web.UI.UserControl
{
    protected override void Render(HtmlTextWriter writer)
    {
        //如果用户等级不为空
        if (Session["userLevel"] != null)
        {
            //获得用户等级图片url
            LevelImg.ImageUrl=GetUrl(Convert.ToInt32(Session["userLevel"]));
        }
        base.Render(writer);
    }

    //根据用户的经验值返回不同等级的图片的URL
    public string GetUrl(int level)
    {
        string imgurl;
        imgurl = "";
        if (level<=5)
        {
            imgurl = "~/App_Themes/image/Level/level0.gif";
        }
        else if (5 < level&&level <= 10)
        {
            imgurl = "~/App_Themes/image/Level/level1.gif";
        }
        else if (10 < level && level <= 20)
        {
            imgurl = "~/App_Themes/image/Level/level2.gif";
        }
        else if (20 < level && level <= 40)
        {
            imgurl = "~/App_Themes/image/Level/level3.gif";
        }
        else if (40 < level && level <= 60)
        {
            imgurl = "~/App_Themes/image/Level/level4.gif";
        }
        else if (60 < level && level <= 100)
        {
            imgurl = "~/App_Themes/image/Level/level5.gif";
        }
        return imgurl;
    }




    protected void Page_Load(object sender, EventArgs e)
    {
        //如果用户已经登录
        if (Session["usernick"] != null)
        {
            //隐藏用户登录面板
            LoginPanel.Visible = false;
            //显示用户信息与欢迎面板
            Panel2.Visible = true;
            lblWel.Visible = true;
            lblWel.Text = Session["username"].ToString() + "WelCome!";
            lblexp.Visible = true;

            //显示用户的经验值信息
            lblexp.Text = "你当前的经验值为：" + Session["userLevel"];
        }

        //如果以管理员的身份登录则显示管理员面板
        if ((Session["username"] != null) && (Session["username"].ToString().ToLower() == "admin"))
        {
            adminBtn.Visible = true;
        }
    }

    //登录成功函数
    public void LoginSucc(string nick,string name,int level)
    {
        //隐藏用户登录面板，显示用户信息面板
        LoginPanel.Visible = false;
        Panel2.Visible = true;
        lblWel.Visible = true;
        lblWel.Text = nick + "WelCome";
        lblexp.Visible = true;

        lblexp.Text = "你当前的经验值为：" + level;
        //若用户成功登录，则把用户名存入全局变量
        Session["usernick"] = nick;
        Session["username"] = name;
        Session["userLevel"] = level;
        //显示用户的IP地址
        lblIp.Text = "你来自：" + Request.UserHostAddress;
    }

    //登录失败时的函数
    public void LoginFal()
    {
        //如果登录失败则显示报错信息
        lblErr.Visible = true;
        lblErr.Text = "用户名或者密码错误！";
    }

    protected void loginBtn_Click(object sender, EventArgs e)
    {
        //实例化一个WebService对象
        localhost.Service service = new localhost.Service();
        //调用webservice方法来将客户端的值传递给服务端
        DataSet myDataSet;
        //通过传入的用户名和密码进行登录验证
        myDataSet = service.Login(nameTbx.Text.ToString().Trim(), passTbx.Text.ToString().Trim());
        //记录昵称
        string nick;
        int level = 0;
        try
        {
            //通过数据库传回的信息获得用户的昵称与经验值
            nick = myDataSet.Tables["UserInfo"].Rows[0].ItemArray[0].ToString();//获取用户的昵称
            level =Convert .ToInt32( myDataSet.Tables["UserInfo"].Rows[0].ItemArray[1]);//获取用户的等级
        }
        catch (Exception)
        {
            
            //登录失败用户昵称为空
            nick = string.Empty;
        }
        //如果登录成功
        if (nick != string.Empty)
        {
            //调用用户成功登录函数
            LoginSucc(nick, nameTbx.Text.ToString(), level);
            //如果用户为管理员则显示管理员面板
            if (Session["username"].ToString().ToLower() == "admin")
            {
                adminBtn.Visible = true;
            }
            //登录后页面重新定向到主页面
            Response.Redirect("Welcome.aspx");
            return;
        }
        else
        {
            //如果登录失败则调用用户登录失败函数
            LoginFal();
            return;
        }
    }
    protected void regBtn_Click(object sender, EventArgs e)
    {
        //转到用户注册页面
        Response.Redirect("Regedit.aspx");
    }
    protected void ModBtn_Click(object sender, EventArgs e)
    {
        //转到用户个人中心页面
        Response.Redirect("Passport.aspx");
    }
    protected void adminBtn_Click(object sender, EventArgs e)
    {
        //转到管理员页面
        Response.Redirect("Admin.aspx");
    }
    protected void outBtn_Click(object sender, EventArgs e)
    {
        //清空用户信息
        Session.Abandon();
        //重定向页面到登录页面
        Response.Redirect("Welcome.aspx");
    }
}
