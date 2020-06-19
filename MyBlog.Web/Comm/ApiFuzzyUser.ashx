<%@ WebHandler Language="C#" Class="ApiFuzzyUser" %>


using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using MyBlog.DAL;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
public class ApiFuzzyUser : IHttpHandler
{
    UserService userService = new UserService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string searchInfo = context.Request.Params["searchInfo"];
        string userType = context.Request.Params["userType"];
        List<User> userList=new List<User>();
        int counts = 0;
        if (userType.Equals("UnCheckedUser"))
        {
            userList = userService.searchUnCheckedUser(searchInfo);
            counts = userList.Count;
        }
        else if (userType.Equals("CheckedUser"))
        {
            userList = userService.searchCheckedUser(searchInfo);
            counts = userList.Count;
        }


        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray users = new JArray();
        foreach (var item in userList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("UserId", item.UserId));
            p.Add(new JProperty("UserName", item.UserName));
            p.Add(new JProperty("Email", item.Email));
            p.Add(new JProperty("Sex", item.Sex));
            p.Add(new JProperty("School", item.School));
            p.Add(new JProperty("Education", item.Education));
            p.Add(new JProperty("MajorName", item.Major.MajorName));
            p.Add(new JProperty("StuCard", item.StuCard));
            p.Add(new JProperty("ProvinceName", item.Province.ProvinceName));
            p.Add(new JProperty("JoinTime", item.JoinTime));
            users.Add(p);
        }
        res.Add(new JProperty("data", users));
        context.Response.Write(res);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}