<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主界面</title>
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
            <input type="text" class="form-control dropdown-toggle" id="search_input" placeholder="搜索 天猫 商品/品牌/店铺" data-toggle="dropdown" name="condition">
            <div class="input-group-append">
                <button class="btn btn-danger" type="submit" id="search_btn" onclick="return searchCheck()">搜&nbsp;索</button>
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

        $(document).ready(function () {
            $.ajax({
                url: "/user/selectUserSearch",//要请求的服务器url
                data: {id:${user.id}},
                async: true,//是否是异步请求
                cache: false,//是否缓存结果
                type: "POST",//请求方式
                dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                    $("#search_prompt").html("");
                    $.each(data, function (index, item) {
                        $("#search_prompt").append(
                            "<a class=\"dropdown-item\" href=\"#\">" + item.content + "</a>"
                        )
                    });
                }
            });
        });
    </script>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-2" id="categoryDiv"><i class="fa fa-list-ul"></i>&emsp;商品分类</div>
        <div class="col-sm-1.5"><a href="#"><img id="tmllShop" src="/image/main/tmllshop.png"></a></div>
        <div class="col-sm-1.5"><a href="#"><img id="tmllInternational" src="/image/main/tmllinternational.png"></a>
        </div>
        <div class="col" id="tmllLink">
            <a href="#">天猫会员</a>
            <a href="#">电器城</a>
            <a href="#">喵鲜生</a>
            <a href="#">医药馆</a>
            <a href="#">营业厅</a>
            <a href="#">魅力惠</a>
            <a href="#">飞猪旅行</a>
            <a href="#">苏宁易购</a>
        </div>
    </div>
</div>
<hr style="background-color: red;height: 2px">

