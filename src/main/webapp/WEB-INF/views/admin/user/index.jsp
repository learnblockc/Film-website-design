<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<link rel="stylesheet" href="../../resources/admin/assets/css/jquery-ui.min.css" />
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
                    <li class="active">用户列表</li>
                </ul><!-- /.breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <button class="btn btn-sm btn-warning" style="margin-bottom: 4px;" onclick="openDialog('添加用户信息', 'add')">
                        <i class="ace-icon glyphicon glyphicon-plus"></i>
                        添加
                    </button>
                    <button class="btn btn-sm btn-info" style="margin-bottom: 4px;" onclick="openDialog('修改用户信息', 'edit')">
                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                        修改
                    </button>
                    <button class="btn btn-sm btn-danger" style="margin-bottom: 4px;" onclick="openConfirm()">
                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                        删除
                    </button>
                    <input type="text" id="search-name" placeholder="请输入用户昵称..." style="width: 200px; float: none">
                    <button class="btn btn-sm btn-info" onclick="searchName(1);" style="margin-bottom: 4px; padding-left: 5px;">
                        <i class="ace-icon fa fa-search nav-search-icon"></i>
                        搜索
                    </button>
                </div><!-- /.page-header -->

                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->
                        <div class="row">
                            <div class="col-xs-12">
                                <table id="table">
                                </table>
                            </div><!-- /.span -->
                        </div><!-- /.row -->





                    </div><!-- /.col -->
                </div><!-- /.row -->


                <div id="pagination">

                </div>

            </div><!-- /.page-content -->


        </div>
    </div><!-- /.main-content -->

    <div id="dialog-message" class="hide">
        <form id="dialog-form">
            <input type="hidden" id="id" name="id" />
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">用户头像：</label>
                <input type="hidden" id="photo" value="../resources/upload/common/no_image.jpg" name="headPic"/>
                <img id="preview-photo" src="../../common/file/view_photo?filename=../resources/upload/common/no_image.jpg" width="80px" height="60px" />
                <button class="btn btn-sm btn-purple" type="button" onclick="uploadPhoto()">
                    <i class="ace-icon fa fa-cloud-upload"></i>
                    上传图片
                </button>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">用户昵称：</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名称..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">用户密码：</label>
                <input type="password" id="password" name="password" placeholder="请输入用户密码..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">用户手机号：</label>
                <input type="text" id="phone" name="phone" placeholder="请输入用户手机号..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">用户性别：</label>
                <select name="sex" id="sex" style="width: 250px; float: none">
                    <option value="1">男</option>
                    <option value="2">女</option>
                    <option value="3">未知</option>
                </select>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">所属角色：</label>
                <select name="roleId" id="roleId" style="width: 250px; float: none">
                    <c:forEach var="role" items="${roleList}" varStatus="vs">
                        <option value="${role.id}">${role.name}</option>
                    </c:forEach>
                </select>
            </div>
        </form>

    </div><!-- #dialog-message -->

    <div id="confirm-message" class="hide">
        <p style="margin-top:10px;">确定要删除此条数据吗？</p>
    </div><!-- #dialog-confirm -->
    <input type="file" id="photo-file" style="display:none;" onchange="upload()">
    <%@include file="../common/footer.jsp"%>

</div><!-- /.main-container -->

<!-- basic scripts -->

<%@include file="../common/url.jsp"%>


<script type="text/javascript">
    $(function(){
        getPage(1, $("#search-name").val());
        $('#table').bootstrapTable({
            url: 'list',
            method: 'post',
            columns: [{
                checkbox: true,
            },{
                field: 'id',
                title: '用户编号',
                width: '80px'
            },{
                field: 'username',
                title: '用户昵称',
                width: '100px'
            },{
                field: 'headPic',
                title: '用户头像',
                width: '90px',
                formatter: function(value,row,index){
                     let img = '<img src="../../common/file/view_photo?filename='+value+'" width="90px" height="60px"/>';
                     return img;
                }
            },{
                field: 'phone',
                title: '用户手机号',
                width: '150px'
            },{
                field: 'sex',
                title: '用户性别',
                width: '100px',
                formatter: function(value,row,index){
                    switch(value){
                        case 3:{
                            return '未知';
                        }
                        case 1:{
                            return '男';
                        }
                        case 2:{
                            return '女';
                        }
                    }
                }
            },{
                field: 'role.name',
                title: '用户所属角色',
                width: '100px',
                formatter: function(value,row,index){
                    return row.role.name;
                }
            }]
        })
    });
    var dialog;
    function openDialog(title, type) {
        if(type === 'add'){
            $("#id").val('');
            $("#username").val('');
            $("#photo").val('../resources/upload/common/no_image.jpg');
            $("#preview-photo").attr('src','../../common/file/view_photo?filename=../resources/upload/common/no_image.jpg');
            $("#password").val('');
            $("#phone").val('');
            $("#sex").val('3');
        } else if(type === 'edit') {
            let selectRow = $('#table').bootstrapTable('getSelections');
            if(selectRow.length !== 1){
                commonUtil.message('请选择一条数据进行修改！', 'danger');
                return false;
            }else {
                let row = selectRow[0];
                $("#id").val(row.id);
                $("#username").val(row.username);
                $("#photo").val(row.headPic);
                $("#preview-photo").attr('src','../../common/file/view_photo?filename='+row.headPic);
                $("#password").val(row.password);
                $("#phone").val(row.phone);
                $("#sex").val(row.sex);
                $("#roleId").val(row.roleId);
            }
        }
        dialog = $("#dialog-message").removeClass('hide').dialog({
            modal: true,
            width: '400',
            height: '400',
            title: title,
            buttons: [
                {
                    text: "取消",
                    "class": "btn btn-minier",
                    click: function () {
                        $(this).dialog("close");
                    }
                },
                {
                    text: "保存",
                    "class": "btn btn-primary btn-minier",
                    click: function () {
                        save();
                    }
                }
            ]
        });
    }


</script>
<style type="text/css">
    .ui-dialog-buttonpane {
        position: absolute;
        width: 100%;
        bottom: 0;
    }
    .table {table-layout:fixed;word-break:break-all;}
</style>
</body>
</html>
