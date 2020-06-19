<%@ WebHandler Language="C#" Class="ApiAddPhoto" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
public class ApiAddPhoto : IHttpHandler
{

    AlbumService albumService=new AlbumService();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string savePath = HttpContext.Current.Server.MapPath("../UploadFiles/");
        if (!System.IO.Directory.Exists(savePath))
        {
            System.IO.Directory.CreateDirectory(savePath);
        }
        HttpFileCollection hfc = context.Request.Files;
        if (hfc.Count > 0)
        {
            HttpPostedFile hpf = context.Request.Files[0];
            if (hpf.ContentLength > 0)
            {
                string fileName = Path.GetFileName(hpf.FileName);
                savePath = savePath + "\\" + fileName;
                hpf.SaveAs(savePath);
                string path = string.Format("UploadFiles/{0}", fileName);
                //法一
                //string json = "{\"fileName\":\"" + path + "\"}";
                //JObject jo = (JObject)JsonConvert.DeserializeObject(json);

                //法二
                JObject jObject=new JObject(new JProperty("fileName",path)) ;
                context.Response.Write(jObject);
                //获取当前时间
                DateTime dateTime = DateTime.Now.ToLocalTime();
                //插入数据库
                string userId = context.Application["userId"].ToString();
                //string userId = "2";
                albumService.insertPhoto(int.Parse(userId), fileName, path, dateTime);
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}