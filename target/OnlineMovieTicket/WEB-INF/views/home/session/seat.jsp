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
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/buySeat.css">
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
<div style="margin-top: 90px;"></div>

<!-- 主体 -->
<div class="container">

    <div class="main" style="width: 1140px;">
        <!-- 主页 -->
        <div class="hall">
            <div class="seat-example" style="margin-left: 138px;">
                <div class="selectable-example example">
                    <span>可选座位</span>
                </div>
                <div class="sold-example example">
                    <span>已售座位</span>
                </div>
                <div class="selected-example example">
                    <span>已选座位</span>
                </div>
            </div>
            <div class="seats-block">
                <div class="row-id-container">
                    <c:forEach var= "temp" begin= "1" step= "1" end= "${session.row}">
                        <span class="row-id">${temp}</span>
                    </c:forEach>
                </div>
                <div class="seats-container">
                    <div class="screen-container">
                        <div class="screen">银幕中央</div>
                        <div class="c-screen-line"></div>
                    </div>
                    <div class="seats-wrapper">
                        <c:forEach var="row" begin= "1" step= "1" end= "${session.row}">
                            <div class="row">
                                <c:forEach var="col" begin="1" step="1" end="${session.col}">
                                    <span id="row-${row}-col-${col}" class="seat selectable" onclick="buySeat(${row - 1}, ${col - 1})"></span>
                                </c:forEach>

                            </div>
                        </c:forEach>
            <%--                                <span class="seat selectable" onclick="buySeat(0,0)"></span>--%>
            <%--                                <span class="seat sold"></span>--%>
            <%--                                <span class="seat selectable" onclick="buySeat(0,2)"></span>--%>
            <%--                                <span class="seat selectable" onclick="buySeat(0,3)"></span>--%>
<%--                        <div class="row">--%>
<%--                            <span class="seat selectable" onclick="buySeat(1,0)"></span>--%>
<%--                            <span class="seat sold"></span>--%>
<%--                            <span class="seat selected"></span>--%>
<%--                            <span class="seat selectable" onclick="buySeat(1,3)"></span>--%>
<%--                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
        <!-- 侧页 -->
        <div class="side">
            <!-- 电影 -->
            <div class="movie-info clearfix">
                <div class="poster">
                    <img src="../../common/file/view_photo?filename=${movie.photo}" />
                </div>
                <div class="content">
                    <p class="name text-ellipsis" title="${movie.name}">${movie.name}</p>
                    <div class="info-item">
                        <span>类型：</span>
                        <span class="value" id="type"></span>
                    </div>
                    <div class="info-item">
                        <span>时长：</span>
                        <span class="value">${movie.time}分钟</span>
                    </div>
                </div>
            </div>
            <!-- 场次 -->
            <div class="show-info">
                <div class="info-item">
                    <span>影院：</span>
                    <span class="value">${cinema.name}</span>
                </div>
                <div class="info-item">
                    <span>影厅：</span>
                    <span class="value">${session.hall}</span>
                </div>
                <div class="info-item">
                    <span>语言：</span>
                    <span class="value">${session.language}</span>
                </div>
                <div class="info-item">
                    <span>时间：</span>
                    <span class="value"><fmt:formatDate value="${session.time}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="info-item">
                    <span>票价：</span>
                    <span class="value">￥${session.price}/张</span>
                </div>
            </div>
            <div class="ticket-info">
                <div class="no-ticket" style="display: block;">
                    <p class="buy-limit">座位：一次最多选4个座位</p>
                </div>
                <div class="has-ticket" style="display: none;">
                    <span class="text">座位：</span>
                    <div class="ticket-container">
                    </div>
                </div>
                <div class="total-price">
                    <span>总价：</span>
                    <span class="price" id="total-price"></span>
                </div>
            </div>
            <div class="confirm-order">
                <div class="confirm-btn disable" onclick="confirmSeat()">确认选座</div>
            </div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<!-- ------------------------------------------------------------------- -->
<script>
    var clientHeight = document.documentElement.clientHeight;
    var SeatMax=0;
    var selectSeat = [];
    var layer;
    window.onload = function(){
        $("#type").text(filterMovieType("${movie.type}"));
        $("#total-price").text("￥0.00");
        layui.use('layer', function(){
            layer = layui.layer;
        });
        initHeader();
        <c:forEach var="item" items="${selectSeat}" varStatus="vs">
            $("#row-${item.row}-col-${item.col}").removeClass("selectable").addClass("sold");
            $("#row-${item.row}-col-${item.col}").removeAttr('onclick');
        </c:forEach>
    };

    //点击具体座位事件
    function buySeat(i,j){
        var row = $(".seats-wrapper").find(".row")[i].children[j];
        var flag = 0;
        var NoTicket = $(".no-ticket")[0];
        var HasTicket = $(".has-ticket")[0];
        var Ticket = $(".has-ticket").find(".ticket-container");
        var TicketRemove;
        var ConfirmBtn = $(".confirm-btn")[0];
        //座位不能大于四
        if((SeatMax>3) && (row.className === "seat selectable")){
            layui.use(['layer'], function(){
                layer = layui.layer;
                layer.alert('一次最多选四个座位！',{icon: 0,offset: clientHeight/5},
                    function (){
                        layer.closeAll();
                    }
                );
            });
        }
        //确定
        if((SeatMax<4) && (row.className === "seat selectable")){
            let seat = {
                row: i+1,
                col: j+1
            };
            selectSeat.push(seat);
            row.className = "seat selected";
            SeatMax++;
            flag = 1;
            Ticket.append("<span class=\"ticket\" data-index=\"" + (i+1) + "-" + (j+1) + "\">" + (i+1) + "排" + (j+1) + "座</span>");
            let totalPrice = "${session.price}" * SeatMax;
            $("#total-price").text("￥"+totalPrice.toFixed(2));
        }
        //取消
        if((row.className === "seat selected") && (flag === 0)){
            let arr = [];
            for(let index=0;index<selectSeat.length;index++){
                if(selectSeat[index].row != (i+1) || selectSeat[index].col != (j+1)){
                    arr.push({row:selectSeat[index].row, col:selectSeat[index].col})
                }
            }
            selectSeat = arr;
            TicketRemove = $("[data-index=" + (i+1) + "-" + (j+1) + "]");
            row.className = "seat selectable";
            SeatMax--;
            TicketRemove[0].remove();
            let totalPrice = "${session.price}" * SeatMax;
            $("#total-price").text("￥"+totalPrice.toFixed(2));
        }
        if(SeatMax === 0){
            NoTicket.style.display = "block";
            HasTicket.style.display = "none";
            ConfirmBtn.className = "confirm-btn disable";
        }
        else{
            NoTicket.style.display = "none";
            HasTicket.style.display = "block";
            ConfirmBtn.className = "confirm-btn";
        }
    }

    function confirmSeat() {
        $.ajax({
            url:'../order/generate?sessionId=${session.id}&cinemaId=${cinema.id}&movieId=${movie.id}',
            dataType:'json',
            type:'post',
            contentType:"application/json",
            data:JSON.stringify(selectSeat),
            success:function(result){
                if(result.code === 0){
                    layer.alert(result.msg, {icon: 6},function () {
                        window.location.href = '../order/pay?orderId='+result.data.id;
                    });
                }else{
                    layer.alert(result.msg, {icon: 5});
                }
            },
            error:function () {
                layer.alert('网络错误！', {icon: 5});
            }
        });
    }

</script>
</body>
</html>
