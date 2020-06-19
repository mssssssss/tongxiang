<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminUpImg.aspx.cs" Inherits="AdminUpImg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Contents/css/layui.css" rel="stylesheet" />
    <style>
        .center {
            position: absolute;
            top: 40%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            -moz-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            -o-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
    <form class="layui-form" id="articleForm" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">省份</label>
            <div class="layui-input-block">
                <select name="typeId" id="typeIdVal" lay-filter="blogType" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <%--<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                <legend style="text-align: center">拖拽上传</legend>
            </fieldset>--%>
            <label class="layui-form-label">拖拽上传</label>
            <div class="layui-upload-drag center" id="uploadContainer">
                <i class="layui-icon"></i>
                <p>点击上传，或将文件拖拽到此处</p>
                <div class="layui-hide" id="uploadDemoView">
                    <hr>
                    <img src="" alt="上传成功后渲染" style="max-width: 196px">
                </div>
            </div>
        </div>
    </form>

    <script src="Contents/layui.js"></script>
    <script>
        layui.use(['upload', 'form'], function () {
            var $ = layui.jquery,
                form = layui.form,
                
                upload = layui.upload;
            //拖拽上传
            upload.render({
                elem: '#uploadContainer'
                , url: 'Comm/ApiAddCityPic.ashx' //上传接口
                , data: {
                    provinceId: function(){ return $("#typeIdVal").val() }
                }//附带额外省份id参数
                , done: function (res) {
                    layer.msg('上传成功');
                    layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.fileName);
                    console.log(res)
                }
            });
            var provinces = [];
            $.ajax({
                url: "/Comm/ApiGetProvince.ashx",
                type: "post",
                dataType:'json',
                success: function (data) {
                    var selects = "";
                    provinces = data.data;
                    for (var x in provinces) {
                        var  its='<option value="'+provinces[x].ProvinceId+'">'+provinces[x].ProvinceName+'</option>';
                        selects +=its;
                    }
                    //将选项动态添加到下拉框中
                    $("#typeIdVal").append(selects);
                    //自动选中第一个option
                    $("#typeIdVal").find("option[value='1']").attr("selected", true);
                    form.render();
                }
            });
        })
    </script>
</body>
</html>