<div class="container-fluid" id="slideDiv" style="position: relative">
    <div class="container" id="type_bar">
        <div class="row">
            <div class="col-sm-2" id="type_bar_inner">
                <ul>
                    <li class="typeLi" id="typeLi1"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=女装">女装</a> / <a
                            href="/type/selectGoodsByType?typeName=内衣">内衣</a></li>
                    <li class="typeLi" id="typeLi2"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=男装">男装</a> / <a
                            href="/type/selectGoodsByType?typeName=运动户外">运动户外</a></li>
                    <li class="typeLi" id="typeLi3"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=女鞋">女鞋</a> / <a
                            href="/type/selectGoodsByType?typeName=男鞋">男鞋</a> / <a
                            href="/type/selectGoodsByType?typeName=箱包">箱包</a></li>
                    <li class="typeLi" id="typeLi4"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=美妆">美妆</a> / <a
                            href="/type/selectGoodsByType?typeName=个人护理">个人护理</a></li>
                    <li class="typeLi" id="typeLi5"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=腕表">腕表</a> / <a
                            href="/type/selectGoodsByType?typeName=眼镜">眼镜</a> / <a
                            href="/type/selectGoodsByType?typeName=珠宝饰品">珠宝饰品</a></li>
                    <li class="typeLi" id="typeLi6"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=手机">手机</a> / <a
                            href="/type/selectGoodsByType?typeName=数码">数码</a> / <a
                            href="/type/selectGoodsByType?typeName=电脑办公">电脑办公</a></li>
                    <li class="typeLi" id="typeLi7"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=母婴玩具">母婴玩具</a></li>
                    <li class="typeLi" id="typeLi8"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=零食">零食</a> / <a
                            href="/type/selectGoodsByType?typeName=茶酒">茶酒</a> / <a
                            href="/type/selectGoodsByType?typeName=进口食品">进口食品</a></li>
                    <li class="typeLi" id="typeLi9"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=生鲜水果">生鲜水果</a></li>
                    <li class="typeLi" id="typeLi10"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=大家电">大家电</a> / <a
                            href="/type/selectGoodsByType?typeName=生活电器">生活电器</a></li>
                    <li class="typeLi" id="typeLi11"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=家具建材">家具建材</a></li>
                    <li class="typeLi" id="typeLi12"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=汽车配件">汽车配件</a> / <a
                            href="/type/selectGoodsByType?typeName=汽车用品">汽车用品</a></li>
                    <li class="typeLi" id="typeLi13"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=家纺">家纺</a> / <a
                            href="/type/selectGoodsByType?typeName=家饰">家饰</a> / <a
                            href="/type/selectGoodsByType?typeName=鲜花">鲜花</a></li>
                    <li class="typeLi" id="typeLi14"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=医药保健">医药保健</a></li>
                    <li class="typeLi" id="typeLi15"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=厨具">厨具</a> / <a
                            href="/type/selectGoodsByType?typeName=收纳">收纳</a> / <a
                            href="/type/selectGoodsByType?typeName=宠物">宠物</a></li>
                    <li class="typeLi" id="typeLi16"><i class="fa fa-wheelchair-alt">&nbsp;</i><a
                            href="/type/selectGoodsByType?typeName=图书影像">图书影像</a></li>
                </ul>
            </div>
            <div class="col-sm-2" id="type_bar_inner_middle">
                <div class="categoryDiv categoryDiv1">
                    <h6>当季流行 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>精选上装 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>浪漫裙装 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>女士下装 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>内裤背心 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv2">
                    <h6>当季流行 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>男士外套 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>男士内搭 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>男士裤装 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>运动服 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv3">
                    <h6>潮流女鞋 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>潮流男鞋 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>潮流女包 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>精品男包 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>功能箱包 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv4">
                    <h6>护肤品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>彩妆 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>男士护肤 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>美发护发 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>口腔护理 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv5">
                    <h6>黄金首饰 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>钻石彩宝 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>潮流饰品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>腕表 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>眼镜 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv6">
                    <h6>品牌手机 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>电脑整机 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>智能数码 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>硬件存储 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>摄影摄像 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv7">
                    <h6>童装 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>婴儿服 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>车床用品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>喂养 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>玩具 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv8">
                    <h6>进口食品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>休闲零食 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>酒类 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>茶叶 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>乳品冲饮 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv9">
                    <h6>新鲜蔬菜 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>冰淇淋 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>蛋类 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>肉类 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>海鲜水产 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv10">
                    <h6>平板电视 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>空调 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>冰箱 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>洗衣机 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>热水器 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv11">
                    <h6>成套家具 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>客厅餐厅 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>卧室家具 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>书房儿童 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>灯饰照明 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv12">
                    <h6>机油轮胎 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>座垫脚垫 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>电子导航 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>美容清洗 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>汽车装饰 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv13">
                    <h6>当季热卖 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>床上用品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>居家布艺 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>家居饰品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>鲜花绿植 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv14">
                    <h6>保健品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>滋补品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>医药 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>医疗器械 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>隐形眼镜 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv15">
                    <h6>厨房烹饪 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>餐饮器具 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>纸品清洁 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>收纳清洁 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>宠物用品 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
                <div class="categoryDiv categoryDiv16">
                    <h6>儿童读物 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>畅销小说 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>学习考试 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>教材教辅 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                    <h6>社会生活 <i class="fa fa-chevron-right" aria-hidden="true"></i></h6>
                </div>
            </div>

            <div class="col-sm-5" id="type_bar_inner_right">
                <div class="categoryDiv categoryDiv1">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=女装新品">女装新品</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=商场同款">商场同款</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=时髦外套">时髦外套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=仙女连衣裙">仙女连衣裙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=百搭船袜">百搭船袜</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=毛呢外套">毛呢外套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=羽绒服">羽绒服</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=棉服">棉服</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=丝绒卫衣">丝绒卫衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=毛针织衫">毛针织衫</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=连衣裙">连衣裙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=半身裙">半身裙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=大摆裙">大摆裙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=长袖连衣裙">长袖连衣裙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛仔裙">牛仔裙</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=休闲裤">休闲裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=阔腿裤">阔腿裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛仔裤">牛仔裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=打底裤">打底裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=背带裤">背带裤</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=男士内裤">男士内裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=平角裤">平角裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=线衣">线衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=线裤">线裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=袜子">袜子</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv2">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛仔衬衫">牛仔衬衫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=修身夹克">修身夹克</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=九分裤">九分裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=帆布鞋">帆布鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=运动卫衣">运动卫衣</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=棉衣">棉衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=风衣">风衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=西服套装">西服套装</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=皮衣">皮衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=马甲">马甲</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=短袖T恤">短袖T恤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=POLO衫">POLO衫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=短袖衬衫">短袖衬衫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=背心">背心</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=卫衣">卫衣</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=小脚裤">小脚裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=九分裤">九分裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=短裤">短裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=休闲裤">休闲裤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛仔裤">牛仔裤</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=健身服">健身服</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=运动内衣">运动内衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=速干T恤">速干T恤</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=运动POLO">运动POLO</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=运动卫衣">运动卫衣</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv3">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=高跟单鞋">高跟单鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=平底单鞋">平底单鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=潮流过膝靴">潮流过膝靴</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=英伦牛津靴">英伦牛津靴</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=小白鞋">小白鞋</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=休闲鞋">休闲鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=豆豆鞋">豆豆鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=帆船鞋">帆船鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=乐福鞋">乐福鞋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=板鞋">板鞋</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=化妆包">化妆包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=腰包">腰包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=胸包">胸包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=单肩包">单肩包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=斜挎包">斜挎包</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=男士钱包">男士钱包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=收纳包">收纳包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=单肩包">单肩包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=斜挎包">斜挎包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=双肩包">双肩包</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=旅行箱">旅行箱</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=万向轮箱">万向轮箱</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=旅行袋">旅行袋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=韩版双肩包">韩版双肩包</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=铆钉双肩包">铆钉双肩包</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv4">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=面膜">面膜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=身体乳">身体乳</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=精华液">精华液</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=面部喷雾">面部喷雾</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=T区护理">T区护理</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=香水">香水</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=口红">口红</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=隔离">隔离</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=粉底">粉底</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=粉饼">粉饼</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洁面">洁面</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=控油">控油</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=防晒">防晒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=眼部护理">眼部护理</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=爽肤水">爽肤水</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洗发水">洗发水</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口洗发水">进口洗发水</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=护发素">护发素</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=发膜">发膜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=护发精油">护发精油</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牙膏">牙膏</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牙刷">牙刷</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牙贴">牙贴</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=漱口水">漱口水</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牙粉">牙粉</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv5">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=耳钉">耳钉</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=黄金项链">黄金项链</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=黄金对戒">黄金对戒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=转运珠">转运珠</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=足金饰品">足金饰品</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=结婚钻戒">结婚钻戒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=钻石吊坠">钻石吊坠</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=钻石耳饰">钻石耳饰</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=钻石手链">钻石手链</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=绿宝石">绿宝石</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=传统银饰">传统银饰</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=木手串">木手串</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=胸针">胸针</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=耳环">耳环</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=石榴石手链">石榴石手链</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=瑞士名表">瑞士名表</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=日韩港表">日韩港表</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=石英表">石英表</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=防水表">防水表</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=运动表">运动表</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=太阳镜">太阳镜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=墨镜">墨镜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=近视镜">近视镜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=老花镜">老花镜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=偏光镜">偏光镜</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv6">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=小米">小米</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=三星">三星</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=iPhone">iPhone</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=荣耀">荣耀</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=华为">华为</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=笔记本">笔记本</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=平板电脑">平板电脑</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=台式机">台式机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=一体机">一体机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=游戏本">游戏本</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能手表">智能手表</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能手环">智能手环</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=VR眼镜">VR眼镜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能机器人">智能机器人</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能摄像">智能摄像</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=显示器">显示器</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=固态硬盘">固态硬盘</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=机械硬盘">机械硬盘</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=CPU">CPU</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=显卡">显卡</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=相机">相机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=单反">单反</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=自拍神器">自拍神器</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=拍立得">拍立得</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=镜头">镜头</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv7">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童套装">套装</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童裤子">裤子</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童外套">外套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=亲子装">亲子装</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童裙子">裙子</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=连体衣">连体衣</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿礼盒">婴儿礼盒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=肚兜">肚兜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿外套">外套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿裤子">裤子</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿推车">婴儿推车</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=学步车">学步车</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=安全座椅">安全座椅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿背带">婴儿背带</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿床">婴儿床</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=奶瓶">奶瓶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=奶嘴">奶嘴</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=辅食机">辅食机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=调奶器">调奶器</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=暖奶器">暖奶器</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=婴儿玩具">婴儿玩具</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童自行车">儿童自行车</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童电动车">儿童电动车</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=毛绒玩具">毛绒玩具</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=积木">积木</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv8">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口零食">进口零食</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口巧克力">进口巧克力</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口饼干">进口饼干</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口糖果">进口糖果</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=进口坚果">进口坚果</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=零食">零食</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=坚果">坚果</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=饼干">饼干</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=膨化食品">膨化食品</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛肉干">牛肉干</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=白酒">白酒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=红酒">红酒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洋酒">洋酒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=啤酒">啤酒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=黄酒">黄酒</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=菊花茶">菊花茶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=红茶">红茶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=绿茶">绿茶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=柠檬片">柠檬片</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=花茶">花茶</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛奶">牛奶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=酸奶">酸奶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=成人奶粉">成人奶粉</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=咖啡豆">咖啡豆</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=奶茶">奶茶</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv9">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=土豆">土豆</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=山药">山药</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=莲藕">莲藕</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=净菜">净菜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=玉米">玉米</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=冰淇淋">冰淇淋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=哈根达斯">哈根达斯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=本杰瑞">本杰瑞</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=老冰棍">老冰棍</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=中街冰点">中街冰点</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鸡蛋">鸡蛋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鸭蛋">鸭蛋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鹅蛋">鹅蛋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鸽子蛋">鸽子蛋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=张旭升">张旭升</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛排">牛排</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=牛腩">牛腩</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鸡肉">鸡肉</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鸡翅">鸡翅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=羊腿">羊腿</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=三文鱼">三文鱼</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=金枪鱼">金枪鱼</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鲽鱼">鲽鱼</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=比目鱼">比目鱼</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=海参">海参</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv10">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=国产电视">国产</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=曲面电视">曲面</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能电视">智能电视</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=超级大屏">超级大屏</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=云电视">云电视</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=节能空调">节能</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能空调">智能空调</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=变频空调">变频空调</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=中央空调">中央空调</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=空调挂机">挂机</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=三门冰箱">三门</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=对开门冰箱">对开门</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=智能冰箱">智能</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=无霜冰箱">无霜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=冷柜">冷柜</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=迷你洗衣机">迷你</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=烘干机">烘干机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=大容量洗衣机">大容量</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洗烘一体">洗烘一体</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=滚筒洗衣机">滚筒洗</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=遥控热水器">遥控</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=恒温热水器">恒温</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=太阳能热水器">太阳能</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=即热式热水器">即热式</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=空气能热水器">空气能</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv11">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=客厅成套家具">客厅成套家具</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=餐厅成套家具">餐厅成套家具</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=卧室成套家具">卧室成套家具</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童成套家具">儿童成套家具</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=沙发">沙发</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=电视柜">电视柜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=茶几">茶几</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鞋柜">鞋柜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=餐桌">餐桌</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=衣柜">衣柜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=床垫">床垫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=实木床">实木床</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=双人床">双人床</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=水床">水床</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=电脑桌">电脑桌</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=电脑椅">电脑椅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=书桌">书桌</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=办公桌">办公桌</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童椅">儿童椅</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=吊灯">吊灯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=简灯">简灯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=射灯">射灯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=灯泡">灯泡</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=壁灯">壁灯</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv12">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=全合成机油">全合成机油</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=半合成机油">半合成机油</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=矿物质机油">矿物质机油</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车轮胎">汽车轮胎</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=雪地胎">雪地胎</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=秋冬坐垫">秋冬坐垫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车脚垫">汽车脚垫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=专用座套">专用座套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=女性坐垫">女性坐垫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=通用坐垫">通用坐垫</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=行车记录仪">行车记录仪</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=安全预警仪">安全预警仪</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=后视镜导航">后视镜导航</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=车载导航">车载导航</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=便携式导航">便携式导航</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洗车机">洗车机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车水枪">汽车水枪</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=车蜡">车蜡</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=底盘装甲">底盘装甲</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=玻璃水">玻璃水</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车香水">香水</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车挂件">汽车挂件</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=手机支架">手机支架</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=方向盘套">方向盘套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汽车头枕">头枕</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv13">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=床上四件套">印花四件套</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=羽绒被">羽绒被</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=毛毯">毛毯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=沙发垫">沙发垫</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=坐垫">坐垫</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=枕头">枕头</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=枕芯">枕芯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=床单">床单</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=被子">被子</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=床帘">床帘</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=窗帘">窗帘</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=毛巾">毛巾</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=门帘">门帘</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=桌布">桌布</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=十字绣">十字绣</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=墙贴">墙贴</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=壁纸">壁纸</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=花瓶">花瓶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=相框">相框</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=冰箱贴">冰箱贴</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=红玫瑰">红玫瑰</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=百合">百合</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=多肉">多肉</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=康乃馨">康乃馨</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=仿真花">仿真花</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv14">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鱼油">鱼油</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=左旋肉碱">左旋肉碱</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=增肌粉">增肌粉</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=维生素C">维生素C</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=护肝">护肝</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=蜂蜜">蜂蜜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=阿胶">阿胶</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=冬虫夏草">冬虫夏草</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=人参">人参</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鹿茸">鹿茸</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=感冒咳嗽">感冒咳嗽</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=腰腿疼痛">腰腿疼痛</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=血糖仪">血糖仪</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=针灸拔罐">针灸拔罐</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=皮炎湿疹">皮炎湿疹</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=制氧机">制氧机</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=体温计">体温计</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=轮椅">轮椅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=助听器">助听器</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=雾化器">雾化器</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=强生美瞳">强生美瞳</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=博士伦">博士伦</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=海昌">海昌</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=卫康">卫康</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=爱尔康">爱尔康</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv15">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=不粘锅">不粘锅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=平底锅">平底锅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=高压锅">高压锅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=砂锅">砂锅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=汤锅">汤锅</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=保温杯">保温杯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=水杯">水杯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=玻璃杯">玻璃杯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=茶杯">茶杯</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=筷子">筷子</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=软包纸抽">软包纸抽</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=卷筒纸">卷筒纸</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=湿巾纸">湿巾纸</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洗衣液">洗衣液</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=洁厕剂">洁厕剂</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=晾衣架">晾衣架</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=收纳盒">收纳盒</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=鞋柜">鞋柜</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=垃圾袋">垃圾袋</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=垃圾桶">垃圾桶</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=狗粮">狗粮</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=猫粮">猫粮</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=猫砂">猫砂</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=栓绳">栓绳</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=宠物衣服">衣服</a>
                    </div>
                </div>

                <div class="categoryDiv categoryDiv16">
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=绘本">绘本</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=儿童文学">儿童文学</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=启蒙认知">启蒙认知</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=益智游戏">益智游戏</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=童话书">童话书</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=都市情感">都市情感</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=穿越架空">穿越架空</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=外国文学">外国文学</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=科幻小说">科幻小说</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=影视同期">影视同期</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=公务员考试">公务员</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=托福考试">托福</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=职称英语">职称英语</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=注册会计师">注册会计师</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=四六级英语">四六级英语</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=中学教辅">中学教辅</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=新课标">新课标</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=中小学作文">中小学作文</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=高职教材">高职教材</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=本科教材">本科教材</a>
                    </div>
                    <div class="categoryDivRight">
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=烘焙">烘焙</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=旅游">旅游</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=菜谱">菜谱</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=时尚">时尚</a>
                        <a href="/type/selectGoodsByGoodsType?goodsTypeName=家居装修">家居装修</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-3" id="type_bar_inner_brand">
                <h1>品牌1</h1>
                <h1>品牌二</h1>
                <h1>品牌叁</h1>
                <h1>品牌four</h1>
                <h1>品牌⑤</h1>
            </div>
        </div>
    </div>

    <div id="demo" class="container carousel slide" data-ride="carousel">
        <!-- 指示符 -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
            <li data-target="#demo" data-slide-to="3"></li>
        </ul>

        <!-- 轮播图片 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/image/main/1.jpg">
            </div>
            <div class="carousel-item">
                <img src="/image/main/2.jpg">
            </div>
            <div class="carousel-item">
                <img src="/image/main/3.jpg">
            </div>
            <div class="carousel-item">
                <img src="/image/main/4.jpg">
            </div>
        </div>
    </div>
