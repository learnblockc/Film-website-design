<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/footer.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/buyTickets.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/movieDetail.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/selectSeat.css">
    <script src="../../resources/home/js/header.js" charset="utf-8"></script>
    <script src="../../resources/home/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../../resources/home/layui/css/layui.css" media="all">
    <title>一路有戏电影网</title>
</head>
<body>
<!-- ------------------------------------------------------------------- -->
<!-- 导航栏 -->
<%@include file="../common/header.jsp"%>

<!-- 巨幕 -->
<div class="banner2">
    <div class="wrapper clearfix">
        <div class="cinema-main clearfix">
            <div class="cinema-brief-container" style="margin-top: 10px;">
                <div id="info">
                    <h3 class="name text-ellipsis" style="padding: 10px 0px;">${cinema.name}</h3>
                    <div class="address text-ellipsis" style="padding: 10px 0px;">地址：${cinema.address}</div>
                </div>
                <div class="telphone" style="padding: 10px 0px;">电话：${cinema.phone}</div>
            </div>
        </div>

    </div>
</div>
<!-- 主体 -->
<div class="main" style="margin-bottom: 100px;">
    <div class="main-inner main-bodyz">

        <div class="show-list active" data-index="0">
            <!-- 电影信息 -->
            <div class="movie-info">
                <div>
                    <h3 class="movie-name">${movie.name}</h3>
                    <span class="score sc">${movie.rate}分</span>
                </div>
                <div class="movie-desc">
                <div>
                    <span class="key">时长：</span>
                    <span class="value">${movie.time}</span>
                </div>
                <div>
                    <span class="key">类型 :</span>
                    <span class="value" id="type"></span>
                </div>
                <div>
                    <span class="key">源地 :</span>
                    <span class="value" id="area"></span>
                    </div>
                </div>
            </div>
            <!-- 观影时间 -->
            <div class="show-date" id="date-div">
                <span style="cursor: pointer" class="date-item active" id="time-0" onclick="changeDate('')">全部</span>
                <span style="cursor: pointer" class="date-item" id="time-1" onclick="changeDate(1)"></span>
                <span style="cursor: pointer" class="date-item" id="time-2" onclick="changeDate(2)"></span>
                <span style="cursor: pointer" class="date-item" id="time-3" onclick="changeDate(3)"></span>
                <span style="cursor: pointer" class="date-item" id="time-4" onclick="changeDate(4)"></span>
            </div>

            <!-- 场次列表 -->
            <div class="plist-container active">
                <table class="plist">
                    <thead>
                    <tr>
                        <th>放映时间</th>
                        <th style="padding-left: 79px;">语言版本</th>
                        <th style="padding-left: 87px;">放映厅</th>
                        <th style="padding-left: 84px;">售价(元)</th>
                        <th>选座购票</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="session" items="${sessionList}" varStatus="vs">
                            <tr>
                                <td><span class="begin-time"><fmt:formatDate value="${session.time}" pattern="yyyy-MM-dd HH:mm"/></span><br></td>
                                <td><span class="lang">${session.language}</span></td>
                                <td><span class="hall">${session.hall}</span> </td>
                                <td><span class="sell-price"><span class="stonefont">${session.price}</span> </span> </td>
                                <td><a href="../session/seat?id=${session.id}" class="buy-btn normal">选座购票</a></td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<script>
    window.onload = function(){

        $("#time-1").text(getDate(1)+"(今天)");
        $("#time-2").text(getDate(2)+"(明天)");
        $("#time-3").text(getDate(3)+"(后天)");
        $("#time-4").text(getDate(4));
        $("#type").text(filterMovieType("${movie.type}"));
        $("#area").text(filterMovieArea("${movie.area}"));
        $("#date-div").children("span").removeClass("active");
        $("#time-${time}").addClass("active");
        initHeader();

    };

    function changeDate(time) {
        window.location.href = "detail?cinemaId=${cinema.id}&movieId=${movie.id}&time="+time;
    }

</script>
<style>
</style>
</body>
</html>
