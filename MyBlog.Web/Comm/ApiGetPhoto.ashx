<%@ WebHandler Language="C#" Class="ApiGetPhoto" %>

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
//获得所有photo表的信息
public class ApiGetPhoto : IHttpHandler
{
    AlbumService albumService = new AlbumService();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string userid = context.Application["userId"].ToString();
        //string userid ="2";
        string page = context.Request.Params["page"];
        string limit=context.Request.Params["limit"];

        List<Photo> photoList = albumService.GetAllPhoto(int.Parse(userid), int.Parse(page), int.Parse(limit));
        //注意返回的count是所有的数据，而不是分页当前页面的数据
        int counts = albumService.getPhotoCounts(int.Parse(userid));

        //重点掌握json对象，注意引入Newtonsoft.Json.Linq和System.Collections.Generic
        //注意layui中table返回数据的json格式如下，如果是自己独有的json格式，需要在
        //table.render中添加parseData字段，详见官方文档
        JObject res = new JObject();
        res.Add(new JProperty("code", 0));
        res.Add(new JProperty("msg", ""));
        res.Add(new JProperty("count", counts));
        JArray photos = new JArray();
        foreach (var item in photoList)
        {
            JObject p = new JObject();
            p.Add(new JProperty("PhotoId", item.PhotoId));
            p.Add(new JProperty("PhotoName", item.PhotoName));
            p.Add(new JProperty("PhotoUrl", item.PhotoUrl));
            p.Add(new JProperty("PhotoTime", item.PhotoTime));
            photos.Add(p);
        }
        res.Add(new JProperty("data", photos));
        context.Response.Write(res);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}