</div>

<script>
    $(".typeLi").mousemove(function () {
        $(".typeLi").css("background-color", "black");
        $(".typeLi").find("a").css("color", "white");
        $(".typeLi").find("i").css("color", "white");
        $(this).css("color", "red");
        $(this).css("background-color", "white");
        $(this).find("a").css("color", "red");
        $(this).find("i").css("color", "red");
        showType();
    });

    $("#slideDiv").mouseleave(function () {
        $(".typeLi").css("background-color", "black");
        $(".typeLi").find("a").css("color", "white");
        $(".typeLi").find("i").css("color", "white");
        hideType();
    });

    $("#typeLi1").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv1").show();
    });

    $("#typeLi2").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv2").show();
    });

    $("#typeLi3").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv3").show();
    });

    $("#typeLi4").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv4").show();
    });

    $("#typeLi5").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv5").show();
    });

    $("#typeLi6").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv6").show();
    });

    $("#typeLi7").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv7").show();
    });

    $("#typeLi8").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv8").show();
    });

    $("#typeLi9").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv9").show();
    });

    $("#typeLi10").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv10").show();
    });

    $("#typeLi11").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv11").show();
    });

    $("#typeLi12").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv12").show();
    });

    $("#typeLi13").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv13").show();
    });

    $("#typeLi14").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv14").show();
    });

    $("#typeLi15").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv15").show();
    });

    $("#typeLi16").mousemove(function () {
        $(".categoryDiv").hide();
        $(".categoryDiv16").show();
    });

    function showType() {
        $("#type_bar_inner_middle").show();
        $("#type_bar_inner_right").show();
        $("#type_bar_inner_brand").show();
    }

    function hideType() {
        $("#type_bar_inner_middle").hide();
        $("#type_bar_inner_right").hide();
        $("#type_bar_inner_brand").hide();
    }
</script>

<div class="container" id="brand_div">

</div>

<script>
    var brandPage = 1;
    $(document).ready(function () {
        $.ajax({
            url: "/user/selectAllBrand",//要请求的服务器url
            data: {page: brandPage},
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                $("#brand_div").html("");
                $("#brand_div").append(
                    ""
                );
            }
        });
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
