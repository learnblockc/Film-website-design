
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
function formatMDY(shijianchuo) {
    //shijianchuo是整数，否则要parseInt转换
    var time = new Date(shijianchuo);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    return add0(m)+'/'+add0(d)+'/'+y;
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

function getDate(i) {
    let date;
    switch (i) {
        case 1:
            // 当前日期
            date = new Date();
            break;
        case 2:
            // 明天日期
            date = new Date((new Date()).getTime() + 60000*60*24);
            break;
        case 3:
            // 后天日期
            date = new Date((new Date()).getTime() + 60000*60*24*2);
            break;
        case 4:
            // 大后天日期
            date = new Date((new Date()).getTime() + 60000*60*24*3);
            break;
    }
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    let currentDate = year + "年" + month + "月" + strDate + "日";
    return currentDate;
}
