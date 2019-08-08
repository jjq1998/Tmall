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
    <link rel="stylesheet" href="/css/shop/shop.css">
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script charset="utf-8" src="/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="/kindeditor/lang/zh-CN.js"></script>
    <script type="text/javascript">
        var editor;　　//全局变量
        KindEditor.ready(function (K) {
            editor = K.create('#kindedito', {
                height: '500px',
                width: '920px',
                allowImageUpload: true,
                uploadJson: '/upload/fileUpload',
                allowFileManager: true,
                filterMode: false,
                afterChange: function () {
                    this.sync();
                }
            });
        });
    </script>
    <style>
        select {
            margin-bottom: 16px;
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
                <span>发布宝贝</span>
            </div>
            <form action="#" enctype="multipart/form-data" method="post">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="goods_name">商品名称：</label>
                            <input type="text" class="form-control" name="name" id="goods_name">
                        </div>
                        <label for="goodsImage">商品图片</label>
                        <div class="custom-file mb-3 custom-control-inline" id="imageInput">
                            <input type="file" class="custom-file-input" accept="image/*" id="goodsImage"
                                   name="goodsImage">
                            <label id="labelForImage" class="custom-file-label" for="goodsImage">选择图片</label>
                        </div>
                        <div class="form-group">
                            <label for="goods_price">商品价格：</label>
                            <input type="text" class="form-control" name="price" id="goods_price">
                        </div>
                        <label for="param_div">添加参数</label>
                        <div class="input-group mb-3" style="width: 100%" id="param_div">
                            <input type="text" class="form-control" placeholder="添加参数" id="param_input">
                            <div class="input-group-append">
                                <button class="btn btn-success" type="button" id="param_btn">添加</button>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div>
                            <label for="sel1">一级分类</label>
                            <select class="form-control" id="sel1" title="一级分类">
                                <option>请选择</option>
                                <c:forEach items="${typeList}" var="type">
                                    <option value="${type.id}" basic="${type.basic}">${type.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="sel2">二级分类</label>
                            <select class="form-control" id="sel2" title="二级分类">
                                <option>请选择</option>
                            </select>
                        </div>
                        <div>
                            <label for="sel3">三级分类</label>
                            <select class="form-control" id="sel3" title="三级分类">
                                <option>请选择</option>
                            </select>
                        </div>
                    </div>
                </div>
                <hr style="margin-bottom: 10px">
                <div id="goodsType_div">

                </div>
                <hr style="margin-bottom: 10px">
                <div class="row" id="param_input_div">

                </div>
                <div id="editor">
                    <label for="kindedito">商品详情</label><textarea name="description" id="kindedito"></textarea>
                </div>
                <button id="submit_btn" type="button" class="btn btn-success" style="float: right; margin-top: 10px">
                    上传商品
                </button>
            </form>
            <script>
                $("#goodsImage").change(function () {
                    if ($("#goodsImage").val() !== null) {
                        $("#labelForImage").html($("#goodsImage").val())
                    }
                });

                $("#sel1").change(
                    function selectAllCategory() {
                        $.ajax({
                            url: "/type/selectCategoryByTypeId",//要请求的服务器url
                            data: {id: $("#sel1 option:selected").val()},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式0
                            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                $('#sel2').html('<option>请选择</option>');
                                $.each(data, function (index, item) {
                                    $('#sel2').append(
                                        "<option value='" + item.id + "'>" + item.name + "</option>"
                                    );
                                });
                            }
                        })
                    });

                $("#sel2").change(
                    function selectAllGoodsType() {
                        $.ajax({
                            url: "/type/selectGoodsTypeByCategoryId",//要请求的服务器url
                            data: {id: $("#sel2 option:selected").val()},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式
                            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                $('#sel3').html('<option>请选择</option>');
                                $.each(data, function (index, item) {
                                    $('#sel3').append(
                                        "<option value='" + item.id + "'>" + item.name + "</option>"
                                    );
                                });
                            }
                        })
                    });

                $("#param_btn").click(function () {
                    var paramValue = $("#param_input").val();
                    if (paramValue != "") {
                        $("#param_input_div").append(
                            "<div class=\"form-group col-sm-6\">\n" +
                            "<label for='" + paramValue + "'>" + paramValue + "</label><input type=\"text\" id=" + paramValue + " name=" + paramValue + " class=\"form-control param_class\">\n" +
                            "</div>"
                        );
                    } else {
                        alert('参数名称不能为空');
                    }
                    $("#param_input").val("");
                });

                var formData = new FormData();
                $("#submit_btn").click(function () {
                    $("#goodsType_div input").each(function () {
                        formData.append("typeId", $(this).val());
                    });
                    var formObject = {};
                    var formArray = $(".param_class").serializeArray();
                    $.each(formArray, function (i, item) {
                        formObject[item.name] = item.value;
                    });
                    var details = JSON.stringify(formObject);
                    formData.append("details", details);
                    formData.append("name", $("#goods_name").val());
                    formData.append("goodsImage", $("#goodsImage")[0].files[0])
                    formData.append("description", $("#kindedito").val());
                    formData.append("price", $("#goods_price").val());
                    $.ajax({
                        url: "/goods/insertGoods",//要请求的服务器url
                        data: formData,
                        async: false,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        processData: false,
                        contentType: false,
                        dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    })
                    $(window).attr("location", "/goods/goodsListStore");
                });

                var goodsType = {};
                $("#sel3").change(function () {
                    goodsType[$("#sel3 option:selected").val()] = $("#sel3 option:selected").html();
                    $("#goodsType_div").append(
                        "<button type='button' id='btn" + $("#sel3 option:selected").val() + "' onclick='deleteType(" + $("#sel3 option:selected").val() + ")' class=\"btn btn-outline-info\">" + $("#sel3 option:selected").html() + "</button>" +
                        "<input type='hidden' id='" + $("#sel3 option:selected").val() + "' name='typeId' value='" + $("#sel3 option:selected").val() + "'>"
                    );
                });

                function deleteType(id) {
                    var typeInput = document.getElementById(id);
                    $(typeInput).remove();
                    $("#btn" + id).remove();
                }

            </script>
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
