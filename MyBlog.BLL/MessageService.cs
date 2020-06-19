using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyBlog.DAL;

namespace MyBlog.BLL
{
    /// <summary>
    /// 留言服务类
    /// </summary>
    public class MessageService
    {
        MyCommunityDataContext db = new MyCommunityDataContext();

        /// <summary>
        /// 插入留言到Message表中
        /// </summary>
        /// <param name="authorId">发帖人Id</param>
        /// <param name="userId">留言人Id</param>
        /// <param name="content">留言内容</param>
        public void insertIntoMessage(int authorId, int userId, string content)
        {
            DateTime date = Convert.ToDateTime(DateTime.Now);
            Message message = new Message
            {
                AuthorId = authorId,
                UserId = userId,
                MessageContent = content,
                MessageTime = date
            };
            db.Message.InsertOnSubmit(message); //插入到message表中
            db.SubmitChanges();
        }

        /// <summary>
        /// 获取分页的留言信息
        /// </summary>
        /// <param name="_authorId">发帖人Id</param>
        /// <param name="page">当前页码</param>
        /// <param name="limit">每页显示数据条数</param>
        /// <returns></returns>
        public List<Message> GetAllMsg(int _authorId,int page, int limit)
        {
            List<Message> msgList = new List<Message>();

            var x = from r in db.Message
                    where r.AuthorId== _authorId
                    select r;
            //分页查询
            var res = x.Skip((page - 1) * limit).Take(limit);
            msgList = res.ToList();
            return msgList;
        }
        /// <summary>
        ///  获取留言总数
        /// </summary>
        /// <param name="_authorId">发帖人Id</param>
        /// <returns></returns>
        public int getMsgCounts(int _authorId)
        {
            var x = from r in db.Message
                    where r.AuthorId== _authorId
                    select r;
            return x.ToList().Count();
        }

        /// <summary>
        /// 删除留言
        /// </summary>
        /// <param name="_messageId">留言Id</param>
        public void delMsg(int _messageId)
        {
            var x = from r in db.Message
                    where r.MessageId == _messageId
                    select r;
            db.Message.DeleteAllOnSubmit(x);
            db.SubmitChanges();
        }

        /// <summary>
        /// 模糊搜索留言内容
        /// </summary>
        /// <param name="_messageContent">留言内容</param>
        /// <returns></returns>
        public List<Message> searchMsg(int userId,string _messageContent)
        {
            string pattern = string.Format("%{0}%", _messageContent);

            var x = from r in db.Message
                    where r.AuthorId==userId&& 
                    System.Data.Linq.SqlClient.SqlMethods.Like(r.MessageContent, pattern)
                    || System.Data.Linq.SqlClient.SqlMethods.Like(r.User.UserName, pattern)
                    select r;
            return x.ToList();
        }

    }
}
