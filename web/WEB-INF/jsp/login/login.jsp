<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/26
  Time: 4:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/login/login.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="/js/login/login.js"></script>
</head>
<body>
<div class="container logo-search">
    <img src="/image/login/logo.png" id="logo">
</div>
<div class="container-fluid" id="middle">
    <div id="login">
        <form action="/user/doLogin" id="loginForm" method="post">
            <h5 id="title1">密码登录<span id="prompt1">${param.error}</span></h5>
            <div class="input-group mb-3 input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-user-o"></i></span>
                </div>
                <input type="text" class="form-control" placeholder="请输入用户名" id="loginName" name="name">
            </div>
            <div class="input-group mb-3 input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                </div>
                <input type="password" class="form-control" placeholder="请输入密码" id="loginPassword" name="password">
            </div>
            <div id="drag"></div>
            <script type="text/javascript">
                $('#drag').drag();

                $("#loginName").click(function () {
                    $("#prompt1").html("");
                });

                $("#loginPassword").click(function () {
                    $("#prompt1").html("");
                });

                function loginCheck() {
                    if ("" === $("#loginName").val()) {
                        $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入用户名');
                        return false;
                    }
                    if ("" === $("#loginPassword").val()) {
                        $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入密码');
                        return false;
                    }
                    if ($("#drag_text").text() === '拖动滑块验证') {
                        $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请进行滑动验证');
                        return false;
                    }
                    else {
                        return true;
                    }
                }
            </script>
            <button type="submit" id="login_submit" class="btn btn-danger btn-primary btn-block"
                    onclick="return loginCheck()">登录
            </button>
            <div id="toRegister" onmousemove="this.style.color='royalblue'" onmouseleave="this.style.color='grey'">
                <span>免费注册</span>&nbsp;<i class="fa fa-mail-forward"></i></div>
        </form>

        <form action="/user/doInsert" id="registerForm" style="display: none" method="post">
            <h5 id="title2">注册<span id="prompt2"></span></h5>
            <div class="input-group mb-3 input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-user-o"></i></span>
                </div>
                <input type="text" class="form-control" placeholder="请输入用户名" id="registerName" name="name">
            </div>
            <div class="input-group mb-3 input-group-lg" data-toggle="tooltip"
                 title="密码为6-18位，不包含特殊字符和汉字，必须含有字母/数字/下划线">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                </div>
                <input type="password" class="form-control" placeholder="请输入密码" id="registerPassword1" name="password">
            </div>
            <div class="input-group mb-3 input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                </div>
                <input type="password" class="form-control" placeholder="请确认密码" id="registerPassword2">
            </div>
            <button type="submit" id="register_submit" class="btn btn-danger btn-primary btn-block"
                    onclick="return registerCheck()">注册
            </button>
            <div id="toLogin" onmousemove="this.style.color='royalblue'" onmouseleave="this.style.color='grey'">
                <i class="fa fa-reply"></i>&nbsp;<span>登录界面</span></div>
        </form>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });

    $(document).ready(function () {
        $("#toRegister").click(function () {
            $("#loginForm").hide();
            $("#registerForm").show(1000);
        });
    });

    $(document).ready(function () {
        $("#toLogin").click(function () {
            $("#registerForm").hide();
            $("#loginForm").show(1000);
        });
    });

    $("#registerName").blur(function () {//失去焦点时执行
        var value = $("#registerName").val();
        $.ajax({
            url: "/user/selectUserName",//要请求的服务器url
            data: {name: value},//一个对象，表示请求参数，有两个参数 method val  method表示交给Servlet中的什么方法处理，不写默认为doGet或者doPost
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                var str = data.result;
                if ("true" === str) {
                    $('#prompt2').html('<i class="fa fa-minus-circle"></i>&nbsp;用户名已存在');
                } else {
                    $('#prompt2').html('<i class="fa fa-check-circle" style="color: greenyellow"></i>&nbsp;<span style="color: greenyellow">可以使用</span>');
                }
            }
        });
    });

    function registerCheck() {
        var partern = /^(\w){6,18}$/;
        if ("" === $("#registerName").val()) {
            $("#prompt2").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入用户名');
            return false;
        }
        if ("" === $("#registerPassword1").val()) {
            $("#prompt2").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入密码');
            return false;
        }
        if ($("#registerPassword1").val() !== $("#registerPassword2").val()) {
            $("#prompt2").html('<i class="fa fa-minus-circle"></i>&nbsp;请再次确认密码');
            return false;
        }
        if (!partern.test($("#registerPassword1").val())) {
            $("#prompt2").html('<i class="fa fa-minus-circle"></i>&nbsp;请确认密码格式');
            return false;
        }
        else {
            return true;
        }
    }
