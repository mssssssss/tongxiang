<%@ WebHandler Language="C#" Class="ApiGetUser" %>

using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using MyBlog.DAL;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
public class ApiGetUser : IHttpHandler {

    UserService userService=new UserService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];
        string userType = context.Request.Params["userType"];
        int counts=0;
        List<User> userList=new List<User>();
        if (userType.Equals("UnCheckedUser"))//获得未审核的用户
        {
            userList= userService.GetUnCheckedUsers(int.Parse(page), int.Parse(limit));
            //注意返回的count是所有的数据，而不是分页当前页面的数据
            counts = userService.getUnCheckedUserCounts();
        }else if(userType.Equals("CheckedUser")){//获得已经审核的用户
            userList = userService.GetCheckedUsers(int.Parse(page), int.Parse(limit));
            counts = userService.getCheckedUserCounts();
        }
        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
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
            //p.Add(new JProperty("PassWord", item.PassWord));
            p.Add(new JProperty("Email", item.Email));
            p.Add(new JProperty("Sex", item.Sex));
            p.Add(new JProperty("School", item.School));
            p.Add(new JProperty("Education", item.Education));
            p.Add(new JProperty("MajorName", item.Major.MajorName));
            p.Add(new JProperty("StuCard", item.StuCard));
            p.Add(new JProperty("ProvinceName", item.Province.ProvinceName));
            //p.Add(new JProperty("CheckStatus", item.CheckStatus));
            p.Add(new JProperty("JoinTime", item.JoinTime));

            users.Add(p);
        }
        res.Add(new JProperty("data", users));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}