<%@ WebHandler Language="C#" Class="ApiGetAllTopic" %>


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
public class ApiGetAllTopic : IHttpHandler {
   TopicService topicService= new TopicService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        
        
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];

        List<Topic> topicList = topicService.GetAdminAllTopic(int.Parse(page), int.Parse(limit));
        //注意返回的count是所有的数据，而不是分页当前页面的数据
        int counts = topicService.getAllTopicCounts();

        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray jArray = new JArray();
        foreach (var item in topicList)
        {
            string level = "";
            if (item.DiffLevel == 1)
            {
                level = "基础知识";
            }
            else if (item.DiffLevel == 2)
            {
                level = "进阶知识";
            }
            else if (item.DiffLevel == 3)
            {
                level = "高级知识";

            }
            JObject p = new JObject();
            p.Add(new JProperty("AuthorName", item.User.UserName));
            p.Add(new JProperty("TopicId", item.TopicId));
            p.Add(new JProperty("TopicTitle", item.TopicTitle));
            p.Add(new JProperty("MajorName", item.Major.MajorName));
            p.Add(new JProperty("DiffLevel", level));
            p.Add(new JProperty("MajorId", item.MajorId));
            p.Add(new JProperty("DiffLevelId", item.DiffLevel));
            p.Add(new JProperty("TopicContent", item.TopicContent));
            p.Add(new JProperty("TopicTime", item.TopicTime));
            p.Add(new JProperty("LikesCount", item.LikesCount));
            p.Add(new JProperty("CommentCount", item.CommentCount));
            jArray.Add(p);
        }
        res.Add(new JProperty("data", jArray));
        context.Response.Write(res);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}