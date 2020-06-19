<%@ WebHandler Language="C#" Class="ApiDeleteMsg" %>
using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;
public class ApiDeleteMsg : IHttpHandler
{

    MessageService messageService = new MessageService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string msgId = context.Request.Params["messageid"];
        messageService.delMsg(int.Parse(msgId));
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