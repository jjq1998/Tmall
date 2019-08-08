<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/30
  Time: 7:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台主界面</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/admin/main.css">
    <link rel="stylesheet" href="/css/admin/main1.css">
    <style>
        .pagination {
            justify-content: center;
        }
    </style>
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
</head>
<body>
<div style="background-color: rgb(47,53,63);width: 300px;min-height: 100%;float: left;display: block" id="left1">
    <div id="logo1">
        <img src="/image/login/logo.png" id="img1">
    </div>
    <ul>
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i>店铺管理</li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-list">&emsp;</i>开店申请</li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-trademark">&emsp;</i>品牌认证</li>
        <li class="leftDiv" onclick="choose4()"><i class="fa fa-cog">&emsp;</i>修改密码</li>
    </ul>
</div>

<div style="background-color: rgb(47,53,63);width: 100px;min-height: 100%;float: left;display: none" id="left2">
    <div id="logo2">
        <img src="/image/icon.png" id="img2">
    </div>
    <ul style="width: 100px;font-size: 30px">
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i></li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-list">&emsp;</i></li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-trademark">&emsp;</i></li>
        <li class="leftDiv" onclick="choose4()"><i class="fa fa-cog">&emsp;</i></li>
    </ul>
</div>

<script>
    function change() {
        if ($("#left2").css("display") == 'block') {
            $("#left1").show(1000);
            $("#left2").hide(1000);
        }
        else {
            $("#left1").hide(1000);
            $("#left2").show(1000);
        }
    }

    $(document).ready(function () {
        $(".leftDiv").click(function () {
            $(".leftDiv").removeClass('choose');
            jQuery(this).addClass('choose');
        });
    });
</script>

