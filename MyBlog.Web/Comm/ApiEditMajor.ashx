<%@ WebHandler Language="C#" Class="ApiEditMajor" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiEditMajor : IHttpHandler {
    MajorService majorService = new MajorService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string majorId = context.Request.Form["majorId"];
        string majorName = context.Request.Form["majorName"];

        bool flag=majorService.updateMajor(int.Parse(majorId),majorName);
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}