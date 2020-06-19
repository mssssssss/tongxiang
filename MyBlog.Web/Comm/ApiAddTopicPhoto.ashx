<%@ WebHandler Language="C#" Class="ApiAddTopicPhoto" %>
using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;
    using System.Web.SessionState;
public class ApiAddTopicPhoto : IHttpHandler ,IReadOnlySessionState{

    
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "application/json";
        string savePath = HttpContext.Current.Server.MapPath("../TopicImages/");
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
                string path = string.Format("TopicImages/{0}", fileName);
                //法一
                //string json = "{\"fileName\":\"" + path + "\"}";
                //JObject jo = (JObject)JsonConvert.DeserializeObject(json);

                //法二
                JObject jo = new JObject(new JProperty("code", 0));
                jo.Add(new JProperty("msg",""));
                JObject data = new JObject(new JProperty("src", path));
                jo.Add(new JProperty("data",data));
                context.Response.Write(jo);
                context.Session["topicPhotoUrl"] = path;
                //获取当前时间
                //DateTime dateTime = DateTime.Now.ToLocalTime();
                //插入数据库
                //string userId = context.Application["userId"].ToString();
                //string userId = "2";
                //topicPhotoService.insertTopicPhoto(,path);
            }
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}