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
using System.Web.SessionState;
public class ApiGetProvinceId : IHttpHandler,IReadOnlySessionState {
    CityPicService cityPicService=new CityPicService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string provinceName = context.Request.Params["provinceName"];
        int provinceId=cityPicService.getProvinceId(provinceName);

        context.Session.Add("provinceId",provinceId);

        JObject jo = new JObject(new JProperty("provinceId", provinceId));
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}