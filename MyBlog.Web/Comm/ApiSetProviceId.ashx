<%@ WebHandler Language="C#" Class="ApiSetProviceId" %>

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
using System.Web.SessionState;

public class ApiSetProviceId : IHttpHandler ,IReadOnlySessionState{
    CityPicService cityPicService = new CityPicService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string provinceId = context.Request.Params["provinceId"];
        context.Session["provinceId"] = provinceId;
        JObject jo = new JObject(new JProperty("msg", "成功"));
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}