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
    <style>
        .pagination {
            justify-content: center;
        }

        .form-group {
            margin-bottom: 0;
        }

        .btn-block {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div style="background-color: rgb(47,53,63);width: 300px;min-height: 100%;float: left;display: block" id="left1">
    <div id="logo1">
        <img src="/image/login/logo.png" id="img1">
    </div>
    <ul>
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i>商品管理</li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-comments-o">&emsp;</i>查看留言</li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-tags">&emsp;</i>添加分类</li>
        <li class="leftDiv" onclick="choose4()"><i class="fa fa-cog">&emsp;</i>修改密码</li>
    </ul>
</div>

<div style="background-color: rgb(47,53,63);width: 100px;min-height: 100%;float: left;display: none" id="left2">
    <div id="logo2">
        <img src="/image/icon.png" id="img2">
    </div>
    <ul style="width: 100px;font-size: 30px">
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i></li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-comments-o">&emsp;</i></li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-tags">&emsp;</i></li>
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
        <div id="goodsDiv" class="allForm">

        </div>

        <div id="chatDiv" class="allForm" style="display: none">

        </div>

        <div id="categoryDiv" class="allForm row" style="display: none">
            <div class="card col">
                <div class="card-header">一级分类</div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>名称</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody id="typeTableBody">

                        </tbody>
                    </table>
                    <ul class="pagination pagination-sm" id="typeTablePage">

                    </ul>
                </div>
                <div class="card-footer">
                    <div class="form-group">
                        <label for="typeName">分类名称</label>
                        <input type="text" class="form-control" id="typeName">
                    </div>
                    <button type="button" class="btn btn-success btn-block" id="typeName_btn">添加分类</button>
                </div>
            </div>
            <script>
                var typePage = 1;
                var totalTypePage;
                var categoryPage = 1;
                var totalCategoryPage;
                var goodsTypePage = 1;
                var totalGoodsTypePage;

                function selectCount() {
                    $.ajax({
                        url: "/type/selectAllCount",//要请求的服务器url
                        async: false,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            totalTypePage = parseInt(data.typeCount / 6);
                            if (data.typeCount % 6 != 0) {
                                totalTypePage++;
                            }

                            totalCategoryPage = parseInt(data.categoryCount / 6);
                            if (data.categoryCount % 6 != 0) {
                                totalCategoryPage++;
                            }

                            totalGoodsTypePage = parseInt(data.goodsTypeCount / 6);
                            if (data.goodsTypeCount % 6 != 0) {
                                totalGoodsTypePage++;
                            }
                        }
                    });
                }

                function selectType(page) {
                    $.ajax({
                        url: "/type/selectAllType",//要请求的服务器url
                        data: {page: page},
                        async: true,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            $('#typeTableBody').html('');
                            $.each(data, function (index, item) {
                                $('#typeTableBody').append(
                                    "<tr>" +
                                    "<td>" + item.id + "</td>" +
                                    "<td>" + item.name + "</td>" +
                                    "<td><button class='btn btn-danger btn-primary'><a onclick='deleteType(" + item.id + ")'>删除</a></button></td>" +
                                    "</tr>"
                                );
                            });

                            selectCount();

                            $('#typeTablePage').html(
                                '<li class="page-item" onclick="prevPage1()"><a class="page-link">Previous</a></li>' +
                                '<li class="page-item"><a class="page-link" href="#">' + typePage + '/' + totalTypePage + '</a></li>' +
                                '<li class="page-item" onclick="nextPage1()"><a class="page-link">Next</a></li>'
                            );
                        }
                    })
                };

                function deleteType(id) {
                    if (id == 1) {
                        alert('无法删除默认分类，你换个别的删删呗');
                    } else {
                        $.ajax({
                            url: "/type/deleteType",//要请求的服务器url
                            data: {id: id},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                selectType(typePage);
                            }
                        });
                    }
                }

                function prevPage1() {
                    typePage--;
                    if (typePage < 1) {
                        typePage = 1;
                    }
                    selectType(typePage);
                }

                function nextPage1() {
                    typePage++;
                    if (typePage > totalTypePage) {
                        typePage = totalTypePage;
                    }
                    selectType(typePage);
                }

                $("#typeName_btn").click(function () {
                    if ($("#typeName").val() != null || $("#typeName").val() != "") {
                        $.ajax({
                            url: "/type/insertType",//要请求的服务器url
                            data: {type: $("#typeName").val()},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                $("#typeName").val("");
                                selectType(typePage);
                                selectAllType();
                            }
                        });
                    }
                });
            </script>

            <div class="card col">
                <div class="card-header">二级分类</div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>名称</th>
                            <th>所属</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody id="categoryTableBody">

                        </tbody>
                    </table>
                    <ul class="pagination pagination-sm" id="categoryTablePage">

                    </ul>
                </div>
                <div class="card-footer">
                    <label for="sel1">所属一级分类:</label>
                    <select class="form-control" id="sel1">

                    </select>
                    <div class="form-group">
                        <label for="categoryName">分类名称</label>
                        <input type="text" class="form-control" id="categoryName">
                    </div>
                    <button type="button" class="btn btn-success btn-block" id="categoryName_btn">添加分类</button>
                </div>
            </div>
            <script>
                function selectCategory(page) {
                    $.ajax({
                        url: "/type/selectAllCategory",//要请求的服务器url
                        data: {page: page},
                        async: true,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            $('#categoryTableBody').html('');
                            $.each(data, function (index, item) {
                                $('#categoryTableBody').append(
                                    "<tr>" +
                                    "<td>" + item.id + "</td>" +
                                    "<td>" + item.name + "</td>" +
                                    "<td>" + item.typeName + "</td>" +
                                    "<td><button class='btn btn-danger btn-primary'><a onclick='deleteCategory(" + item.id + ")'>删除</a></button></td>" +
                                    "</tr>"
                                );
                            });

                            selectCount();

                            $('#categoryTablePage').html(
                                '<li class="page-item" onclick="prevPage2()"><a class="page-link">Previous</a></li>' +
                                '<li class="page-item"><a class="page-link" href="#">' + categoryPage + '/' + totalCategoryPage + '</a></li>' +
                                '<li class="page-item" onclick="nextPage2()"><a class="page-link">Next</a></li>'
                            );
                        }
                    })
                };

                function deleteCategory(id) {
                    if (id == 1) {
                        alert('无法删除默认分类，你换个别的删删呗');
                    } else {
                        $.ajax({
                            url: "/type/deleteCategory",//要请求的服务器url
                            data: {id: id},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                selectCategory(categoryPage);
                            }
                        });
                    }
                }

                function selectAllType() {
                    $.ajax({
                        url: "/type/selectType",//要请求的服务器url
                        async: true,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            $('#sel1').html('');
                            $.each(data, function (index, item) {
                                $('#sel1').append(
                                    "<option value='" + item.id + "'>"+ item.id + "、" + item.name + "</option>"
                                );
                            });
                        }
                    })
                }

                function prevPage2() {
                    categoryPage--;
                    if (categoryPage < 1) {
                        categoryPage = 1;
                    }
                    selectCategory(categoryPage);
                }

                function nextPage2() {
                    categoryPage++;
                    if (categoryPage > totalCategoryPage) {
                        categoryPage = totalCategoryPage;
                    }
                    selectCategory(categoryPage);
                }

                $("#categoryName_btn").click(function () {
                    if ($("#categoryName").val() != null || $("#categoryName").val() != "") {
                        $.ajax({
                            url: "/type/insertCategory",//要请求的服务器url
                            data: {typeId: $('#sel1 option:selected').val(), category: $("#categoryName").val()},
                            async: true,//是否是异步请求
                            cache: false,//是否缓存结果
                            type: "POST",//请求方式
                            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                                $("#categoryName").val("");
                                selectCategory(categoryPage);
                                selectAllCategory();
                            }
                        });
                    }
                });
            </script>
            <div class="card col">
                <div class="card-header">三级分类</div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>名称</th>
                            <th>所属</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody id="goodsTypeTableBody">

                        </tbody>
                    </table>
                    <ul class="pagination pagination-sm" id="goodsTypeTablePage">

                    </ul>
                </div>
                <div class="card-footer">
                    <label for="sel2">所属二级分类:</label>
                    <select class="form-control" id="sel2">

                    </select>
                    <div class="form-group">
                        <label for="goodsTypeName">分类名称</label>
                        <input type="text" class="form-control" id="goodsTypeName">
                    </div>
                    <button type="button" class="btn btn-success btn-block" id="goodsTypeName_btn">添加分类</button>
                </div>
            </div>
        </div>
        <script>
            function selectGoodsType(page) {
                $.ajax({
                    url: "/type/selectAllGoodsType",//要请求的服务器url
                    data: {page: page},
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $('#goodsTypeTableBody').html('');
                        $.each(data, function (index, item) {
                            $('#goodsTypeTableBody').append(
                                "<tr>" +
                                "<td>" + item.id + "</td>" +
                                "<td>" + item.name + "</td>" +
                                "<td>" + item.categoryName + "</td>" +
                                "<td><button class='btn btn-danger btn-primary'><a onclick='deleteGoodsType(" + item.id + ")'>删除</a></button></td>" +
                                "</tr>"
                            );
                        });

                        selectCount();

                        $('#goodsTypeTablePage').html(
                            '<li class="page-item" onclick="prevPage3()"><a class="page-link">Previous</a></li>' +
                            '<li class="page-item"><a class="page-link" href="#">' + goodsTypePage + '/' + totalGoodsTypePage + '</a></li>' +
                            '<li class="page-item" onclick="nextPage3()"><a class="page-link">Next</a></li>'
                        );
                    }
                })
            };

            function deleteGoodsType(id) {
                if (id == 1) {
                    alert('无法删除默认分类，你换个别的删删呗');
                } else {
                    $.ajax({
                        url: "/type/deleteGoodsType",//要请求的服务器url
                        data: {id: id},
                        async: true,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            selectGoodsType(goodsTypePage);
                        }
                    });
                }
            }

            function selectAllCategory() {
                $.ajax({
                    url: "/type/selectCategory",//要请求的服务器url
                    async: true,//是否是异步请求
                    cache: false,//是否缓存结果
                    type: "POST",//请求方式
                    dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
                    success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                        $('#sel2').html('');
                        $.each(data, function (index, item) {
                            $('#sel2').append(
                                "<option value='" + item.id + "'>" + item.id + "、" + item.name + "</option>"
                            );
                        });
                    }
                })
            }

            function prevPage3() {
                goodsTypePage--;
                if (goodsTypePage < 1) {
                    goodsTypePage = 1;
                }
                selectGoodsType(goodsTypePage);
            }

            function nextPage3() {
                goodsTypePage++;
                if (goodsTypePage > totalGoodsTypePage) {
                    goodsTypePage = totalGoodsTypePage;
                }
                selectGoodsType(goodsTypePage);
            }

            $("#goodsTypeName_btn").click(function () {
                if ($("#goodsTypeName").val() != null || $("#goodsTypeName").val() != "") {
                    $.ajax({
                        url: "/type/insertGoodsType",//要请求的服务器url
                        data: {categoryId: $('#sel2 option:selected').val(), goodsType: $("#goodsTypeName").val()},
                        async: true,//是否是异步请求
                        cache: false,//是否缓存结果
                        type: "POST",//请求方式
                        success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                            $("#goodsTypeName").val("");
                            selectGoodsType(goodsTypePage);
                        }
                    });
                }
            });
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
        $('#goodsDiv').show(500);
    }

    function choose2() {
        $('.allForm').hide(500);
        $('#chatDiv').show(500);
    }

    function choose3() {
        $('.allForm').hide(500);
        $('#categoryDiv').show(500);
        selectType(typePage);
        selectCategory(categoryPage);
        selectGoodsType(goodsTypePage);
        selectAllType();
        selectAllCategory();
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
