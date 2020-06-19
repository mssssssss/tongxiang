<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CheckedUser.aspx.cs" Inherits="CheckedUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
     <style>
        img {
            width: 100%;
            object-fit: cover;
            
        }
    </style>
</head>
<body>
        <div class="demoTable">
        模糊搜索已验证用户：
        <div class="layui-inline">
            <input class="layui-input" name="id" id="demoReload" autocomplete="off">
        </div>
        <button class="layui-icon layui-icon-search layui-btn" data-type="reload">搜索</button>
    </div>
    <%--  --%>
    <table class="layui-hide" id="userTable" lay-filter="test"></table>

    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
            <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
            <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-icon layui-icon-chat layui-btn layui-btn-normal layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-icon layui-icon-survey layui-btn layui-btn-danger layui-btn-xs" lay-event="check">注销</a>
    </script>
    <script src="Contents/layui.js"></script>

    <script>
        layui.use(['table', 'jquery'], function () {
            var table = layui.table;
            var $ = layui.jquery;
            table.render({
                elem: '#userTable'
                , height: 444//高度
                , id: 'userTable'//表格id，搜索功能重载表格需要使用
                , url: '/Comm/ApiGetUser.ashx'
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板,指向自定义工具栏模板选择器
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , where: {userType:"CheckedUser"}
                , title: '用户数据表'
                , cols: [[
                    { type: 'checkbox', fixed: 'left' }
                    , { field: 'UserId', title: '用户ID', width: 100, fixed: 'left', unresize: true, sort: true }
                    , { field: 'UserName', title: '用户名', width: 120 }
                   
                    , { field: 'Sex', title: '性别', width: 70 }
                    , { field: 'School', title: '学校', width: 120 }
                    , { field: 'Education', title: '教育程度', width: 100 }
                    , { field: 'MajorName', title: '专业', width: 120 }
                    , { field: 'ProvinceName', title: '省份', width: 90 }
                    , { field: 'JoinTime', title: '注册时间', width: 120, sort: true }
                    , {
                        field: 'StuCard', title: '学生证', width: 80, templet: function (res) {
                            return '<img src=' + res.StuCard + '>';
                        }
                    }
                     , {
                        field: 'Email', title: '邮箱', width: 150, templet: function (res) {
                            return '<em>' + res.Email + '</em>'
                        }
                    }
                    , { fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150 }
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
                        layer.alert('此表格是用于审核用户');
                        break;
                };
            });

            //监听行工具事件
            table.on('tool(test)', function (obj) {
                var data = obj.data;
                if (obj.event == 'detail') {
                    var url = data.StuCard;
                    layer.photos({ photos: { "data": [{ "src": url }] }, anim: 1, area: 'auto' });
                } else if (obj.event == 'check') {
                    layer.confirm('确认注销用户' + data.UserName + '的学生认证?', function (index) {
                        $.ajax({
                            type: "post",
                            async: true,
                            url: "Comm/ApiUpdateUser.ashx",
                            data: { userId: data.UserId, checkStatus: "0" },
                            success: function (res) {
                                
                                obj.del();
                                layer.close(index);
                                layer.msg("注销成功");
                            }
                        })
                    })
                }
            });

            //模糊搜索
            var $ = layui.$, active = {
                reload: function () {
                    var demoReload = $('#demoReload');
                    //执行重载 table.reload(id, options); //表格重载
                    table.reload('userTable', {
                        url: '/Comm/ApiFuzzyUser.ashx'//模糊查询接口，默认是table.render中的url
                        //可以利用附带参数来区别是模糊搜索还是显示全部数据
                        ,
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {//设定异步数据接口的额外参数，任意设
                            searchInfo: demoReload.val(),
                            userType:"CheckedUser"
                        }
                    }, 'data');
                }
            };
            $('.demoTable .layui-btn').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        });
    </script>
</body>
</html>
