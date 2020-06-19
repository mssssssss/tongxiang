<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login2.aspx.cs" Inherits="login2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <style>
        .i {
            width: 85%;
            display: inline;
            margin-right: 5px;
        }

        .checkCode {
            position: absolute;
            top: 7px;
            right: 45px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="layui-container fly-marginTop">
                <div class="fly-panel fly-panel-user" pad20>
                    <div class="layui-tab layui-tab-brief" lay-filter="user">
                        <ul class="layui-tab-title">
                            <li class="layui-this"><a href="login2.aspx">登陆</a></li>
                            <li><a href="register2.aspx">注册</a></li>
                        </ul>
                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                            <div class="layui-tab-item layui-show">
                                <div class="layui-form layui-form-pane">
                                    <form method="post">
                                        <div class="layui-form-item">
                                            <label for="L_email" class="layui-form-label">昵称</label>
                                            <div class="layui-input-inline" style="width: 250px">
                                                <asp:TextBox ID="txtUserame" runat="server" ToolTip="昵称" CssClass="layui-input i"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtUserame" Display="Dynamic" ForeColor="Red" ID="rfvName" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label for="L_pass" class="layui-form-label">密码</label>
                                            <div class="layui-input-inline" style="width: 250px">
                                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ToolTip="密码" CssClass="layui-input i" Width="85%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" ID="rfvPssword" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label for="L_vercode" class="layui-form-label">验证码</label>
                                            <div class="layui-input-inline" style="width: 250px; position: relative;">
                                                <asp:TextBox ID="txtCheckcode" runat="server" ToolTip="验证码" CssClass="layui-input i" Width="85%"></asp:TextBox>
                                                <asp:Image ID="imgChkcode2" runat="server" ImageUrl="checkcode.aspx" onclick="this.src=this.src+'?'" ImageAlign="Middle" ToolTip="换一张" CssClass="checkCode" />
                                                <asp:RequiredFieldValidator ControlToValidate="txtCheckcode" Display="Dynamic" ForeColor="Red" ID="rfvCheckcode" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <div class="layui-inline">
                                                <asp:Button ID="btnLogin" runat="server" Text="立即登录" lay-filter="*" lay-submit CssClass="layui-btn" OnClick="btnLogin_Click" />
                                            </div>
                                            <div class="layui-inline">
                                                <a href="findPwd2.aspx" class="layui-btn">忘记密码</a>
                                            </div>
                                        </div>

                                        <div class="layui-form-item">
                                            <asp:Label ID="lblErr" runat="server" ForeColor="#009688"></asp:Label>
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
</html>
