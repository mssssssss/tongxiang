<%@ WebHandler Language="C#" Class="ApiGetAllMajor" %>

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

public class ApiGetAllMajor : IHttpHandler {
    
   MajorService majorService= new MajorService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        List<Major> majorList=majorService.GetMajors();
        JObject jo = new JObject();
        //jo.Add(new JProperty("counts",provinceList.Count));
        JArray jArray=new JArray();
        foreach (var item in majorList)
        {
            JObject temp = new JObject();
            temp.Add(new JProperty("MajorId", item.MajorId));
            temp.Add(new JProperty("MajorName", item.MajorName));
            jArray.Add(temp);
        }
        jo.Add(new JProperty("data", jArray));
        context.Response.Write(jo);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}