<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <style>
        /*退出按钮*/
        .exit {
            border: none;
            width: 100%;
            text-align: left;
        }

        /*回复按钮*/
        .reply {
            cursor: pointer;
            color: #999;
        }

            .reply:hover {
                color: #666;
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

        .zan {
            width: 17px;
            margin-bottom: -1px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--头部导航栏--%>
            <div class="fly-header layui-bg-black">
                <div class="layui-container">
                    <a class="fly-logo" href="/">
                        <img src="images/logo_通享.png" />
                        <%--<img src="images/logo通享.png" style="width: 140px; position: absolute; top: -40px; left: -25px" />--%>
                    </a>
                    <ul class="layui-nav fly-nav">
                        <li class="layui-nav-item layui-this">
                            <a href="index2.aspx">首页</a>
                        </li>
                        <li class="layui-nav-item">
                            <a href="register2.aspx" target="_blank">注册</a>
                        </li>
                        </li>
                        <li class="layui-nav-item">
                            <a href="login2.aspx" target="_blank">登录</a>
                        </li>
                        <li class="layui-nav-item">
                            <a href="about.aspx" target="_blank">关于</a>
                        </li>
                        <li class="layui-nav-item" style="margin-left: 20px;">
                            <span class="fly-search"><i class="layui-icon"></i></span>
                        </li>
                        <li class="layui-nav-item">
                            <a href="PostArticle.aspx" class="layui-btn ">发表新帖</a>
                        </li>
                        <li class="layui-nav-item" style="position: absolute; top: 0; right: 10px;" runat="server" id="perInfo">
                            <a href="javascript:;">
                                <asp:Image ID="imgHead" runat="server" CssClass="layui-nav-img" />
                                <asp:Label ID="lblUser" runat="server"></asp:Label>
                            </a>
                            <dl class="layui-nav-child">
                                <dd>
                                    <a href="javascript:;">
                                        <asp:HyperLink ID="hlHome" runat="server">个人主页</asp:HyperLink>
                                    </a>
                                </dd>
                                <dd><a href="BackStage.aspx">后台管理</a></dd>
                                <dd>
                                    <a href="javascript:;">
                                        <asp:Button ID="btnExit" runat="server" Text="退出" CssClass="exit" BackColor="Transparent" OnClick="btnExit_Click" />
                                    </a>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </div>


            </div>

            <%--文章信息栏--%>
            <div class="layui-container" style="margin-top: 20px;">
                <div class="layui-row layui-col-space15">
                    <div class="layui-col-md12 content detail">
                        <%--文章区--%>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsTopic">
                            <HeaderTemplate>
                                <div class="fly-panel detail-box">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <h1><%# Eval("TopicTitle") %></h1>
                                <div class="fly-detail-info">
                                    <span class="layui-badge layui-bg-green fly-detail-column"><%# Eval("MajorName") %></span>
                                    <span class="layui-badge" style="background-color: #999;"><%# handle(Eval("DiffLevel").ToString()) %></span>
                                    <span class="fly-list-nums">
                                        <a href="javascript:;">
                                            <asp:ImageButton CssClass="zan" ID="btnZan" runat="server" OnClick="btnZan_Click" ImageUrl="<%# judgeZan() %>" />
                                            <%# Eval("LikesCount") %>
                                        </a>
                                        <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i><%# Eval("CommentCount") %></a>
                                    </span>
                                </div>
                                <div class="detail-about">
                                    <a class="fly-avatar" href="home.aspx?userId=<%# Eval("UserId") %>">
                                        <img src="<%# Eval("HeadPic") %>">
                                    </a>
                                    <div class="fly-detail-user">
                                        <a href="home.aspx?userId=<%# Eval("UserId") %>" class="fly-link" style="padding-right: 5px;">
                                            <cite><%# Eval("UserName") %></cite>
                                        </a>
                                        <span class="layui-badge layui-bg-green"><%# Eval("School") %></span>
                                    </div>
                                    <div class="detail-hits" id="LAY_jieAdmin">
                                        <span style="padding-right: 10px;"><%# Eval("TopicTime")%></span>
                                    </div>
                                </div>
                                <div class="detail-body photos">
                                    <p>
                                        <%# Eval("TopicContent") %>
                                    </p>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="sdsTopic" runat="server" ConnectionString="<%$ ConnectionStrings:MyCommunityConnectionString %>" SelectCommand="SELECT * FROM [Major] JOIN [Topic] ON [Major].MajorId = [Topic].MajorId JOIN [User] ON [Topic].AuthorId=[User].UserId  WHERE ([Topic].TopicId = @TopicId)">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="6" Name="TopicId" QueryStringField="topicId" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <%--评论区--%>
                        <div class="fly-panel detail-box" id="flyReply">
                            <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                                <legend>讨论区</legend>
                            </fieldset>
                            <%--评论列表--%>
                            <asp:Repeater ID="rp" runat="server" OnItemCommand="rp_ItemCommand">
                                <HeaderTemplate>
                                    <ul class="jieda" id="jieda">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li data-id="111" class="jieda-daan">
                                        <div class="detail-about detail-about-reply">
                                            <a class="fly-avatar" href='home.aspx?userId=<%# Eval("UserId") %>'>
                                                <img src='<%# Eval("HeadPic") %>' alt=" " />
                                            </a>
                                            <div class="fly-detail-user">
                                                <a href='home.aspx?userId=<%# Eval("UserId") %>' class="fly-link">
                                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("UserId") %> ' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("UserName") %> '></asp:Label>
                                                </a>
                                                <span class="layui-badge"><%# Eval("School") %></span>
                                            </div>

                                            <div class="detail-hits">
                                                <span><%# Eval("CmtTime") %></span>
                                            </div>
                                        </div>
                                        <div class="detail-body jieda-body photos">
                                            <p><%# Eval("CmtContent") %></p>
                                        </div>
                                        <div class="jieda-reply">
                                            <span>
                                                <i class="iconfont icon-svgmoban53"></i>
                                                <asp:Button ID="btn" runat="server" Text="回复" BackColor="Transparent" BorderStyle="None" CssClass="reply" />
                                            </span>
                                        </div>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>

                            <div style="text-align: right; height: 55px; line-height: 55px;" id="pageDiv" runat="server">
                                当前页码为：<asp:Label ID="num" runat="server"></asp:Label><asp:Label ID="totalNum" runat="server"></asp:Label>
                                <asp:Button ID="btnFirst" runat="server" Text="第一页" OnClick="btnFirst_Click" BackColor="Transparent" CssClass="btnPage" />
                                <asp:Button ID="btnUp" runat="server" Text="上一页" OnClick="btnUp_Click" BackColor="Transparent" CssClass="btnPage" />
                                <asp:Button ID="btnDown" runat="server" Text="下一页" OnClick="btnDown_Click" BackColor="Transparent" CssClass="btnPage" />
                                <asp:Button ID="btnLast" runat="server" Text="最后一页" OnClick="btnLast_Click" BackColor="Transparent" CssClass="btnPage" />
                            </div>



                            <div class="layui-form layui-form-pane">
                                <form>
                                    <div class="layui-form-item layui-form-text">
                                        <a name="comment"></a>
                                        <div class="layui-input-block">
                                            <textarea id="L_content" runat="server" name="content" placeholder="请输入内容" class="layui-textarea fly-editor" style="height: 150px;"></textarea>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <asp:Button ID="btnReply" runat="server" Text="评论" lay-filter="*" lay-submit CssClass="layui-btn" OnClick="btnReply_Click" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--底部的信息栏--%>
            <div class="fly-footer">
                <p>
                    <a href="javascript:;">通享社区</a>
                    2020 &copy;
                <a href="javascript:;">版权所有，翻版必究</a>
                </p>
            </div>
        </div>

    </form>
</body>
<script src="res/layui/layui.js"></script>
<script>
    layui.config({
        version: "3.0.0"
        , base: 'res/mods/' //这里实际使用时，建议改成绝对路径
    }).extend({
        fly: 'index'
    }).use('fly');

    //给评论区域设置为富文本编辑器
    layui.use('layedit', function () {
        var layedit = layui.layedit;

        layedit.set({
            uploadImage: {
                url: "Comm/ApiAddTopicPhoto.ashx",
                type: "post"
            }
        })
        layedit.build('L_content'); //建立编辑器
    });

</script>
<script src="Scripts/jquery-3.5.1.min.js"></script>
<script>

</script>
</html>
