<%@ WebHandler Language="C#" Class="ApiUpdateUser" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiUpdateUser : IHttpHandler {

    UserService userService=new UserService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string userId = context.Request.Form["userId"];
        string checkStatus = context.Request.Form["checkStatus"];
        bool flag = userService.setUserCheckStatus(int.Parse(userId), int.Parse(checkStatus));
        JObject jo;
        if(flag==true)
        {
            jo = new JObject(new JProperty("msg", "审核通过"));
        }
        else
        {
            jo = new JObject(new JProperty("msg", "审核不通过"));

        }
        context.Response.Write(jo);

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}