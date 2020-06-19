<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectDemo.aspx.cs" Inherits="SelectDemo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
</head>
<body>
    <form class="layui-form" id="articleForm" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">博客类别</label>
            <div class="layui-input-block">
                <select name="typeId" id="cityIdVal" lay-filter="blogType" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <%--<option value="1" selected="">散文</option>
                    <option value="2">诗歌</option>
                    <option value="3">小说</option>
                    <option value="4">随笔</option>--%>
                </select>
            </div>
        </div>
    </form>

    <script src="Contents/layui.js"></script>
    <script>
        layui.use(['upload', 'form'], function () {
            var $ = layui.jquery,
                form = layui.form;
            var provinces = [];
            //$("#cityIdVal").empty();
            $.ajax({
                url: "/Comm/ApiGetProvince.ashx",
                type: "post",
                dataType: 'json',
                success: function (data) {
                    var selects = "";
                    provinces = data.data;
                    for (var x in provinces) {
                        var its = '<option value="' + provinces[x].ProvinceId + '">' + provinces[x].ProvinceName + '</option>';
                        selects += its;
                    }
                    //将选项动态添加到下拉框中
                    $("#cityIdVal").append(selects);
                    //自动选中第一个option
                    $("#cityIdVal").find("option[value='1']").attr("selected", true);
                    //重新渲染表单
                    form.render();

                }
            });
            //option选中事件
            form.on('select(blogType)', function (data) {
                layer.msg(data.value);
            });

            
        })
    </script>
</body>
</html>
