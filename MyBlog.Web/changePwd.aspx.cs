using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;

public partial class changePwd : System.Web.UI.Page
{
    UserService userService = new UserService();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnChangePwd_Click(object sender, EventArgs e)
    {
      
        if (Page.IsValid)
        {
            if (Application["userName"] != null)
            {
                //调用UserService类中的checkLogin()方法检查用户名和输入的原密码是否正确，返回值大于0表示输入的原密码正确
                if (userService.checkLogin(Application["userName"].ToString(), txtOldPwd.Text) > 0)
                {
                   
                    userService.changePassword(int.Parse(Application["userId"].ToString()), txtPwd.Text);
                    lblMsg.Text = "";
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('密码修改成功！');</script>");
                }
                else  //输入的原密码不正确
                {
                    lblMsg.Text = "原密码不正确！";
                }
            }
            
        }
    }
}