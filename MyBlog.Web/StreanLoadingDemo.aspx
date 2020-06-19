<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StreanLoadingDemo.aspx.cs" Inherits="StreanLoadingDemo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
    <style>
        img {
            width: auto;
            height: auto;
            max-width: 50%;
            max-height: 50%;
            align-items:center;
        }
    </style>
</head>

<body>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>信息流 - 滚动加载</legend>
    </fieldset>


    <ul class="flow-default" id="LAY_demo1"></ul>

    <script src="Contents/layui.js"></script>
    <script>
        layui.use('flow', function () {
            var flow = layui.flow;
            var $ = layui.jquery;
            flow.load({
                elem: '#LAY_demo1' //流加载容器
                , scrollElem: '#LAY_demo1' //滚动条所在元素，一般不用填，此处只是演示需要。
                , isAuto: true
                , done: function (page, next) { //执行下一页的回调
                    var list = [];
                    $.ajax({
                        type: "post",
                        dataType:"json",
                        async: true,
                        url: "/Comm/ApiStreamLoad.ashx",
                        data: { myPage: page },
                        success: function (res) {
                            layui.each(res.data, function (index, item) {
                                list.push('<li><img "  src=' + item.PhotoUrl + '><li><br/>')
                            });
                            next(list.join(''), page < res.pages);
                        }
                    })
                }
            });


        });
    </script>
</body>
</html>
