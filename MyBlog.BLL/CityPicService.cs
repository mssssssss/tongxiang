using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;
namespace MyBlog.BLL
{
    /// <summary>
    /// 城市图片管理
    /// </summary>
    public class CityPicService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();
        //添加城市图片
        public void insertCityPic(int provinceId,string cityPicUrl)
        {
            CityPic cityPic = new CityPic
            {
                ProvinceId = provinceId,
                CityPicUrl = cityPicUrl
            };
            db.CityPic.InsertOnSubmit(cityPic);
            db.SubmitChanges();
        }

        // 分页查询城市图片
        public List<CityPic> GetAllCtyPic(int page, int limit)
        {
            List<CityPic> cityPicList = new List<CityPic>();
            var x = from r in db.CityPic
                    select r;
            var res = x.Skip((page - 1) * limit).Take(limit);
            cityPicList = res.ToList();
            return cityPicList;
        }

        // 获取城市图片总数
        public int getCityPicCounts()
        {
            List<Photo> photos = new List<Photo>();
            var x = from r in db.CityPic
                    select r;
            return x.ToList().Count();
        }
        //删除照片
        public string delCityPic(int _cityPicId)
        {
            var x = from r in db.CityPic
                    where r.CityPicId == _cityPicId
                    select r;
            string pUrl = null;
            foreach (var item in x)
            {
                pUrl = item.CityPicUrl;
            }
            db.CityPic.DeleteAllOnSubmit(x);
            db.SubmitChanges();
            return pUrl;//返回被删除图片的url，从而在服务器上对该图片进行删除
        }

        //模糊搜索城市图片
        public List<CityPic> searchCityPic(string provinceName)
        {
            string pattern = string.Format("%{0}%", provinceName);

            var x = from r in db.CityPic
                    where System.Data.Linq.SqlClient.SqlMethods.Like(r.Province.ProvinceName,pattern)
                    select r;
            return x.ToList();
        }

        //获取省份ID和省份名
        public List<Province> GetProvinces()
        {
            var x = from r in db.Province
                    select r;
            return x.ToList();

        }
        
        /// <summary>
        /// 获取省份Id
        /// </summary>
        /// <param name="provinceName">省份名</param>
        /// <returns></returns>
        public int getProvinceId(string provinceName)
        {
            int provinceId = 0;
            var x = from r in db.Province
                    where r.ProvinceName == provinceName
                    select r;
            if(x!=null)
            {
                foreach (var item in x)
                {
                    provinceId = item.ProvinceId;
                }
            }
            return provinceId;
        }

    }
}
