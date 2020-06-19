<%@ WebHandler Language="C#" Class="ApiAddBlog" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;

public class ApiAddBlog : IHttpHandler {

    TopicService topicService=new TopicService();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string userId =  context.Application["userId"].ToString();
            
        string topicId=context.Request.Params["topicId"];
        string majorId = context.Request.Params["majorId"];
        string diffLevel = context.Request.Params["diffLevel"];
        string topicTitle = context.Request.Params["topicTitle"];
        string topicContent = context.Request.Params["topicContent"];
        DateTime nowTime = DateTime.Now.ToLocalTime();
        if (topicId.Equals("-1")){//新增文章
            topicService.insertTopic(int.Parse(userId), int.Parse(majorId),int.Parse(diffLevel), topicTitle, topicContent, nowTime);
            JObject jo = new JObject(new JProperty("msg", "文章发布成功！"));
            context.Response.Write(jo);
        }
        else//编辑文章
        {
            bool flag=topicService.updateTopic(int.Parse(topicId),topicTitle,topicContent);
            JObject jo;
            if (flag == true)
            {
                jo = new JObject(new JProperty("msg", "修改成功"));
            }
            else
            {
                jo = new JObject(new JProperty("msg", "修改失败"));
            }
            context.Response.Write(jo);
        }
        //topicService.insertTopic(int.Parse(userId), int.Parse(majorId),int.Parse(diffLevel), topicTitle, topicContent, nowTime);
        //JObject jo = new JObject(new JProperty("msg", "文章发布成功！"));
        //context.Response.Write(jo);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}