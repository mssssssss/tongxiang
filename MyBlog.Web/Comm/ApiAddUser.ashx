<%@ WebHandler Language="C#" Class="ApiAddUser" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;

//注册用户
public class ApiAddUser : IHttpHandler
{
    UserService userService = new UserService();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string userName = context.Request.Params["UserName"];
        string passWord = context.Request.Params["PassWord"];
        string email = context.Request.Params["Email"];
        string sex = context.Request.Params["Sex"];
        string school = context.Request.Params["School"];
        string education = context.Request.Params["Education"];
        string majorId = context.Request.Params["MajorId"];
        string headPic = context.Request.Params["HeadPic"];
        string stuCard = context.Request.Params["StuCard"];
        string provinceId = context.Request.Params["ProvinceId"];
        JObject jo=new JObject();
        if (userService.isNameSame(userName))
        {
            //重名用户
            jo.Add(new JProperty("msg", "用户名已被注册"));
            context.Response.Write(jo);
        }
        else
        {
            //插入数据库
            userService.insertUserInfo(userName,passWord,email
                ,sex,school,education,int.Parse(majorId),headPic,stuCard,int.Parse(provinceId));
            jo.Add(new JProperty("msg", "注册成功，请等待审核..."));
            context.Response.Write(jo);
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}