<%@ WebHandler Language="C#" Class="ApiStreamLoad" %>

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
public class ApiStreamLoad : IHttpHandler {
    AlbumService albumService=new AlbumService();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string page=context.Request.Form["myPage"];
        List<Photo> photoList = albumService.GetAllPhoto(2, int.Parse(page), 3);
        int counts=albumService.getPhotoCounts(2);
        int pages = counts / 3;
        if (pages * 3 < counts) pages = pages + 1;
        JObject res=new JObject();
        res.Add(new JProperty("pages", pages));
        JArray jArray=new JArray();
        foreach (var item in photoList)
        {
            JObject temp = new JObject();
            temp.Add("PhotoName", item.PhotoName);
            temp.Add("PhotoUrl", item.PhotoUrl);
            jArray.Add(temp);

        }
        res.Add(new JProperty("data", jArray));
        context.Response.Write(res);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}