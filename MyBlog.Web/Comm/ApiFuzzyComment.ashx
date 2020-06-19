<%@ WebHandler Language="C#" Class="ApiFuzzyComment" %>

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
public class ApiFuzzyComment : IHttpHandler {
    
    CommentService commentService = new CommentService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string comContent = context.Request.Params["comContent"];
        string userId = context.Application["userId"].ToString();
        List<Comment> cmtList=commentService.searchCmt(int.Parse(userId),comContent);
        int counts = cmtList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray comments = new JArray();
        foreach (var item in cmtList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("CommentId", item.CommentId));
            //p.Add(new JProperty("TlogId", item.Topic.TopicId));
            p.Add(new JProperty("TopicTitle", item.Topic.TopicTitle));
            p.Add(new JProperty("UserId", item.UserId));
            p.Add(new JProperty("UserName", item.User.UserName));
            p.Add(new JProperty("CmtContent", item.CmtContent));
            p.Add(new JProperty("CmtTime", item.CmtTime));
            comments.Add(p);
        }
        res.Add(new JProperty("data", comments));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}