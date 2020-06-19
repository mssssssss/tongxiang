using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class home : System.Web.UI.Page
{
    MessageService ms = new MessageService();
    UserService us = new UserService();
    FanService fs = new FanService();

    string _user = "";
    int user2 = 0;
    int user1 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        _user = Request.QueryString["userId"].ToString();  //发帖人Id
        if (Session["userid"] != null)
        {
            user2 = int.Parse(Session["userid"].ToString()); //登录用户id
        }  
        if (_user != null)
        {
            user1 = int.Parse(_user);  //得到发帖人Id
        }
         //若登录
        if (Session["username"] != null)
        {  
            //显示登录用户的用户名和头像
            lblUser.Text = Session["username"].ToString();
            imgHead.ImageUrl = us.findUserhead(lblUser.Text);
            
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

    //判断用户性别 从而显示出对应的图标
    public string judge(string str)
    {
        if (str == "男")
        {
            return "<i class='iconfont icon-nan'> </i>";
        }
        else
        {
            return "<i class='iconfont icon-nv'> </i>";
        }
    }

    //将日期时间转换为年月日的形式
    public string convert(string str)
    {
        return str.Substring(0, 9);
    }

    //点击发表留言
    protected void tbMes_Click(object sender, EventArgs e)
    {
        //先检验留言是否为空
        if (tb.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('留言内容不能为空！');</script>");
        }
        else
        {
            //检验用户是否登录了
            //如果登录了
            if (Session["username"] != null)
            {
                //插入留言到message表中
                int userId = us.findUserid(Session["username"].ToString());  //留言者id
                string authorId = Request.QueryString["userId"];  //发帖人id
                if (authorId != null)
                {
                    int _authorId = int.Parse(authorId);
                    ms.insertIntoMessage(_authorId, userId, tb.Text); //插入评论
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('留言发表成功！');</script>");
                    tb.Text = ""; //清空留言信息
                    Response.AddHeader("Refresh", "0");  //刷新此页面
                }
            }
            //未登录
            else
            {
                //弹出警告
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录再留言！');</script>");
            }
        }
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

    //用户点击关注
    protected void btnGz_Click(object sender, EventArgs e)
    {
        Button b = (Button)Repeater1.Items[0].FindControl("btnGz");  //找到关注的按钮
        //如果用户登录了
        if (Session["userid"] != null)
        {
            //首先判断此用户是不是发帖人的粉丝
      
                //如果是粉丝
                if (fs.isFan(user1, user2))
                {
                    //取消关注
                    fs.deleteFan(user1, user2);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('取关成功');</script>");
                    Response.AddHeader("Refresh", "0");
                    b.CssClass = "layui-btn layui-bg-green fly-imActive";
                    b.Text = "关注";
                    
                }
                //如果不是粉丝
                else
                {
                    //判断是不是自己
                    if (user1 == user2)
                    {
                        //弹出不能关注自己的警告框
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('不能关注自己哦！');</script>");
                    }
                    else
                    {
                        //添加关注
                        fs.insertFan(user1, user2);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('关注成功！');</script>");
                        Response.AddHeader("Refresh", "0");
                        b.CssClass = "layui-btn layui-bg-gray fly-imActive";
                        b.Text = "取消关注";
                }
                    
                }
          
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('请先登录再关注！');</script>");
        }
            
        
    }

    //关注按钮的文本
    public string GzText()
    {
      
     if (fs.isFan(user1, user2))
            {
                return "取消关注";
            }

       
        return "关注";
    }

    //关注按钮的样式
    public string GzCss()
    {
            if (fs.isFan(user1, user2))
            {
                return "layui-btn layui-bg-gray fly-imActive";
            }

        return "layui-btn layui-bg-green fly-imActive";
    }

    //统计用户id为userid的用户的粉丝数
    public int FansCount(int userid)
    {
        return fs.NumOfFans(userid);
    }
}
   