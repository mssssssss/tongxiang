using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    /// <summary>
    /// 收藏服务
    /// </summary>
    public class CollectService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();

        /// <summary>
        /// 添加收藏
        /// </summary>
        /// <param name="userId">收藏者Id</param>
        /// <param name="topicId">帖子Id</param>
        public void insertCollect(int userId,int topicId)
        {
            Collect collect = new Collect
            {
                UserId = userId,
                TopicId = topicId
            };
            db.Collect.InsertOnSubmit(collect);
            db.SubmitChanges();

        }

        /// <summary>
        /// 收藏帖子总数
        /// </summary>
        /// <param name="userId">收藏者Id</param>
        /// <returns>返回收藏的帖子总数</returns>
        public int getCollectCounts(int userId)
        {
            var x = from r in db.Collect
                    where r.UserId == userId
                    select r;
            return x.Count();

        }

        /// <summary>
        /// 取消收藏
        /// </summary>
        /// <param name="userId">收藏者Id</param>
        /// <param name="topicId">话题Id</param>
        public void deleteCollect(int userId,int topicId)
        {
            var x = from r in db.Collect
                    where r.UserId == userId&&r.TopicId==topicId
                    select r;
            db.Collect.DeleteAllOnSubmit(x);
        }

        /// <summary>
        /// 获取收藏的所有帖子的信息
        /// </summary>
        /// <param name="userId">收藏者Id</param>
        /// <returns>收藏的所有帖子集合</returns>
        public List<Topic> getCollectTopic(int userId)
        {
            List<Topic> topicList = new List<Topic>();
            var x = (from collect in db.Collect
                    join topic in db.Topic on collect.TopicId equals topic.TopicId
                    select new
                    {
                        topic.TopicId,
                        topic.AuthorId,
                        topic.MajorId,
                        topic.DiffLevel,
                        topic.TopicTitle,
                        topic.TopicContent,
                        topic.TopicTime,
                        topic.LikesCount,
                        topic.CommentCount
                    });
            foreach (var item in x)
            {
                Topic topic = new Topic
                {
                    TopicId=item.TopicId,
                    AuthorId=item.AuthorId,
                    MajorId=item.MajorId,
                    DiffLevel=item.DiffLevel,
                    TopicTitle=item.TopicTitle,
                    TopicContent=item.TopicContent,
                    TopicTime=item.TopicTime,
                    LikesCount=item.LikesCount,
                    CommentCount=item.CommentCount
                };
                topicList.Add(topic);
            }
            return topicList;
        }
    }
}
