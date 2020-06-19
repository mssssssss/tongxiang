<%@ Page Language="C#" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="layui-container fly-marginTop">
                <div class="fly-panel fly-panel-user" pad20>
                    <div class="layui-tab layui-tab-brief" lay-filter="user">
                        <ul class="layui-tab-title">
                            <li class="layui-this">项目介绍</li>
                        </ul>
                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                            <div class="layui-tab-item layui-show">
                                <div class="layui-form layui-form-pane">
                                    <div >通享社区:</div>
                                    我们秉承着“通力合作，资源共享”的开发理念，旨在打造一个同城大学生知识交流平台。<br />
                                    在这里，你们可以与相似专业的同学交流专业知识，
                                    根据学生对知识掌握需求的不同程度，我们分了基础知识，进阶知识，高级知识三个模块，
                                    力求给每个基础的学生最好的学习交流体验。<br />
                                    努力钻研,不断丰富积累专业知识的同时，我们还提供给兴趣广泛，知识面广的你们一个体验不同学科知识魅力的机会和平台。
                                    你们可以在其他学科知识板块下畅所欲言，对感兴趣的帖子提出见解。
                                </div>
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
</html>
