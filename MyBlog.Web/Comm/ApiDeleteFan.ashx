<%@ WebHandler Language="C#" Class="ApiDeleteFan" %>
using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiDeleteFan : IHttpHandler {
    
   FanService fanService = new FanService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string userId = context.Application["userId"].ToString();//当前登录用户的Id
        string followerId = context.Request.Params["followerId"];//关注者Id
        fanService.deleteFan(int.Parse(userId),int.Parse(followerId));
        JObject jo;
        jo = new JObject(new JProperty("msg", "删除成功"));
        context.Response.Write(jo);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}