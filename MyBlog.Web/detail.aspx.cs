using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class detail : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyCommunityConnectionString"].ConnectionString.ToString());
    static int totalCount = 0;  //页面总数

    UserService us = new UserService();
    CommentService cs = new CommentService();
    TopicService ts = new TopicService();
    ZanService zs = new ZanService();

    string topicId = "";
    int userId = 0;
    int _topicId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            num.Text = "1";
            _databind();
        }

        //若登录
        if (Session["username"] != null)
        {
            //显示登录用户的用户名和头像
            lblUser.Text = Session["username"].ToString();
            imgHead.ImageUrl = us.findUserhead(lblUser.Text);

            topicId = Request.QueryString["topicId"].ToString(); //帖子id
            userId = us.findUserid(Session["username"].ToString());  //评论者id

            if (topicId != null)
            {
                _topicId = int.Parse(topicId);   //帖子id
            }
        }
        //未登录
        else
        {
            //右边的信息将被隐藏
            perInfo.Visible = false;
        }
        //跳转到用户自己的个人主页
        hlHome.NavigateUrl = "home.aspx?userId=" + Session["userid"];
    }

    //点击了退出
    protected void btnExit_Click(object sender, EventArgs e)
    {
        //清空Session中的用户信息
        Session["userid"] = null;
        Session["username"] = null;
        //隐藏右边用户信息
        perInfo.Visible = false;
    }

    public string handle(string str)
    {
        if (str == "1") return "基础知识";
        else if (str == "2") return "进阶知识";
        else return "高级知识";
    }

    //点击回复
    protected void btnReply_Click(object sender, EventArgs e)
    {
        //先检验评论是否为空
        if (L_content.InnerText == "")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('评论内容不能为空！');</script>");
         }
        else
        {
            //检验用户是否登录了
            //如果登录了
            if (Session["username"] != null)
            {
                //插入评论到comment表中
                if (topicId != null)
                {
                    _topicId = int.Parse(topicId);   //帖子id
                    cs.insertIntoComment(_topicId, userId, L_content.InnerText, 0); //插入评论
                    //更新Topic表中的评论数 加1
                    ts.addCommentCount(_topicId);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "comment", "<script language='javascript' defer>alert('留言发表成功！');</script>");
                    L_content.InnerText = ""; //清空评论信息
                    Response.AddHeader("Refresh", "0");  //刷新此页面
                }
            }
            //未登录
            else
            {
                //弹出警告
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "comment", "<script language='javascript' defer>alert('请先登录再评论！');</script>");
            }
        }
    }

  
    //点击评论的回复
    protected void rp_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //L_content.InnerText = rp.Items[e.Item.ItemIndex].ItemIndex.ToString();
        //得到被回复的用户Id和用户名
        Label label_1 = (Label)(rp.Items[e.Item.ItemIndex].FindControl("lblID"));
        Label label_2 = (Label)(rp.Items[e.Item.ItemIndex].FindControl("lblName"));
        L_content.InnerHtml += "<a href='home.aspx?userId="+ int.Parse(label_1.Text) + "'>" +"@"+ label_2.Text+"</a>";
    }

    public void _databind()
    {
        connection.Open(); //打开连接的数据库
        SqlCommand com = new SqlCommand("SELECT * FROM [Comment] JOIN [User] ON [Comment].UserId = [User].UserId  WHERE [Comment].TopicId = "+ Request.QueryString["topicId"]+" and [Comment].PreCmtId=0 ORDER BY [Comment].CmtTime DESC", connection);
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
            rp.DataSource = pds;  //设置repeator的数据源
            rp.DataBind();  //绑定数据源
       
        
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

   public string judgeZan()
   {
        //如果用户登录了
        if (Session["userid"] != null)
        {
            //ImageButton ib = (ImageButton)Repeater1.Items[0].FindControl("btnZan");
            if (zs.IsLikes(_topicId, userId))
            {
                return "~/images/zan2.png"; //换成点赞的图片
            }
            else
            {
                return "~/images/zan1.png"; //换成原始的图片
            }
        }
        else
        {
            return "~/images/zan1.png"; //换成初始的图片
        }  
   }
    protected void btnZan_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton ib = (ImageButton)Repeater1.Items[0].FindControl("btnZan");
        //如果用户登录了
        if (Session["userid"] != null)
        {
            //未点赞
            if (ib.ImageUrl == "~/images/zan1.png")
            {
                ib.ImageUrl = "~/images/zan2.png"; //换成点赞的图片
                //赞数加1
                ts.addLikeCount(_topicId);
                //插入赞的记录到Zan表中
                zs.insertToZan(_topicId, userId);
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "zan", "<script language='javascript' defer>alert('点赞成功！');</script>");
                Response.AddHeader("Refresh", "0");  //刷新此页面
            }
            else
            {
                ib.ImageUrl = "~/images/zan1.png";
                //赞数减1
                ts.subLikeCount(_topicId);
                //取消点赞的记录
                zs.cancelZan(_topicId, userId);
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "zan", "<script language='javascript' defer>alert('取消点赞成功！');</script>");
                Response.AddHeader("Refresh", "0");  //刷新此页面
            }

        }
        else
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "zan", "<script language='javascript' defer>alert('请先登录再点赞！');</script>");
        }



    }
}