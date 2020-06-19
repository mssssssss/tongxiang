<%@ WebHandler Language="C#" Class="ApiFuzzyCityPic" %>

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

public class ApiFuzzyCityPic : IHttpHandler {
    CityPicService cityPicService = new CityPicService();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string provinceName = context.Request.Params["provinceName"];
        List<CityPic> photoList=cityPicService.searchCityPic(provinceName);
        int counts = photoList.Count;
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray photos = new JArray();
        foreach (var item in photoList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("CityPicId", item.CityPicId));
            p.Add(new JProperty("ProvinceId", item.ProvinceId));
            p.Add(new JProperty("ProvinceName", item.Province.ProvinceName));
            p.Add(new JProperty("CityPicUrl", item.CityPicUrl));
            photos.Add(p);
        }
        res.Add(new JProperty("data", photos));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}