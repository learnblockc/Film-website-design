// 分页初始化
function getPage(page, name) {
    $("#pagination").children('ul').remove();
    $.ajax({
        url:'page',
        dataType:'json',
        type:'post',
        data:{page: page, name: name},
        success:function(result){
            let html = '<ul class="pagination" id="pagination-ul" style="margin-top: 0px;">';
            if(result.page === 1){
                html += '<li class="disabled"><a href="javascript:void(0)"><i class="ace-icon fa fa-angle-double-left"></i></a></li>';
            } else {
                let prePage = result.page - 1;
                html += '<li><a onclick="searchName('+prePage+')" href="javascript:void(0)"><i class="ace-icon fa fa-angle-double-left"></i></a></li>';
            }
            if(result.page - 2 > 0){
                let prePage = result.page - 2;
                html += '<li id="'+prePage+'"><a href="javascript:void(0)" onclick="searchName('+prePage+')">'+prePage+'</a></li>'
            }
            if(result.page - 1 > 0){
                let prePage = result.page - 1;
                html += '<li id="'+prePage+'"><a href="javascript:void(0)" onclick="searchName('+prePage+')">'+prePage+'</a></li>'
            }
            html += '<li class="active" id="'+result.page+'"><a href="javascript:void(0)">'+result.page+'</a></li>';
            if(result.page + 1 <= result.totalPage){
                let nextPage = result.page + 1;
                html += '<li id="'+nextPage+'"><a href="javascript:void(0)" onclick="searchName('+nextPage+')">'+nextPage+'</a></li>'
            }
            if(result.page + 2 <= result.totalPage){
                let nextPage = result.page + 2;
                html += '<li id="'+nextPage+'"><a href="javascript:void(0)" onclick="searchName('+nextPage+')">'+nextPage+'</a></li>'
            }
            if(result.page === result.totalPage){
                html += '<li class="disabled"><a href="javascript:void(0)"><i class="ace-icon fa fa-angle-double-right"></i></a></li>';
            } else {
                let nextPage = result.page + 1;
                html += '<li><a href="javascript:void(0)" onclick="searchName('+nextPage+')"><i class="ace-icon fa fa-angle-double-right"></i></a></li>';
            }
            html += '</ul>';
            $("#pagination").html(html);
        },
        error:function () {
            commonUtil.message('网络错误！', 'danger');
        }
    });
}

// 订单状态返回处理
function filterOrderState(val) {
    switch (parseInt(val)) {
        case 1:
            return "已完成";
            break;
        case 2:
            return "已取消";
            break;
        case 3:
            return "未支付";
            break;
        default:
            return "";
            break;
    }
}

// 确认提示弹窗
var confirm;
function openConfirm() {
    let selectRow = $('#table').bootstrapTable('getSelections');
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
                        remove(selectRow[0]);
                    }
                }
            ]
        });
    }
}

// 保存数据
function save() {
    var data = serializeRemoveNull($("#dialog-form").serialize());
    $.ajax({
        url:'save',
        dataType:'json',
        type:'post',
        data:data,
        success:function(result){
            if(result.code === 0){
                commonUtil.message('保存成功！', 'success');
                dialog.dialog("close");
                $("#table").bootstrapTable('refresh');
                getPage(1, $("#search-name").val());
            }else {
                commonUtil.message(result.msg, 'danger');
            }
        },
        error:function () {
            commonUtil.message('网络错误！', 'danger');
        }
    });
}
// 表单序列化去空
function serializeRemoveNull(serStr){
    return serStr.split("&").filter(str => !str.endsWith("=")).join("&");
}
// 删除数据
function remove(item) {
    $.ajax({
        url:'delete',
        dataType:'json',
        type:'post',
        data:{id:item.id},
        success:function(result){
            if(result.code === 0){
                commonUtil.message('删除成功！', 'success');
                $("#table").bootstrapTable('refresh');
                searchName(1);
                getPage(1, $("#search-name").val());
            }else {
                commonUtil.message(result.msg, 'danger');
            }
        },
        error:function () {
            commonUtil.message('网络错误！', 'danger');
        }
    });
}

