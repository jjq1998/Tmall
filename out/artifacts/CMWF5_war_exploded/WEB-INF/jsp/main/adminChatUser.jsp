<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/20
  Time: 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>你没事跟人撩什么骚</title>
    <link rel="icon" href="/image/icon.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script charset="utf-8" src="/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="/kindeditor/lang/zh-CN.js"></script>
    <script type="text/javascript">
        var editor;　　//全局变量
        KindEditor.ready(function (K) {
            editor = K.create('#kindedito', {
                height: '240px',
                width: '100%',
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
        #chatDiv {
            height: 70%;
            width: 100%;
            background-color: white;
        }

        #chat_btn {
            float: right;
            width: 100px;
        }
    </style>
</head>
<body>
<div id="chatDiv">
<c:forEach items="${chatList}" var="chat">
    <c:if test="${chat.sender == '用户'}" var="result">
        <div class="container-fluid">
            <div class="container" style="float: right; color: black; background-color: greenyellow">
                <span>${chat.user}</span>
                <span>${chat.content}</span>
            </div>
        </div>
    </c:if>
    <c:if test="${result}">
        <div class="container-fluid">
            <div class="container" style="float: left; color: black; background-color: white">
                <span>${chat.admin}</span>
                <span>${chat.content}</span>
            </div>
        </div>
    </c:if>
</c:forEach>
</div>
<textarea name="content" id="kindedito"></textarea>
<button type="button" class="btn btn-outline-success" id="chat_btn">发送</button>
<script>
    $("#chat_btn").click(function () {
        $.ajax({
            url: "/chat/getUnreadChatCount",//要请求的服务器url
            data: {id:${user.id}},//一个对象，表示请求参数，有两个参数 method val  method表示交给Servlet中的什么方法处理，不写默认为doGet或者doPost
            async: true,//是否是异步请求
            cache: false,//是否缓存结果
            type: "POST",//请求方式
        });
    });
</script>
</body>
</html>
