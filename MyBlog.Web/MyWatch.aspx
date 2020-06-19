<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyWatch.aspx.cs" Inherits="MyWatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
</head>
<body>
    
    <%--  --%>
    <table class="layui-hide" id="watchTable" lay-filter="test"></table>

    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
            <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
            <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-icon layui-icon-chat layui-btn layui-btn-normal layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-icon layui-icon-delete layui-btn layui-btn-danger layui-btn-xs" lay-event="del">取消关注</a>
    </script>
    <script src="Contents/layui.js"></script>

    <script>
        layui.use(['table', 'jquery'], function () {
            var table = layui.table;
            var $ = layui.jquery;
            table.render({
                elem: '#watchTable'
                , height: 444//高度
                , id: 'watchTable'//表格id，搜索功能重载表格需要使用
                , url: '/Comm/ApiGetWatch.ashx'//接口
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板,指向自定义工具栏模板选择器
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [[
                    { type: 'checkbox', fixed: 'left' }
                    , { field: 'UserId', title: '关注者Id', width: 120, fixed: 'left', unresize: true, sort: true }
                    , { field: 'UserName', title: '关注者', width: 120}
                    , { field: 'Sex', title: '性别', width: 120, sort: true }
                    , {
                        field: 'School', title: '学校', width: 200, templet: function (res) {
                            return '<em>' + res.School + '</em>'
                        }
                    }
                    , { field: 'Education', title: '教育', width: 200}
                    , { field: 'MajorName', title: '专业', width: 200}
                    , { fixed: 'right', title: '操作', toolbar: '#barDemo', width: 180 }
                ]]
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                    //,curr: 5 //设定初始在第 5 页
                    , groups: 2 //只显示 2个连续页码
                    , first: "首页" //显示首页
                    , last: "尾页" //显示尾页
                }
                , limits: [3, 6, 9]//每页条数的选择项
                , limit: 3//每页显示的条数，值务必对应 limits 参数的选项

            });

            //头工具栏事件
            table.on('toolbar(test)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);
                switch (obj.event) {
                    case 'getCheckData':
                        var data = checkStatus.data;
                        layer.alert(JSON.stringify(data));
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：' + data.length + ' 个');
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选' : '未全选');
                        break;

                    //自定义头工具栏右侧图标 - 提示
                    case 'LAYTABLE_TIPS':
                        layer.alert('此表格是我的关注');
                        break;
                };
            });

            //监听行工具事件
            table.on('tool(test)', function (obj) {
                var data = obj.data;
                if (obj.event == 'detail') {
                    //var messageContent = data.MessageContent;
                    layer.open({
                        title: "用户" + data.UserName + '的信息:'
                        , content: "用户名:" + data.UserName + "<br/>" +
                            "学校:" + data.School + "<br/>" +
                            "教育程度:" + data.Education + "<br/>" +
                            "专业:" + data.MajorName
                    });
                } else if (obj.event === 'del') {
                    layer.confirm('真的取消关注?', function (index) {
                        $.ajax({
                            type: "post",
                            async: true,
                            url: "/Comm/ApiDeleteWatch.ashx",
                            data: { watchingId: data.UserId }
                            ,
                            success: function (res) {
                                console.log(res);
                                obj.del();
                                //关闭弹出层
                                layer.close(index);
                            }
                        })

                    });
                }
            });
        });
    </script>
</body>
</html>
