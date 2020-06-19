<%@ WebHandler Language="C#" Class="ApiGetMajor" %>

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

public class ApiGetMajor : IHttpHandler {
    MajorService majorService = new MajorService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];
        List<Major> majorList = majorService.GetAllMajor(int.Parse(page), int.Parse(limit));
        //注意返回的count是所有的数据，而不是分页当前页面的数据
        int counts = majorService.getMajorCounts();
        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
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