<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changePwd.aspx.cs" Inherits="changePwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal" >
        <div style="width:  55%; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 20px; margin-top: 40px; font-size: 18px; font-weight:bold;">修改密码</div>
            <div class="form-group">
                <label class="col-sm-2 control-label">原密码:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtOldPwd" Display="Dynamic" ForeColor="Red" ID="rfvOldPwd" runat="server" ErrorMessage="必填"></asp:RequiredFieldValidator>      
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">新密码:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                     <asp:RequiredFieldValidator ControlToValidate="txtPwd" Display="Dynamic" ForeColor="Red" ID="rfvPwd" runat="server" ErrorMessage="必填"> </asp:RequiredFieldValidator>   
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label"> 确认新密码:</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtPwdAgain" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPwdAgain" Display="Dynamic" ForeColor="Red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="必填">
                        </asp:RequiredFieldValidator>
                    <asp:CompareValidator ControlToValidate="txtPwdAgain" ControlToCompare="txtPwd" Display="Dynamic" ForeColor="Red" ID="CompareValidator1" runat="server" ErrorMessage="2次新密码不一致"></asp:CompareValidator>
                </div>
            </div>
            <div style="text-align: right; margin-bottom: 8px;">
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" ></asp:Label>
            </div>
            <div style="float: right">
                <asp:Button ID="btnChangePwd" runat="server" Text="确认修改" OnClick="btnChangePwd_Click" class="btn btn-primary" />
            </div>
            
        </div>
    </form>
</body>
</html>
