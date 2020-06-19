<%@ WebHandler Language="C#" Class="ApiFuzzyMajor" %>

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

public class ApiFuzzyMajor : IHttpHandler {
    MajorService majorService = new MajorService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string majorName = context.Request.Params["majorName"];
        List<Major> majorList=majorService.searchMajor(majorName);
        int counts = majorList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray majors = new JArray();
        foreach (var item in majorList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("MajorId", item.MajorId));
            p.Add(new JProperty("MajorName", item.MajorName));
            majors.Add(p);
        }
        res.Add(new JProperty("data", majors));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}