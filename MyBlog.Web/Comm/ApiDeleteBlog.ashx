<%@ WebHandler Language="C#" Class="ApiDeleteBlog" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;
public class ApiDeleteBlog : IHttpHandler
{

    TopicService topicService= new TopicService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string topicId = context.Request.Form["topicId"];
        topicService.delTopic(int.Parse(topicId));
        JObject jo;
        jo = new JObject(new JProperty("msg", "删除成功"));
        context.Response.Write(jo);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}