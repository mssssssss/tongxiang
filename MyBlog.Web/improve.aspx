<%@ Page Language="C#" AutoEventWireup="true" CodeFile="improve.aspx.cs" Inherits="improve" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <style>
          html body{
            margin-top: 0;
        }
        /*分页按钮*/
        /*页码样式*/ 
        #totalNum {
            margin-right: 15px;
        }

       .btnPage {
            border: none;
            font-size: 15px;
            color: #5FB878;
            margin-right: 15px;
        }
       .tit:hover{
            color: #5FB878;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <%--帖子列表--%>
                    <div class="fly-panel" style="margin-bottom: 0; ">
                    
                        <asp:Repeater ID="rp2" runat="server">
                            <HeaderTemplate>
                                <ul class="fly-list">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li style="border-bottom: 1px dotted #e2e2e2;">
                                    <a href="home.aspx?userId=<%# Eval("UserId") %>" target="_blank" link class="fly-avatar">
                                        <img src="<%# Eval("HeadPic") %>">
                                    </a>
                                    <h2>
                                        <a class="layui-badge"><%# Eval("School") %></a>
                                        <a class="layui-badge"><%# Eval("MajorName") %></a>
                                        <a href="detail.aspx?topicId=<%# Eval("TopicId") %>" target="_blank" class="tit"><%# Eval("TopicTitle") %></a>
                                    </h2>
                                    <div class="fly-list-info">
                                        <a href="home.aspx?userId=<%# Eval("UserId") %>" target="_blank" link>
                                            <cite><%# Eval("UserName") %></cite>
                                        </a>
                                        <span><%# Eval("TopicTime") %></span>

                                        <span class="fly-list-nums">
                                            <i class="iconfont icon-zan" title="点赞"></i><%# Eval("LikesCount") %>
                                            <i class="iconfont icon-pinglun1" title="评论"></i><%# Eval("CommentCount") %>
                                        </span>
                                    </div>
                                </l>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div style="text-align: right; height: 55px; line-height: 55px;">
                            当前页码为：<asp:Label ID="num" runat="server"></asp:Label><asp:Label ID="totalNum" runat="server"></asp:Label>
                            <asp:Button ID="btnFirst" runat="server" Text="第一页" OnClick="btnFirst_Click" BackColor="Transparent" CssClass="btnPage" />
                            <asp:Button ID="btnUp" runat="server" Text="上一页" OnClick="btnUp_Click" BackColor="Transparent" CssClass="btnPage" />
                            <asp:Button ID="btnDown" runat="server" Text="下一页" OnClick="btnDown_Click" BackColor="Transparent" CssClass="btnPage" />
                            <asp:Button ID="btnLast" runat="server" Text="最后一页" OnClick="btnLast_Click" BackColor="Transparent" CssClass="btnPage" />
                        </div>
                    </div>
            
    </form>
</body>
    <script src="res/layui/layui.js"></script>
</html>
