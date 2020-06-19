<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <style>
        /*照片墙调整图片间距*/
        .home-jieda li:nth-child(1),.home-jieda li:nth-child(2){
            margin-top: 15px;
        }
        .home-jieda>li:nth-of-type(2n){
            margin-right: 0 !important; 
        }

        /*留言*/
         .tbMes {
            width: 90%;
            height: 80px;
            border: 1px solid #ddd;
            border-radius: 3px;
            margin: 8px 0 15px 16px;
        }
            .btnMessage {
            float: right;
            width: 60px;
            height: 30px;
            background-color: #009688;
            color: #fff;
            border: none;
            margin-top: 58px;
            margin-right: 30px;
            border-radius: 3px;
        }
        /*退出按钮*/
        .exit{
            border: none;
            width: 100%;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--头部导航栏--%>
            <div class="fly-header layui-bg-black">
                <div class="layui-container">
                    <a class="fly-logo" href="javascript:;" style="top:10px;">
                        <img src="images/logo_通享.png" />
                    </a>
                    <ul class="layui-nav fly-nav">
                        <li class="layui-nav-item layui-this">
                            <a href="index2.aspx">首页</a>
                        </li>
                        <li class="layui-nav-item">
                            <a href="register2.aspx" target="_blank">注册</a>
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
                                <asp:Image ID="imgHead" runat="server" CssClass="layui-nav-img"  /> 
                                <asp:Label ID="lblUser" runat="server"></asp:Label>
                            </a>
                            <dl class="layui-nav-child">
                                <dd>
                                    <a href="javascript:;">
                                        <asp:HyperLink ID="hlHome" runat="server"  >个人主页</asp:HyperLink>
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
            <%--基本资料--%>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsUser">
                <HeaderTemplate>
                    <div class="fly-home fly-panel">
                </HeaderTemplate>
                <ItemTemplate>
                    <img src="<%# Eval("HeadPic") %>" />
                    <h1><%# Eval("UserName") %>
                        <%--判断用户的性别 从而显示出男、女的图标--%>
                        <%# judge( Eval("Sex").ToString())  %>  
                        <span style=" color: #5FB878;"">（ <%# Eval("MajorName") %> ）</span>
                    </h1>
                    <p style="padding: 10px 0; color: #5FB878;">学历：<%# Eval("School") %> &nbsp;<%# Eval("Education") %></p>
                   
                    <p class="fly-home-info">
                        <i class="iconfont icon-shijian"></i><span><%# convert(Eval("JoinTime").ToString()) %>加入</span>
                        <i class="iconfont icon-chengshi"></i><span>来自<%# Eval("ProvinceName") %></span>
                        <img src="images/fan.png" style="width: 20px; height: 20px;padding-right: 5px;
padding-left: 10px;" /><span>粉丝数：<%# FansCount( int.Parse(Eval("UserId").ToString()) ) %></span>
                    </p>
                    
                    <div class="fly-sns">

                        <asp:Button ID="btnGz" runat="server" Text="<%# GzText() %>"  CssClass="<%# GzCss() %>" OnClick="btnGz_Click" />
                        <a href="#mes" class="layui-btn layui-btn-normal fly-imActive" data-type="chat">留言</a>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:MyCommunityConnectionString %>" SelectCommand="SELECT * FROM [User] JOIN [Province] ON [User].ProvinceId = [Province].ProvinceId JOIN [Major] ON [User].MajorId=[Major].MajorId  WHERE ([UserId] = @UserId)">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="11" Name="UserId" QueryStringField="userId" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div class="layui-container">
                <div class="layui-row layui-col-space15">
                    <%--帖子列表--%>
                    <asp:Repeater ID="rp" runat="server" DataSourceID="sdsTopic">
                        <HeaderTemplate>
                             <div class="layui-col-md6 fly-home-jie">
                                <div class="fly-panel">
                            <h3 class="fly-panel-title"><%# Eval("UserName") %> 最近的帖子</h3>
                            <ul class="jie-row">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%--显示作者最新的十个帖子--%>
                            <li>       
                                    <a href="detail.aspx?topicId=<%# Eval("TopicId") %>" class="jie-title"><%# Eval("TopicTitle") %></a>
                                    <i><%# Eval("TopicTime") %></i>
                                    <em class="layui-hide-xs"><%# Eval("LikesCount") %>赞/<%# Eval("CommentCount")%>答</em>
                                </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </div>
                    </div>
                        </FooterTemplate>
                    </asp:Repeater>
                       
                    <asp:SqlDataSource ID="sdsTopic" runat="server" ConnectionString="<%$ ConnectionStrings:MyCommunityConnectionString %>" SelectCommand="SELECT TOP 10 * FROM [Topic] JOIN [User] ON [Topic].AuthorId = [User].UserId  WHERE ([AuthorId] = @AuthorId) ORDER BY [Topic].TopicTime desc">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="7" Name="AuthorId" QueryStringField="userId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                        

                    <%--照片墙--%>
                    <div class="layui-col-md6 fly-home-da">
                        <div class="fly-panel">
                            <h3 class="fly-panel-title">照片墙</h3>
                            <%--展示最新的四张个人照片--%>
                            <asp:Repeater ID="rp2" runat="server" DataSourceID="sdsPhoto">
                                <HeaderTemplate>
                                     <ul class="home-jieda">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li style="width: 48%; float: left; margin-right: 14px;">
                                    <img src="<%# Eval("PhotoUrl") %>" style="width:100%;  height: 225px; object-fit: cover"/>
                                   </li> 
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                            
                            <asp:SqlDataSource ID="sdsPhoto" runat="server" ConnectionString="<%$ ConnectionStrings:MyCommunityConnectionString %>" SelectCommand="SELECT TOP 4 * FROM [Photo] WHERE ([UserId] = @UserId) ORDER BY [Photo].PhotoTime desc">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="7" Name="UserId" QueryStringField="userId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>               
                            
                        </div>
                    </div>
                   <%--留言区--%>
                    <div class="layui-col-md12 fly-home-jie">
                        <div class="fly-panel">
                            <a name="mes"></a>
                            <h3 class="fly-panel-title">留言区</h3>
                            <ul class="home-jieda">
                                <li>
                                     <asp:TextBox ID="tb" runat="server" TextMode="MultiLine"  CssClass="tbMes" ToolTip="在这儿留下你的留言！" ></asp:TextBox>
                                     <asp:Button ID="tbMes" runat="server" Text="留言" CssClass="btnMessage" OnClick="tbMes_Click"  />
                                </li> 
                           </ul>
                        </div>
                    </div>

                    <%-- 留言区流加载 --%>


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
</script>
</html>
