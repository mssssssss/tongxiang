<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="MyProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" />
    <style>
        body {
	    overflow-x: hidden; /*--right gutter fix--*/
        font-family: sans-serif;
        color: #505962
        }
        .navbar{
        text-transform: uppercase;
        background-color: #505962
        }
        .navbar-brand img{
        height:2rem;
        }

        .top_bottom_pic{
            width: 100%;
        }

        .caption{
            width: 100%;
            max-width: 100%;
            position: absolute;
            top: 40%;
            z-index: 1;
        }
        .caption h3{
            color: white;
            font-size: 3rem;
  
        }
        .btn{
            border-width: medium;
            border-radius: 0;
            padding: .5rem 1.1rem;
            font-size:.9rem;
        }
        h3.heading{
            text-align: center;
            font-size: 1.9rem;
            margin-bottom: 1.9rem;

        }
        .paddling{
            padding: 2rem 0;

        }
        img.portfolio{
            max-width: 100%;
        }
        .no-padding .col-md-6{
            padding: 0;
        }
        .card{
            margin: 2rem;
        }
        .footer .row{
            background-color: #505962;
        }
        .row{
            background-color: whitesmoke;
        }


        /*--- iOS Landing Page Fix --*/
        .landing {
            position: relative;
            width: 100%;
            height: 100vh;
            display: table;
            background: #E9ECEF;
            z-index: -1;
        }
        .home-wrap {
            clip: rect(0, auto, auto, 0);
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .home-inner {
            position: fixed;
            display: table;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center center;
            -webkit-transform: translateZ(0);
                    transform: translateZ(0);
            will-change: transform;
        }
        #info_change1{
            border-radius: 120px;width:240px;height:240px;
            position:absolute;
            background-color:azure;
            left:640px;
            top:0px;
            text-align:center;
            line-height:240px;
            opacity:0
        }
        .Emailinfo{
            line-height: 1.5;  
        }

    </style>
</head>
<body data-spy="scroll" data-target="#menu">
    <form id="form1" runat="server">
        <div>
            
<!--翻页风格-->
	<div class="landing">
		<div class="home-wrap">
			<div class="home-inner" style="background-image:url(images/background.jpg)">
			</div>
		</div>  
	</div>	
            
<!--翻页标题-->
	<div class="caption center-block text-center"><!--标题中心块和居中-->
        <div>
            <img src="images/新一.jpg" style="border-radius: 50px;width:100px;height:100px;"/>
            <div id="info_change1">
                <asp:Label ID="lblTel" runat="server" Text="lblTel"></asp:Label>
            </div>
            <div id="info_change2">
                <asp:Label ID="lblEmail" runat="server" Text="lblTel" CssClass="Emailinfo" ></asp:Label>
            </div>
        </div>
        
        <br/><br/>
		<asp:Label ID="lbl_welcomeuser" runat="server" Font-Size="Large"></asp:Label>
	</div>
<!--嵌套响应式引导主题，按钮自举式-->
</div><!--主页设置完成-->

<!--开始简介部分-->
<div id="about ">

</div><!--简介部分完成-->



<!--- Script Source Files -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
        </div>
    </form>
</body>
</html>
