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
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/center.css">
    <link rel="stylesheet" type="text/css" href="../../resources/home/css/footer.css">
    <script src="../../resources/home/js/header.js" charset="utf-8"></script>
    <script src="../../resources/home/js/Api.js"></script>
    <script src="../../resources/home/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="../../resources/home/layui/css/layui.css" media="all">
    <title>一路有戏电影网</title>
</head>
<body>
<!-- 导航栏 -->
<%@include file="../common/header.jsp"%>

<!-- 占位符 -->
<div style="margin-top: 110px;"></div>

<!-- 主体 -->
<div class="container">
    <div class="contents">
        <div class="nav-next" style="height: 1100px;">
            <div class="nav-title">
                <h3>个人中心</h3>
            </div>
            <a class="cardId">我的订单</a>
            <a class="cardId">基本信息</a>
        </div>
        <div class="nav-body">
            <!-- 我的订单 -->
            <div class="one card" style="display: block;">
                <div>
                    <div class="title">我的订单</div>
                    <hr/>
                </div>
                <c:forEach var="order" items="${orderList}" varStatus="vs">
                    <div class="order-box">
                        <div class="order-head">
                            <span class="order-date"><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                            <span class="order-id">订单号：${order.tradeNo}</span>
                            <c:if test="${order.state == 3}">
                                <span class="order-delete" style="cursor: pointer;" onclick="cancelOrder('${order.id}')">取消</span>
                            </c:if>
                        </div>
                        <div class="order-body">
                            <div class="poster"><img src="../../common/file/view_photo?filename=${order.moviePhoto}" /></div>
                            <div class="order-content">
                                <div class="movie-name" style="margin-left: 0px;">${order.movieName}</div>
                                <div class="cinema-name">${order.cinemaName}</div>
                                <div class="hall-ticket">${order.sessionHall}
                                    <c:forEach var="orderItem" items="${order.orderItemList}" varStatus="vs">
                                        ${orderItem.row}排${orderItem.col}列
                                    </c:forEach>
                                </div>
                                <div class="show-time"><fmt:formatDate value="${order.sessionTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                            </div>
                            <div class="order-price">￥${order.totalPrice}</div>
                            <div class="order-status" id="state">
                                <c:if test="${order.state == 1}">
                                    已完成
                                </c:if>
                                <c:if test="${order.state == 2}">
                                    已取消
                                </c:if>
                                <c:if test="${order.state == 3}">
                                    未支付
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
            <!-- 基本信息 账号、邮箱、角色、头像 -->
            <div class="two card" style="display: none;">
                <div>
                    <div class="title">基本信息</div>
                    <hr/>
                </div>
                <div class="avatar-container layui-upload">
                    <div class="layui-upload-list">
                        <img class="layui-upload-img" id="preview-photo" style="width: 250px;max-width: 250px;" src="../../common/file/view_photo?filename=${HOME_USER.headPic}">
                        <p id="demoText"></p>
                    </div>
                    <input type="file" id="photo-file" style="display:none;" onchange="upload()">
                    <a href="javascript:void(0);" class="file" onclick="uploadPhoto()">选择文件</a>
                    <div class="tips">支持JPG,JPEG,PNG格式，且文件需小于1024KB</div>
                </div>

                <div class="avatar-body">
                    <form id="user-info-form">
                        <input type="hidden" name="id" value="${HOME_USER.id}" />
                        <input type="hidden" id="user-headPic" name="headPic" value="${HOME_USER.headPic}" />
                        <div class="userexinfo-form-section">
                            <p>用户昵称：</p>
                            <span>
                                <input type="text" name="username" id="username" value="${HOME_USER.username}" />
                            </span>
                        </div>
                        <div class="userexinfo-form-section">
                            <p>用户密码：</p>
                            <span>
                                <input type="password" name="password" id="password" value="${HOME_USER.password}" />
                            </span>
                        </div>
                        <div class="userexinfo-form-section">
                            <p>手机号码：</p>
                            <span>
                                <input type="text" name="phone" id="phone" value="${HOME_USER.phone}" />
                            </span>
                        </div>
                        <div class="userexinfo-form-section">
                            <p>用户性别：</p>
                            <span>
                                <input type="radio" id="sex-1" name="sex" value="1">男&nbsp;&nbsp;
                                <input type="radio" id="sex-2" name="sex" value="2">女&nbsp;&nbsp;
                                <input type="radio" id="sex-3" name="sex" value="3">未知&nbsp;&nbsp;
                            </span>
                        </div>
                    </form>
                    <div class="userexinfo-btn-section">
                    <input type="button" onclick="saveUserInfo()" class="form-save-btn" value="保存">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 脚 -->
<%@include file="../common/footer.jsp"%>


<script>
    var clientHeight = document.documentElement.clientHeight;
    var layer;
    window.onload = function(){
        layui.use('layer', function(){
            layer = layui.layer;
        });
        initHeader();
        initCard(); //初始化选项卡
        $("#sex-${HOME_USER.sex}").click();
    };

    // 保存用户信息
    function saveUserInfo() {
        var data = $("#user-info-form").serialize();
        $.ajax({
            url:'../user/save_info',
            dataType:'json',
            type:'post',
            data:data,
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

    //选项卡
    function initCard(){
        var aArr = $(".nav-next").find(".cardId");
        var divArr = $(".nav-body").find(".card");
        if(localStorage.getItem("usercardId") == null){
            localStorage.setItem("usercardId", 0);
        }
        for(var i=0; i<aArr.length; i++){
            aArr[i].index = i;
            aArr[i].onclick = function(){
                localStorage.setItem("usercardId",this.index);
                for(var j=0;j<divArr.length;j++){
                    divArr[j].style.display = "none";
                    aArr[j].style.cssText = "background-color: #f4f3f4; color: #333;";
                }
                divArr[this.index].style.display = "block";
                aArr[this.index].style.cssText = "background-color: #ed3931; color: #fff;";
            }
        }
        for(var p=0;p<aArr.length;p++){
            divArr[p].style.display = "none";
            aArr[p].style.cssText = "background-color: #f4f3f4; color: #333;";
            if(localStorage.getItem("usercardId")==p){
                divArr[p].style.display = "block";
                aArr[p].style.cssText = "background-color: #ed3931; color: #fff;";
            }
        }
    }

    // 取消订单
    function cancelOrder(id) {
        layer.confirm("确定要取消订单吗？", {btn: ['确定', '取消'], title: "提示"}, function () {
            $.ajax({
                url:'../order/cancel',
                dataType:'json',
                type:'post',
                data:{id: id},
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
        });
    }

    // 上传图片
    function upload(){
        if($("#photo-file").val() === '')return;
        var formData = new FormData();
        formData.append('photo',document.getElementById('photo-file').files[0]);
        $.ajax({
            url:'../../common/file/upload_photo',
            type:'post',
            data:formData,
            contentType:false,
            processData:false,
            success:function(result){
                if(result.code === 0){
                    $("#preview-photo").attr('src','../../common/file/view_photo?filename='+result.data);
                    $("#user-headPic").val(result.data);
                    layer.alert(result.msg, {icon: 6});
                }else{
                    layer.alert(result.msg, {icon: 5});
                }
            },
            error:function(){
                layer.alert("网络错误！", {icon: 5});
            }
        });
    }

    // 打开上传图片的弹窗
    function uploadPhoto(){
        $("#photo-file").click();
    }

</script>
</body>
</html>
