using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class login2 : System.Web.UI.Page
{
    UserService userService = new UserService();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //点击登录按钮
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Session["checkcode"] != null)
        {
            //先检查验证码是否正确 正确的验证码存入了Session中
            if (txtCheckcode.Text.ToString() == Session["checkcode"].ToString())
            {
                if (txtUserame.Text.Equals("admin") && txtPassword.Text.Equals("password"))
                {
                    Response.Redirect("~/AdminManage.aspx");  //跳转管理员后台
                }
                else
                {
                    //检查登录是否成功
                    int r = userService.checkLogin(txtUserame.Text, txtPassword.Text);
                    //登录成功
                    if (r > 0)
                    {
                        lblErr.Text = "";
                        Session["username"] = txtUserame.Text;  //记录用户名到Session中
                        Session["userid"] = userService.findUserid(Session["username"].ToString()); //记录用户Id到Session中
                        Session["majorid"] = userService.findUserMajor(Session["username"].ToString());  //记录用户专业Id到Session中
                        Session["provinceid"] = userService.findUserProId(Session["username"].ToString());
                        Response.Redirect("~/index2.aspx");  //跳转到主页

                    }
                    //登录失败 提示错误信息
                    else
                    {
                        lblErr.Text = "用户名/密码错误或用户未被审核";
                    }
                }

            }
            else
            {
                lblErr.Text = "验证码错误";
            }
        }

    }

    protected void btnFindPwd_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/findPwd2.aspx");

    }
}