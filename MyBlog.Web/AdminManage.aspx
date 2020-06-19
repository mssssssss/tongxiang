<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminManage.aspx.cs" Inherits="AdminManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
</head>
<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin ">
        <div class="layui-header">
            <div class="layui-logo ">管理员后台</div>
            <!-- 头部区域（可配合layui已有的水平导航） -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item"><a href="">控制台</a></li>

                <li class="layui-nav-item">
                    <a href="javascript:;" class="layui-icon layui-icon-carousel"> 轮播图管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" data-id="4" data-title="上传图片" data-url="AdminUpImg.aspx"
                                class="site-demo-active" data-type="tabAdd">上传图片</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" data-id="5" data-title="城市图片" data-url="AdminAlbum.aspx"
                                class="site-demo-active" data-type="tabAdd">城市图片</a>
                        </dd>

                    </dl>
                </li>
            </ul>

            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img runat="server" src="images/管理员.png" class="layui-nav-img"/>
                        <asp:Label ID="lbl_userName" runat="server" Text="管理员"></asp:Label>
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" data-id="1" data-title="基本资料" data-url=""
                                class="site-demo-active" data-type="tabAdd">基本资料</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" data-id="9" data-title="安全设置" data-url="changePwd.aspx"
                                class="site-demo-active" data-type="tabAdd">安全设置</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="index2.aspx">退出</a></li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                    <li class="layui-nav-item layui-nav-itemed ">
                        <a class="layui-icon layui-icon-form" href="javascript:;"> 用户管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="javascript:;" data-id="2" data-title="用户审核" data-url="UnCheckedUser.aspx"
                                    class="site-demo-active " data-type="tabAdd">用户审核</a>
                            </dd>
                            <dd>
                                <a href="javascript:;" data-id="3" data-title="已审核用户" data-url="CheckedUser.aspx"
                                    class="site-demo-active" data-type="tabAdd">已审核用户</a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;" class="layui-icon layui-icon-note"> 帖子管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="javascript:;" data-id="6" data-title="帖子信息" data-url="AdminTopic.aspx"
                                    class="site-demo-active " data-type="tabAdd">帖子信息</a>
                            </dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="javascript:;" class="layui-icon layui-icon-note"> 专业类别管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="javascript:;" data-id="7" data-title="专业类别管理" data-url="AdminMajor.aspx"
                                    class="site-demo-active " data-type="tabAdd">专业类别管理</a>
                            </dd>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>

        <!--tab标签-->
        <%-- lay-allowclose允许Tab选项卡被删除 --%>
        <div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin-left: 200px;">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content"></div>
        </div>

    </div>
    <script src="Contents/layui.js"></script>
     <script>
        //JavaScript代码区域
        layui.use(['element', 'layer', 'jquery'], function () {
            var element = layui.element;
            // var layer = layui.layer;
            var $ = layui.$;
            // 配置tab实践在下面无法获取到菜单元素
            $('.site-demo-active').on('click', function () {
                var dataid = $(this);
                //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
                if ($(".layui-tab-title li[lay-id]").length <= 0) {
                    //如果比零小，则直接打开新的tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                } else {
                    //否则判断该tab项是否以及存在
                    var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                    $.each($(".layui-tab-title li[lay-id]"), function () {
                        //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                        if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                            isData = true;
                        }
                    })
                    if (isData == false) {
                        //标志为false 新增一个tab项
                        active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                    }
                }
                //最后不管是否新增tab，最后都转到要打开的选项页面上
                active.tabChange(dataid.attr("data-id"));
            });

            var active = {
                //在这里给active绑定几项事件，后面可通过active调用这些事件
                tabAdd: function (url, id, name) {
                    //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                    //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                    element.tabAdd('demo', {
                        title: name,
                        content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:99%;"></iframe>',
                        id: id //规定好的id
                    })
                    FrameWH();  //计算ifram层的大小
                },
                tabChange: function (id) {
                    //切换到指定Tab项
                    element.tabChange('demo', id); //根据传入的id传入到指定的tab项
                },
                tabDelete: function (id) {
                    element.tabDelete("demo", id);//删除
                }
            };
            function FrameWH() {
                var h = $(window).height();
                $("iframe").css("height", h + "px");
            }
        });
    </script>
</body>
</html>
