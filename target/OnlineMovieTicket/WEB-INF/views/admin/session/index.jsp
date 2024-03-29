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
                    <li class="active">场次列表</li>
                </ul><!-- /.breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <button class="btn btn-sm btn-warning" style="margin-bottom: 4px;" onclick="openDialog('添加场次信息', 'add')">
                        <i class="ace-icon glyphicon glyphicon-plus"></i>
                        添加
                    </button>
                    <button class="btn btn-sm btn-info" style="margin-bottom: 4px;" onclick="openDialog('修改场次信息', 'edit')">
                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                        修改
                    </button>
                    <button class="btn btn-sm btn-danger" style="margin-bottom: 4px;" onclick="openConfirm()">
                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                        删除
                    </button>
                    <input type="text" id="search-name" placeholder="请输入场次编号..." style="width: 200px; float: none">
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
                <label style="width: 100px;">所属电影院：</label>
                <select name="cinemaId" id="cinemaId" style="width: 250px; float: none">
                    <c:forEach var="cinema" items="${cinemaList}" varStatus="vs">
                        <option value="${cinema.id}">${cinema.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">所属电影：</label>
                <select name="movieId" id="movieId" style="width: 250px; float: none">
                    <c:forEach var="movie" items="${movieList}" varStatus="vs">
                        <option value="${movie.id}">${movie.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">放映时间：</label>
                <input type="text" id="datepicker"  name="time" id="time" style="width: 250px;" readonly="readonly" />
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">语言版本：</label>
                <input type="text" id="language" name="language" placeholder="请输入语音版本..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">放映厅：</label>
                <input type="text" id="hall" name="hall" placeholder="请输入放映厅..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">票价：</label>
                <input type="number" id="price" onkeyup="this.value= this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : ''" min="0.01" name="price" step="0.01" placeholder="请输入票价..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">座位行数：</label>
                <input type="number" id="row" name="row" min="1" oninput="this.value=this.value.replace(/\D/g);" placeholder="请输入座位行数..." style="width: 250px; float: none">
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">座位列数：</label>
                <input type="number" id="col" name="col" min="1" oninput="this.value=this.value.replace(/\D/g);" placeholder="请输入座位列数..." style="width: 250px; float: none">
            </div>
        </form>

    </div><!-- #dialog-message -->

    <div id="confirm-message" class="hide">
        <p style="margin-top:10px;">确定要删除此条数据吗？</p>
    </div><!-- #dialog-confirm -->

    <%@include file="../common/footer.jsp"%>

</div><!-- /.main-container -->

<!-- basic scripts -->

<%@include file="../common/url.jsp"%>


<script type="text/javascript">
    $(function(){
        $('#datepicker').datetimepicker().next().on(ace.click_event, function(){
            $(this).prev().focus();
        });
        getPage(1, $("#search-name").val());
        $('#table').bootstrapTable({
            url: 'list',
            method: 'post',
            columns: [{
                checkbox: true,
            },{
                field: 'id',
                title: '场次编号',
                width: '100px'
            },{
                field: 'movie.name',
                title: '所属电影',
                width: '100px',
                formatter: function (value, row, index) {
                    return row.movie.name;
                }
            },{
                field: 'cinema.name',
                title: '所属电影院',
                width: '100px',
                formatter: function (value, row, index) {
                    return row.cinema.name;
                }
            },{
                field: 'time',
                title: '放映时间',
                width: '100px',
                formatter: function (value, row, index) {
                    return formatYMDHM(value);
                }
            },{
                field: 'language',
                title: '语言版本',
                width: '80px'
            },
            {
                field: 'hall',
                title: '放映厅',
                width: '80px'
            },
            {
                field: 'price',
                title: '票价',
                width: '80px',
                formatter: function(value,row,index){
                    return value + '元';
                }
            },
            {
                field: 'row',
                title: '行数',
                width: '50px'
            },
            {
                field: 'col',
                title: '列数',
                width: '50px'
            },
            {
                field: 'totalSeat',
                title: '总座位数',
                width: '80px'
            },
            {
                field: 'orderSeat',
                title: '已订购座位数',
                width: '80px'
            }]
        })
    });
    var dialog;
    function openDialog(title, type) {
        if(type === 'add'){
            $("#id").val('');
            $("#datepicker").val('');
            $("#language").val('');
            $("#hall").val('');
            $("#price").val('');
            $("#row").val('');
            $("#col").val('');
        } else if(type === 'edit') {
            let selectRow = $('#table').bootstrapTable('getSelections');
            if(selectRow.length !== 1){
                commonUtil.message('请选择一条数据进行修改！', 'danger');
                return false;
            }else {
                let row = selectRow[0];
                $("#id").val(row.id);
                $("#movieId").val(row.movieId);
                $("#cinemaId").val(row.cinemaId);
                $("#datepicker").val(formatYMDHMAPM(row.time));
                $("#language").val(row.language);
                $("#hall").val(row.hall);
                $("#price").val(row.price);
                $("#row").val(row.row);
                document.getElementById("row").readOnly = true;
                $("#col").val(row.col);
                document.getElementById("col").readOnly = true;
            }
        }
        dialog = $("#dialog-message").removeClass('hide').dialog({
            modal: true,
            width: '400',
            height: '480',
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