// 搜索内容
function searchName(page){
    $("#pagination-ul").children("li").removeClass("active");
    $("#"+page).addClass("active");
    let opt = {
        url: 'list?name=' + $("#search-name").val() + "&page=" + page
    };
    $("#table").bootstrapTable('refresh', opt);
    getPage(page, $("#search-name").val());
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
                $("#photo").val(result.data);
                commonUtil.message(result.msg, 'success');
            }else{
                commonUtil.message(result.msg, 'danger');
            }
        },
        error:function(){
            commonUtil.message('网络错误', 'danger');
        }
    });
}

// 打开上传图片的弹窗
function uploadPhoto(){
    $("#photo-file").click();
}

//时间格式显示
function add0(m){return m<10?'0'+m:m }
function formatYMDHMS(shijianchuo){
    //shijianchuo是整数，否则要parseInt转换
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    var h = time.getHours();
    var mm = time.getMinutes();
    var s = time.getSeconds();
    return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
}
function formatYMD(shijianchuo){
    //shijianchuo是整数，否则要parseInt转换
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    return y+'-'+add0(m)+'-'+add0(d);
}
function formatYMDHM(shijianchuo){
    //shijianchuo是整数，否则要parseInt转换
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    var h = time.getHours();
    var mm = time.getMinutes();
    return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm);
}
function formatYMDHMAPM(shijianchuo){
    //shijianchuo是整数，否则要parseInt转换
    var flag = 'AM';
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    var h = time.getHours();
    var mm = time.getMinutes();
    if(h === 12 && mm === 0){
        flag = 'PM';
    }else if(h >= 12 && mm > 0){
        flag = 'PM';
        h = h - 12;
    }else if(h === 0 && mm === 0){
        flag = 'AM';
        h = 12;
    }
    return add0(m)+'/'+add0(d)+'/'+y+' '+add0(h)+':'+add0(mm) + ' ' + flag;
}
function formatMDY(shijianchuo) {
    //shijianchuo是整数，否则要parseInt转换
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    return add0(m)+'/'+add0(d)+'/'+y;
}

//电影类型返回处理
function filterMovieType(val) {
    switch (parseInt(val)) {
        case 1:
            return "爱情";
            break;
        case 2:
            return "动作";
            break;
        case 3:
            return "喜剧";
            break;
        case 4:
            return "剧情";
            break;
        case 5:
            return "战争";
            break;
        case 6:
            return "惊悚";
            break;
        case 7:
            return "科幻";
            break;
        case 8:
            return "悬疑";
            break;
        case 9:
            return "犯罪";
            break;
        case 10:
            return "冒险";
            break;
        case 11:
            return "家庭";
            break;
        case 12:
            return "古装";
            break;
        case 13:
            return "动画";
            break;
        default:
            return '';
            break;
    }
}

//电影源地返回处理
function filterMovieArea(val) {
    switch (parseInt(val)) {
        case 1:
            return "中国大陆";
            break;
        case 2:
            return "美国";
            break;
        case 3:
            return "韩国";
            break;
        case 4:
            return "日本";
            break;
        case 5:
            return "中国香港";
            break;
        case 6:
            return "德国";
            break;
        case 7:
            return "印度";
            break;
        case 8:
            return "英国";
            break;
        case 9:
            return "法国";
            break;
        case 10:
            return "俄罗斯";
            break;
        case 11:
            return "意大利";
            break;
        default:
            return '';
            break;
    }
}

//演职人员类型返回处理
function filterActorType(val) {
    switch (parseInt(val)) {
        case 1:
            return "导演";
            break;
        case 2:
            return "演员";
            break;
        default:
            return '';
            break;
    }
}

