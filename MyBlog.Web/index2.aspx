<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index2.aspx.cs" Inherits="index2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Access-Control-Allow-Origin" content="*" />
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <link href="swiper/swiper.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    
    <style>
        /*轮播图*/
        .swiper-container {
            width: 100%;
            height: 100%;
        }

        .swiper-slide {
            text-align: center;
            font-size: 14px;
            background: #fff;
            display: flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }
        /*改变分页区的选中色*/
        .swiper-pagination-bullet-active{
            opacity: 1;
            background-color: #5FB878;
        }
        /*改变前后按钮的大小和颜色*/
        .swiper-button-prev,.swiper-button-next {
            width: 25px;
            height: 20px;
            margin-top: -8px;
            background-image:url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M0%2C22L22%2C0l2.1%2C2.1L4.2%2C22l19.9%2C19.9L22%2C44L0%2C22L0%2C22L0%2C22z'%20fill%3D'%235FB878'%2F%3E%3C%2Fsvg%3E")
        }
        .swiper-button-next {
            background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M27%2C22L27%2C22L5%2C44l-2.1-2.1L22.8%2C22L2.9%2C2.1L5%2C0L27%2C22L27%2C22z'%20fill%3D'%235FB878'%2F%3E%3C%2Fsvg%3E")
        }

        /*分页按钮*/
        /*页码样式*/ 
        #totalNum {
            margin-right: 15px;
        }

        .btnPage {
            border: none;
            font-size: 15px;
            color: rgb(88, 157, 198);
            margin-right: 15px;
        }

        .reyi a:hover{
            color: #009688;
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
        <%--头部导航栏--%>
        <div class="fly-header layui-bg-black">
            <div class="layui-container">
                <a class="fly-logo" href="javascript:;" style="top:10px;">
                    <img src="images/logo_通享.png" />
                    <%--<img src="images/logo通享.png" style="width: 140px; position: absolute; top: -40px; left: -25px " />--%>
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
                        <asp:LinkButton ID="lbPost" runat="server" OnClick="lbPost_Click" CssClass="layui-btn">发表新帖</asp:LinkButton>
                        <%--<a href="PostArticle.aspx" class="layui-btn ">发表新帖</a>--%>
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
                                <a href="javascript:;" runat="server" >
                                    <asp:Button ID="btnExit" runat="server" Text="退出" CssClass="exit" BackColor="Transparent" OnClick="btnExit_Click" />
                                </a>

                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item" style="color: rgba(255,255,255,0.7); padding-left: 50px" runat="server" id="loc">
                     <i class="iconfont icon-chengshi" style="font-size: 16px; padding-right: 5px"></i> 定位您的位置是在：<span id="provinceName" runat="server"></span>
                        
                    </li>
                  
                </ul>


            </div>


        </div>

        <div class="layui-container" id="bot">
           
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md8">
                    <%--城市轮播图--%>
                    <div class="fly-panel" style="margin-top: 20px; margin-bottom: 20px; height: 240px;">
                        <!-- Swiper -->
                        <div class="swiper-container">
                                <asp:Repeater ID="rp" runat="server" DataSourceID="sdsCityPic">
                                    <HeaderTemplate>
                                        <div class="swiper-wrapper">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                         <div class="swiper-slide">
                                            <img src="<%# Eval("CityPicUrl") %>" style="width: 100%; object-fit: cover;"/>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                            
                              
                            
                                <asp:SqlDataSource ID="sdsCityPic" runat="server" ConnectionString="<%$ ConnectionStrings:MyCommunityConnectionString %>" SelectCommand="SELECT * FROM [CityPic] WHERE ([ProvinceId] = @ProvinceId)">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="11" Name="ProvinceId" SessionField="provinceid" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            
                              
                            
                            <!-- Add Pagination -->
                            <div class="swiper-pagination"></div>
                            <!-- Add Arrows -->
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                    </div>
                    
                    <%--帖子列表--%>
                    <div class="fly-panel" style="margin-bottom: 0; box-shadow: none; background-color: transparent;" >
                        <%--面包屑导航--%>
                        <div class="fly-panel-title fly-filter" id="mb" runat="server" style="background-color:#fff">
                            <a href="basic.aspx" target="iList" class="layui-this" >基础知识</a>
                            <span class="fly-mid"></span>
                            <a href="improve.aspx" target="iList" >进阶知识</a>
                            <span class="fly-mid"></span>
                            <a href="highLevel.aspx" target="iList">高级知识</a>
                            <span class="fly-mid"></span>
                            <a href="otherSubject.aspx" target="iList">其他知识</a>
                            <span class="fly-filter-right layui-hide-xs">
                                <a href="javascript:;" class="layui-this" >按最新</a>
                            </span>
                        </div>
                        <iframe id="ifr" name="iList" src="basic.aspx" width="100%" height="283px" scrolling="none" frameborder="0"></iframe>                  
                    </div>
                </div>
                
                <div class="layui-col-md4">
                    <%--每日一句--%>
                    <dl class="fly-panel fly-list-one" style="margin-top: 20px;">
                        <dt class="fly-panel-title">每日一句</dt>
                        <dd style="white-space: normal; color: #009688">
                             <div id="sentenceEng" >英文： </div>
                             <div id="sentenceChe">译文：</div>
                             <div id="date" style="text-align: right;"></div>
                        </dd>
                    </dl>

                    <%--知识热榜--%>
                    <asp:Repeater ID="_rp" runat="server" >
                        <HeaderTemplate>
                            <dl class="fly-panel fly-list-one">
                                <dt class="fly-panel-title">知识热榜</dt>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <dd class="reyi" style="line-height: 30px">
                                <a href="detail.aspx?topicId=<%# Eval("TopicId") %>" target="_blank"><%# Eval("TopicTitle") %></a>
                                <span style="float: right;">
                                    <i class="iconfont icon-zan" title="点赞"></i><%# Eval("LikesCount") %>
                                    <i class="iconfont icon-pinglun1" title="评论" style="margin-left: 8px;"></i><%# Eval("CommentCount") %>
                                </span>
                            </dd>
                        </ItemTemplate>
                        <FooterTemplate>
                            </dl>
                        </FooterTemplate>
                    </asp:Repeater>


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
    </form>
</body>
<script src="res/layui/layui.js"></script>
<script src="Scripts/jquerysession.js"></script>
<script>
    layui.config({
        version: "3.0.0"
        , base: 'res/mods/' //这里实际使用时，建议改成绝对路径
    }).extend({
        fly: 'index'
        }).use('fly');

    
</script>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>
<%--引入轮播图js--%>
<script src="swiper/swiper.js"></script>
<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper('.swiper-container', {
        spaceBetween: 30,
        centeredSlides: true,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
  </script>

<script>
    //实现面包屑导航选中的元素变色 而未选中的元素不变色
    $(function () {
        $(".fly-panel-title>a").click(function () {
            $(this).addClass("layui-this").siblings().removeClass("layui-this");
        })
        $(".fly-filter-right>a").click(function () {
            $(this).index
             $(this).addClass("layui-this").siblings().removeClass("layui-this");
        })
        //每日一句 将json数据渲染到页面上
        $.get("http://api.tianapi.com/txapi/everyday/index?key=77d1009c367b9d373ee7fbe952db681d",
            function(data,status){
                console.log(data.newslist[0].imgurl);
                $('#sentenceEng').append(data.newslist[0].content); //返回中文内容绑定到ID为sentenceEng的标签
                $('#sentenceChe').append(data.newslist[0].note); //返回英文内容绑定到ID为sentenceChe的标签
                $('#date').append(" " + data.newslist[0].date); //绑定日期
               
            });
    
        //点击面包屑导航的不同选项 跳转到不同页面
        //$("#mb>a:nth-of-type(1)").click(function () {
        //    $("#ifr").attr("src", "basic.aspx");
        //})
        //$("#mb>a:nth-of-type(2)").click(function () {
        //    $("#ifr").attr("src", "improve.aspx");
        //})
        //$("#mb>a:nth-of-type(3)").click(function () {
        //    $("#ifr").attr("src", "highLevel.aspx");
        //})
        //$("#mb>a:nth-of-type(4)").click(function () {
        //    $("#ifr").attr("src", "otherSubject.aspx");
        //})    

        //按热度
        $("#r").click(function () {
            var s = $("#ifr").attr("src");
            var ss = s + "?type=1";
            $("#ifr").attr("src", ss);
        })



        //获取城市名： ajax
        //$.ajax({
        //    url: 'http://api.map.baidu.com/location/ip?ak=ia6HfFL660Bvh43exmH9LrI6',
        //    type: 'POST',
        //    dataType: 'jsonp',
        //    success: function (data) {
        //        $('#provinceName').append(data.content.address_detail.province) //将省份名显示到页面
        //        $.ajax({
        //            url: "ashx/ApiGetProvinceId.ashx",
        //            data: { provinceName: data.content.address_detail.province }, //将此时的省份名作为参数
        //            type: "post",
        //            dataType: 'json',
        //            success: function (res) {
        //                console.log(res.provinceId);
        //            }
        //        })
        //    }
        //});
        //var xx = $(".lable").val();
        //console.log("46");
        //f1(xx);
   

    //function f1(data) {
    //    if (data == "-1"){
    //        //获取城市名： ajax
    //    $.ajax({
    //        url: 'http://api.map.baidu.com/location/ip?ak=ia6HfFL660Bvh43exmH9LrI6',
    //        type: 'POST',
    //        dataType: 'jsonp',
    //        success: function (data) {
    //            $('#provinceName').append(data.content.address_detail.province) //将省份名显示到页面
    //            $.ajax({
    //                url: "ashx/ApiGetProvinceId.ashx",
    //                data: { provinceName: data.content.address_detail.province }, //将此时的省份名作为参数
    //                type: "post",
    //                dataType: 'json',
    //                success: function (res) {
    //                    console.log(res.provinceId);
    //                }
    //            })
    //        }
    //    });
        })
   
</script>

</html>
