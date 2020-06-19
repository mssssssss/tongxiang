<%@ WebHandler Language="C#" Class="ApiDeleteWatch" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiDeleteWatch : IHttpHandler {
    WatchService watchService = new WatchService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string userId = context.Application["userId"].ToString();//当前登录用户的Id
        string watchingId = context.Request.Params["watchingId"];//关注者Id
        watchService.deleteWatch(int.Parse(userId),int.Parse(watchingId));
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