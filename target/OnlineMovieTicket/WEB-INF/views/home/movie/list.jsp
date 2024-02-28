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
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/main.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/movieList.css">
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


<!-- 占位符 -->
<!-- <div style="margin-top: 80px;"></div> -->


<!-- 主体 -->
<div class="main">
    <div class="main-Tagsz main-inner movieList">
        <div class="movies-channel">
            <div class="tags-panel">
                <ul class="tags-lines">
                    <input type="hidden" id="movie-type" value="0" />
                    <input type="hidden" id="movie-area" value="0" />
                    <input type="hidden" id="movie-time" value="0" />
                    <input type="hidden" id="movie-name" value="" />
                    <li class="tags-line">
                        <div class="tags-title">类型 :</div>
                        <ul class="tags tags-type" id="type-ul">
                            <li class="active" id="type-0"><a href="javascript:void(0)" onclick="listMovieByType(0)">全部</a></li>
                            <li id="type-1"><a href="javascript:void(0)" onclick="listMovieByType(1)">爱情</a></li>
                            <li id="type-2"><a href="javascript:void(0)" onclick="listMovieByType(2)">动作</a></li>
                            <li id="type-3"><a href="javascript:void(0)" onclick="listMovieByType(3)">喜剧</a></li>
                            <li id="type-4"><a href="javascript:void(0)" onclick="listMovieByType(4)">剧情</a></li>
                            <li id="type-5"><a href="javascript:void(0)" onclick="listMovieByType(5)">战争</a></li>
                            <li id="type-6"><a href="javascript:void(0)" onclick="listMovieByType(6)">惊悚</a></li>
                            <li id="type-7"><a href="javascript:void(0)" onclick="listMovieByType(7)">科幻</a></li>
                            <li id="type-8"><a href="javascript:void(0)" onclick="listMovieByType(8)">悬疑</a></li>
                            <li id="type-9"><a href="javascript:void(0)" onclick="listMovieByType(9)">犯罪</a></li>
                            <li id="type-10"><a href="javascript:void(0)" onclick="listMovieByType(10)">冒险</a></li>
                            <li id="type-11"><a href="javascript:void(0)" onclick="listMovieByType(11)">家庭</a></li>
                            <li id="type-12"><a href="javascript:void(0)" onclick="listMovieByType(12)">古装</a></li>
                            <li id="type-13"><a href="javascript:void(0)" onclick="listMovieByType(13)">动画</a></li>
                        </ul>
                    </li>
                    <li class="tags-line tags-line-border">
                        <div class="tags-title">区域 :</div>
                        <ul class="tags tags-area" id="area-ul">
                            <li class="active" id="area-0"><a href="javascript:void(0)" onclick="listMovieByArea(0)">全部</a></li>
                            <li id="area-1"><a href="javascript:void(0)" onclick="listMovieByArea(1)">中国大陆</a></li>
                            <li id="area-2"><a href="javascript:void(0)" onclick="listMovieByArea(2)">美国</a></li>
                            <li id="area-3"><a href="javascript:void(0)" onclick="listMovieByArea(3)">韩国</a></li>
                            <li id="area-4"><a href="javascript:void(0)" onclick="listMovieByArea(4)">日本</a></li>
                            <li id="area-5"><a href="javascript:void(0)" onclick="listMovieByArea(5)">中国香港</a></li>
                            <li id="area-6"><a href="javascript:void(0)" onclick="listMovieByArea(6)">德国</a></li>
                            <li id="area-7"><a href="javascript:void(0)" onclick="listMovieByArea(7)">印度</a></li>
                            <li id="area-8"><a href="javascript:void(0)" onclick="listMovieByArea(8)">英国</a></li>
                            <li id="area-9"><a href="javascript:void(0)" onclick="listMovieByArea(9)">法国</a></li>
                            <li id="area-10"><a href="javascript:void(0)" onclick="listMovieByArea(10)">俄罗斯</a></li>
                            <li id="area-11"><a href="javascript:void(0)" onclick="listMovieByArea(11)">意大利</a></li>
                        </ul>
                    </li>
                    <li class="tags-line tags-line-border">
                        <div class="tags-title">年代 :</div>
                        <ul class="tags tags-year" id="time-ul">
                            <li class="active" id="time-0"><a href="javascript:void(0)" onclick="listMovieByTime(0)">全部</a></li>
                            <li id="time-1"><a href="javascript:void(0)" onclick="listMovieByTime(1)">2023</a></li>
                            <li id="time-2"><a href="javascript:void(0)" onclick="listMovieByTime(2)">2022</a></li>
                            <li id="time-3"><a href="javascript:void(0)" onclick="listMovieByTime(3)">2021</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

        <div class="movies-panel">
            <div class="movies-sorter">
                <div class="cat-sorter">
                    <input type="hidden" id="movie-sort" value="0" />
                    <ul>
                        <li>
                            <span class="sort-control-group" data-act="sort-click" onclick="sortMovieList(0)">
                                <span id="sort-0" class="sort-control sort-radio sort-radio-checked"></span>
                                <span class="sort-control-label">默认</span>
                            </span>
                        </li>
                        <li>
                            <span class="sort-control-group" data-act="sort-click" onclick="sortMovieList(1)">
                                <span id="sort-1" class="sort-control sort-radio"></span>
                                <span class="sort-control-label">按时间排序</span>
                            </span>
                        </li>
                        <li>
                            <span class="sort-control-group" data-act="sort-click" onclick="sortMovieList(2)">
                                <span id="sort-2" class="sort-control sort-radio"></span>
                                <span class="sort-control-label">按评分排序</span>
                            </span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="movies-list" style="height:1000px">
                <ul class="movie-list">

                    <c:forEach var="movie" items="${movieList}" varStatus="vs">
                        <li style="height: 288px;">
                            <div class="movie-item" style="height: 220px;">
                                <a href="../movie/info?id=${movie.id}">
                                    <div class="movie-poster">
                                        <img src="../../common/file/view_photo?filename=${movie.photo}" />
                                    </div>
                                </a>
                            </div>
                            <div class="channel-detail movie-item-title" title="">
                                <a href="">${movie.name}</a>
                            </div>
                            <div class="channel-detail channel-detail-orange"> <i class="integer">${movie.rate}分</i> </div>
                        </li>
                    </c:forEach>

                </ul>
            </div>
            <div id="pagination">
                <ul class="pagination">

                </ul>

            </div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<!-- ------------------------------------------------------------------- -->
