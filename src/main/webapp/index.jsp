<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>管理员登录</title>
    <script src="static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <script src="static/js/bootstrap.min.js"></script>
    <style type="text/css">
        body{
            background-image: url("${APP_PATH}/static/image/back.jpg");
        }
        #kuang{
            width: 300px;
        }
        #submit{
            margin-top: 20px;
        }
        #tishi{
            margin-top: 10px;
            text-align: center;
            color:red;

        }
    </style>
    <script type="text/javascript">
       $(document).ready(
           function () {
               $("#tishi").hide();
           $("#submit").click(function(){
                var admin = $("#inputadmin").val();
                var password=$("#inputPassword").val();
               $.post("account/adminLoad",{"admin":admin,"password":password},function (result) {
                   if (result=="sucess"){
                           $("#tishi").hide();
                           $(location).attr('href', 'account/findAll');
                       }else{
                           $("#tishi").show();
                       }
               });
            });
           });
    </script>
</head>
<body>
<div class="page-header" align="center">
    <h1>员工信息管理系统 <small>Employee information management system</small></h1>
</div>
<div class="container" id="kuang">

    <form class="form-signin">
        <h2 class="form-signin-heading">管理员登录</h2>
        <input type="text" id="inputadmin" class="form-control" placeholder="账户" required autofocus>
        <input type="password" id="inputPassword" class="form-control" placeholder="密码" required>
        <button class="btn btn-lg btn-primary btn-block" type="button" id="submit">登录</button>
    </form>
</div>
<p id="tishi">账户或密码错误!</p>
</body>
</html>