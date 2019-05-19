using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
// [System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{
    //数据库连接字符串
    private static string DBconn = "server=.\\SQLEXPRESS;database=MYBBS_DB;uid=sa;pwd=123";

    public Service () 
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }
  
    #region 用户登录验证以及用户注册模块
  
    [WebMethod(Description = "该方法用于实现用户登录")]
    public DataSet Login(string name, string pass)
    {
        //获得数据库连接
        SqlConnection conn = new SqlConnection(DBconn);
        //创建数据库操作命令
        SqlCommand SqlCmd = conn.CreateCommand();
        //使用pd_Login存储过程来验证是否合法用户
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_Login";

        //传入用户名与密码参数
        //参数1，用户名
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@Name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name.Trim();
        //参数2，密码
        SqlParameter parInput2 = SqlCmd.Parameters.Add("@Pass", SqlDbType.Char);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = pass.Trim();

        //连接数据库
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        //执行SQL命令
        SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
        DataSet myDataSet = new DataSet();
        //填充数据集，并为数据集取别名
        myDataAdapter.Fill(myDataSet, "UserInfo");

        //获得用户等级与昵称信息
        if (conn.State == ConnectionState.Open)
        {
            conn.Close();
        }
        //返回数据集
        return myDataSet;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="name">客户端输入的用户名</param>
    /// <returns>返回为1，则用户在数据库中，返回为0，则用户不在数据库中</returns>
    [WebMethod(Description = "检测用户是否存在")]
    public int CheckUser(string name)
    {
        //获得数据库连接
        SqlConnection conn = new SqlConnection(DBconn);
        //创建数据库操作命令
        SqlCommand SqlCmd = conn.CreateCommand();
        //使用pd_checkUser存储过程来验证是否合法用户
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_CheckUser";
        //传入用户名参数
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@Name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name.Trim();

        //获得返回值
        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;
        //打开数据库
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        int state;
        
        SqlCmd.ExecuteNonQuery();           
        //输出参数结果为0表明没有受影响，该用户不在数据库中，该参数为1表明受到影响，该用户在数据库中
        state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value.ToString());
      
        return state; 
    }

    /// <summary>
    /// 返回的是插入数据的结果，如果返回的是1，则插入成功；返回的是0，则插入失败
    /// </summary>
    /// <param name="regedit">用字符串数组来记录注册用户的信息</param>
    /// <returns>返回的是一个输出参数</returns>
    [WebMethod(Description = "注册")]
    public int Register(string[] regedit)
    {
        //连接数据库
        SqlConnection coon = new SqlConnection(DBconn);
        SqlCommand SqlCmd = coon.CreateCommand();
        //使用pd_regedit存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_regedit";

        //设置注册的用户默认的组为1  为用户
        //数据库中有默认的用户为0组 为管理员
        //将用户信息作为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = regedit[0].Trim();
        SqlParameter parInput2 = SqlCmd.Parameters.Add("@nick", SqlDbType.Char);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = regedit[1].Trim();
        SqlParameter parInput3 = SqlCmd.Parameters.Add("@pass", SqlDbType.Char);
        parInput3.Direction = ParameterDirection.Input;
        parInput3.Value = regedit[2].Trim();
        SqlParameter parInput4 = SqlCmd.Parameters.Add("@email", SqlDbType.VarChar);
        parInput4.Direction = ParameterDirection.Input;
        parInput4.Value = regedit[3].Trim();
        SqlParameter parInput5 = SqlCmd.Parameters.Add("@mark", SqlDbType.VarChar);
        parInput5.Direction = ParameterDirection.Input;
        parInput5.Value = regedit[4].Trim();

        //获得存储过程的返回值
        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;

        //打开数据库连接
        if (coon.State == ConnectionState.Closed)
        {
            coon.Open();
        }

        int state;
        try
        {
            //执行插入用户信息命令，并获得返回值
            SqlCmd.ExecuteNonQuery();
            //获取输出参数的值
            state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value);
        }
        catch (Exception)
        {

            state = 0;
        }
        finally
        {
            //关闭数据库
            if (coon.State == ConnectionState.Open)
            {
                coon.Close();
            }
        }
        //返回插入数据是否成功的状态值
        return state;
    }
    
    #endregion


    #region 发表主题相关的web service访问模块
   
    [WebMethod(Description = "获得最新的主题")]
    public DataSet GetNewList(string sort)
    {
        //连接字符串对象
        SqlConnection conn = new SqlConnection(DBconn);
        //使用pd_GetNewList存储过程
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetNewList";
        //把论坛分区做为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@group", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = sort.Trim();
        //打开数据库连接
        try
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();                
            }
            //使用SqlDataAdapter把数据填充到DataSet类型中
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //将表TitleList填写到DataSet类型中
            myDataAdapter.Fill(myDataSet, "TitleList");
            //返回DateSet类型值
             return myDataSet;
        }
        catch (Exception)
        {

            throw;
        } 
        finally
        {
            if(conn.State==ConnectionState.Open)
            {
                conn.Close();
            }
        }
     
    }

    [WebMethod(Description = "通过主题的ID来获得该主题的标题、内容等信息，将信息传给前台代码")]
    public DataSet GetTitle(int id)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        //使用pd_GetTitle存储过程
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetTitle";
        //将id作为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = id;
        //打开数据库连接
        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //使用SqlDataAdapter把数据填充到DataSet类型中
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //将表TitleList填写到DataSet类型中
            myDataAdapter.Fill(myDataSet, "TitleList");
            //返回DateSet类型值
            return myDataSet;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod(Description = "获得特定组的主题贴")]
    public DataSet GetSortList(string sort)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_sortList";
        //将组名传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@group", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = sort.Trim();
        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //使用SqlDataAdapter把数据填充到DataSet类型中
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //将表TitleList填写到DataSet类型中
            myDataAdapter.Fill(myDataSet, "TitleList");
            //返回DateSet类型值
            return myDataSet;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="name"></param>
    /// <param name="title"></param>
    /// <param name="cont"></param>
    /// <param name="group"></param>
    /// <param name="nick"></param>
    /// <param name="exp"></param>
    /// <returns>返回为0时执行发表失败，返回为1时发表成功</returns>
    [WebMethod(Description = "发表新主题")]
    public int AppearTitle(string name, string title, string cont, string group, string nick, int exp)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        //使用pd_appearNote存储过程
        SqlCmd.CommandText = "pd_appearNote";
        //将主题相关参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name.Trim();
        SqlParameter parInput2 = SqlCmd.Parameters.Add("@title", SqlDbType.Char);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = title.Trim();
        //使用系统时间作为发表主题时间
        SqlParameter parInput3 = SqlCmd.Parameters.Add("@time", SqlDbType.Char);
        parInput3.Direction = ParameterDirection.Input;
        parInput3.Value = System.DateTime.Now;
        SqlParameter parInput4 = SqlCmd.Parameters.Add("@group", SqlDbType.VarChar);
        parInput4.Direction = ParameterDirection.Input;
        parInput4.Value = group;
        SqlParameter parInput5 = SqlCmd.Parameters.Add("@content", SqlDbType.VarChar);
        parInput5.Direction = ParameterDirection.Input;
        parInput5.Value = cont;
        SqlParameter parInput6 = SqlCmd.Parameters.Add("@nick", SqlDbType.VarChar);
        parInput6.Direction = ParameterDirection.Input;
        parInput6.Value = nick;
        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;
        
        //使用pd_GetExp存储过程
       
        SqlCommand SqlCmd1 = conn.CreateCommand();
        SqlCmd1.CommandType = CommandType.StoredProcedure;
        SqlCmd1.CommandText = "pd_GetExp";
        
        //通过用户名来增加经验值
        SqlParameter parInput7 = SqlCmd1.Parameters.Add("@name", SqlDbType.Char);
        parInput7.Direction = ParameterDirection.Input;
        parInput7.Value = name.Trim();
        
        //没发表一个主题就增加一个经验值
        SqlParameter parInput8 = SqlCmd1.Parameters.Add("@exp", SqlDbType.Int);
        parInput8.Direction = ParameterDirection.Input;
        parInput8.Value = exp + 1;
        //打开数据库连接
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        
        int state;
        try
        {
            //执行插入新主题命令
            SqlCmd.ExecuteNonQuery();
           
            //执行增加经验值命令
            SqlCmd1.ExecuteNonQuery();
          
            state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value);
        }
        catch
        {
            state = 0;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return state;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <param name="title"></param>
    /// <param name="content"></param>
    /// <returns>如果修改成功则返回1，修改失败则返回0</returns>    

    [WebMethod(Description = "修改数据库中的主题信息")]
    public int AlterNote(int id,string title,string content)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_alterNote";
        
        
        //将主题id作为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = id;
       
        
        //将主题信息传入
        SqlParameter parInput2 = SqlCmd.Parameters.Add("@Content", SqlDbType.Text);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = content;

        SqlParameter parInput3 = SqlCmd.Parameters.Add("@title", SqlDbType.Text);
        parInput3.Direction = ParameterDirection.Input;
        parInput3.Value = title;

        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;
        
        
        //打开数据库连接
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        int state;
        //try
        //{
            //执行修改主题命令
            SqlCmd.ExecuteNonQuery();
            state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value);
        //}
        //catch
        //{
        //    state = 0;
        //}
        //finally
        //{
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        //}
        return state;
    }

    [WebMethod (Description="删除帖子")]
     public int DelNote(int id)
        {
            SqlConnection conn = new SqlConnection(DBconn);
            SqlCommand SqlCmd = conn.CreateCommand();

            //使用pd_DelNote存储过程
            SqlCmd.CommandType = CommandType.StoredProcedure;
            SqlCmd.CommandText = "pd_DelNote";

            SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
            parInput1.Direction = ParameterDirection.Input;
            parInput1.Value = id;

            SqlCommand SqlCmd1 = conn.CreateCommand();

            //使用DelRes存储过程
            SqlCmd1.CommandType = CommandType.StoredProcedure;
            SqlCmd1.CommandText = "pd_DelRes";

            SqlParameter parInput2 = SqlCmd1.Parameters.Add("@id", SqlDbType.Int);
            parInput2.Direction = ParameterDirection.Input;
            parInput2.Value = id;

            //打开数据库连接
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }

            //执行插入新贴命令
            SqlCmd.ExecuteNonQuery();
            SqlCmd1.ExecuteNonQuery();

            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
           
        return 0;
        }

    [WebMethod(Description = "回复主题信息")]
    public int AppearRes(int id, string content, string nick, string name)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        //使用pd_ResNote存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_ResNote";
        //id
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = id;
        SqlParameter parInput2 = SqlCmd.Parameters.Add("@Content", SqlDbType.Text);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = content;
        //使用系统时间作为回复主题时间参数
        SqlParameter parInput3 = SqlCmd.Parameters.Add("@noteTime", SqlDbType.DateTime);
        parInput3.Direction = ParameterDirection.Input;
        parInput3.Value = System.DateTime.Now;
        SqlParameter parInput4 = SqlCmd.Parameters.Add("@userNick", SqlDbType.Char);
        parInput4.Direction = ParameterDirection.Input;
        parInput4.Value = nick;
        SqlParameter parInput5 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput5.Direction = ParameterDirection.Input;
        parInput5.Value = name;
        //获得返回值
        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;
        //打开数据库连接
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        int state;
        try
        {
            //执行回复主题命令
            SqlCmd.ExecuteNonQuery();
            state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value);
        }
        catch
        {
            state = 0;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return state;
    }
    
    [WebMethod (Description ="获得主题回复信息")]
    
    public DataSet GetContent(int id)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetContent";
        //主题Id作为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = id;
        //打开数据库
        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //使用SqlDataAdapter把数据填充到DataSet类型中
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //将表noteContent填写到DataSet类型中
            myDataAdapter.Fill(myDataSet, "noteContent");
            //返回DateSet类型值
            return myDataSet;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }
    #endregion

    
    #region 投票相关的webservice访问模块
    [WebMethod (Description="根据传入的主题名，检查该投票主题是否存在")]
    public bool CheckSubject(string subject)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_checkSubject存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_checkSubject";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@Subject", SqlDbType.VarChar, 50);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = subject;


        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //如果已有投票项目返回false，返回的是单行单列的结果，这里是统计的人数
            if (Convert.ToInt16(SqlCmd.ExecuteScalar()) > 0)
            {
                return false;
            }
            //否则返回true
            else
            {
                return true;
            }
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod (Description ="新增投票主题")]
    public void NewSubject(string subject)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_addSubject存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_addSubject";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@subject", SqlDbType.VarChar, 50);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = subject;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //添加项目
            SqlCmd.ExecuteNonQuery();
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod (Description ="根据投票主题名，获得该投票的ID")]
    public int GetSubjectID(string subject)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_GetSubject存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetSubjectId";

        //将投票项目名传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@subject", SqlDbType.VarChar, 50);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = subject;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //返回投票项ID
            return Convert.ToInt16(SqlCmd.ExecuteScalar());
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod (Description ="显示当前存在的所有投票主题")]
    public DataSet ShowSubjects()
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();
        //使用pd_ShowSubject存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_ShowSubject";
        //打开数据库连接
        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //将Subject表填入myDataSet中
            myDataAdapter.Fill(myDataSet, "Subject");
            //将myDataSet返回
            return myDataSet;
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod(Description = "获得当前投票结果")]
    public DataSet GetBallotRes(int id)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_GetSubject存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetSubject";

        //传入需要结果的投票ID
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = id;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();

            //将投票结果填充到myDataSet中并返回
            myDataAdapter.Fill(myDataSet, "Ballot");

            return myDataSet;
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod(Description = "更新投票项")]
    public void UpdateBallot(int OptionId, int SubjectId)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_UpdateBallot存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_UpdateBallot";

        //将投票项目与投票ID作为参数传入
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@option", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = OptionId;

        SqlParameter parInput2 = SqlCmd.Parameters.Add("@subject", SqlDbType.Int);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = SubjectId;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            //执行SQL
            SqlCmd.ExecuteNonQuery();
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod(Description = "在新投票主题中增加投票项")]
    public void AddBallotItem(int SubjectId, string OptionName)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_AddBallot存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_AddBallot";

        //传入投票项名与Id
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@Name", SqlDbType.VarChar, 50);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = OptionName;

        SqlParameter parInput2 = SqlCmd.Parameters.Add("@Id", SqlDbType.Int);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = SubjectId;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            SqlCmd.ExecuteNonQuery();
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod (Description ="通过主题名删除投票")]
    public void DeleteSubject(int subjectId)
    {
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        //使用pd_DelSubject存储过程通过传入的Id来删除项目
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_DelSubject";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@id", SqlDbType.Int);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = subjectId;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();
            SqlCmd.ExecuteNonQuery();
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }
    #endregion

   
    #region 管理相关webservice访问模块
    [WebMethod (Description="获得用户信息")]
    public DataSet GetUserInfo(string name)
    {
        SqlConnection conn = new SqlConnection(DBconn);

        //使用pd_GetUserInfor存储过程
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetUserInfo";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();

            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //使用返回的数据填充表
            myDataAdapter.Fill(myDataSet, "UserInfor");
            //返回该数据
            return myDataSet;
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }

    [WebMethod (Description="更新用户信息")]
    public int UpdateUser(string[] userInfor)
    {
        //连接数据库
        SqlConnection conn = new SqlConnection(DBconn);
        SqlCommand SqlCmd = conn.CreateCommand();

        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_UpdateUser";
        //设置注册的用户默认的组为1  为用户
        //数据库中有默认的用户为0组 为管理员
        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = userInfor[0].Trim();

        SqlParameter parInput2 = SqlCmd.Parameters.Add("@nick", SqlDbType.Char);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = userInfor[1].Trim();

        SqlParameter parInput3 = SqlCmd.Parameters.Add("@pass", SqlDbType.Char);
        parInput3.Direction = ParameterDirection.Input;
        parInput3.Value = userInfor[2].Trim();

        SqlParameter parInput4 = SqlCmd.Parameters.Add("@email", SqlDbType.VarChar);
        parInput4.Direction = ParameterDirection.Input;
        parInput4.Value = userInfor[3].Trim();

        SqlParameter parInput5 = SqlCmd.Parameters.Add("@mark", SqlDbType.VarChar);
        parInput5.Direction = ParameterDirection.Input;
        parInput5.Value = userInfor[4].Trim();

        SqlParameter parReturn1 = SqlCmd.Parameters.Add("returnvalue", SqlDbType.Int);
        parReturn1.Direction = ParameterDirection.ReturnValue;
        //打开数据库连接
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        int state;
        try
        {
            //执行插入用户信息命令
            SqlCmd.ExecuteNonQuery();
            state = Convert.ToInt32(SqlCmd.Parameters["returnvalue"].Value);
        }
        catch
        {
            state = 0;
        }
        finally
        {
            //关闭数据库
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        return state;
    }

    [WebMethod(Description ="获得用户发表的主题")]
    //获得用户发表的主题
    public DataSet GetUserTitle(string name, string group)
    {
        SqlConnection conn = new SqlConnection(DBconn);

        SqlCommand SqlCmd = conn.CreateCommand();
        //使用pd_GetUserTitle存储过程
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetUserTitle";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name;

        SqlParameter parInput2 = SqlCmd.Parameters.Add("@group", SqlDbType.Char);
        parInput2.Direction = ParameterDirection.Input;
        parInput2.Value = group;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();

            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();

            myDataAdapter.Fill(myDataSet, "TitleList");

            return myDataSet;
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }
    
    [WebMethod(Description ="获得用户回复")]
    public DataSet GetUserRes(string name)
    {
        SqlConnection conn = new SqlConnection(DBconn);

        //使用pd_GetUserRes获得用户回复
        SqlCommand SqlCmd = conn.CreateCommand();
        SqlCmd.CommandType = CommandType.StoredProcedure;
        SqlCmd.CommandText = "pd_GetUserRes";

        SqlParameter parInput1 = SqlCmd.Parameters.Add("@name", SqlDbType.Char);
        parInput1.Direction = ParameterDirection.Input;
        parInput1.Value = name;

        try
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open();

            SqlDataAdapter myDataAdapter = new SqlDataAdapter(SqlCmd);
            DataSet myDataSet = new DataSet();
            //获得结果填充到myDataSet数据集中并返回
            myDataAdapter.Fill(myDataSet, "NoteContent");
            return myDataSet;
        }
        finally
        {
            //函数结束时关闭连接
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
    }
   
    #endregion
}
