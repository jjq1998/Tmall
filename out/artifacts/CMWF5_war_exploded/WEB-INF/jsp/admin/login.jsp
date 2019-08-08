<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/30
  Time: 4:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台登录界面</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/admin/login.css">
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<body style="background-color: rgb(245,245,245)">
<div class="container" id="loginDiv">
    <form action="/admin/doLogin" id="registerForm" method="post">
        <h5 id="title">后台登录<span id="prompt">${param.error}</span></h5>
        <div class="input-group mb-3 input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-user-o"></i></span>
            </div>
            <input type="text" class="form-control" placeholder="请输入用户名" id="name" name="name">
        </div>
        <div class="input-group mb-3 input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="fa fa-lock"></i></span>
            </div>
            <input type="password" class="form-control" placeholder="请输入密码" id="password" name="password">
        </div>
        <button type="submit" id="register_submit" class="btn btn-danger btn-primary btn-block"
                onclick="return check()">登录
        </button>
        <script>
            function check() {
                if ("" == $("#name").val()) {
                    $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入用户名');
                    return false;
                }
                if ("" == $("#password").val()) {
                    $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入密码');
                    return false;
                }
            }
        </script>
    </form>
</div>
</body>
</html>
