<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="../../resources/home/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resources/home/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="../../resources/home/bootstrap/js/jquery-3.3.1.min.js"></script>
    <script src="../../resources/home/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/header.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/main.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/main2.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/manage.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/footer.css">
    <script src="../../resources/home/js/header.js" charset="utf-8"></script>
    <script src="../../resources/home/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" charset="UTF-8" src="../../resources/home/js/common.js"></script>
    <link rel="stylesheet" href="../../resources/home/layui/css/layui.css" media="all">
    <title>一路有戏电影网</title>
</head>
<body>
<div class="layui-layout layui-layout-admin" style="width:100%">
    <div class="layui-header">
        <div class="layui-logo">一路有戏电影网</div>
        <div class="nav">
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item"><a href="../system/index">首页</a></li>
                <li class="layui-nav-item"><a href="../movie/list">电影分类</a></li>
                <li class="layui-nav-item">
                    <input type="text" placeholder="搜索电影" value="" id="searchMovie" class="layui-input" style="height: 30px;
    padding-left: 12px;
    background-color: #424652;
    background-color: rgba(255,255,255,.05);
    border: none 0;
    color: #fff;
    color: rgba(255,255,255,.5);
    font-size: 12px;">
                </li>
                <li class="layui-nav-item"><a href="javascript:void(0);" onclick="searchMovie()" style="text-decoration:none">搜索</a></li>
            </ul>
        </div>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item  header-li">
                <c:if test="${HOME_USER == null}">
                    <a href="javascript:void(0);"><img src="../../common/file/view_photo?filename=../resources/upload/common/no_image.jpg" class="layui-nav-img"></a>
                    <dl class="layui-nav-child nav-image">
                        <dd><a href="../user/login">登录/注册</a></dd>
                    </dl>
                </c:if>
                <c:if test="${HOME_USER != null}">
                    <a href="javascript:void(0);" ><img src="../../common/file/view_photo?filename=${HOME_USER.headPic}" class="layui-nav-img"></a>
                    <dl class="layui-nav-child nav-image">
                        <dd><a href="javascript:void(0);" onclick="toMyOrder()">我的订单</a></dd>
                        <hr/>
                        <dd><a href="javascript:void(0);" onclick="toUserInfo()">基本信息</a></dd>
                        <hr/>
                        <dd><a style="text-decoration: none; cursor: pointer;" href="javascript:void(0);" onclick="logout();">注销</a></dd>
                        <hr/>
                    </dl>
                </c:if>
            </li>
        </ul>
    </div>
</div>


<script>
    function toMyOrder() {
        localStorage.setItem("usercardId", 0);
        window.location.href = "../user/center";
    }
    function toUserInfo() {
        localStorage.setItem("usercardId", 1);
        window.location.href = "../user/center";
    }
    function logout() {
        $.ajax({
            url:'../user/logout',
            dataType:'json',
            type:'post',
            data:{},
            success:function(result){
                if(result.code === 0){
                    layer.alert(result.msg, {icon: 6}, function () {
                        window.location.href = "../system/index";
                    });
                }
            },
            error:function () {
                layer.alert('网络错误！', {icon: 5});
            }
        });
    }
    function searchMovie() {
        let value = $("#searchMovie").val();
        window.location.href = '../movie/list?name='+value;
    }
</script>
</body>
</html>
