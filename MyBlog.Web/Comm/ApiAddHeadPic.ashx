<%@ WebHandler Language="C#" Class="ApiAddHeadPic" %>
using System;
using System.Web;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using MyBlog.BLL;
using Newtonsoft.Json.Linq;

public class ApiAddHeadPic : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string savePath = HttpContext.Current.Server.MapPath("../HeadPics/");
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
                string path = string.Format("HeadPics/{0}", fileName);
                //法一
                //string json = "{\"fileName\":\"" + path + "\"}";
                //JObject jo = (JObject)JsonConvert.DeserializeObject(json);

                //法二
                JObject jObject=new JObject(new JProperty("headPicUrl",path)) ;
                jObject.Add(new JProperty("fileName",path)) ;
                context.Response.Write(jObject);
               
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}