using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    /// <summary>
    /// 粉丝服务
    /// </summary>
   public class FanService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();

        //判断user_b是否是user_a的粉丝
        public Boolean isFan(int user_a, int user_b)
        {
            Fan fan = (from f in db.Fan
                       where f.UserId == user_a && f.FollowerId == user_b
                       select f).FirstOrDefault();
            if (fan != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //统计userId为userid的用户的粉丝数
        public int NumOfFans(int userid)
        {
            return (from r in db.Fan
                    where r.UserId == userid
                    select r).Count();
        }
        /// <summary>
        /// 添加粉丝
        /// </summary>
        /// <param name="userId">我</param>
        /// <param name="followerId">毛双双</param>
        public void insertFan(int userId,int followerId)
        {
            Fan fan = new Fan
            {
                UserId = userId,
                FollowerId = followerId
            };
            Watch watch = new Watch
            {
                UserId = followerId,
                FollowingId = userId
            };
            db.Watch.InsertOnSubmit(watch);
            db.Fan.InsertOnSubmit(fan);
            db.SubmitChanges();
        }

        /// <summary>
        /// 删除粉丝
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="followerId"></param>
        public void deleteFan(int userId,int followerId)
        {
            var x = from r in db.Fan
                    where r.UserId == userId && r.FollowerId == followerId
                    select r;
            var watch = from r in db.Watch
                    where r.UserId == followerId && r.FollowingId == userId
                    select r;
            db.Watch.DeleteAllOnSubmit(watch);
            db.Fan.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }

        //获取我的粉丝
        public List<User> getMyFan(int userId, int page, int limit)
        {
            List<User> users = new List<User>();
            var x = from r in db.Fan
                    where r.UserId == userId 
                    select r;
            var res = x.Skip((page - 1) * limit).Take(limit);
            foreach (var item in res)
            {
                User user = (from u in db.User
                             where item.FollowerId == u.UserId
                             select u).FirstOrDefault();
                users.Add(user);
            }
            return users;
        }

        //获取我的粉丝总数
        public int getMyFanCount(int userId)
        {
            List<User> users = new List<User>();
            var x = from r in db.Fan
                    where r.UserId == userId
                    select r;
            foreach (var item in x)
            {
                User user = (from u in db.User
                             where item.FollowerId == u.UserId
                             select u).FirstOrDefault();
                users.Add(user);
            }
            return users.Count;
        }
    }
}
