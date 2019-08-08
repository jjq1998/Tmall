<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商店界面</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/shop/shop.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
        #shop_details_div {
            margin-top: 10px;
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

<div class="container">
    <div class="row" id="middle">
        <div class="col-sm-2">
            <ul class="nav flex-column" id="left_bar">
                <li class="nav-item">
                    <a class="nav-link disabled" href="#"><i class="fa fa-cogs"></i>店铺管理</a>
                    <c:if test="${user.type == '买家'}" var="result1">
                        <a class="nav-link" href="/ask/openShop">我要开店</a>
                    </c:if>
                    <c:if test="${!result1}">
                        <a class="nav-link" href="/shop/shopPage">店铺信息</a>
                        <a class="nav-link" href="/ask/brandAsk">品牌认证</a>
                    </c:if>
                    <a class="nav-link" href="/ask/askList">过往申请</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#"><i class="fa fa-cny"></i>交易管理</a>
                    <a class="nav-link" href="/shop/shop">已卖出的宝贝</a>
                    <a class="nav-link" href="#">评价管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#"><i class="fa fa-wheelchair-alt"></i>物流管理</a>
                    <a class="nav-link" href="#">发货</a>
                    <a class="nav-link" href="#">物流服务</a>
                    <a class="nav-link" href="#">物流工具</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#"><i class="fa fa-shopping-basket"></i>宝贝管理</a>
                    <a class="nav-link" href="/goods/goodsInsert">发布宝贝</a>
                    <a class="nav-link" href="/goods/goodsListSale">出售中的宝贝</a>
                    <a class="nav-link" href="/goods/goodsListStore">仓库中的宝贝</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#"><i class="fa fa-group"></i>客户服务</a>
                    <a class="nav-link" href="#">退款管理</a>
                    <a class="nav-link" href="#">违规记录</a>
                </li>
            </ul>
        </div>

        <div class="col-sm-10">
            <div id="middle_title">
                <span>店铺详情</span>
            </div>
            <div class="row" id="shop_details_div">
                <div class="col-sm-6">
                    <form action="#">
                        <div class="form-group">
                            <label for="shop_name">店铺名:</label>
                            <input type="text" class="form-control" id="shop_name" value="${shop.name}" readonly>
                        </div>
                        <div>
                            <p>描述评分：${shop.descriptionMark}</p>
                            <p>物流评分：${shop.streamMark}</p>
                            <p>服务评分：${shop.serviceMark}</p>
                            <p>建立时间：${shop.time}</p>
                        </div>
                        <div class="form-group">
                            <label for="service1">客服一：</label>
                            <input type="text" class="form-control service" name="serviceOne" id="service1" value="${shop.serviceOne}">
                            <label for="service2">客服二：</label>
                            <input type="text" class="form-control service" name="serviceTwo" id="service2" value="${shop.serviceTwo}">
                            <label for="service3">客服三：</label>
                            <input type="text" class="form-control service" name="serviceThree" id="service3" value="${shop.serviceThree}">
                        </div>
                        <input type="hidden" name="shopId" value="${shop.id}">
                        <div>
                            <button type="submit" onclick="return submitCheck()" class="btn btn-outline-success">
                                任命客服
                            </button>
                        </div>
                    </form>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="user">用户名:</label>
                        <input type="text" class="form-control" id="user" readonly value="${shop.user.name}">
                    </div>
                    <div>
                        <span>店铺图标</span>
                        <img src="/shopImage/${shop.name}/${shop.image}" width="100px" height="100px">
                    </div>
                    <div>
                        <span>品牌：${brand.name}</span>
                        <img src="/brandImage/${brand.name}/${brand.image}" width="100px" height="100px">
                    </div>
                    <div>
                        <span>店铺状态：${shop.state}</span>
                        <button type="button" class="btn btn-outline-success">
                            <a href="/shop/updateShopState?state=营业&id=${shop.id}">营业</a>
                        </button>
                        <button type="button" class="btn btn-outline-danger">
                            <a href="/shop/updateShopState?state=停业&id=${shop.id}">停业</a>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var result = false;

    function submitCheck() {
        return result;
    }

    $(".service").blur(function () {
        $.ajax({
            url: "/user/selectUserName",//要请求的服务器url
            data: {name: $(this).val()},//一个对象，表示请求参数，有两个参数 method val  method表示交给Servlet中的什么方法处理，不写默认为doGet或者doPost
            async: false,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                if (data.result == "true") {
                    result = true;
                }
                if (data.result == "false") {
                    result = false;
                }
                if (data.result == '${shop.user.name}') {
                    result = false;
                }
            }
        });
        if ($(this).val() == null || $(this).val() == "") {
            result = false;
        }
        if (result == true) {
            $(this).css("background-color", "greenyellow");
        }
    });
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
