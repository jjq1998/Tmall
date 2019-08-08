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
        input[type=file] {
            margin-bottom: 22px;
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
                <span>添加商品信息</span>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <form action="/goods/insertGoodsChoose">
                        <h5>添加商品可选规格</h5>
                        <div class="form-group">
                            <label for="param_one">参数一：</label>
                            <input type="text" class="form-control" id="param_one" name="chooseOne" value="${goods.goodsChoose.chooseOne}">
                        </div>
                        <div class="form-group">
                            <label for="param_two">参数二：</label>
                            <input type="text" class="form-control" id="param_two" name="chooseTwo" value="${goods.goodsChoose.chooseTwo}">
                        </div>
                        <div class="form-group">
                            <label for="param_three">参数三：</label>
                            <input type="text" class="form-control" id="param_three" name="chooseThree" value="${goods.goodsChoose.chooseThree}">
                        </div>
                        <input type="hidden" name="goodsId" value="${goods.id}">
                        <button type="submit" class="btn btn-success" style="width: 100%">添加参数</button>
                    </form>
                </div>
                <div class="col-sm-6">
                    <form action="/goods/insertGoodsSlide" method="post" enctype="multipart/form-data">
                        <h5>添加商品轮播图</h5>
                        <c:if test="${!empty goodsSlide}" var="slideResult">
                            <c:forEach items="${goodsSlide}" var="slide">
                                <div class="custom-file mb-3 custom-control-inline">
                                    <input type="file" class="custom-file-input" accept="image/*"
                                           id="goodsImage${slide.id}"
                                           name="goodsImage">
                                    <label id="labelForImage${slide.id}" class="custom-file-label"
                                           for="goodsImage${slide.id}">${slide.imageUrl}</label>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${!slideResult}">
                            <div class="custom-file mb-3 custom-control-inline">
                                <input type="file" class="custom-file-input" accept="image/*" id="goodsImage1"
                                       name="goodsImage">
                                <label id="labelForImage1" class="custom-file-label" for="goodsImage1">选择图片</label>
                            </div>
                            <div class="custom-file mb-3 custom-control-inline">
                                <input type="file" class="custom-file-input" accept="image/*" id="goodsImage2"
                                       name="goodsImage">
                                <label id="labelForImage2" class="custom-file-label" for="goodsImage2">选择图片</label>
                            </div>
                            <div class="custom-file mb-3 custom-control-inline">
                                <input type="file" class="custom-file-input" accept="image/*" id="goodsImage3"
                                       name="goodsImage">
                                <label id="labelForImage3" class="custom-file-label" for="goodsImage3">选择图片</label>
                            </div>
                            <div class="custom-file mb-3 custom-control-inline">
                                <input type="file" class="custom-file-input" accept="image/*" id="goodsImage4"
                                       name="goodsImage">
                                <label id="labelForImage4" class="custom-file-label" for="goodsImage4">选择图片</label>
                            </div>
                            <div class="custom-file mb-3 custom-control-inline">
                                <input type="file" class="custom-file-input" accept="image/*" id="goodsImage5"
                                       name="goodsImage">
                                <label id="labelForImage5" class="custom-file-label" for="goodsImage5">选择图片</label>
                            </div>
                        </c:if>
                        <input type="hidden" name="goodsId" value="${goods.id}">
                        <button type="submit" class="btn btn-success" style="width: 100%">提交轮播图</button>
                    </form>
                </div>
                <script>
                    $("input[type=file]").change(function () {
                        $(this).siblings().html($(this).val());
                    });
                </script>
                <div class="container-fluid">
                    <h5>添加商品参数</h5>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>${goods.goodsChoose.chooseOne}</th>
                            <th>${goods.goodsChoose.chooseTwo}</th>
                            <th>${goods.goodsChoose.chooseThree}</th>
                            <th>价格</th>
                            <th>库存</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${goods.goodsParams}" var="goodsParam">
                            <tr>
                                <td>${goodsParam.paramOne}</td>
                                <td>${goodsParam.paramTwo}</td>
                                <td>${goodsParam.paramThree}</td>
                                <td>${goodsParam.price}</td>
                                <td>${goodsParam.inventory}</td>
                                <td>
                                    <button class="btn btn-danger">
                                        <a href="/goods/deleteGoodsParamById?id=${goodsParam.id}&&goodsId=${goods.id}" style="color: white;">删除</a>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <form action="/goods/insertGoodsParam">
                                <td><input type="text" class="form-control" name="paramOne"></td>
                                <td><input type="text" class="form-control" name="paramTwo"></td>
                                <td><input type="text" class="form-control" name="paramThree"></td>
                                <td><input type="text" class="form-control" name="price"></td>
                                <td><input type="text" class="form-control" name="inventory"></td>
                                <input type="hidden" name="goodsId" value="${goods.id}">
                                <td>
                                    <button type="submit" class="btn btn-success" style="width: 100px">添加</button>
                                </td>
                            </form>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

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
