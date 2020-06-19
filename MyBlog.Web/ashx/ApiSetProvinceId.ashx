<%@ WebHandler Language="C#" Class="ApiSetProvinceId" %>

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


public class ApiSetProvinceId : IHttpHandler,System.Web.SessionState.IRequiresSessionState {
    
     public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string provinceId = context.Request.Params["provinceId"];

        context.Session["provinceid"] = provinceId;
        JObject jo = new JObject(new JProperty("msg", "成功"));
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}