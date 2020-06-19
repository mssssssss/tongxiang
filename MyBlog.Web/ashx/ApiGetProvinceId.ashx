<%@ WebHandler Language="C#" Class="ApiGetProvinceId" %>

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

public class ApiGetProvinceId : IHttpHandler ,System.Web.SessionState.IRequiresSessionState{

    ProvinceService provinceService=new ProvinceService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string provinceName = context.Request.Params["provinceName"];
        int provinceId=provinceService.findProId(provinceName);
        //将provinceId存到session中
        context.Session["provinceid"] = provinceId;
        
        JObject jo = new JObject(new JProperty("provinceId", provinceId));
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}