</script>
<hr>
<div class="container bottom" id="bottom">
    <img src="/image/login/bottom.png">
</div>
<hr>
<div class="container">
    <div class="row">
        <div class="col link_one">
            <h5>购物指南</h5>
            <div class="list-group">
                <a href="#" class="list-group-item">免费注册</a>
                <a href="#" class="list-group-item">开通支付宝</a>
                <a href="#" class="list-group-item">支付宝充值</a>
            </div>
        </div>
        <div class="col link_one">
            <h5>天猫保障</h5>
            <div class="list-group">
                <a href="#" class="list-group-item">发票保障</a>
                <a href="#" class="list-group-item">售后规则</a>
                <a href="#" class="list-group-item">缺货赔付</a>
            </div>
        </div>
        <div class="col link_one">
            <h5>支付方式</h5>
            <div class="list-group">
                <a href="#" class="list-group-item">快捷支付</a>
                <a href="#" class="list-group-item">信用卡</a>
                <a href="#" class="list-group-item">蚂蚁花呗</a>
                <a href="#" class="list-group-item">货到付款</a>
            </div>
        </div>
        <div class="col link_one">
            <h5>商家服务</h5>
            <div class="list-group">
                <a href="#" class="list-group-item">商家入驻</a>
                <a href="#" class="list-group-item">商家中心</a>
                <a href="#" class="list-group-item">天猫智库</a>
                <a href="#" class="list-group-item">天猫规则</a>
                <a href="#" class="list-group-item">物流服务</a>
                <a href="#" class="list-group-item">喵言喵语</a>
                <a href="#" class="list-group-item">运营服务</a>
            </div>
        </div>
        <div class="col link_one">
            <h5>手机天猫</h5>
            <img src="/image/login/qrcode.png" alt="" id="qrcode">
        </div>
    </div>
    <img src="/image/login/cateye.png" alt="">
</div>
<hr style="background-color: red;height: 2px">
<div class="container-fluid" id="about">
    <div class="container">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="#" style="padding-left: 0">关于天猫</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">帮助中心</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">开放平台</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">成聘英才</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">联系我们</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">网站合作</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">法律声明</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">知识产权</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">廉政举报</a>
            </li>
        </ul>
        <a href="#" class="link_two">阿里巴巴集团</a><span class="shu">|</span>
        <a href="#" class="link_two">淘宝网</a><span class="shu">|</span>
        <a href="#" class="link_two">天猫</a><span class="shu">|</span>
        <a href="#" class="link_two">聚划算</a><span class="shu">|</span>
        <a href="#" class="link_two">全球速卖通</a><span class="shu">|</span>
        <a href="#" class="link_two">阿里巴巴国际交易市场</a><span class="shu">|</span>
        <a href="#" class="link_two">1688</a><span class="shu">|</span>
        <a href="#" class="link_two">阿里妈妈</a><span class="shu">|</span>
        <a href="#" class="link_two">阿里旅游·去哪</a><span class="shu">|</span>
        <a href="#" class="link_two">阿里云计算</a><span class="shu">|</span>
        <a href="#" class="link_two">阿里通信</a><span class="shu">|</span>
        <a href="#" class="link_two">YunOS</a><span class="shu">|</span>
        <a href="#" class="link_two">万网</a><span class="shu">|</span>
        <a href="#" class="link_two">高德</a><span class="shu">|</span>
        <a href="#" class="link_two">优视</a><span class="shu">|</span>
        <a href="#" class="link_two">友盟</a><span class="shu">|</span>
        <a href="#" class="link_two">虾米</a><span class="shu">|</span>
        <a href="#" class="link_two">天天动听</a><span class="shu">|</span>
        <a href="#" class="link_two">来往</a><span class="shu">|</span>
        <a href="#" class="link_two">钉钉</a><span class="shu">|</span>
        <a href="#" class="link_two">支付宝</a>
        <div id="copy1">增值电信业务经营许可证： 浙B2-20110446 网络文化经营许可证：浙网文[2015]0295-065号 互联网医疗保健信息服务 审核同意书 浙卫网审【2014】6号
            互联网药品信息服务资质证书编号：浙-（经营性）-2012-0005
        </div>
        <div id="copy2">© 2003-2016 TMALL.COM 版权所有</div>
        <img src="/image/login/copyRight1.jpg" alt="">
        <img src="/image/login/copyRight2.jpg" alt="">
    </div>
</div>
</body>
</html>