<div class="container-fluid" style="padding: 0">
    <div class="container-fluid" id="top">
        <i class="fa fa-bars fa-3x" onclick="change()" onmousemove="this.style.color='royalblue'"
           onmouseleave="this.style.color='rgb(145,145,145)'"></i>
        <span class="fa-stack fa-lg" id="out" onclick="window.location.href='/admin/login'"><i
                class="fa fa-circle fa-stack-2x" style="color: royalblue"></i><i class="fa fa-power-off fa-stack-1x"
                                                                                 style="color: white"></i></span>
    </div>
    <div class="container-fluid" id="basic">
        <div id="shopDiv" class="allForm">
            <table id="shopTable" class="table table-striped">
                <thead>
                <tr>
                    <th>店铺ID</th>
                    <th>店铺名称</th>
                    <th>店铺状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="shopTableBody">

                </tbody>
            </table>
            <ul class="pagination" id="shopPage">

            </ul>
        </div>

        <div id="shop" class="allForm" style="display: none">

        </div>

        <script>
            var shopPage = 1;
            var totalShopPage;
            var askPage = 1;
            var totalAskPage;
            var brandPage = 1;
            var totalBrandPage;

            $(document).ready(function () {
                selectShop(shopPage);
            });

            function prevPage1() {
                shopPage--;
                if (shopPage < 1) {
                    shopPage = 1;
                }
                selectShop(shopPage);
            }

            function nextPage1() {
                shopPage++;
                if (shopPage > totalShopPage) {
                    shopPage = totalShopPage;
                }
                selectShop(shopPage);
            }

            function selectShopPage() {
                $.ajax({
                    url: "/admin/selectShopPage",//要请求的服务器url
                    async: false,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        totalShopPage = parseInt(data.shopCount / 10);
                        if (data.shopCount % 10 != 0) {
                            totalShopPage++;
                        }
                    }
                });
            }

            function selectAskPage() {
                $.ajax({
                    url: "/admin/selectAskPage",//要请求的服务器url
                    async: false,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        totalAskPage = parseInt(data.askCount / 10);
                        if (data.askCount % 10 != 0) {
                            totalAskPage++;
                        }

                        totalBrandPage = parseInt(data.brandCount / 10);
                        if (data.brandCount % 10 != 0) {
                            totalBrandPage++;
                        }
                    }
                });
            }

            function selectShop(page) {
                $.ajax({
                    url: "/admin/selectAllShopAdmin",//要请求的服务器url
                    data: {page: page},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $('#shopTableBody').html('');
                        $.each(data, function (index, item) {
                            $('#shopTableBody').append(
                                "<tr>" +
                                "<td>" + item.id + "</td>" +
                                "<td>" + item.name + "</td>" +
                                "<td>" + item.state + "</td>" +
                                "<td>" +
                                "<button class='btn btn-danger btn-primary deleteButton'>" +
                                "<a class='deleteAdmin' onclick='closeShopCheck(" + item.id + ")'> 封停 </a>" +
                                "</button>&emsp;" +
                                "<button class='btn btn-success btn-primary deleteButton'>" +
                                "<a class='deleteAdmin' onclick='selectShopById(" + item.id + ")'> 查看 </a>" +
                                "</button>" +
                                "</td>" +
                                "</tr>"
                            );
                        });

                        selectShopPage();

                        $('#shopPage').html(
                            '<li class="page-item" onclick="prevPage1()"><a class="page-link">Previous</a></li>' +
                            '<li class="page-item"><a class="page-link" href="#">' + shopPage + '/' + totalShopPage + '</a></li>' +
                            '<li class="page-item" onclick="nextPage1()"><a class="page-link">Next</a></li>'
                        );
                    }
                })
            };

            function selectShopById(id) {
                $.ajax({
                    url: "/admin/selectShopById",//要请求的服务器url
                    data: {id: id},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $("#shopDiv").hide();
                        $("#shop").html(
                            "<span class=\"shopDescription\">店铺ID：" + data.shop.id + "</span>\n" +
                            "<span class=\"shopDescription\">店铺名称：" + data.shop.name + "</span><br>\n" +
                            "<span class=\"shopDescription\">店长：" + data.shop.user.name + "</span>\n" +
                            "<span class=\"shopDescription\">店铺状态：" + data.shop.state + "</span><br>\n" +
                            "<span class=\"shopDescription\">创建时间：" + new Date(data.shop.time).toLocaleString() + "</span><br>\n" +
                            "<span class=\"shopDescription\">描述评分：" + data.shop.descriptionMark + "</span>\n" +
                            "<span class=\"shopDescription\">物流评分：" + data.shop.streamMark + "</span>\n" +
                            "<span class=\"shopDescription\">服务评分：" + data.shop.serviceMark + "</span><br>\n" +
                            "<img src=\"/shopImage/" + data.shop.name + "/" + data.shop.image + "\" width=\"300px\" height=\"300px\">"
                        );
                        $("#shop").show();
                    }
                });
            }

            function closeShopCheck(id) {
                $.ajax({
                    url: "/admin/selectShopState",//要请求的服务器url
                    data: {id: id},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        if (data.shopState == "待审核") {
                            alert('该店铺尚未通过审核');
                        }
                        else {
                            closeShop(id)
                            selectShop(shopPage);
                        }
                    }
                });
            }

            function closeShop(id) {
                $.ajax({
                    url: "/admin/updateShopState",//要请求的服务器url
                    data: {id: id},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST"//请求方式
                });
            }
        </script>

        <div id="shopAskDiv" class="allForm" style="display: none">
            <table id="shopAskTable" class="table table-striped">
                <thead>
                <tr>
                    <th>申请ID</th>
                    <th>申请人</th>
                    <th>店铺名称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="shopAskTableBody">

                </tbody>
            </table>
            <ul class="pagination" id="shopAskPage">

            </ul>
        </div>

        <div id="ask" class="allForm" style="display: none">
            <label for="name" id="shopNameLabel">店铺名称</label>
            <div class="input-group mb-3 custom-control-inline" id="nameInput">
                <input type="text" class="form-control" placeholder="店铺名称" id="name" name="name" readonly>
            </div>

            <label for="customFile" id="fileLabel">店铺图片</label>
            <div class="custom-file mb-3 custom-control-inline" id="imageInput">
                <input type="file" class="custom-file-input" accept="image/*" id="customFile" name="shopImage" disabled>
                <label id="labelForImage" class="custom-file-label" for="customFile" style="text-align: left"></label>
            </div>

            <div class="container" id="askContent">
                <div id="askContent2">
                    <pre id="askContentPre" style="margin: auto">

                    </pre>
                    <button type="button" id="ask_btn_1" class="btn btn-outline-success ask_btn">
                        通过
                    </button>
                    <button type="button" id="ask_btn_2" class="btn btn-outline-danger ask_btn">
                        退回
                    </button>
                </div>
            </div>
        </div>

        <script>
            function prevPage2() {
                askPage--;
                if (askPage < 1) {
                    askPage = 1;
                }
                selectAsk(askPage);
            }

            function nextPage2() {
                askPage++;
                if (askPage > totalAskPage) {
                    askPage = totalAskPage;
                }
                selectAsk(askPage);
            }

            function selectAsk(page) {
                $.ajax({
                    url: "/admin/askListAdmin",//要请求的服务器url
                    data: {type: '开店', page: page},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $('#shopAskTableBody').html('');
                        $.each(data, function (index, item) {
                            $('#shopAskTableBody').append(
                                "<tr>" +
                                "<td>" + item.id + "</td>" +
                                "<td>" + item.user.name + "</td>" +
                                "<td>" + item.shop.name + "</td>" +
                                "<td>" +
                                "<button class='btn btn-success btn-primary deleteButton'>" +
                                "<a class='deleteAdmin' onclick='selectAskById(" + item.id + ")'> 查看 </a>" +
                                "</button>" +
                                "</td>" +
                                "</tr>"
                            );
                        });

                        selectAskPage();

                        $('#shopAskPage').html(
                            '<li class="page-item" onclick="prevPage2()"><a class="page-link">Previous</a></li>' +
                            '<li class="page-item"><a class="page-link" href="#">' + askPage + '/' + totalAskPage + '</a></li>' +
                            '<li class="page-item" onclick="nextPage2()"><a class="page-link">Next</a></li>'
                        );
                    }
                })
            };

            function selectAskById(id) {
                $.ajax({
                    url: "/admin/selectAskById",//要请求的服务器url
                    data: {id: id},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $(".allForm").hide();
                        if (data.ask.type == "开店") {
                            $("#shopNameLabel").html("店铺名称");
                            $("#fileLabel").html("店铺图片");
                            $("#name").val(data.ask.shop.name);
                            $("#labelForImage").html(data.ask.shop.image);
                        } else {
                            $("#shopNameLabel").html("品牌名称");
                            $("#fileLabel").html("品牌图片");
                            $("#name").val(data.ask.brandName);
                            $("#labelForImage").html(data.ask.brandImage);
                        }
                        $("#askContentPre").html(data.ask.content);
                        $("#ask").show();
                        $("#ask_btn_1").click(function () {
                            $.ajax({
                                url: "/admin/updateAskState",//要请求的服务器url
                                data: {id: data.ask.id, state: "已通过"},
                                async: false,//是否是异步请求
                                cache: false,//是否缓存结果
                                type: "POST"//请求方式
                            });
                            choose2();
                        });

                        $("#ask_btn_2").click(function () {
                            $.ajax({
                                url: "/admin/updateAskState",//要请求的服务器url
                                data: {id: data.ask.id, state: "未通过"},
                                async: false,//是否是异步请求
                                cache: false,//是否缓存结果
                                type: "POST"//请求方式
                            });
                            choose2();
                        });
                    }
                });
            }

        </script>

        <div id="brandDiv" class="allForm" style="display: none">
            <table id="brandTable" class="table table-striped">
                <thead>
                <tr>
                    <th>申请ID</th>
                    <th>申请人</th>
                    <th>店铺ID</th>
                    <th>店铺名称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="brandTableBody">

                </tbody>
            </table>
            <ul class="pagination" id="brandPage">

            </ul>
        </div>

        <script>

            function prevPage3() {
                brandPage--;
                if (brandPage < 1) {
                    brandPage = 1;
                }
                selectBrandAsk(brandPage);
            }

            function nextPage3() {
                brandPage++;
                if (brandPage > totalBrandPage) {
                    brandPage = totalBrandPage;
                }
                selectBrandAsk(brandPage);
            }


            function selectBrandAsk(page) {
                $.ajax({
                    url: "/admin/askListAdmin",//要请求的服务器url
                    data: {type: '认证', page: page},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $('#brandTableBody').html('');
                        $.each(data, function (index, item) {
                            $('#brandTableBody').append(
                                "<tr>" +
                                "<td>" + item.id + "</td>" +
                                "<td>" + item.user.name + "</td>" +
                                "<td>" + item.shop.id + "</td>" +
                                "<td>" + item.shop.name + "</td>" +
                                "<td>" +
                                "<button class='btn btn-success btn-primary deleteButton'>" +
                                "<a class='deleteAdmin' onclick='selectAskById(" + item.id + ")'> 查看 </a>" +
                                "</button>" +
                                "</td>" +
                                "</tr>"
                            );
                        });

                        selectAskPage();

                        $('#brandPage').html(
                            '<li class="page-item" onclick="prevPage3()"><a class="page-link">Previous</a></li>' +
                            '<li class="page-item"><a class="page-link" href="#">' + brandPage + '/' + totalBrandPage + '</a></li>' +
                            '<li class="page-item" onclick="nextPage3()"><a class="page-link">Next</a></li>'
                        );
                    }
                })
            };
        </script>

        <div id="updatePassword" class="allForm" style="display: none">
            <form action="/admin/updateAdminPassword" method="post">
                <h5 id="title1">修改密码<span id="prompt1"></span></h5>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-user-o"></i></span>
                    </div>
                    <input type="text" class="form-control" placeholder="请输入用户名" value="${admin.name}" readonly
                           name="name">
                </div>
                <div class="input-group mb-3" data-toggle="tooltip"
                     title="密码为6-18位，不包含特殊字符和汉字，必须含有字母/数字/下划线">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" placeholder="请输入密码" id="updatePassword1"
                           name="password">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" placeholder="请确认密码" id="updatePassword2">
                </div>

                <input type="hidden" name="id" value="${admin.id}">

                <button type="submit" id="update_submit" class="btn btn-danger btn-primary"
                        onclick="return updatePasswordCheck()">修改
                </button>
            </form>
        </div>
    </div>
</div>
<script>
    function choose1() {
        $('.allForm').hide(500);
        $('#shopDiv').show(500);
        selectShop(1);
    }

    function choose2() {
        $('.allForm').hide(500);
        $('#shopAskDiv').show(500);
        selectAsk(1);
    }

    function choose3() {
        $('.allForm').hide(500);
        $('#brandDiv').show(500);
        selectBrandAsk(1);
    }

    function choose4() {
        $('.allForm').hide(500);
        $('#updatePassword').show(500);
    }

    function updatePasswordCheck() {
        var partern = /^(\w){6,18}$/;

        if ("" === $("#updatePassword1").val()) {
            $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入密码');
            return false;
        }
        if ($("#updatePassword1").val() !== $("#updatePassword2").val()) {
            $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请再次确认密码');
            return false;
        }
        if (!partern.test($("#updatePassword1").val())) {
            $("#prompt1").html('<i class="fa fa-minus-circle"></i>&nbsp;请确认密码格式');
            return false;
        }
        else {
            return true;
        }
    }
</script>
</body>
</html>
