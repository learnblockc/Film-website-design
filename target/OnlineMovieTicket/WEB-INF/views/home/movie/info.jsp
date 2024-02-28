<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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


<!-- 巨幕 -->
<div class="banner2">
    <div class="wrapper clearfix">
        <div class="celeInfo-left">
            <div class="avatar-shadow">
                <img class="avatar" style="width: 245px;" src="../../common/file/view_photo?filename=${movie.photo}" />
            </div>
        </div>

        <div class="celeInfo-right clearfix">

            <div class="movie-brief-container">
                <h3 class="name">${movie.name}</h3>
                <ul>
                    <li class="ellipsis" id="type"></li>
                    <li class="ellipsis">${movie.time}分钟 / <span id="area"></span></li>
                    <li class="ellipsis" id="createTime"></li>
                </ul>
            </div>

            <div class="action-buyBtn">
                <div class="action clearfix" data-val="{movieid:42964}">
                    <a class="score-btn " data-bid="b_rxxpcgwd" onclick="rateMovie()">
                        <div>
                            <i class="icon score-btn-icon"></i>
                            <span class="score-btn-msg" data-act="comment-open-click">评分</span>
                        </div>
                    </a>
                </div>

                <a class="btn buy" href="detail?id=${movie.id}" data-act="more-detail-click">查看更多电影详情</a>
            </div>

            <div class="movie-stats-container">
                <div class="movie-index">
                    <p class="movie-index-title">用户评分</p>
                    <div class="movie-index-content score normal-score">
                        <span class="index-left info-num " style="padding-left: 17px;">
                            <span class="stonefont">${movie.rate}</span>
                        </span>
                        <div class="index-right" style="margin-left: 100px;">
                            <div class="star-wrapper">
                                <div id="MovieScore"></div>
                            </div>
                            <span class="score-num">
                                    <span class="stonefont">${movie.rateCount}</span>人评分
                            </span>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

<!-- 占位符 -->
<div style="margin-top: 50px;"></div>

<!-- 主体 -->
<div class="main">
    <div class="main-inner main-buyticket">
        <!-- 标签 -->
        <div class="tags-panel">
            <ul class="tags-lines">
                <li class="tags-line">
                    <div class="tags-title">日期:</div>
                    <ul class="tags tags-date" id="date-ul">
                        <li class="active" id="time-0"><a href="info?id=${movie.id}">全部</a></li>
                        <li id="time-1"><a href="info?id=${movie.id}&time=1" id="day-1"></a></li>
                        <li id="time-2"><a href="info?id=${movie.id}&time=2" id="day-2"></a></li>
                        <li id="time-3"><a href="info?id=${movie.id}&time=3" id="day-3"></a></li>
                        <li id="time-4"><a href="info?id=${movie.id}&time=4" id="day-4"></a></li>
                    </ul>
                </li>

            </ul>
        </div>
        <!-- 列表 -->
        <div class="cinemas-list" style="margin-bottom: 50px;">
            <h2 class="cinemas-list-header">影院列表</h2>

                <c:forEach var="cinema" items="${cinemaList}" varStatus="vs">
                    <div class="cinema-cell">
                        <div class="cinema-info">
                            <a class="cinema-name">${cinema.name}</a>
                            <p class="cinema-address">地址：${cinema.address}</p>
                        </div>
                        <div class="buy-btn">
                            <a href="../cinema/detail?cinemaId=${cinema.id}&movieId=${movie.id}">选座购票</a>
                        </div>
                    </div>
                </c:forEach>

        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<script>
    var clientHeight = document.documentElement.clientHeight;
    var rateHtml;
    var CinemaLength;
    window.onload = function(){
        initHeader();
        initHtml(); //HTML
        layui.use('rate', function(){
            var rate = layui.rate;
            rate.render({
                elem: '#MovieScore'
                ,value: (parseInt("${movie.rate}")/2)
                ,half: true
                ,readonly: true
            })
        });
        $("#type").text(filterMovieType("${movie.type}"));
        $("#area").text(filterMovieArea("${movie.area}"));
        $("#createTime").text(formatYMD("${movie.createTime}"));
        $("#day-1").text(getDate(1)+"(今天)");
        $("#day-2").text(getDate(2)+"(明天)");
        $("#day-3").text(getDate(3)+"(后天)");
        $("#day-4").text(getDate(4));
        $("#date-ul").children("li").removeClass("active");
        $("#time-${time}").addClass("active");
    };

    //初始化HTML
    function initHtml(){
        rateHtml =
            "<h3 class=\"commenttitle\">评分</h3>" +
            "<div style=\"text-align:center; margin:30px 0;\">" +
            "<div id=\"GiveScore\"></div>" +
            "<p style=\"color:#888;\">点击星星进行评分</p>" +
            "</div>"
        ;
    }

    //评分
    function rateMovie(){
        layui.use(['rate','laypage', 'layer', 'table'], function(){
            var layer = layui.layer;
            var rate = layui.rate;
            //写评论
            layer.open({
                type: 1
                ,title: "评分" //不显示标题栏
                ,closeBtn: false
                ,area: '430px;'
                ,shade: 0.8
                ,offset: clientHeight/20
                ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                ,btn: ['确认评分', '取消']
                ,yes: function(){
                    var score = $('#GiveScore span').text().replace("分",'');
                    $.ajax({
                        url:'../rate/rate',
                        dataType:'json',
                        type:'post',
                        data:{movieId: "${movie.id}", score: score},
                        success:function(result){
                            if(result.code === 0){
                                layer.alert(result.msg, {icon: 6}, function () {
                                    window.location.reload();
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
                ,btnAlign: 'c movie-last'
                ,moveType: 0 //拖拽模式，0或者1
                ,content: rateHtml
                ,success: function(layero){
                    rate.render({
                        elem: '#GiveScore'
                        ,value: 0
                        ,half: true
                        ,text: true
                        ,setText: function(value){
                            this.span.text(value * 2 + "分");
                        }
                    })
                }
            });
        });
    }



</script>

</body>
</html>
