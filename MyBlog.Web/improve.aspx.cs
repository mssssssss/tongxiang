using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class improve : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyCommunityConnectionString"].ConnectionString.ToString());
    static int totalCount = 0;  //页面总数
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            num.Text = "1";
            _databind();
        }
    }

    public void _databind()
    {
        connection.Open(); //打开连接的数据库                     
       
        if (Session["username"] != null)
        {
            //如果登录 就查找注册时城市的用户专业的2级话题
            com = new SqlCommand("select * from [User] left join Topic on Topic.AuthorId=[User].UserId left join [Major] on Topic.MajorId = [Major].MajorId where [User].ProvinceId=" + Session["provinceid"] + "and Topic.MajorId=" + Session["majorid"] + "and Topic.DiffLevel=2" + "order by Topic.TopicTime desc", connection);
        }
        else
        {
            //如果未登录 就查找此城市的2级话题
            com = new SqlCommand("select * from [User] left join Topic on Topic.AuthorId=[User].UserId left join [Major] on Topic.MajorId = [Major].MajorId where [User].ProvinceId=" + Session["provinceid"] + "and Topic.DiffLevel=2" + "order by Topic.TopicTime desc", connection);
        }
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = com; //执行查询
        DataSet ds = new DataSet();
        adapter.Fill(ds); //将数据存放在了myDs数据集中

        PagedDataSource pds = new PagedDataSource();
        pds.DataSource = ds.Tables[0].DefaultView;
        pds.AllowPaging = true;//允许分页
        pds.PageSize = 3;//单页显示项数
        int curpage = Convert.ToInt32(num.Text);
        totalCount = pds.PageCount;
        totalNum.Text = "/" + totalCount;  //设置总页数

        btnDown.Enabled = true;
        btnUp.Enabled = true;
        pds.CurrentPageIndex = curpage - 1; //当前页索引 从0开始
        if (curpage == 1) //如果为第一页
        {
            btnUp.Enabled = false; //禁用上一页
        }
        if (curpage == totalCount)  //如果为最后一页
        {
            btnDown.Enabled = false;  //禁用下一页
        }
        rp2.DataSource = pds;  //设置repeator的数据源
        rp2.DataBind();  //绑定数据源
    }

    //点击上一页
    protected void btnUp_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) - 1);
        _databind();
    }

    //点击下一页
    protected void btnDown_Click(object sender, EventArgs e)
    {
        num.Text = Convert.ToString(Convert.ToInt32(num.Text) + 1);
        _databind();
    }

    //点击第一页
    protected void btnFirst_Click(object sender, EventArgs e)
    {
        num.Text = "1";
        _databind();
    }

    //点击最后一页
    protected void btnLast_Click(object sender, EventArgs e)
    {
        //Response.Write(totalCount);
        num.Text = totalCount.ToString();
        _databind();
    }
}