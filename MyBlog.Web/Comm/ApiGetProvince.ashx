<%@ WebHandler Language="C#" Class="ApiGetProvince" %>

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

public class ApiGetProvince : IHttpHandler {
    CityPicService cityPicService = new CityPicService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        List<Province> provinceList=cityPicService.GetProvinces();
        JObject jo = new JObject();
        //jo.Add(new JProperty("counts",provinceList.Count));
        JArray jArray=new JArray();
        foreach (var item in provinceList)
        {
            JObject temp = new JObject();
            temp.Add(new JProperty("ProvinceId", item.ProvinceId));
            temp.Add(new JProperty("ProvinceName", item.ProvinceName));
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