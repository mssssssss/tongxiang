<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadImg.aspx.cs" Inherits="UploadImg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>图片上传</title>
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

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend style="text-align: center">拖拽上传</legend>
    </fieldset>

    <div class="layui-upload-drag center" id="uploadContainer">
        <i class="layui-icon"></i>
        <p>点击上传，或将文件拖拽到此处</p>
        <div class="layui-hide" id="uploadDemoView">
            <hr>
            <img src="" alt="上传成功后渲染" style="max-width: 196px">
        </div>
    </div>
    <script src="Contents/layui.js"></script>
    <script>
        layui.use('upload', function () {
            var $ = layui.jquery,
                upload = layui.upload;
            //拖拽上传
            upload.render({
                elem: '#uploadContainer'
                , url: 'Comm/ApiAddPhoto.ashx' //上传接口
                , done: function (res) {
                    layer.msg('上传成功');
                    layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.fileName);
                    console.log(res)
                }
            });
        })
    </script>
</body>
</html>
