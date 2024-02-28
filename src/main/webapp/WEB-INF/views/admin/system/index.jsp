<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../common/header.jsp"%>
<div class="main-container" id="main-container">
    <%@include file="../common/sidebar.jsp"%>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        系统
                    </li>
                    <li class="active">首页</li>
                </ul><!-- /.breadcrumb -->

            </div>

            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->
                        <div class="alert alert-block alert-success">

                            <i class="ace-icon fa fa-check green"></i>
                            欢迎使用电影订票系统！ 当前时间：<span id="now-time"></span>
                        </div>
                        <div>
                            <div id="user-profile-1" class="user-profile row">
                                <div class="col-xs-12 col-sm-3 center">
                                    <div>
                                        <span class="profile-picture">
                                            <img id="avatar" class="editable img-responsive" alt="Alex's Avatar" src="../../common/file/view_photo?filename=${ADMIN_USER.headPic}" />
                                        </span>

                                        <div class="space-4"></div>

                                        <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                            <div class="inline position-relative">
                                                <a href="javasrcipt:void(0);" class="user-title-label dropdown-toggle">
                                                    <i class="ace-icon fa fa-circle light-green"></i>
                                                    &nbsp;
                                                    <span class="white">${ADMIN_USER.username}</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xs-12 col-sm-9">
                                    <div class="center">
                                        <span class="btn btn-app btn-sm btn-light no-hover">
                                            <span class="line-height-1 bigger-170 blue"> ${userTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 用户数 </span>
                                        </span>

                                        <span class="btn btn-app btn-sm btn-yellow no-hover">
                                            <span class="line-height-1 bigger-170"> ${movieTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 电影院数 </span>
                                        </span>

                                        <span class="btn btn-app btn-sm btn-pink no-hover">
                                            <span class="line-height-1 bigger-170"> ${sessionTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 场次数 </span>
                                        </span>

                                        <span class="btn btn-app btn-sm btn-grey no-hover">
                                            <span class="line-height-1 bigger-170"> ${orderTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 订单数 </span>
                                        </span>

                                        <span class="btn btn-app btn-sm btn-success no-hover">
                                            <span class="line-height-1 bigger-170"> ${movieTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 电影数 </span>
                                        </span>

                                        <span class="btn btn-app btn-sm btn-primary no-hover">
                                            <span class="line-height-1 bigger-170"> ${commentTotal} </span>
                                            <br />
                                            <span class="line-height-1 smaller-90"> 评论数 </span>
                                        </span>
                                    </div>

                                    <div class="space-12"></div>

                                    <div class="profile-user-info profile-user-info-striped">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 用户昵称 </div>

                                            <div class="profile-info-value">
                                                <span class="editable" id="username">${ADMIN_USER.username}</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 手机号码 </div>
                                            <div class="profile-info-value">
                                                <span class="editable" id="phone">${ADMIN_USER.phone}</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 性别 </div>

                                            <div class="profile-info-value">
                                                <span class="editable" id="sex"></span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 所属角色 </div>

                                            <div class="profile-info-value">
                                                <span class="editable" id="role">
                                                    <c:forEach var="role" items="${roleList}" varStatus="vs">
                                                        <c:if test="${ADMIN_USER.roleId == role.id}">
                                                            ${role.name}
                                                        </c:if>
                                                    </c:forEach>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 最后登录时间 </div>

                                            <div class="profile-info-value">
                                                <span class="editable" id="login"><fmt:formatDate value="${ADMIN_USER.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>



                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->

    <%@include file="../common/footer.jsp"%>

</div><!-- /.main-container -->

<%@include file="../common/url.jsp"%>

<!-- inline scripts related to this page -->
<script type="text/javascript">
    $( document).ready(function() {
        //时间设置
        function currentTime() {
            var d = new Date(), str = '';
            str += d.getFullYear() + '年';
            str += d.getMonth() + 1 + '月';
            str += d.getDate() + '日';
            str += d.getHours() + '时';
            str += d.getMinutes() + '分';
            str += d.getSeconds() + '秒';
            return str;
        }
        setInterval(function () {
            $('#now-time').html(currentTime)
        }, 1000);

        switch("${ADMIN_USER.sex}") {
            case "1":
                $("#sex").text("男");
                break;
            case "2":
                $("#sex").text("女");
                break;
            case "3":
                $("#sex").text("未知");
                break;
            default:
                break;
        }
    });

</script>
</body>
</html>
