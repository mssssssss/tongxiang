<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostArticle.aspx.cs" Inherits="PostArticle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布帖子</title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
</head>
<body>
    <%-- 是否是编辑帖子 --%>
    <input id="isEdit" type="text" value="-1" style="visibility:hidden"/>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend style="text-align: center">帖子发布</legend>
    </fieldset>

    <form class="layui-form" id="articleForm" action="">

        <div class="layui-form-item">
            <label class="layui-form-label">帖子标题</label>
            <div class="layui-input-block">
                <input id="topicTitleVal" type="text" name="topicTitle" lay-verify="required" lay-reqtext="帖子标题不能为空噢" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">专业类别</label>
            <div class="layui-input-block">
                <select name="majorId" id="majorIdVal" lay-filter="majorType" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">难度分级</label>
            <div class="layui-input-block">
                <select name="levelId" id="levelIdVal" lay-filter="levelType" lay-search="">
                    <option value="" >直接选择或搜索选择</option>
                    <option value="1" selected="selected" >基础知识</option>
                    <option value="2">进阶知识</option>
                    <option value="3">高级知识</option>
                </select>
            </div>
        </div>
      
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">编辑帖子</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
            </div>
        </div>
        <%--<div class="layui-form-item">
            <div class="layui-input-block">
                <div class="site-demo-button" style="margin-top: 20px;">
                    <button class="layui-btn site-demo-layedit" data-type="content">获取编辑器内容</button>
                    <button class="layui-btn site-demo-layedit" data-type="text">获取编辑器纯文本内容</button>
                    <button class="layui-btn site-demo-layedit" data-type="selection">获取编辑器选中内容</button>
                </div>
            </div>
        </div>--%>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">发布帖子</button>
                <button id="resetBtn" type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>


    <script src="Contents/layui.js"></script>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function () {
            var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , $ = layui.jquery
                //设置图片上传接口
            layedit.set({
                uploadImage: {
                    url: "Comm/ApiAddTopicPhoto.ashx",
                    type:"post"
                }
            })
            //创建一个编辑器
            var editIndex = layedit.build('LAY_demo_editor');
            form.verify({
                content: function (value) {
                    //同步编辑器
                    layedit.sync(editIndex);
                }
            });
            ////编辑器外部操作
            //var active = {
            //    content: function () {
            //        alert(editIndex.getContent(editIndex)); //获取编辑器内容
            //    }
            //    , text: function () {
            //        alert(editIndex.getText(editIndex)); //获取编辑器纯文本内容
            //    }
            //    , selection: function () {
            //        alert(editIndex.getSelection(editIndex));
            //    }
            //};

            //$('.site-demo-layedit').on('click', function () {
            //    var type = $(this).data('type');
            //    active[type] ? active[type].call(this) : '';
            //});
            $('#resetBtn').on('click', function () {
                $(window.frames["LAY_layedit_1"].document).find('body').html('');
            })
            //监听提交
            form.on('submit(demo1)', function (data) {
                $.ajax({
                    url: "/Comm/ApiAddBlog.ashx",
                    type: "post",
                    async: true,
                    //data: data.field,
                    data: {
                        topicId: $("#isEdit").val(),
                        majorId: $("#majorIdVal").val(),
                        diffLevel:$("#levelIdVal").val(),
                        topicTitle: $("#topicTitleVal").val(),
                        topicContent: layedit.getContent(editIndex)
                    },
                    success: function (res) {
                        console.log(res);
                        layer.alert(res.msg, {
                            titl: "提示信息"
                        })
                        $("#articleForm")[0].reset();//清空表单数据
                        $(window.frames["LAY_layedit_1"].document).find('body').html('');//清空富文本编辑器
                    }
                })
                return false;
            });
            //动态添加专业
            var majors = [];
            $.ajax({
                url: "/Comm/ApiGetAllMajor.ashx",
                type: "post",
                dataType:'json',
                success: function (data) {
                    var selects = "";
                    majors = data.data;
                    for (var x in majors) {
                        var  its='<option value="'+majors[x].MajorId+'">'+majors[x].MajorName+'</option>';
                        selects +=its;
                    }
                    //将选项动态添加到下拉框中
                    $("#majorIdVal").append(selects);
                    //自动选中第一个option
                    $("#majorIdVal").find("option[value='1']").attr("selected", true);
                    form.render();
                }
            });
        });
    </script>
</body>
</html>
