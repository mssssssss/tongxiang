<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register2.aspx.cs" Inherits="register2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                            <li><a href="login2.aspx">登陆</a></li>
                            <li class="layui-this"><a href="register2.aspx">注册</a></li>
                        </ul>
                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                            <div class="layui-tab-item layui-show">
                                <div class="layui-form layui-form-pane">
                                   

                                    <form class="layui-form" id="articleForm" action="">

                                        <div class="layui-form-item">
                                            <label class="layui-form-label">用户名</label>
                                            <div class="layui-input-block">
                                                <input id="userNameVal" type="text" name="userName" lay-verify="required" lay-reqtext="用户名不能为空噢" placeholder="请输入用户名" autocomplete="off" class="layui-input" />
                                            </div>
                                        </div>

                                        <%--<div class="layui-form-item">
                                            <label class="layui-form-label">自定义验证</label>
                                            <div class="layui-input-inline">
                                                <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                            </div>
                                            <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
                                        </div>--%>

                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <%--<label class="layui-form-label">密码</label>
                                                <div class="layui-input-inline">
                                                    <input id="passWordVal" type="text" name="passWord" lay-verify="required" lay-reqtext="密码不能为空噢" placeholder="请输入密码" autocomplete="off" class="layui-input" />
                                                </div>--%>
                                                <label class="layui-form-label">密码</label>
                                                <div class="layui-input-inline">
                                                    <input type="password" name="password" id="passWordVal" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                                </div>
                                                <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
                                            </div>

                                            <div class="layui-inline">
                                                <label class="layui-form-label">邮箱</label>
                                                <div class="layui-input-inline">
                                                    <input id="emailVal" type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="layui-form-item">
                                            <label class="layui-form-label">学历</label>
                                            <div class="layui-input-block">
                                                <select name="education" id="educationVal" lay-filter="education" lay-search="">
                                                    <option value="">直接选择或搜索选择</option>
                                                    <option value="本科" selected="selected">本科</option>
                                                    <option value="硕士">硕士</option>
                                                    <option value="博士">博士</option>
                                                    <option value="保密">保密</option>
                                                </select>
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
                                            <label class="layui-form-label">学校</label>
                                            <div class="layui-input-inline">
                                                <select name="quiz1" id="selProvince" lay-filter="provinceChange" lay-verify="required">
                                                    <option value="">请选择省</option>
                                                </select>
                                            </div>
                                            <div class="layui-input-inline">
                                                <select name="quiz2" id="selSchool" lay-verify="required">
                                                    <option value="">请选择学校</option>

                                                </select>
                                            </div>
                                        </div>

                                        <div class="layui-form-item">
                                            <label class="layui-form-label">性别</label>
                                            <div class="layui-input-block" id="choseSex">
                                                <input type="radio" name="sex" value="男" title="男" checked="">
                                                <input type="radio" name="sex" value="女" title="女">
                                            </div>
                                        </div>

                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <label class="layui-form-label">头像</label>
                                                <div class="layui-input-inline">
                                                    <div class="layui-upload-drag center" id="uploadHeadPicContainer">
                                                        <i class="layui-icon"></i>
                                                        <p>点击上传头像，或将头像拖拽到此处</p>
                                                        <div class="layui-hide" id="uploadHeadPic">
                                                            <hr>
                                                            <img src="" alt="上传成功后渲染" style="max-width: 196px">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="layui-inline">
                                                <label class="layui-form-label">学生证</label>
                                                <div class="layui-input-inline">
                                                    <div class="layui-upload-drag center" id="uploadStuCardContainer">
                                                        <i class="layui-icon"></i>
                                                        <p>点击上传学生证，或将学生证拖拽到此处</p>
                                                        <div class="layui-hide" id="uploadStuCard">
                                                            <hr>
                                                            <img src="" alt="上传成功后渲染" style="max-width: 196px">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-input-block">
                                                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">注册</button>
                                                <button id="resetBtn" type="reset" class="layui-btn layui-btn-primary">重置</button>
                                            </div>
                                        </div>
                                    </form>


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
<script>
    layui.use(['form', 'layedit', 'laydate', 'upload'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , upload = layui.upload
            //上传成功后的头像和学生证图片url
        var headPicUrl = "";
        var stuCardUrl = "";
        //拖拽上传
        upload.render({
            elem: '#uploadHeadPicContainer'
            , url: 'Comm/ApiAddHeadPic.ashx' //上传接口
            , done: function (res) {
                layer.msg('上传头像成功');
                layui.$('#uploadHeadPic').removeClass('layui-hide').find('img').attr('src', res.fileName);
                headPicUrl = res.headPicUrl;
                console.log(res.headPicUrl)
            }
        });

        //拖拽上传
        upload.render({
            elem: '#uploadStuCardContainer'
            , url: 'Comm/ApiAddStuCard.ashx' //上传接口
            , done: function (res) {
                layer.msg('上传头像成功');
                layui.$('#uploadStuCard').removeClass('layui-hide').find('img').attr('src', res.fileName);
                stuCardUrl = res.stuCardUrl;
                console.log(res)
            }
        });

        //清空表单元素
        $('#resetBtn').on('click', function () {
            $(window.frames["LAY_layedit_1"].document).find('body').html('');
        })
        //监听提交
        form.on('submit(demo1)', function (data) {
            $.ajax({
                url: "/Comm/ApiAddUser.ashx",
                type: "post",
                async: true,
                data: {
                    UserName: $("#userNameVal").val(),
                    PassWord: $("#passWordVal").val(),
                    Email: $("#emailVal").val(),
                    Sex: $('#choseSex input[name="sex"]:checked').val(),
                    School: $("#selSchool").val(),
                    Education:$("#educationVal").val(),
                    MajorId: $("#majorIdVal").val(),
                    HeadPic: headPicUrl,
                    StuCard: stuCardUrl,
                    ProvinceId: $("#selProvince").val(),
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

        //监听省份下拉框改变
        var provinceSchool = [];//当前省份的学校
        form.on('select(provinceChange)', function (data) {
            var proviceName = data.elem[data.elem.selectedIndex].text
            $.ajax({
                url: "https://api.hcfpz.cn/un/schools?province=" + proviceName,
                type: "get",
                dataType: 'json',
                async: true,
                success: function (data) {
                    var selects = "";
                    provinceSchool = data.data;
                    //先清空数据
                    $("#selSchool").empty();
                    $.each(provinceSchool, function (index, value) {
                        var its = '<option value="' + value.name + '">' + value.name + '</option>';
                        selects += its;
                    })
                    $("#selSchool").append(selects);
                    //自动选中第一个option
                    $("#selSchool").find("option[value='1']").attr("selected", true);
                    form.render();
                    //console.log(selects)
                    //console.log(provinceSchool)
                }
            })
        })
        //动态添加专业
        var majors = [];
        $.ajax({
            url: "/Comm/ApiGetAllMajor.ashx",
            type: "post",
            dataType: 'json',
            success: function (data) {
                var selects = "";
                majors = data.data;
                for (var x in majors) {
                    var its = '<option value="' + majors[x].MajorId + '">' + majors[x].MajorName + '</option>';
                    selects += its;
                }
                //将选项动态添加到下拉框中
                $("#majorIdVal").append(selects);
                //自动选中第一个option
                $("#majorIdVal").find("option[value='1']").attr("selected", true);
                form.render();
            }
        });

        //动态从数据库获取省份
        var provinces = [];
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
                $("#selProvince").append(selects);
                //自动选中第一个option
                //$("#selProvince").find("option[value='1']").attr("selected", true);
                form.render();
            }
        });

    });

</script>
</html>
