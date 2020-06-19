<%@ WebHandler Language="C#" Class="ApiEditPhoto" %>

using System;
using System.Web;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
using System.IO;
public class ApiEditPhoto : IHttpHandler
{
    AlbumService albumService = new AlbumService();

    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string photoId = context.Request.Form["photoid"];
        string photoName = context.Request.Form["photoname"];
        bool flag=albumService.updatePhoto(int.Parse(photoId),photoName);
        JObject jo;
        if(flag==true)
        {
            jo = new JObject(new JProperty("msg", "修改成功"));
        }
        else
        {
            jo = new JObject(new JProperty("msg", "修改失败"));

        }
        context.Response.Write(jo);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}