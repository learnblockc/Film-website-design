<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="icon" type="image/x-icon" href="../../resources/home/images/logo.ico"/>
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/header.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/pay.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/footer.css">
    <script src="../../resources/home/js/header.js" charset="utf-8"></script>
    <script src="../../resources/home/js/Api.js"></script>
    <script src="../../resources/home/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../../resources/home/layui/css/layui.css" media="all">
    <title>一路有戏电影网</title>
</head>
<body>
<!-- ------------------------------------------------------------------- -->
<!-- 导航栏 -->
<%@include file="../common/header.jsp"%>

<!-- 主体 -->
<div class="container" style="height: 400px; margin-top: 150px;">

    <p class="warning">
        请仔细核对订单信息，出票后将<span class="attention">无法退票和改签</span>
    </p>

    <table class="order-table">
        <thead>
        <tr>
            <th>影片</th>
            <th>时间</th>
            <th>影院</th>
            <th>座位</th>
        </tr>
        </thead>
        <tbody>
        <!-- 信息表 -->
            <tr>
                <td class="movie-name">${order.movieName}</td>
                <td class="showtime"><fmt:formatDate value="${order.sessionTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td class="cinema-name">${order.cinemaName}</td>
                <td><span class="hall" style="margin-top: 3px;">${order.sessionHall}</span>
                    <div class="seats">
                        <div class="choiceseat" style="display: block;">
                            <c:forEach var="item" items="${order.orderItemList}" varStatus="vs">
                                <span class="border" style="font-size: 15px;">${item.row}排${item.col}列</span>
                            </c:forEach>
                        </div>
                    </div>
                </td>
            <tr>
        </tbody>
    </table>

    <div class="right">
        <div class="price-wrapper">
            <span>实际支付：</span>
            <span class="price">${order.totalPrice}</span>
        </div>
        <div>
            <div class="pay-btn" onclick="pay()">确认支付</div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<!-- ------------------------------------------------------------------- -->
<script>
    var clientHeight = document.documentElement.clientHeight;
    var layer;
    window.onload = function(){
        initHeader();
        layui.use('layer', function(){
            layer = layui.layer;
        });
    };

    function pay() {
        $.ajax({
            url:'pay',
            dataType:'json',
            type:'post',
            data:{id: "${order.id}"},
            success:function(result){
                if(result.code === 0){
                    layer.alert(result.msg, {icon: 6}, function () {
                        localStorage.setItem("usercardId", 0);
                        window.location.href = '../user/center';
                    });
                }else {
                    layer.alert(result.msg, {icon: 5});
                }
            },
            error:function () {
                layer.alert('网络错误！', {icon: 5});
            }
        });
    }

</script>
<!-- ------------------------------------------------------------------- -->
</body>
</html>
