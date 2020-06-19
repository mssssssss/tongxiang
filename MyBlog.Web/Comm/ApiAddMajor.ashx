<%@ WebHandler Language="C#" Class="ApiAddMajor" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
public class ApiAddMajor : IHttpHandler {
    MajorService majorService = new MajorService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";

        string majorName = context.Request.Params["majorName"];
        majorService.insertMajor(majorName);
        JObject jo = new JObject(new JProperty("msg", "专业类别添加成功！"));
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}