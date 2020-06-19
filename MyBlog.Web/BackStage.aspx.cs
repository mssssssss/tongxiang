using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyBlog.BLL;
public partial class BackStage : System.Web.UI.Page
{
    UserService userService = new UserService();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string userName = Request.QueryString["username"];
            //lbl_userName.Text = userName;
            //Application["userId"]=userService.findUserid(userName).ToString();
            //Application["userName"] = userName;
            //Application["userId"] = "2";
            //Application["userName"] = "逝不等琴生";
            lbl_userName.Text = Application["userName"].ToString();
            headImg.ImageUrl = Application["userHeadUrl"].ToString();

        }
    }
}