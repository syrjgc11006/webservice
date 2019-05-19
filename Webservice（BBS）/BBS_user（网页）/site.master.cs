using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

public partial class site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //将子页面的信息传递到页首用户控件中,我们可以在母版页中访问子页面的控件和属性，同样也可以在内容页面中访问母版页上的控件和属性
        Label tempLblMsg = ContentPlaceHolder1.FindControl("lblName") as Label;//页面的标题
        Label tempLblIcn = ContentPlaceHolder1.FindControl("lblImgUrl") as Label;//页面的图标
        
        //传值
        bbsHeader1.Message = tempLblMsg.Text;
        bbsHeader1.IconImageUrI = tempLblIcn.Text;
    }
}
