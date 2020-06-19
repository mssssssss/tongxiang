using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    public class MajorService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();
        //插入专业类别
        public void insertMajor(string majorName)
        {
            Major major = new Major
            {
                MajorName=majorName
            };
            db.Major.InsertOnSubmit(major);
            db.SubmitChanges();
        }

        // 分页查询专业类别
        public List<Major> GetAllMajor(int page, int limit)
        {
            List<Major> majorList = new List<Major>();

            var x = from r in db.Major
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);

            majorList = res.ToList();
            return majorList;
        }
        //获取所有的专业类别，用于贴子发布下拉框
        public List<Major> GetMajors()
        {
            List<Major> majorList = new List<Major>();

            var x = from r in db.Major
                    select r;
            majorList = x.ToList();

            return majorList;
        }

        // 获取类别总数
        public int getMajorCounts()
        {
            var x = from r in db.Major
                    select r;
            return x.ToList().Count();
        }

        //删除博客类别
        /*public void delBlogType(int _typeId)
        {
            var x = from r in db.blogType
                    where r.typeId == _typeId
                    select r;
            db.blogType.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }*/

        //更新专业类别
        public bool updateMajor(int majorId,string majorName)
        {
            bool flag = false;
            var x = from r in db.Major
                    where r.MajorId == majorId
                    select r;
            if (x != null)
            {
                foreach (var item in x)
                {
                    item.MajorName = majorName;
                    flag = true;
                }
            }
            db.SubmitChanges();
            return flag;
        }

        //模糊搜索博客类别
        public List<Major> searchMajor(string majorName)
        {
            string pattern = string.Format("%{0}%", majorName);

            var x = from r in db.Major
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.MajorName, pattern) 
                    select r;
            return x.ToList();
        }

    }
}
