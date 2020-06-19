using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;
using MyBlog.DAL;

public partial class index2 : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyCommunityConnectionString"].ConnectionString.ToString());
    MyCommunityDataContext db = new MyCommunityDataContext();

    UserService userService = new UserService();
    ProvinceService provinceService = new ProvinceService();
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
      
            //若登录
            if (Session["username"] != null)
            {
            
                //显示登录用户的用户名和头像
                lblUser.Text = Session["username"].ToString();
                Application["userId"] = userService.findUserid(Session["username"].ToString());
                Application["userName"]= Session["username"].ToString();
                imgHead.ImageUrl = userService.findUserhead(lblUser.Text);
                Application["userHeadUrl"] = imgHead.ImageUrl;
                //将省份id设置为用户注册时填写的省份-id 并且显示新的位置信息
                Session["provinceid"] = userService.findUserProId(Session["username"].ToString());
                loc.InnerText =  provinceService.findProName(int.Parse(Session["provinceid"].ToString()));
            }
            //未登录
            else
            {
                //右边的信息将被隐藏
                perInfo.Visible = false;
                Session["provinceid"] = 14;
                provinceName.InnerText = "江西省";
        }
        //跳转到用户自己的个人主页
        hlHome.NavigateUrl = "home.aspx?userId=" + Session["userid"];

            //绑定知识热榜的数据
            repeaterKnowLedge();
       
       
    }

    public void repeaterKnowLedge()
    {
        connection.Open(); //打开连接的数据库
        //如果用户已登录              
        if (Session["username"] != null)
        {
            //如果未登录 就查找注册城市的专业话题
            com = new SqlCommand("select top 10 * from [User] left join Topic on Topic.AuthorId=[User].UserId left join [Major] on Topic.MajorId = [Major].MajorId where [User].ProvinceId=" + Session["provinceid"] + "and [User].MajorId="+ Session["majorid"]+ "order by [Topic].LikesCount desc", connection);
        }
        else
        {
            //如果未登录 就查找定位城市的话题
            com = new SqlCommand("select top 10 * from [User] left join Topic on Topic.AuthorId=[User].UserId left join [Major] on Topic.MajorId = [Major].MajorId where [User].ProvinceId=" + Session["provinceid"] + "order by [Topic].LikesCount desc", connection);
        }

        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds);

        _rp.DataSource = ds;  //设置知识热榜repeator的数据源
        _rp.DataBind();  //绑定数据源
    }


    //点击了退出
    protected void btnExit_Click(object sender, EventArgs e)
    {
       
        //清空Session中的用户信息
        Session["userid"] = null;
        Session["username"] = null;
        //隐藏右边用户信息
        perInfo.Visible = false;
        Response.AddHeader("Refresh", "0");  //刷新此页面
        //Label1.Text = "-1";
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (Session["provinceName"] != null)
        {
            Session["provinceId"] = provinceService.findProId(Session["provinceName"].ToString());
            Response.Write(Session["provinceId"]);
        }
    }

    protected void lbPost_Click(object sender, EventArgs e)
    {
        if (Session["userid"] != null)
        {
            Response.Redirect("PostArticle.aspx");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "post", "<script language='javascript' defer>alert('请先登录再发表帖子！');</script>");
        }
    }
}