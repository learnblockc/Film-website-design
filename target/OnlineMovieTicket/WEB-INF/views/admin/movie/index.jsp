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
                    <li class="active">电影列表</li>
                </ul><!-- /.breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <button class="btn btn-sm btn-warning" style="margin-bottom: 4px;" onclick="openDialog('添加电影信息', 'add')">
                        <i class="ace-icon glyphicon glyphicon-plus"></i>
                        添加
                    </button>
                    <button class="btn btn-sm btn-info" style="margin-bottom: 4px;" onclick="openDialog('修改电影信息', 'edit')">
                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                        修改
                    </button>
                    <button class="btn btn-sm btn-danger" style="margin-bottom: 4px;" onclick="openConfirm()">
                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                        删除
                    </button>
                    <button class="btn btn-sm btn-pink" style="margin-bottom: 4px;" onclick="openActorDialog()">
                        <i class="ace-icon fa fa-users"></i>
                        管理演职人员
                    </button>
                    <button class="btn btn-sm btn-purple" style="margin-bottom: 4px;" onclick="openViewInfoDialog()">
                        <i class="ace-icon fa fa-eye"></i>
                        查看电影简介
                    </button>
                    <input type="text" id="search-name" placeholder="请输入电影名称..." style="width: 200px; float: none">
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
                                <table id="table"></table>
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
                <label style="width: 100px;">电影海报：</label>
                <input type="hidden" id="photo" value="../resources/upload/common/no_image.jpg" name="photo"/>
                <img id="preview-photo" src="../../common/file/view_photo?filename=../resources/upload/common/no_image.jpg" width="80px" height="60px" />
                <button class="btn btn-sm btn-purple" type="button" onclick="uploadPhoto()">
                    <i class="ace-icon fa fa-cloud-upload"></i>
                    上传图片
                </button>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">电影名称：</label>
                <input type="text" id="name" name="name" placeholder="请输入电影名称..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">电影时长：</label>
                <input type="number" id="time" name="time" min="1" oninput="this.value=this.value.replace(/\D/g);" placeholder="请输入电影时长(分钟)..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">电影类型：</label>
                <select name="type" id="type" style="width: 250px; float: none">
                    <option value="1">爱情</option>
                    <option value="2">动作</option>
                    <option value="3">喜剧</option>
                    <option value="4">剧情</option>
                    <option value="5">战争</option>
                    <option value="6">惊悚</option>
                    <option value="7">科幻</option>
                    <option value="8">悬疑</option>
                    <option value="9">犯罪</option>
                    <option value="10">冒险</option>
                    <option value="11">家庭</option>
                    <option value="12">古装</option>
                    <option value="13">动画</option>
                </select>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">电影源地：</label>
                <select name="area" id="area" style="width: 250px; float: none">
                    <option value="1">中国大陆</option>
                    <option value="2">美国</option>
                    <option value="3">韩国</option>
                    <option value="4">日本</option>
                    <option value="5">中国香港</option>
                    <option value="6">德国</option>
                    <option value="7">印度</option>
                    <option value="8">英国</option>
                    <option value="9">法国</option>
                    <option value="10">俄罗斯</option>
                    <option value="11">意大利</option>
                </select>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">上映时间：</label>
                <input type="text" id="datepicker" name="createTime" id="createTime" style="width: 250px;" readonly="readonly" />
            </div>
            <div style="margin: 10px 0px;" >
                <label style="width: 100px;float: left;margin-top: 35px;">电影简介：</label>
                <textarea id="info" name="info" placeholder="请输入电影简介..." style="width: 250px;height: 100px;resize:none;margin-left: 4px;"></textarea>
            </div>

        </form>

    </div><!-- #dialog-message -->

    <div id="confirm-message" class="hide">
        <p style="margin-top:10px;">确定要删除此条数据吗？</p>
    </div><!-- #dialog-confirm -->

    <div id="actor-dialog" class="hide">
        <button class="btn btn-sm btn-warning" style="margin-bottom: 4px;" onclick="openActor('添加演职人员信息', 'add')">
            <i class="ace-icon glyphicon glyphicon-plus"></i>
            添加
        </button>
        <button class="btn btn-sm btn-info" style="margin-bottom: 4px;" onclick="openActor('修改演职人员信息', 'edit')">
            <i class="ace-icon fa fa-pencil bigger-120"></i>
            修改
        </button>
        <button class="btn btn-sm btn-danger" style="margin-bottom: 4px;" onclick="openConfirmActor()">
            <i class="ace-icon fa fa-trash-o bigger-120"></i>
            删除
        </button>
        <div style="height: 360px;overflow: auto;">
            <table id="actor-table"></table>
        </div>

    </div><!-- #dialog-confirm -->

    <div id="actor" class="hide">
        <form id="actor-form">
            <input type="hidden" id="actor-id" name="id" />
            <input type="hidden" id="actor-movieId" name="movieId" />
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">演职人员名称：</label>
                <input type="text" id="actor-name" name="name" placeholder="请输入演职人员名称..." style="width: 250px; float: none;">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">演职人员类型：</label>
                <select name="type" id="actor-type" style="width: 250px; float: none">
                    <option value="1">导演</option>
                    <option value="2">演员</option>
                </select>
            </div>
        </form>

    </div><!-- #dialog-message -->

    <div id="open-view-info" class="hide">
        <p style="margin-top:10px;" id="view-info"></p>
    </div><!-- #dialog-message -->
    <input type="file" id="photo-file" style="display:none;" onchange="upload()">
    <%@include file="../common/footer.jsp"%>