<script>
    var clientWidth = document.documentElement.clientWidth;
    window.onload = function(){
        initHeader();
        initClass(); //布局
        initPage();
        $("#movie-type").val("${movieListSearch.type}");
        $("#type-ul").children("li").removeClass("active");
        $("#type-"+"${movieListSearch.type}").addClass("active");
        <!-- -------------------------->
        $("#movie-area").val("${movieListSearch.area}");
        $("#area-ul").children("li").removeClass("active");
        $("#area-"+"${movieListSearch.area}").addClass("active");
        <!-- -------------------------->
        $("#movie-time").val("${movieListSearch.time}");
        $("#time-ul").children("li").removeClass("active");
        $("#time-"+"${movieListSearch.time}").addClass("active");
        <!-- -------------------------->
        $("#movie-sort").val("${movieListSearch.sort}");
        $(".sort-radio").removeClass("sort-radio-checked");
        $("#sort-"+${movieListSearch.sort}).addClass("sort-radio-checked");
        <!-- -------------------------->
        $("#movie-name").val("${movieListSearch.name}");
        $("#searchMovie").val("${movieListSearch.name}");
    };

    // 初始化分页
    function initPage() {
        $("#pagination").children('ul').remove();
        let html = '<ul class="pagination">';
        if(parseInt("${page.page}")  === 1){
            html += '<li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>';
        } else {
            let prePage = parseInt("${page.page}") - 1;
            html += '<li><a onclick="changePage('+prePage+')" href="javascript:void(0)">&laquo;</a></li>';
        }
        if(parseInt("${page.page}") - 2 > 0){
            let prePage = parseInt("${page.page}") - 2;
            html += '<li id="'+prePage+'"><a href="javascript:void(0)" onclick="changePage('+prePage+')">'+prePage+'</a></li>'
        }
        if(parseInt("${page.page}") - 1 > 0){
            let prePage = parseInt("${page.page}") - 1;
            html += '<li id="'+prePage+'"><a href="javascript:void(0)" onclick="changePage('+prePage+')">'+prePage+'</a></li>'
        }
        html += '<li class="active" id="'+ parseInt("${page.page}") +'"><a href="javascript:void(0)">'+ parseInt("${page.page}") +'</a></li>';
        if(parseInt("${page.page}") + 1 <= parseInt("${page.totalPage}")){
            let nextPage = parseInt("${page.page}") + 1;
            html += '<li id="'+nextPage+'"><a href="javascript:void(0)" onclick="changePage('+nextPage+')">'+nextPage+'</a></li>'
        }
        if(parseInt("${page.page}") + 2 <= parseInt("${page.totalPage}")){
            let nextPage = parseInt("${page.page}") + 2;
            html += '<li id="'+nextPage+'"><a href="javascript:void(0)" onclick="changePage('+nextPage+')">'+nextPage+'</a></li>'
        }
        if(parseInt("${page.page}") === parseInt("${page.totalPage}")){
            html += '<li class="disabled"><a href="javascript:void(0)">&raquo;</a></li>';
        } else {
            let nextPage = parseInt("${page.page}") + 1;
            html += '<li><a href="javascript:void(0)" onclick="changePage('+nextPage+')">&raquo;</a></li>';
        }
        html += '</ul>';
        $("#pagination").html(html);
    }

    function changePage(page) {
        window.location.href = "../movie/list?type="+$("#movie-type").val()+"&area="+$("#movie-area").val()+
            "&time="+$("#movie-time").val()+"&sort="+$("#movie-sort").val()+"&name="+$("#movie-name").val()+"&page=" + page;
    }

    //初始化布局
    function initClass(){
        mainTagsz = $(".main-Tagsz")[0];
        mainTagsz.style.cssText = "width:1170px !important; margin: 0 0 0 " + (clientWidth - 1170)/2 + " !important;";
    }

    function listMovieByType(val) {
        $("#type-ul").children("li").removeClass("active")
        $("#type-"+val).addClass("active");
        $("#movie-type").val(val);
        window.location.href = "../movie/list?type="+$("#movie-type").val()+"&area="+$("#movie-area").val()+
            "&time="+$("#movie-time").val()+"&sort="+$("#movie-sort").val()+"&name="+$("#movie-name").val()+"&page=1";
    }

    function listMovieByArea(val) {
        $("#area-ul").children("li").removeClass("active")
        $("#area-"+val).addClass("active");
        $("#movie-area").val(val);
        window.location.href = "../movie/list?type="+$("#movie-type").val()+"&area="+$("#movie-area").val()+
            "&time="+$("#movie-time").val()+"&sort="+$("#movie-sort").val()+"&name="+$("#movie-name").val()+"&page=1";
    }

    function listMovieByTime(val) {
        $("#time-ul").children("li").removeClass("active")
        $("#time-"+val).addClass("active");
        $("#movie-time").val(val);
        window.location.href = "../movie/list?type="+$("#movie-type").val()+"&area="+$("#movie-area").val()+
            "&time="+$("#movie-time").val()+"&sort="+$("#movie-sort").val()+"&name="+$("#movie-name").val()+"&page=1";
    }

    function sortMovieList(val) {
        $(".sort-radio").removeClass("sort-radio-checked");
        $("#sort-"+val).addClass("sort-radio-checked");
        $("#movie-sort").val(val);
        window.location.href = "../movie/list?type="+$("#movie-type").val()+"&area="+$("#movie-area").val()+
            "&time="+$("#movie-time").val()+"&sort="+$("#movie-sort").val()+"&name="+$("#movie-name").val()+"&page=${page.page}";
    }

</script>
</body>
</html>
