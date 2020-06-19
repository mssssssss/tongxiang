using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;
namespace MyBlog.BLL
{
    /// <summary>
    /// 评论服务类
    /// </summary>
    public class CommentService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();

        /// <summary>
        /// 返回TopicId为id的话题的评论数
        /// </summary>
        /// <param name="_topicId">帖子Id</param>
        /// <returns></returns>
        public int CommentCount(int _topicId)
        {
            return (from c in db.Comment where c.TopicId == _topicId select c).Count();
        }

        /// <summary>
        /// 插入评论到Comment表中
        /// </summary>
        /// <param name="topicId">帖子Id</param>
        /// <param name="userId">评论人Id</param>
        /// <param name="cmtContent">评论内容</param>
        /// <param name="preCmtId">对什么评论</param>
        public void insertIntoComment(int topicId, int userId, string cmtContent, int preCmtId)
        {
            //设置一个默认值时间插入
            DateTime time = new DateTime();
            time = Convert.ToDateTime(DateTime.Now);
            Comment comment = new Comment
            {
                TopicId = topicId,
                UserId = userId,
                CmtContent = cmtContent,
                PreCmtId = preCmtId,
                CmtTime = time
            };
            db.Comment.InsertOnSubmit(comment);  //插入到Comment表中
            db.SubmitChanges();  //提交修改
        }

        /// <summary>
        /// 分页查询评论,_authorId为发帖人的Id，即查询该博主所有帖子的评论
        /// </summary>
        /// <param name="_authorId"></param>
        /// <param name="page"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        public List<Comment> GetAllComment(int _authorId, int page, int limit)
        {
            List<Comment> cmtList = new List<Comment>();
            var x = from r in db.Comment
                        //直接引用，不用多表连接，但是只返回一个表的数据，若要
                        //返回多个表的数据，则自定义与返回类型相同结构的类，或者使用委托
                    where r.TopicId == r.Topic.TopicId && r.Topic.AuthorId == _authorId
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);
            cmtList = res.ToList();
            return cmtList;
        }

        /// <summary>
        /// 获取评论总数
        /// </summary>
        /// <param name="_authorId"></param>
        /// <returns></returns>
        public int getCmtCounts(int _authorId)
        {
            var x = from r in db.Comment
                    where r.TopicId == r.Topic.TopicId && r.Topic.AuthorId == _authorId
                    select r;
            return x.ToList().Count();
        }

        /// <summary>
        /// 删除评论
        /// </summary>
        /// <param name="_commentId"></param>
        public void delMsg(int _commentId)
        {
            var x = from r in db.Comment
                    where r.CommentId == _commentId
                    select r;
            db.Comment.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }

        /// <summary>
        /// 模糊搜索评论关键字
        /// </summary>
        /// <param name="_comContent">评论内容关键字</param>
        /// <returns></returns>
        public List<Comment> searchCmt(int userId, string _comContent)
        {
            string pattern = string.Format("%{0}%", _comContent);

            var x = from r in db.Comment
                    where
                    (
                    System.Data.Linq.SqlClient.SqlMethods.Like(r.CmtContent, pattern)
                    || System.Data.Linq.SqlClient.SqlMethods.Like(r.User.UserName, pattern)
                    || System.Data.Linq.SqlClient.SqlMethods.Like(r.Topic.TopicTitle, pattern)) && r.Topic.AuthorId == userId && r.TopicId == r.Topic.TopicId
                    select r;
            return x.ToList();
        }
    }
}
