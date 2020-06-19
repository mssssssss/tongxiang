<%@ WebHandler Language="C#" Class="ApiFuzzyAdminTopic" %>
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


public class ApiFuzzyAdminTopic : IHttpHandler {
    
    TopicService topicService= new TopicService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string topicTitleOrContent = context.Request.Params["topicTitleOrContent"];
        List<Topic> topicList=topicService.searchAllTopic(topicTitleOrContent);
        int counts = topicList.Count;
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