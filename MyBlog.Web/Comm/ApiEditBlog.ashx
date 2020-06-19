<%@ WebHandler Language="C#" Class="ApiEditBlog" %>


using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiEditBlog : IHttpHandler {

    TopicService topicService= new TopicService();

    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string topicId = context.Request.Form["topicId"];
        string topicTitle = context.Request.Form["topicTitle"];
        string topicContent=context.Request.Form["topicContent"];

        bool flag=topicService.updateTopic(int.Parse(topicId),topicTitle,topicContent);
        JObject jo;
        if(flag==true)
        {
            jo = new JObject(new JProperty("msg", "修改成功"));
        }
        else
        {
            jo = new JObject(new JProperty("msg", "修改失败"));
        }
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