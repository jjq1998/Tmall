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
    </style>
</head>
<body>
<div style="background-color: rgb(47,53,63);width: 300px;min-height: 100%;float: left;display: block" id="left1">
    <div id="logo1">
        <img src="/image/login/logo.png" id="img1">
    </div>
    <ul>
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i>注册管理员</li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-list">&emsp;</i>查看日志</li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-cog">&emsp;</i>修改密码</li>
    </ul>
</div>

<div style="background-color: rgb(47,53,63);width: 100px;min-height: 100%;float: left;display: none" id="left2">
    <div id="logo2">
        <img src="/image/icon.png" id="img2">
    </div>
    <ul style="width: 100px;font-size: 30px">
        <li class="leftDiv choose" onclick="choose1()"><i class="fa fa-home">&emsp;</i></li>
        <li class="leftDiv" onclick="choose2()"><i class="fa fa-list">&emsp;</i></li>
        <li class="leftDiv" onclick="choose3()"><i class="fa fa-cog">&emsp;</i></li>
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
        <div id="registerPage" class="allForm">
            <form action="/admin/insertAdmin" method="post">
                <h5 id="title">注册<span id="prompt">${error}</span></h5>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-user-o"></i></span>
                    </div>
                    <input type="text" class="form-control" placeholder="请输入用户名" id="registerName" name="name">
                </div>
                <div class="input-group mb-3" data-toggle="tooltip"
                     title="密码为6-18位，不包含特殊字符和汉字，必须含有字母/数字/下划线">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" placeholder="请输入密码" id="registerPassword1"
                           name="password">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    </div>
                    <input type="password" class="form-control" placeholder="请确认密码" id="registerPassword2">
                </div>
                <div class="input-group mb-3">
                    <label for="permission">权限：</label><select id="permission" name="permission"
                                                               class="custom-select-sm">
                    <option value="super_admin">超级管理员</option>
                    <option value="shop_admin">店铺管理员</option>
                    <option value="customer_admin">用户管理员</option>
                </select>
                </div>

                <button type="submit" id="register_submit" class="btn btn-danger btn-primary"
                        onclick="return registerCheck()">注册
                </button>
            </form>
            <table id="adminTable" class="table table-striped">
                <thead>
                <tr>
                    <th width=\"100px\">管理员ID</th>
                    <th width=\"200px\">管理员账号</th>
                    <th width=\"200px\">管理员密码</th>
                    <th width=\"120px\">管理员权限</th>
                    <th width=\"100px\">操作</th>
                </tr>
                </thead>
                <tbody id="adminTableBody">

                </tbody>
            </table>
            <ul class="pagination" id="adminPage">

            </ul>
        </div>

        <div class="allForm" id="adminLog" style="display: none">
            <table id="adminLogTable" class="table table-striped">
                <thead>
                <tr>
                    <th width='100px'>管理员</th>
                    <th width='100px'>操作</th>
                    <th width='200px'>时间</th>
                </tr>
                </thead>
                <tbody id="adminLogTableBody">

                </tbody>
            </table>
            <ul class="pagination" id="adminLogPage">

            </ul>
        </div>

        <div class="allForm" id="updatePassword" style="display: none">
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
    var adminPage = 1;
    var totalAdminPage;
    var adminLogPage = 1;
    var totalAdminLogPage;

    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });

    $(document).ready(function () {
        selectAdmin(adminPage);
    });

    function prevPage1() {
        adminPage--;
        if (adminPage < 1) {
            adminPage = 1;
        }
        selectAdmin(adminPage);
    }

    function nextPage1() {
        adminPage++;
        if (adminPage > totalAdminPage) {
            adminPage = totalAdminPage;
        }
        selectAdmin(adminPage);
    }

    function prevPage2() {
        adminLogPage--;
        if (adminLogPage < 1) {
            adminLogPage = 1;
        }
        selectAdminLog(adminLogPage);
    }

    function nextPage2() {
        adminLogPage++;
        if (adminLogPage > totalAdminLogPage) {
            adminLogPage = totalAdminLogPage;
        }
        selectAdminLog(adminLogPage);
    }

    function selectCount() {
        $.ajax({
            url: "/admin/selectAllCount",//要请求的服务器url
            async: false,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                totalAdminPage = parseInt(data.adminCount / 10);
                if (data.adminCount % 10 != 0) {
                    totalAdminPage++;
                }

                totalAdminLogPage = parseInt(data.adminLogCount / 10);
                if (data.adminLogCount % 10 != 0) {
                    totalAdminLogPage++;
                }
            }
        });
    }

    function selectAdmin(page) {
        $.ajax({
            url: "/admin/selectAllAdmin",//要请求的服务器url
            data: {page: page},
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                $('#adminTableBody').html('');
                $.each(data, function (index, item) {
                    $('#adminTableBody').append(
                        "<tr>" +
                        "<td>" + item.id + "</td>" +
                        "<td>" + item.name + "</td>" +
                        "<td>" + item.password + "</td>" +
                        "<td>" + item.permission + "</td>" +
                        "<td>" +
                        "<button class='btn btn-danger btn-primary deleteButton'>" +
                        "<a class='deleteAdmin' href = \"/admin/deleteAdmin?id=" + item.id + "\"> 删除 </a>" +
                        "</button>" +
                        "</td>" +
                        "</tr>"
                    );
                });

                selectCount();

                $('#adminPage').html(
                    '<li class="page-item" onclick="prevPage1()"><a class="page-link" id="prevPage1">Previous</a></li>' +
                    '<li class="page-item"><a class="page-link" href="#">' + adminPage + '/' + totalAdminPage + '</a></li>' +
                    '<li class="page-item" onclick="nextPage1()"><a class="page-link" id="nextPage1">Next</a></li>'
                );
            }
        })
    };

    function selectAdminLog(page) {
        $.ajax({
            url: "/admin/selectAllAdminLog",//要请求的服务器url
            data: {page: page},
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                $('#adminLogTableBody').html('');
                $.each(data, function (index, item) {
                    $('#adminLogTableBody').append(
                        "<tr>" +
                        "<td>" + item.admin.name + "</td>" +
                        "<td>" + item.action + "</td>" +
                        "<td>" + new Date(item.time).toLocaleString() + "</td>" +
                        "</tr>"
                    );
                });

                selectCount();

                $('#adminLogPage').html(
                    '<li class="page-item" onclick="prevPage2()"><a class="page-link" id="prevPage2">Previous</a></li>' +
                    '<li class="page-item"><a class="page-link" href="#">' + adminLogPage + '/' + totalAdminLogPage + '</a></li>' +
                    '<li class="page-item" onclick="nextPage2()"><a class="page-link" id="nextPage2">Next</a></li>'
                );
            }
        })
    };

    $("#registerName").blur(function () {//失去焦点时执行
        var value = $("#registerName").val();
        $.ajax({
            url: "/admin/selectAdminName",//要请求的服务器url
            data: {name: value},//一个对象，表示请求参数，有两个参数 method val  method表示交给Servlet中的什么方法处理，不写默认为doGet或者doPost
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
            dataType: "json",//服务器返回什么类型数据 text xml javascript json(javascript对象)
            success: function (data) {//函数会在服务器执行成功后执行，result就是服务器返回结果
                var str = data.result;
                if ("true" === str) {
                    $('#prompt').html('<i class="fa fa-minus-circle"></i>&nbsp;用户名已存在');
                } else {
                    $('#prompt').html('<i class="fa fa-check-circle" style="color: greenyellow"></i>&nbsp;<span style="color: greenyellow">可以使用</span>');
                }
            }
        });
    });

    function registerCheck() {
        var partern = /^(\w){6,18}$/;
        if ("" === $("#registerName").val()) {
            $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入用户名');
            return false;
        }
        if ("" === $("#registerPassword1").val()) {
            $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请输入密码');
            return false;
        }
        if ($("#registerPassword1").val() !== $("#registerPassword2").val()) {
            $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请再次确认密码');
            return false;
        }
        if (!partern.test($("#registerPassword1").val())) {
            $("#prompt").html('<i class="fa fa-minus-circle"></i>&nbsp;请确认密码格式');
            return false;
        }
        else {
            return true;
        }
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

    function choose1() {
        $('.allForm').hide(500);
        $('#registerPage').show(500);
        selectAdmin(1);
    }

    function choose2() {
        $('.allForm').hide(500);
        $('#adminLog').show(500);
        selectAdminLog(1)
    }

    function choose3() {
        $('.allForm').hide(500);
        $('#updatePassword').show(500);
    }
</script>
</body>
</html>
