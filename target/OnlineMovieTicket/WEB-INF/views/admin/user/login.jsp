<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>电影订票系统</title>

    <meta name="description" content="User login page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="../../resources/admin/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../resources/admin/assets/font-awesome/4.2.0/css/font-awesome.min.css" />

    <!-- text fonts -->
    <link rel="stylesheet" href="../../resources/admin/assets/fonts/fonts.googleapis.com.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="../../resources/admin/assets/css/ace.min.css" />

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../../resources/admin/assets/css/ace-part2.min.css" />
    <![endif]-->
    <link rel="stylesheet" href="../../resources/admin/assets/css/ace-rtl.min.css" />

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../../resources/admin/assets/css/ace-ie.min.css" />
    <![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
    <script src="../../resources/admin/assets/js/html5shiv.min.js"></script>
    <script src="../../resources/admin/assets/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-layout blur-login">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1" style="margin-top:100px;">
                <div class="login-container">
                    <div class="center">
                        <h1>
                            <i class="ace-icon fa fa-leaf green"></i>
                            <span class="red">电影院</span>
                            <span class="white" id="id-text2">后台管理系统</span>
                        </h1>
                    </div>

                    <div class="space-6"></div>

                    <div class="position-relative">
                        <div id="login-box" class="login-box visible widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header blue lighter bigger">
                                        <i class="ace-icon fa fa-coffee green"></i>
                                        请输入您的信息！
                                    </h4>

                                    <div class="space-6"></div>

                                    <form id="login-form">
                                        <fieldset>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="text" name="username" class="form-control" placeholder="请输入用户昵称..." />
                                                    <i class="ace-icon fa fa-user"></i>
                                                </span>
                                            </label>

                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" name="password" class="form-control" placeholder="请输入用户密码..." />
                                                    <i class="ace-icon fa fa-lock"></i>
                                                </span>
                                            </label>

                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right" style="position: relative">
                                                    <input type="text" name="captcha" class="form-control" style="width:160px;" placeholder="请输入验证码..." />
                                                    <i class="ace-icon fa fa-key" style="right: 133px;"></i>
                                                    <img id="captcha-img" title="点击切换验证码" style="cursor:pointer;position: absolute; top:0px;left:170px;" src="../../common/captcha/generate_captcha?vl=4&fs=21&w=94&h=29&method=admin_login" width="120px" height="34px"  onclick="changeCaptcha();">
                                                </span>
                                            </label>

                                            <div class="space"></div>

                                            <div class="clearfix">

                                                <button type="button" class="width-35 pull-right btn btn-sm btn-primary" onclick="login()" style="margin-right:90px;">
                                                    <span class="bigger-110">登录</span>
                                                </button>
                                            </div>

                                            <div class="space-4"></div>
                                        </fieldset>
                                    </form>


                                </div><!-- /.widget-main -->

                            </div><!-- /.widget-body -->
                        </div><!-- /.login-box -->



                    </div><!-- /.position-relative -->

                </div>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

<!-- basic scripts -->

<!--[if !IE]> -->
<script src="../../resources/admin/assets/js/jquery.2.1.1.min.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="../../resources/admin/assets/js/jquery.1.11.1.min.js"></script>
<![endif]-->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='../../resources/admin/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='../../resources/admin/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='../../resources/admin/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="../../resources/admin/assets/js/alert.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
    jQuery(function($) {
        $(document).on('click', '.toolbar a[data-target]', function(e) {
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
        });
    });
    // 登录操作处理
    function login() {
        var data = $("#login-form").serialize();
        $.ajax({
            url:'../user/login',
            dataType:'json',
            type:'post',
            data:data,
            success:function(result){
                if(result.code === 0){
                    window.location.href = '../system/index';
                }else {
                    changeCaptcha();
                    commonUtil.message(result.msg, 'danger');
                }
            },
            error:function () {
                changeCaptcha();
                commonUtil.message("网络错误", 'danger');
            }
        });
    }

    /**
     *  更换验证码
     */
    function changeCaptcha(){
        $("#captcha-img").attr("src",'../../common/captcha/generate_captcha?vl=4&fs=21&w=94&h=29&method=admin_login&t=' + new Date().getTime());
    }

</script>
</body>
</html>
