<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link href="../../resources/home/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resources/home/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="../../resources/home/js/jquery-3.3.1.min.js"></script>
    <script src="../../resources/home/bootstrap/js/bootstrap.min.js"></script>
    <script src="../../resources/home/layui/layui.js" charset="utf-8"></script>
    <link href="../../resources/home/css/login.css" rel="stylesheet">
    <link rel="stylesheet" href="../../resources/home/layui/css/layui.css" media="all">

    <script></script>
    <title>一路有戏电影网</title>
</head>
<body>

<!-- ------------------------------------------------------------------- -->
<div class="screen">
    <label class="title">电 影 订 票</label><br/>
</div>
<!-- 登录页 -->
<div class="content" style="float: left;">
    <ul class="tab">
        <li class="login">登录</li>
        <li class="register">注册</li>
    </ul>
    <div class="page">
        <!-- 登录界面 -->
        <div class="childpage" style="display: block">
            <div>
                <label class="login_title" style="margin-top: 10px;">用户登录</label><br/>
            </div>
            <div class="login_page">
                <form id="login-form">
                    <div>
                        <label>用户昵称</label><br/>
                        <input id="login-username" class="login-input" type="text" name="username"/>
                    </div>
                    <div>
                        <label>用户密码</label><br/>
                        <input id="login-password" class="login-input" type="password" name="password"/>
                    </div>
                    <div>
                        <label>验证码</label><br/>
                        <input id="captcha" name="captcha" type="text" class="login-input" style="width: 130px;"/>
                        <img id="login-captcha-img" name="captcha" title="点击切换验证码" style="cursor:pointer;" src="../../common/captcha/generate_captcha?vl=4&fs=21&w=90&h=26&method=home_login" width="107px" height="29px"  onclick="changeLoginCaptcha();">
                    </div>
                </form>
            </div>
            <div class="lo_error">
                <label class="login_error"></label>
            </div>
            <div>
                <input type="button" value="登录" class="btn btn-success login_btn" onclick="login()"/>
            </div>
        </div>
        <!-- 注册界面 -->
        <div class="childpage" style="display: none">
            <div>
                <label class="register_title" style="margin-top: 10px;">用户注册</label><br/>
            </div>
            <div class="register_page" style="height: 450px;">
                <form id="register-form">
                    <div>
                        <label>用户昵称</label><br/>
                        <input type="text" class="register-input" name="username"/>
                    </div>
                    <div>
                        <label>用户密码</label><br/>
                        <input type="password" class="register-input" name="password"/>
                    </div>
                    <div>
                        <label>确认密码</label><br/>
                        <input type="password" class="register-input" name="rePassword"/>
                    </div>
                    <div>
                        <label>手机号码</label><br/>
                        <input type="text" class="register-input" name="phone"/>
                    </div>
                    <div>
                        <label>验证码</label><br/>
                        <input type="text" name="captcha" class="register-input" style="width: 130px;"/>
                        <img id="register-captcha-img" name="captcha" title="点击切换验证码" style="cursor:pointer;" src="../../common/captcha/generate_captcha?vl=4&fs=21&w=90&h=26&method=home_register" width="107px" height="29px"  onclick="changeRegisterCaptcha();">
                    </div>
                </form>
                <div>
                    <input type="button" value="注册" class="btn btn-warning register_btn" style="margin-top: 10px;" onclick="register()"/>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- ------------------------------------------------------------------- -->
<script>
    var layer;
    //初始化
    window.onload = function(){
        initWindow(); //初始化登录框位置
        initLogin(); //初始化登录界面
        layui.use('layer', function(){
            layer = layui.layer;
        });
    };

    //初始化登录框位置（垂直居中、水平4/7）
    function initWindow(){
        var middle = 3;
        var colorNum = 200;
        var clientHeight = document.documentElement.clientHeight;
        var clientWidth = document.documentElement.clientWidth;
        var content = document.getElementsByClassName('content')[0];
        var screen = document.getElementsByClassName('screen')[0];
        var title = document.getElementsByClassName('title')[0];
        var bodys = document.getElementsByTagName('body')[0];
        bodys.style.cssText = "background-size: " + clientWidth + "px auto;";
        content.style.cssText = "margin:" + (clientHeight - content.clientHeight)/2 +"px " +
            clientWidth*4/7 + "px " +
            (clientHeight - content.clientHeight)/2 + "px;";
        screen.style.cssText = "margin:" + (content.clientHeight - screen.clientHeight)/2 +"px " +
            (clientWidth*4/7 - screen.clientWidth)/2 + "px " +
            (content.clientHeight - screen.clientHeight)/2 + "px;";
        setInterval(function(){
            colorNum += middle;
            if(colorNum>185){
                middle = -3;
            }else if(colorNum<80){
                middle = 3;
            }
            title.style.cssText = "color:rgb(255," + colorNum + ", 0)";
        },30);
    }

    //初始化登录界面
    function initLogin(){
        var liArr = document.getElementsByTagName('li');
        var divArr = document.getElementsByClassName("page")[0].getElementsByClassName("childpage");
        for(var i=0;i<liArr.length;i++){
            liArr[i].index = i;
            liArr[i].onclick = function(){
                for(var j=0;j<divArr.length;j++){
                    liArr[j].style.cssText = "background-color:rgba(255, 255, 255, 0.2);";
                    divArr[j].style.display = "none";
                }
                liArr[this.index].style.cssText = "background-color:rgba(255, 255, 255, 0);";
                divArr[this.index].style.display = "block";
            }
        }
    }


    // 登录操作处理
    function login() {
        var data = $("#login-form").serialize();
        $.ajax({
            url:'login',
            dataType:'json',
            type:'post',
            data:data,
            success:function(result){
                if(result.code === 0){
                    layer.alert(result.msg, {icon: 6}, function () {
                        window.location.href = '../system/index';
                    });
                }else {
                    changeLoginCaptcha();
                    layer.alert(result.msg, {icon: 5});
                }
            },
            error:function () {
                changeLoginCaptcha();
                layer.alert('网络错误！', {icon: 5});
            }
        });
    }

    // 注册操作处理
    function register() {
        var data = $("#register-form").serialize();
        $.ajax({
            url:'register',
            dataType:'json',
            type:'post',
            data:data,
            success:function(result){
                if(result.code === 0){
                    layer.alert(result.msg, {icon: 6});
                }else {
                    changeRegisterCaptcha();
                    layer.alert(result.msg, {icon: 5});
                }
            },
            error:function () {
                changeRegisterCaptcha();
                layer.alert('网络错误！', {icon: 5});
            }
        });
    }

    function changeLoginCaptcha(){
        $("#login-captcha-img").attr("src",'../../common/captcha/generate_captcha?vl=4&fs=21&w=94&h=29&method=home_login&t=' + new Date().getTime());
    }

    function changeRegisterCaptcha(){
        $("#register-captcha-img").attr("src",'../../common/captcha/generate_captcha?vl=4&fs=21&w=94&h=29&method=home_register&t=' + new Date().getTime());
    }


</script>
<style>
    .login-input{
        width: 240px;
        height: 30px;
        border: none;
        background-color:rgba(255, 255, 255, 0.3);
        border-radius: 5px;
    }
    .register-input{
        width: 240px;
        height: 30px;
        border: none;
        background-color:rgba(255, 255, 255, 0.3);
        border-radius: 5px;
    }
</style>
</body>
</html>
