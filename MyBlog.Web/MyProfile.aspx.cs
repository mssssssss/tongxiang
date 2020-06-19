using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyProfile : System.Web.UI.Page
{
    SqlConnection connection = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["MyCommunityConnectionString"].ConnectionString.ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        getUserinfo();
    }

    public void getUserinfo()
    {
        connection.Open();
        string userId = Application["userId"].ToString();

        string sql = "select * from [User] where UserId="+userId;         //传入用户id
        SqlCommand cmd = new SqlCommand(sql, connection);
        SqlDataReader dataReader = cmd.ExecuteReader();
        if (dataReader.Read())
        {
            lbl_welcomeuser.Text = "你好哇！" + " " + dataReader["UserName"].ToString();
            lblEmail.Text = "Email:" + dataReader["Email"].ToString()+"</br>"+"JoinTime:" + dataReader["JoinTime"].ToString();
        }
        connection.Close();
    }
}