<%@ WebHandler Language="C#" Class="ApiDeleteCityPic" %>
using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;

public class ApiDeleteCityPic : IHttpHandler {

    CityPicService cityPicService = new CityPicService();
    public void ProcessRequest (HttpContext context) {
         context.Response.ContentType = "application/json";
        
        string CityPicId = context.Request.Form["CityPicId"];
        string url = cityPicService.delCityPic(int.Parse(CityPicId));
        JObject jo;
        if (url != null)
        {//成功删除图片
            string savePath = HttpContext.Current.Server.MapPath("../" + url);
            File.Delete(savePath);
            jo = new JObject(new JProperty("msg", "删除成功"));
        }
        else
        {
            jo = new JObject(new JProperty("msg", "删除失败"));
        }
        context.Response.Write(jo);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}