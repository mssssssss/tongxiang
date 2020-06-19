using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    
    public class AlbumService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();

        /// <summary>
        /// 插入图片
        /// </summary>
        /// <param name="_userId"></param>
        /// <param name="_photoName"></param>
        /// <param name="_photoUrl"></param>
        /// <param name="_dateTime"></param>
        public void insertPhoto(int _userId,string _photoName,string _photoUrl,DateTime _dateTime)
        {
            Photo photoItem = new Photo
            {
                UserId = _userId,
                PhotoName = _photoName,
                PhotoUrl= _photoUrl,
                PhotoTime=_dateTime
            };
            db.Photo.InsertOnSubmit(photoItem);
            db.SubmitChanges();
        }

        // 分页查询
        public List<Photo> GetAllPhoto(int _userId,int page,int limit)
        {
            List<Photo> photoList = new List<Photo>();
            var x=from r in db.Photo
                  where r.UserId==_userId 
                  select r ;
            var res = x.Skip((page - 1) * limit).Take(limit);
            photoList = res.ToList();
            return photoList; 
        }

        // 获取该用户的相片总数
        public int getPhotoCounts(int _userId)
        {
            List<Photo> photos = new List<Photo>();
            var x= from r in db.Photo
                   where r.UserId == _userId
                   select r;
            return x.ToList().Count();
        }
        //删除照片
        public string delPhoto(int _photoId)
        {
            var x = from r in db.Photo
                    where r.PhotoId == _photoId
                    select r;
            string pUrl=null;
            foreach (var item in x)
            {
                pUrl = item.PhotoUrl;
            }
            db.Photo.DeleteAllOnSubmit(x);
            db.SubmitChanges();
            return pUrl;//返回被删除图片的url，从而在服务器上对该图片进行删除
        }

        //更新照片名
        public bool updatePhoto(int _photoId,string _photoName)
        {
            bool flag = false;
            var x = from r in db.Photo
                    where r.PhotoId == _photoId
                    select r;
            if(x!=null)
            {
                foreach (var item in x)
                {
                    item.PhotoName = _photoName;
                    flag = true;
                }
            }
            db.SubmitChanges();
            return flag;
        }

        //照片模糊搜索
        public List<Photo> searchPhoto(int _userId,string _photoName)
        {
            string pattern = string.Format("%{0}%", _photoName);

            var x = from r in db.Photo
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.PhotoName, pattern)&&r.UserId==_userId
                    select r;
            return x.ToList();
        }

    }

    
}
