<%@ Page Language="C#" AutoEventWireup="true" CodeFile="findPwd2.aspx.cs" Inherits="findPwd2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="res/css/global.css" rel="stylesheet" />
    <link href="res/layui/css/layui.css" rel="stylesheet" media="all" />
    <style>
            .i{
            width: 85%;
            display: inline;
            margin-right: 5px;
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
                            <li class="layui-this">找回密码</li>
                        </ul>
                        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                            <div class="layui-tab-item layui-show">
                                <div class="layui-form layui-form-pane">
                                    <form method="post">
                                        <div class="layui-form-item">
                                            <label for="L_email" class="layui-form-label">昵称</label>
                                            <div class="layui-input-inline" style="width: 250px">
                                                <asp:TextBox ID="txtUserame" runat="server" ToolTip="昵称" cssClass="layui-input i" ></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtUserame" Display="Dynamic" ForeColor="Red" ID="rfvName" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label for="L_pass" class="layui-form-label">邮箱</label>
                                            <div class="layui-input-inline" style="width: 250px">
                                                <asp:TextBox ID="txtEmail" runat="server"  ToolTip="邮箱" cssClass="layui-input i"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ID="rfvPssword" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="邮箱格式不正确！" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>      
                                            </div>
                                        </div>
                                       
                                        <div class="layui-form-item">
                                            <asp:Button ID="btnFind" runat="server" Text="找回密码" lay-filter="*" lay-submit CssClass="layui-btn" OnClick="btnFind_Click"/>   
                                        </div>
                                        <div class="layui-form-item">
                                            <asp:Label ID="lblInfo" runat="server" ForeColor="#009688"></asp:Label>
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