</div><!-- /.main-container -->

<!-- basic scripts -->

<%@include file="../common/url.jsp"%>


<script type="text/javascript">
    $(function(){
        $( "#datepicker" ).datepicker({
            showOtherMonths: true,
            selectOtherMonths: false,
        });
        getPage(1, $("#search-name").val());
        $('#table').bootstrapTable({
            url: 'list',
            method: 'post',
            columns: [{
                checkbox: true,
            },{
                field: 'id',
                title: '电影编号',
                width: '100px'
            },{
                field: 'name',
                title: '电影名称',
                width: '170px'
            },{
                field: 'photo',
                title: '电影海报',
                width: '110px',
                formatter: function(value,row,index){
                    let img = '<img src="../../common/file/view_photo?filename='+value+'" width="90px" height="60px"/>';
                    return img;
                }
            },{
                field: 'type',
                title: '电影类型',
                width: '80px',
                formatter: function(value,row,index){
                    return filterMovieType(value);
                }
            },{
                field: 'time',
                title: '电影时长',
                width: '80px',
                formatter: function(value,row,index){
                    return value + '分钟';
                }
            },{
                field: 'area',
                title: '电影源地',
                width: '80px',
                formatter: function(value,row,index){
                    return filterMovieArea(value);
                }
            },{
                field: 'rate',
                title: '评分',
                width: '80px'
            },{
                field: 'rateCount',
                title: '评分人数',
                width: '80px'
            },{
                field: 'createTime',
                title: '上映时间',
                width: '150px',
                formatter: function(value,row,index){
                    return formatYMD(value);
                }
            }]
        });
    });
    var info;
    function openViewInfoDialog() {
        let selectRow = $('#table').bootstrapTable('getSelections');
        if(selectRow.length !== 1){
            commonUtil.message('请选择一条数据进行查看！', 'danger');
            return false;
        }else {
            $("#view-info").text(selectRow[0].info);
            info = $("#open-view-info").removeClass('hide').dialog({
                modal: true,
                width: '400',
                height: '300',
                title: "查看电影简介",
                buttons: [
                    {
                        text: "关闭",
                        "class": "btn btn-primary btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }
    }
    var actor;
    function openActor(title, type) {
        if(type === 'add'){
            $("#actor-id").val('');
            $("#actor-name").val('');
            $("#actor-type").val('1');
        } else if(type === 'edit') {
            let selectRow = $('#actor-table').bootstrapTable('getSelections');
            if(selectRow.length !== 1){
                commonUtil.message('请选择一条数据进行修改！', 'danger');
                return false;
            }else {
                let row = selectRow[0];
                $("#actor-id").val(row.id);
                $("#actor-name").val(row.name);
                $("#actor-type").val(row.type);
            }
        }
        actor = $("#actor").removeClass('hide').dialog({
            modal: true,
            width: '400',
            height: '220',
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
                        saveActor();
                    }
                }
            ]
        });
    }

    function openConfirmActor() {
        let selectRow = $('#actor-table').bootstrapTable('getSelections');
        if(selectRow.length !== 1){
            commonUtil.message('请选择一条数据进行删除！', 'danger');
            return false;
        }else {
            confirm = $("#confirm-message").removeClass('hide').dialog({
                modal: true,
                width: '280',
                height: '150',
                title: "确认提示",
                buttons: [
                    {
                        text: "取消",
                        "class": "btn btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        text: "确定",
                        "class": "btn btn-primary btn-minier",
                        click: function () {
                            $(this).dialog("close");
                            removeActor(selectRow[0]);
                        }
                    }
                ]
            });
        }
    }

    function removeActor(item) {
        $.ajax({
            url:'../actor/delete',
            dataType:'json',
            type:'post',
            data:{id:item.id},
            success:function(result){
                if(result.code === 0){
                    commonUtil.message('删除成功！', 'success');
                    $("#actor-table").bootstrapTable('refresh');
                }else {
                    commonUtil.message(result.msg, 'danger');
                }
            },
            error:function () {
                commonUtil.message('网络错误！', 'danger');
            }
        });
    }

    function saveActor() {
        var data = $("#actor-form").serialize();
        $.ajax({
            url:'../actor/save',
            dataType:'json',
            type:'post',
            data:data,
            success:function(result){
                if(result.code === 0){
                    commonUtil.message('保存成功！', 'success');
                    actor.dialog("close");
                    $("#actor-table").bootstrapTable('refresh');
                }else {
                    commonUtil.message(result.msg, 'danger');
                }
            },
            error:function () {
                commonUtil.message('网络错误！', 'danger');
            }
        });
    }


    var dialog;
    function openDialog(title, type) {
        if(type === 'add'){
            $("#id").val('');
            $("#photo").val('../resources/upload/common/no_image.jpg');
            $("#preview-photo").attr('src','../../common/file/view_photo?filename=../resources/upload/common/no_image.jpg');
            $("#name").val('');
            $("#time").val('');
            $("#type").val('1');
            $("#area").val('1');
            $("#datepicker").val('');
            $("#info").val('');
        } else if(type === 'edit') {
            let selectRow = $('#table').bootstrapTable('getSelections');
            if(selectRow.length !== 1){
                commonUtil.message('请选择一条数据进行修改！', 'danger');
                return false;
            }else {
                let row = selectRow[0];
                $("#id").val(row.id);
                $("#photo").val(row.photo);
                $("#preview-photo").attr('src','../../common/file/view_photo?filename='+row.photo);
                $("#name").val(row.name);
                $("#time").val(row.time);
                $("#type").val(row.type);
                $("#area").val(row.area);
                $("#datepicker").val(formatMDY(row.createTime));
                $("#info").val(row.info);
            }
        }
        dialog = $("#dialog-message").removeClass('hide').dialog({
            modal: true,
            width: '400',
            height: '530',
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




    var actorDialog;
    function openActorDialog() {
        let selectRow = $('#table').bootstrapTable('getSelections');
        if(selectRow.length !== 1){
            commonUtil.message('请选择一条数据进行管理！', 'danger');
            return false;
        }else {
            $('#actor-table').bootstrapTable('destroy');
            $('#actor-table').bootstrapTable({
                url: '../actor/list?id='+selectRow[0].id,
                method: 'post',
                columns: [{
                    checkbox: true,
                }, {
                    field: 'id',
                    title: '演职人员编号',
                    width: '100px'
                },{
                    field: 'name',
                    title: '演职人员名称',
                    width: '200px'
                },{
                    field: 'type',
                    title: '演职人员类型',
                    width: '100px',
                    formatter: function(value,row,index){
                        return filterActorType(value);
                    }
                }]
            });
            $('#actor-movieId').val(selectRow[0].id);
            actorDialog = $("#actor-dialog").removeClass('hide').dialog({
                modal: true,
                width: '700',
                height: '550',
                title: "演职人员",
                buttons: [
                    {
                        text: "关闭",
                        "class": "btn btn-primary btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }
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
