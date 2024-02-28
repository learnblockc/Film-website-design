<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    try{ace.settings.check('main-container' , 'fixed')}catch(e){}
</script>
<script src="../../resources/admin/assets/js/jquery.2.1.1.min.js"></script>

<div id="sidebar" class="sidebar                  responsive">
    <script type="text/javascript">
        try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
    </script>


    <ul class="nav nav-list" id="nav-list">
        <li class="active" id="system">
            <a href="../system/index">
                <i class="menu-icon fa fa-home"></i>
                <span class="menu-text"> 首页 </span>
            </a>

            <b class="arrow"></b>
        </li>

        <li class="" id="user">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-user"></i>
                <span class="menu-text">
                    用户管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="user-index">
                    <a href="../user/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        用户列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="role">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-key"></i>
                <span class="menu-text">
                    角色管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="role-index">
                    <a href="../role/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        角色列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="cinema">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-building"></i>
                <span class="menu-text">
                    电影院管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="cinema-index">
                    <a href="../cinema/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                            电影院列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="movie">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-film"></i>
                <span class="menu-text">
                    电影管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="movie-index">
                    <a href="../movie/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        电影列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="session">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-desktop"></i>
                <span class="menu-text">
                    场次管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="session-index">
                    <a href="../session/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        场次列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="order">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-money"></i>
                <span class="menu-text">
                    订单管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="order-index">
                    <a href="../order/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        订单列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>

        <li class="" id="comment">
            <a href="javascript:void(0);" class="dropdown-toggle">
                <i class="menu-icon fa fa-comment"></i>
                <span class="menu-text">
                    评论管理
                </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li id="comment-index">
                    <a href="../comment/index">
                        <i class="menu-icon fa fa-caret-right"></i>
                        评论列表
                        <b class="arrow"></b>
                    </a>
                </li>
            </ul>
        </li>
<%--增加电影票房功能--%>
<%--        <li class="" id="fares">--%>
<%--            <a href="javascript:void(0);" class="dropdown-toggle">--%>
<%--                <i class="menu-icon fa fa-money"></i>--%>
<%--                <span class="menu-text">--%>
<%--                    票房管理--%>
<%--                </span>--%>
<%--                <b class="arrow fa fa-angle-down"></b>--%>
<%--            </a>--%>
<%--            <b class="arrow"></b>--%>
<%--            <ul class="submenu">--%>
<%--                <li id="fares-index">--%>
<%--                    <a href="../fares/index">--%>
<%--                        <i class="menu-icon fa fa-caret-right"></i>--%>
<%--                        票房排行--%>
<%--                        <b class="arrow"></b>--%>
<%--                    </a>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--        </li>--%>
<%--    </ul><!-- /.nav-list -->--%>

    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
        <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>

    <script type="text/javascript">
        $(function(){
            $("#nav-list").children("li").removeClass('active');
            $("#nav-list").children("li").removeClass('open');
            $(".submenu").children("li").removeClass('active');
            clickChange("${firstMenu}", "${secondMenu}");
        });
        try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
        function clickChange(firstMenu, secondMenu) {
            if(secondMenu !== ''){
                $("#"+firstMenu).addClass('active open');
                $("#"+secondMenu).addClass('active');
            }else {
                $("#"+firstMenu).addClass('active');
            }
        }
    </script>
</div>
