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
                <!-- 图片 -->
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
    <div class="main-inner main-detail">
        <div class="main-content">
            <div class="tab-container">
                <div class="tab-title-container clearfix">
                    <div class="tab-title active" data-act="tab-desc-click">介绍</div>
                </div>

                <div class="tab-content-container">
                    <div class="tab-desc tab-content active" data-val="{tabtype:'desc'}">
                        <!-- 剧情简介 -->
                        <div class="module introduction" style="margin-bottom: 20px;">
                            <div class="mod-title">
                                <h3>剧情简介</h3>
                            </div>
                            <div class="mod-content">
                                ${movie.info}
                            </div>
                        </div>
                        <!-- 演职人员 -->
                        <div class="module staringPeople" style="margin-bottom: 20px;">
                            <div class="mod-title">
                                <h3>演职人员</h3>
                            </div>
                            <div class="mod-content">
                                <div class="celebrity-container clearfix">
                                    <div class="celebrity-group" style="float:none;">
                                        <div class="celebrity-type">导演：
                                            <c:forEach var="actor" items="${actorList}" varStatus="vs">
                                                <c:if test="${actor.type == 1}">
                                                    ${actor.name}&nbsp;&nbsp;
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="celebrity-group" style="float:none;margin-left:0px;">
                                        <div class="celebrity-type">
                                          演职人员：
                                            <c:forEach var="actor" items="${actorList}" varStatus="vs">
                                                <c:if test="${actor.type == 2}">
                                                    ${actor.name}&nbsp;&nbsp;
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 评论 -->
                        <div class="module">
                            <div class="mod-title">
                                <h3>热门短评</h3>
                            </div>
                            <div class="mod-content">
                                <div class="comment-list-container" data-hot="10">
                                    <ul>

                                        <c:forEach var="comment" items="${commentList}" varStatus="vs">
                                            <li class="comment-container">
                                                <div class="portrait-container">
                                                    <div class="portrait">
                                                        <img src="../../common/file/view_photo?filename=${comment.user.headPic}" />
                                                    </div>
                                                    <i class="level-4-icon"></i>
                                                </div>
                                                <div class="main2">
                                                    <div class="main2-header clearfix">
                                                        <div class="user">
                                                            <span class="name">${comment.user.username}</span>
                                                        </div>
                                                        <div class="time">
                                                            <span><fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                                        </div>
                                                        <div class="approve" data-id="1044884745">
                                                        </div>
                                                    </div>
                                                    <div class="comment-content">
                                                        ${comment.content}
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>

                                    </ul>
                                </div>
                                <a class="comment-entry" data-act="comment-no-content-click" onclick="writeComment()">写短评</a>
                            </div>
                            <div id="demo0"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<!-- ------------------------------------------------------------------- -->
<script>
    var clientHeight = document.documentElement.clientHeight;
    var RateMovieHtml = "";
    var WriteCommentHtml = "";

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
    };

    //初始化HTML
    function initHtml(){
        RateMovieHtml =
            "<h3 class=\"commenttitle\">评分</h3>" +
            "<div style=\"text-align:center; margin:30px 0;\">" +
            "<div id=\"GiveScore\"></div>" +
            "<p style=\"color:#888;\">点击星星进行评分</p>" +
            "</div>";

        WriteCommentHtml =
            "<h3 class=\"commenttitle\">评论信息</h3>" +
            "<div class=\"layui-form-item\">" +
            "<label class=\"layui-form-label commentcontenttext\">评论内容</label>" +
            "<div class=\"layui-input-block commentcontent\">" +
            "<textarea id=\"comment_content_write\" style=\"height:150px;\" placeholder=\"请输入评论内容\" autocomplete=\"off\" class=\"layui-textarea\" name=\"desc\" class=\"layui-input\"></textarea>" +
            "</div>" +
            "</div>"
        ;
    }

    function writeComment(){
        layui.use(['rate','laypage', 'layer', 'table'], function(){
            var layer = layui.layer;
            //写评论
            layer.open({
                type: 1
                ,title: "编写评论"
                ,closeBtn: false
                ,area: '430px;'
                ,shade: 0.8
                ,offset: clientHeight/20
                ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                ,btn: ['发表评论', '取消']
                ,yes: function(){
                    let content = $("#comment_content_write").val()
                    $.ajax({
                        url:'../comment/add',
                        dataType:'json',
                        type:'post',
                        data:{movieId: "${movie.id}", content: content},
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
                ,content: WriteCommentHtml
                ,success: function(layero){

                }
            });
        });
    }


    //评分
    function rateMovie(){
        layui.use(['rate','laypage', 'layer', 'table'], function(){
            var layer = layui.layer;
            var rate = layui.rate;
            //写评论
            layer.open({
                type: 1
                ,title: "评分"
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
                ,content: RateMovieHtml
                ,success: function(layero){
                    rate.render({
                        elem: '#GiveScore'
                        ,value: 0
                        ,half: true
                        ,text: true
                        ,setText: function(value){
                            this.span.text(value*2+"分");
                        }
                    })
                }
            });
        });
    }






</script>

</body>
</html>
