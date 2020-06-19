using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class findPwd2 : System.Web.UI.Page
{
    UserService userService = new UserService();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnFind_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!userService.isNameSame(txtUserame.Text.Trim()))
            {
                lblInfo.Text = "用户名不存在！";
            }
            else
            {
                //验证邮箱是否正确
                if (!userService.IsEmailExist(txtUserame.Text.Trim(), txtEmail.Text))
                {
                    lblInfo.Text = "邮箱不正确";
                }
                else
                {
                    //重置密码 为newPwd
                    String newPwd = userService.ResetPassword(txtUserame.Text.Trim(), txtEmail.Text.Trim());
                    //新建自定义的EmailSender类实例emailSender对象 
                    EmailSender emailSender = new EmailSender(txtEmail.Text.Trim(), newPwd);
                    //调用自定义的EmailSender类中的Send()方法发送邮件
                    emailSender.Send();
                    lblInfo.Text = "密码已发送至邮箱，请注意查收！";
                    lblInfo.Text += "<br/ >五秒后自动跳转到登录界面！";
                    //五秒后回到登录界面
                    Response.Write("<script language='javascript'>setTimeout(\"{location.href='" + "login2.aspx" + "'}\",5000);</script>");     //自动跳转  
                }
            }
        }
    }
}