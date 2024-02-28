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
                    <li class="active">订单列表</li>
                </ul><!-- /.breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <button class="btn btn-sm btn-warning" style="margin-bottom: 4px;" onclick="viewOrderItem()">
                        <i class="ace-icon glyphicon glyphicon-eye-open"></i>
                        查看详情
                    </button>
                    <button class="btn btn-sm btn-info" style="margin-bottom: 4px;" onclick="openDialog('修改订单状态')">
                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                        修改状态
                    </button>
                    <button class="btn btn-sm btn-danger" style="margin-bottom: 4px;" onclick="openConfirm()">
                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                        删除
                    </button>
                    <input type="text" id="search-name" placeholder="请输入订单号..." style="width: 200px; float: none">
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
                <label style="width: 100px;">订单编号：</label>
                <span id="order-id"></span>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">订单号：</label>
                <span id="order-no"></span>
            </div>
            <div style="margin: 10px 0px;">
                <label style="width: 100px;">订单状态：</label>
                <select name="state" id="order-state" style="width: 250px; float: none">
                    <option value="1">已完成</option>
                    <option value="2">已取消</option>
                    <option value="3">未支付</option>
                </select>
            </div>
        </form>

    </div><!-- #dialog-message -->

    <div id="order-item-dialog" class="hide">
        <div style="margin: 10px 0px;">
            <label style="width: 100px;">订单编号：</label>
            <span id="view-order-id"></span>
        </div>
        <div style="margin: 10px 0px;">
            <label style="width: 100px;">订单号：</label>
            <span id="view-order-no"></span>
        </div>
        <div style="margin: 10px 0px;">
            <label style="width: 100px;">放映厅：</label>
            <span id="view-session-hall"></span>
        </div>
        <div style="height: 360px;overflow: auto;">
            <table id="order-item-table"></table>
        </div>
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
        getPage(1, $("#search-name").val());
        $('#table').bootstrapTable({
            url: 'list',
            method: 'post',
            columns: [{
                checkbox: true,
            },{
                field: 'id',
                title: '订单编号',
                width: '100px'
            },{
                field: 'tradeNo',
                title: '订单号',
                width: '180px'
            },{
                field: 'user.username',
                title: '所属用户',
                width: '120px',
                formatter: function(value,row,index){
                    return row.user.username;
                }
            },{
                field: 'moviePhoto',
                title: '电影海报',
                width: '110px',
                formatter: function(value,row,index){
                    let img = '<img src="../../common/file/view_photo?filename='+value+'" width="90px" height="60px"/>';
                    return img;
                }
            },{
                field: 'movieName',
                title: '电影名称',
                width: '150px'
            },{
                field: 'totalPrice',
                title: '订单总价',
                width: '100px',
                formatter: function(value,row,index){
                    return value + '元';
                }
            },{
                field: 'state',
                title: '订单状态',
                width: '100px',
                formatter: function(value,row,index){
                    return filterOrderState(value);
                }
            },{
                field: 'sessionTime',
                title: '放映时间',
                width: '150px',
                formatter: function(value,row,index){
                    return formatYMDHM(value)
                }
            },{
                field: 'createTime',
                title: '下单时间',
                width: '150px',
                formatter: function(value,row,index){
                    return formatYMDHMS(value)
                }
            }]
        })
    });
    var dialog;
    function openDialog(title) {
        let selectRow = $('#table').bootstrapTable('getSelections');
        if(selectRow.length !== 1){
            commonUtil.message('请选择一条数据进行修改状态！', 'danger');
            return false;
        }else {
            let row = selectRow[0];
            $("#id").val(row.id);
            $("#order-no").text(row.tradeNo);
            $("#order-id").text(row.id);
            $("#order-state").val(row.state);
        }
        dialog = $("#dialog-message").removeClass('hide').dialog({
            modal: true,
            width: '400',
            height: '300',
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

    var orderItemDialog;
    function viewOrderItem() {
        let selectRow = $('#table').bootstrapTable('getSelections');
        if(selectRow.length !== 1){
            commonUtil.message('请选择一条数据进行查看详情！', 'danger');
            return false;
        }else {
            let row = selectRow[0];
            $("#view-order-id").text(row.id);
            $("#view-order-no").text(row.tradeNo);
            $("#view-session-hall").text(row.sessionHall);
            $('#order-item-table').bootstrapTable({
                url: '../order/view?id='+row.id,
                method: 'post',
                columns: [{
                    field: 'id',
                    title: '编号',
                    width: '100px'
                },{
                    field: 'row',
                    title: '座位行数',
                    width: '100px'
                },{
                    field: 'col',
                    title: '座位列数',
                    width: '100px'
                },{
                    field: 'price',
                    title: '票价',
                    width: '100px',
                    formatter: function(value,row,index){
                        return value + '元';
                    }
                }]
            });
            orderItemDialog = $("#order-item-dialog").removeClass('hide').dialog({
                modal: true,
                width: '500',
                height: '500',
                title: "查看订单详情",
                buttons: [{
                        text: "确定",
                        "class": "btn btn-primary btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }]
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
