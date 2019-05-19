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

public partial class UserControl_bbsHeader : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
               
    }
    //声明两个字符串私有变量，分别保存页面信息与页面图标
    private string _message = string.Empty;
    private string _imagepath = string.Empty;

    //获得与设置页面信息字符串的方法
    public string Message
    {
        get { return _message; }
        set { _message = value; }
    }

    //获得与设置页面图标字符串的方法
    public string IconImageUrI
    {
        get { return _imagepath; }
        set { _imagepath = value; }
    }

    //在开发自定义服务器控件时，可以重写此方法以生成 ASP.NET 页的内容。 
    protected override void Render(HtmlTextWriter writer)
    {
        //如果信息不为空则设置页面信息与图标
        if (Message != string.Empty)
        {
            lblWelcome.Text = _message;
        }
        if (IconImageUrI != string.Empty)
        {
            ImgIcon.ImageUrl = _imagepath;
        }
        //呈现在客户端
        base.Render(writer);
    }
}
