<%@ WebHandler Language="C#" Class="ApiDeleteComment" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiDeleteComment : IHttpHandler {
    
    CommentService commentService = new CommentService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string commentId = context.Request.Params["commentId"];
        commentService.delMsg(int.Parse(commentId));
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