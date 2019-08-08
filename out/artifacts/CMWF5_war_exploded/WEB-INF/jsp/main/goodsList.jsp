<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/16
  Time: 13:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/css/main/main.css">
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
        h6 {
            font-weight: bold;
            height: 80px;
            margin-top: 20px;
        }

        .categoryDiv {
            text-align: center;
        }

        .categoryDivRight {
            text-align: left;
            height: 80px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container-fluid" id="top_bar_div">
    <div class="container">
        <nav class="navbar navbar-expand-sm bg-danger navbar-dark" id="top_bar">
            <ul class="navbar-nav">
                <c:if test="${empty user}" var="result">
                    <li class="nav-item active">
                        <a class="nav-link" href="/user/main"><i class="fa fa-home"
                                                                 aria-hidden="true"></i>&nbsp;天猫首页</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#">喵！欢迎来到天猫</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="/user/login">请登录</a>
                    </li>
                </c:if>
                <c:if test="${!result}">
                    <li class="nav-item active">
                        <a class="nav-link" href="/user/main"><i class="fa fa-home"
                                                                 aria-hidden="true"></i>&nbsp;天猫首页</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Hi！${user.name}</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#" id="chat">消息 </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="/user/logout">退出</a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav" id="top_bar_right">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle active" href="#" data-toggle="dropdown">
                        我的淘宝
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">已买到的宝贝</a>
                        <a class="dropdown-item" href="/shop/shop">已卖出的宝贝</a>
                    </div>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#" id="cart"><i class="fa fa-shopping-cart"></i>&nbsp;购物车</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">我的足迹</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle active" href="#" data-toggle="dropdown">
                        收藏夹
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">收藏的宝贝</a>
                        <a class="dropdown-item" href="#">收藏的店铺</a>
                    </div>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/chat/adminChatUser" target="_blank">联系客服</a>
                </li>
            </ul>
        </nav>
        <script>
            $(document).ready(function () {
                $.ajax({
                    url: "/chat/getUnreadChatCount",//要请求的服务器url
                    data: {id:${user.id}},//一个对象，表示请求参数，有两个参数 method val  method表示交给Servlet中的什么方法处理，不写默认为doGet或者doPost
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $("#chat").append(data.unreadChatCount)
                    }
                });
            });
        </script>
    </div>
</div>
<div class="container" id="headDiv">
    <form action="/type/selectGoodsByCondition">
        <img src="/image/main/headLeft.gif" id="head_left_img">
        <div class="input-group mb-3 custom-control-inline" id="search">
            <input type="text" class="form-control dropdown-toggle" id="search_input" placeholder="搜索 天猫 商品/品牌/店铺"
                   data-toggle="dropdown" name="condition">
            <div class="input-group-append">
                <button class="btn btn-danger" type="submit" id="search_btn" onclick="return searchCheck()">搜&nbsp;索
                </button>
            </div>
            <div class="input-group-prepend">
                <div class="dropdown-menu" id="search_prompt">
                    <a class="dropdown-item" href="#">你先登录一下呗</a>
                    <a class="dropdown-item" href="#">你登录以后搜索一下呗</a>
                </div>
            </div>
        </div>
        <img src="/image/main/headRight.jpg" id="head_right_img">
    </form>
    <script>
        function searchCheck() {
            return $("#search_input").val() != "";
        };
    </script>
</div>
<div class="container">
    <div class="row">
        <c:forEach items="${goodsList}" var="goods">
            <div style="padding: 3px; border: solid rgb(245,245,245) 1px">
                <img src="/shopImage/${goods.shop.name}/${goods.id}/${goods.image}" style="max-height: 210px; max-width: 100%; width: 210px; height: 210px" alt="">
                <p style="color: red; font-weight: bold">￥${goods.price}</p>
                <p>${goods.name}</p>
                <p>${goods.shop.name}</p>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
