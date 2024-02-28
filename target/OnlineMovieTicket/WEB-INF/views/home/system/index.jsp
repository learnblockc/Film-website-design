<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>一路有戏电影网</title>
</head>
<body>
<!-- ------------------------------------------------------------------- -->
<!-- 导航栏 -->
<%@include file="../common/header.jsp"%>


<!-- 主体 -->
<div class="main" style="height:1200px">
    <div class="main-inner main-page" style="margin-top: 3px;">
        <div class="layui-carousel" id="test3" lay-filter="test4">
            <div carousel-item="">
                <div>
                    <img src="../../resources/home/images/电影8.jpg">
                </div>
                <div>
                    <img src="../../resources/home/images/电影6.jpg">
                </div>
                <div>
                    <img src="../../resources/home/images/电影9.jpg">
                </div>
                <div>
                    <img src="../../resources/home/images/电影7.jpg">
                </div>
            </div>
        </div>
        <div class="aside">
            <!-- 3 -->
            <div class="most-expect-wrapper">
                <div class="panel">
                    <div class="panel-header">
                        <span class="panel-title">
                              <span class="textcolor_orange">评分排名</span>
                            </span>
                    </div>
                    <div class="panel-content">
                        <ul class="ranking-wrapper ranking-mostExpect" id="sortMovie">

                            <c:forEach var="movie" items="${rateMovieList}" varStatus="vs">
                                <li class="ranking-item ranking-top ranking-index-1" style="position: relative;margin-top:40px;">
                                    <i class="movie-rank">${vs.index + 1}</i>
                                    <a href="../movie/info?id=${movie.id}" data-act="mostExpect-movie-click" data-val="{movieid:1229534}">
                                        <div class="ranking-top-left">
                                            <img class="ranking-img  default-img" src="../../common/file/view_photo?filename=${movie.photo}" style=width:140px;height:194px>
                                        </div>
                                        <div class="ranking-top-right">
                                            <div class="ranking-top-right-main">
                                                <span class="ranking-top-moive-name">${movie.name}</span>
                                                <p class="ranking-release-time">上映时间：<fmt:formatDate value="${movie.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                                                <p class="ranking-top-wish">
                                                    <span class="stonefont">${movie.rate}</span>分
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="movie-grid">

            <div class="panel-header">
                    <span class="panel-more">
                        <a href="../movie/list" class="textcolor_red" data-act="all-playingMovie-click">
                            <span>全部</span>
                        </a>
                        <span class="panel-arrow panel-arrow-red"></span>
                    </span>
                <span class="panel-title hot-title">
                    <span class="textcolor_red">正在热映（${total}部）</span>
                </span>
            </div>
            <div class="panel-content">
                <ul class="movie-list movie-hot">
                    <c:forEach var="movie" items="${movieList}" varStatus="vs">
                        <li style="height:260px;margin-top:40px;margin-bottom: 40px;">
                            <div class="movie-item">
                                <a href="../movie/info?id=${movie.id}" data-act="playingMovie-click" data-val="1">
                                    <div class="movie-poster" style="cursor:default;">
                                        <img id="moive_picture" src="../../common/file/view_photo?filename=${movie.photo}" />
                                        <div class="movie-overlay movie-overlay-bg">
                                            <div class="movie-info">
                                                <div class="movie-score">
                                                    <i id="moive_score" class="integer">${movie.rate}</i>
                                                </div>
                                                <div class="movie-title movie-title-padding" title="${movie.name}">${movie.name}</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <div class="movie-detail movie-detail-strong movie-sale">
                                    <a href="../movie/info?id=${movie.id}" class="active" data-act="salePlayingMovie-click" data-val="{movieid:42964}">购 票</a>
                                </div>
                            </div>
                        </li>
                    </c:forEach>

                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 脚 -->
<%@include file="../common/footer.jsp"%>

<!-- ------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------- -->
<style>
    .movie-rank{
        position: absolute;
        z-index: 9999 !important;
        top: 0px;
        left: 0px;
        background-color: #ffb400;
        color: #fff;
        width: 20px;
        height: 20px;
        padding-left: 4px;
        font-size: 18px;
    }
</style>
<script>
    var clientHeight = document.documentElement.clientHeight;

    window.onload = function(){
        initHostMovie(); //初始化正在热映和即将上映电影
        initHeader();
    }

    //图片轮播
    layui.use(['carousel', 'form'], function(){
        var carousel = layui.carousel, form = layui.form;
        carousel.render({
            elem: '#test3'
            ,width: '100%'
            ,height: '420px'
            ,interval: 5000
        });
    });

    //初始化正在热映电影
    function initHostMovie(){
        var MoiveLiHot = $(".movie-hot");
        var MoiveLiOn = $(".movie-on");
        var sortMovie = $("#sortMovie");
        var htmlHot,htmlOn;
        var ListLength;
        var sortMovieList;
        var notice, sale;
        var HotNum = $(".hot-title");
        var OnNum = $(".on-title");
        var TempName;

        const obj = {"code":0,"data":[{"movie_actor":"甄子丹:叶问,吴樾:万宗华,吴建豪:赫文,斯科特·阿金斯:巴顿,李宛妲:若男","movie_boxOffice":0.0,"movie_cn_name":"叶问4：完结篇","movie_commentCount":12,"movie_country":"中国大陆","movie_detail":"因故来到美国唐人街的叶问（甄子丹 饰），意外卷入一场当地军方势力与华人武馆的纠纷，面对日益猖狂的民族歧视与压迫，叶问挺身而出，在美国海军陆战队军营拼死一战，以正宗咏春，向世界证明了中国功夫。","movie_director":"叶伟信","movie_duration":"120分钟","movie_fg_name":"葉問4","movie_id":2,"movie_picture":"/file/upload/head/53a1f31f-1b86-4fce-9ab9-c07981bff888.jpg","movie_score":8.7,"movie_state":1,"movie_type":"动作","releaseDate":1575043200000},{"movie_actor":"肖央:李维杰","movie_boxOffice":0.0,"movie_cn_name":"误杀","movie_commentCount":1,"movie_country":"中国大陆","movie_detail":"李维杰（肖央 饰）与妻子阿玉（谭卓 饰）打拼多年，膝下育有两个女儿。一个雨夜，一场意外，打破了这个家庭的宁静。而李维杰作为一个父亲，为了保全自己的家人，他不顾一切地决定瞒天过海……","movie_director":"柯文丽","movie_duration":"112分钟","movie_fg_name":"Sheep Without a Shepherd","movie_id":3,"movie_picture":"/file/upload/movies/c9dfbe5a616041ab8ccf593f46548f92.jpg","movie_score":3.7,"movie_state":1,"movie_type":"剧情 犯罪","releaseDate":1574956800000},{"movie_actor":"张子枫:江楠,于和伟:高铭,吴磊:陈乐云","movie_boxOffice":0.0,"movie_cn_name":"宠爱","movie_commentCount":2,"movie_country":"中国大陆","movie_detail":"电影《宠爱》共由6段温暖的故事组成，不同年龄段的人们，在宠物的陪伴和守护中，收获爱、发现爱，更重新学会爱。在“爱”的主线下，一系列关于亲情、友情、爱情的故事逐一展开。电影《宠爱》将于12月31日，全国公映，陪大家一起温暖跨年。","movie_director":"杨子","movie_duration":"108分钟","movie_fg_name":"Adoring","movie_id":4,"movie_picture":"/file/upload/head/a11b37ba-c96d-4ad2-bc92-4215e744914b.jpg","movie_score":9.0,"movie_state":1,"movie_type":"喜剧 爱情 剧情","releaseDate":1577808000000},{"movie_actor":":","movie_boxOffice":0.0,"movie_cn_name":"叶问","movie_commentCount":2,"movie_country":"大陆","movie_detail":"","movie_director":"叶问2","movie_duration":"","movie_fg_name":"ye2","movie_id":6,"movie_picture":"/file/upload/head/f03d48aa-f31c-46b9-a7df-a5b8b676084a.jpg","movie_score":7.0,"movie_state":1,"movie_type":"动作","releaseDate":1577980800000},{"movie_actor":"张涵予:刘长健,欧豪:徐奕辰,杜江:梁栋,袁泉:毕男,李沁:周雅文","movie_boxOffice":0.0,"movie_cn_name":"中国机长","movie_commentCount":2,"movie_country":"大陆","movie_detail":"根据2018年5月14日四川航空3U8633航班机组成功处置特情真实事件改编。机组执行航班任务时，在万米高空突遇驾驶舱风挡玻璃爆裂脱落、座舱释压的极端罕见险情，生死关头，他们临危不乱、果断应对、正确处置，确保了机上全部人员的生命安全，创造了世界民航史上的奇迹","movie_director":"刘伟强","movie_duration":"111分钟","movie_fg_name":"The Captain","movie_id":7,"movie_picture":"/file/upload/head/679e5220-af24-4e37-ab23-221b07b6a7c9.jpg","movie_score":4.0,"movie_state":1,"movie_type":"剧情","releaseDate":1569772800000},{"movie_actor":"王宝强:唐仁,刘昊然:秦风,肖央:宋义,刘承羽:陈英","movie_boxOffice":0.0,"movie_cn_name":"唐人街探案2","movie_commentCount":1,"movie_country":"大陆","movie_detail":"秦风接到唐仁的邀请来纽约参加其与阿香的婚礼。壕气逼人的唐仁迎接秦风，极尽招摇。岂料“婚礼”是唐仁为巨额奖金而参加的世界名侦大赛，比赛的内容是寻找杀害唐人街教父七叔的孙子的凶手。 受骗的秦风怒极欲走，却被纽约华人刑警陈英送来的讯息所吸引。七叔孙子的死法离奇，寻人上升为悬赏缉凶。“名侦探”们各显“其能”，鸡飞狗跳。众人调查的同时另一起案件发生，作案手法极其相似。原本锁定的凶手竟有了不在场证明，秦风不禁对自己的推理产生了怀疑。第三起案件发生连环案件。秦风、唐仁二人再次披挂，摆脱各路纠缠，闹翻纽约，几欲接近真相。第四起，与凶手失之交臂，诡计呼之欲出。真凶伏法，动机令人不寒而栗。看似完美结案的背后却隐藏着另一个发人深省的谜题 。","movie_director":" 陈思诚","movie_duration":"121分钟","movie_fg_name":"Detective Chinatown 2","movie_id":8,"movie_picture":"/file/upload/head/d9e1bf6e-385f-4a0f-875d-46627e85dd55.jpg","movie_score":3.0,"movie_state":1,"movie_type":"喜剧 动作 悬疑","releaseDate":1518710400000},{"movie_actor":"田中真弓:蒙奇·D·路飞（配音）,冈村明美:娜美（配音）,中井和哉:罗罗诺亚·索隆（配音）,山口胜平:乌索普（配音）,平田广明:香吉士（配音）","movie_boxOffice":0.0,"movie_cn_name":"航海王：狂热行动","movie_commentCount":1,"movie_country":"日本","movie_detail":"“航海王系列”第14部剧场版，也是《航海王》动画二十周年纪念之作。 以超新星为代表的众多航海家纷纷现身世界最大的航海家庆典——航海世博会。草帽航海团也收到了主办者费斯塔的邀请函，搭乘万里阳光号前往。原以为航海家们的狂热世博会只是为争夺“航海王罗杰留下的宝藏”，就在神秘宝藏争夺战如火如荼之际，阻挡在路飞等人面前的可怕威胁道格拉斯·巴雷特突然现身！暗藏阴谋的敌我混战一触即发……","movie_director":"大塚隆史","movie_duration":"101分钟","movie_fg_name":"ONE PIECE STAMPEDE","movie_id":9,"movie_picture":"/file/upload/head/c61bbee2-75ee-4bc2-b4c9-d33156dc36e8.jpg","movie_score":5.0,"movie_state":1,"movie_type":"动画 冒险","releaseDate":1570464000000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"aa","movie_commentCount":1,"movie_country":"大陆","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":10,"movie_picture":"/file/upload/head/3c0a744c-66fa-48fd-9b87-ce170cf7142c.jpg","movie_score":6.0,"movie_state":1,"movie_type":"传记","releaseDate":4103193600000},{"movie_actor":"道恩·强森:斯宾塞,凯文·哈特:弗里奇,杰克·布莱克:贝瑟尼,凯伦·吉兰:玛莎,尼克·乔纳斯:亚历克斯","movie_boxOffice":0.0,"movie_cn_name":"勇敢者游戏：决战丛林","movie_commentCount":2,"movie_country":"美国","movie_detail":"本片讲述了四名性格迥异的高中生意外穿越到险象环生的勇敢者游戏中，变身成为与自身性格外貌截然不同的游戏角色：瘦小“弱鸡”斯宾塞变成了大块头冒险家(道恩·强森 饰)，高大威猛的运动员福基变成了身材迷你的龟速行李手 (凯文· 哈特 饰)，万人迷校花贝瑟尼变成一个中年发福教授(杰克·布莱克 饰)，自闭内向的学霸玛莎变成了魅力十足的热辣女打手(凯伦·吉兰 饰)。四人惊魂 未定，就发现更大的危机已经来临：在各类猛兽的恐怖袭击和邪恶势力的夺命追逐中，他们必须要利用自身技能，并肩作战，才能赢得游戏，而这也是他们重返现实的唯一途径⋯⋯","movie_director":"杰克·卡斯丹","movie_duration":"119分钟","movie_fg_name":"Jumanji: Welcome to the Jungle","movie_id":11,"movie_picture":"/file/upload/head/716578ec-308e-41b9-a581-e7613f7c548f.jpg","movie_score":4.0,"movie_state":1,"movie_type":"动作 冒险","releaseDate":1515686400000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"a","movie_commentCount":0,"movie_country":"a","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":13,"movie_picture":"/file/upload/head/a905a2dc-af5c-4543-9f78-806cb2cad8cd.jpg","movie_score":0.0,"movie_state":1,"movie_type":"a","releaseDate":1577894400000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"a","movie_commentCount":0,"movie_country":"a","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":14,"movie_picture":"/file/upload/head/fc25b7bb-b95e-4246-8e24-422b1c302937.jpg","movie_score":0.0,"movie_state":1,"movie_type":"a","releaseDate":1577894400000},{"movie_actor":"2:2","movie_boxOffice":0.0,"movie_cn_name":"2","movie_commentCount":1,"movie_country":"2","movie_detail":"2","movie_director":"2","movie_duration":"2","movie_fg_name":"2","movie_id":16,"movie_picture":"/file/upload/head/81e455a3-21bb-488f-8ef3-13843751172c.jpg","movie_score":3.0,"movie_state":1,"movie_type":"2","releaseDate":1578067200000},{"movie_actor":"3:3","movie_boxOffice":0.0,"movie_cn_name":"3","movie_commentCount":1,"movie_country":"3","movie_detail":"3","movie_director":"3","movie_duration":"3","movie_fg_name":"3","movie_id":17,"movie_picture":"/file/upload/head/cbac3225-e231-4490-8ad7-360eaed02b75.jpg","movie_score":1.0,"movie_state":1,"movie_type":"3","releaseDate":1578067200000},{"movie_actor":"4:4","movie_boxOffice":0.0,"movie_cn_name":"4","movie_commentCount":0,"movie_country":"4","movie_detail":"4","movie_director":"4","movie_duration":"4","movie_fg_name":"4","movie_id":18,"movie_picture":"/file/upload/head/0ba3641a-94af-4431-a04f-95cf6c0bf019.jpg","movie_score":0.0,"movie_state":1,"movie_type":"4","releaseDate":1578067200000},{"movie_actor":"13:1","movie_boxOffice":0.0,"movie_cn_name":"13","movie_commentCount":0,"movie_country":"31","movie_detail":"3","movie_director":"13","movie_duration":"13","movie_fg_name":"13","movie_id":20,"movie_picture":"/file/upload/head/dd76493e-4f8b-4636-8e7f-a275aef0e95a.jpg","movie_score":0.0,"movie_state":1,"movie_type":"13","releaseDate":1438963200000},{"movie_actor":"张译:杨锐,黄景瑜:顾顺,海清:夏楠,杜江:徐宏,蒋璐霞:佟莉","movie_boxOffice":0.0,"movie_cn_name":"红海行动","movie_commentCount":0,"movie_country":"大陆","movie_detail":"本片主要讲述了索马里海域外，中国商船遭遇劫持，船员全数沦为阶下囚。蛟龙突击队沉着应对，潜入商船进行突袭，成功解救全部人质。返航途中，非洲北部伊维亚共和国发生政变，恐怖组织连同叛军攻入首都，当地华侨面临危险，海军战舰接到上级命令改变航向，前往执行撤侨任务。蛟龙突击队八人，整装待发。时间紧迫，在“撤侨遇袭可反击，相反则必须避免交火，以免引起外交冲突”的大原则下，海军战舰及蛟龙突击队深入伊维亚，在恶劣的环境之下，借助海陆等多种装备，成功转移等候在码头的中国侨民，并在激烈的遭遇战之后，营救了被恐怖分子追击的中国领事馆巴士。然而事情尚未完结，就在掩护华侨撤离之际，蛟龙突击队收到中国人质被恐怖分子劫持的消息。众人深感责任重大，义无反顾地再度展开营救行动。前方路途险恶，蛟龙突击队即将遭遇的，远不止人质营救那么简单,恐怖分子的惊天阴谋即将浮出水面…..","movie_director":"林超贤","movie_duration":"138分钟","movie_fg_name":"Operation Red Sea","movie_id":21,"movie_picture":"/file/upload/head/3ea74b51-9d77-48b5-9bbb-6ea776e2de56.jpg","movie_score":0.0,"movie_state":1,"movie_type":"剧情 动作","releaseDate":1518710400000},{"movie_actor":"贾玲:贾晓玲,张小斐:李焕英,沈腾:沈光林","movie_boxOffice":0.0,"movie_cn_name":"你好，李焕英","movie_commentCount":2,"movie_country":"中国大陆","movie_detail":"2001年的某一天，刚刚考上大学的贾晓玲（贾玲 饰）经历了人生中的一次大起大落。一心想要成为母亲骄傲的她却因母亲突遭严重意外，而悲痛万分。在贾晓玲情绪崩溃的状态下，竟意外的回到了1981年，并与年轻的母亲李焕英（张小斐 饰）相遇，二人形影不离，宛如闺蜜。与此同时，也结识了一群天真善良的好朋友。晓玲以为来到了这片“广阔天地”，她可以凭借自己超前的思维，让母亲“大有作为”，但结果却让晓玲感到意外 [3]  。","movie_director":"贾玲","movie_duration":"128 分钟","movie_fg_name":"Hi, Mom","movie_id":23,"movie_picture":"/file/upload/head/9bee1593-d552-4ee8-9524-eff5bb6f6c07.jpg","movie_score":8.0,"movie_state":1,"movie_type":"喜剧","releaseDate":1613059200000}],"count":17,"sort":[{"movie_actor":"张子枫:江楠,于和伟:高铭,吴磊:陈乐云","movie_boxOffice":0.0,"movie_cn_name":"宠爱","movie_commentCount":2,"movie_country":"中国大陆","movie_detail":"电影《宠爱》共由6段温暖的故事组成，不同年龄段的人们，在宠物的陪伴和守护中，收获爱、发现爱，更重新学会爱。在“爱”的主线下，一系列关于亲情、友情、爱情的故事逐一展开。电影《宠爱》将于12月31日，全国公映，陪大家一起温暖跨年。","movie_director":"杨子","movie_duration":"108分钟","movie_fg_name":"Adoring","movie_id":4,"movie_picture":"/file/upload/head/a11b37ba-c96d-4ad2-bc92-4215e744914b.jpg","movie_score":9.0,"movie_state":1,"movie_type":"喜剧 爱情 剧情","releaseDate":1577808000000},{"movie_actor":"甄子丹:叶问,吴樾:万宗华,吴建豪:赫文,斯科特·阿金斯:巴顿,李宛妲:若男","movie_boxOffice":0.0,"movie_cn_name":"叶问4：完结篇","movie_commentCount":12,"movie_country":"中国大陆","movie_detail":"因故来到美国唐人街的叶问（甄子丹 饰），意外卷入一场当地军方势力与华人武馆的纠纷，面对日益猖狂的民族歧视与压迫，叶问挺身而出，在美国海军陆战队军营拼死一战，以正宗咏春，向世界证明了中国功夫。","movie_director":"叶伟信","movie_duration":"120分钟","movie_fg_name":"葉問4","movie_id":2,"movie_picture":"/file/upload/head/53a1f31f-1b86-4fce-9ab9-c07981bff888.jpg","movie_score":8.7,"movie_state":1,"movie_type":"动作","releaseDate":1575043200000},{"movie_actor":"贾玲:贾晓玲,张小斐:李焕英,沈腾:沈光林","movie_boxOffice":0.0,"movie_cn_name":"你好，李焕英","movie_commentCount":2,"movie_country":"中国大陆","movie_detail":"2001年的某一天，刚刚考上大学的贾晓玲（贾玲 饰）经历了人生中的一次大起大落。一心想要成为母亲骄傲的她却因母亲突遭严重意外，而悲痛万分。在贾晓玲情绪崩溃的状态下，竟意外的回到了1981年，并与年轻的母亲李焕英（张小斐 饰）相遇，二人形影不离，宛如闺蜜。与此同时，也结识了一群天真善良的好朋友。晓玲以为来到了这片“广阔天地”，她可以凭借自己超前的思维，让母亲“大有作为”，但结果却让晓玲感到意外 [3]  。","movie_director":"贾玲","movie_duration":"128 分钟","movie_fg_name":"Hi, Mom","movie_id":23,"movie_picture":"/file/upload/head/9bee1593-d552-4ee8-9524-eff5bb6f6c07.jpg","movie_score":8.0,"movie_state":1,"movie_type":"喜剧","releaseDate":1613059200000},{"movie_actor":":","movie_boxOffice":0.0,"movie_cn_name":"叶问","movie_commentCount":2,"movie_country":"大陆","movie_detail":"","movie_director":"叶问2","movie_duration":"","movie_fg_name":"ye2","movie_id":6,"movie_picture":"/file/upload/head/f03d48aa-f31c-46b9-a7df-a5b8b676084a.jpg","movie_score":7.0,"movie_state":1,"movie_type":"动作","releaseDate":1577980800000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"aa","movie_commentCount":1,"movie_country":"大陆","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":10,"movie_picture":"/file/upload/head/3c0a744c-66fa-48fd-9b87-ce170cf7142c.jpg","movie_score":6.0,"movie_state":1,"movie_type":"传记","releaseDate":4103193600000},{"movie_actor":"田中真弓:蒙奇·D·路飞（配音）,冈村明美:娜美（配音）,中井和哉:罗罗诺亚·索隆（配音）,山口胜平:乌索普（配音）,平田广明:香吉士（配音）","movie_boxOffice":0.0,"movie_cn_name":"航海王：狂热行动","movie_commentCount":1,"movie_country":"日本","movie_detail":"“航海王系列”第14部剧场版，也是《航海王》动画二十周年纪念之作。 以超新星为代表的众多航海家纷纷现身世界最大的航海家庆典——航海世博会。草帽航海团也收到了主办者费斯塔的邀请函，搭乘万里阳光号前往。原以为航海家们的狂热世博会只是为争夺“航海王罗杰留下的宝藏”，就在神秘宝藏争夺战如火如荼之际，阻挡在路飞等人面前的可怕威胁道格拉斯·巴雷特突然现身！暗藏阴谋的敌我混战一触即发……","movie_director":"大塚隆史","movie_duration":"101分钟","movie_fg_name":"ONE PIECE STAMPEDE","movie_id":9,"movie_picture":"/file/upload/head/c61bbee2-75ee-4bc2-b4c9-d33156dc36e8.jpg","movie_score":5.0,"movie_state":1,"movie_type":"动画 冒险","releaseDate":1570464000000},{"movie_actor":"张涵予:刘长健,欧豪:徐奕辰,杜江:梁栋,袁泉:毕男,李沁:周雅文","movie_boxOffice":0.0,"movie_cn_name":"中国机长","movie_commentCount":2,"movie_country":"大陆","movie_detail":"根据2018年5月14日四川航空3U8633航班机组成功处置特情真实事件改编。机组执行航班任务时，在万米高空突遇驾驶舱风挡玻璃爆裂脱落、座舱释压的极端罕见险情，生死关头，他们临危不乱、果断应对、正确处置，确保了机上全部人员的生命安全，创造了世界民航史上的奇迹","movie_director":"刘伟强","movie_duration":"111分钟","movie_fg_name":"The Captain","movie_id":7,"movie_picture":"/file/upload/head/679e5220-af24-4e37-ab23-221b07b6a7c9.jpg","movie_score":4.0,"movie_state":1,"movie_type":"剧情","releaseDate":1569772800000},{"movie_actor":"道恩·强森:斯宾塞,凯文·哈特:弗里奇,杰克·布莱克:贝瑟尼,凯伦·吉兰:玛莎,尼克·乔纳斯:亚历克斯","movie_boxOffice":0.0,"movie_cn_name":"勇敢者游戏：决战丛林","movie_commentCount":2,"movie_country":"美国","movie_detail":"本片讲述了四名性格迥异的高中生意外穿越到险象环生的勇敢者游戏中，变身成为与自身性格外貌截然不同的游戏角色：瘦小“弱鸡”斯宾塞变成了大块头冒险家(道恩·强森 饰)，高大威猛的运动员福基变成了身材迷你的龟速行李手 (凯文· 哈特 饰)，万人迷校花贝瑟尼变成一个中年发福教授(杰克·布莱克 饰)，自闭内向的学霸玛莎变成了魅力十足的热辣女打手(凯伦·吉兰 饰)。四人惊魂 未定，就发现更大的危机已经来临：在各类猛兽的恐怖袭击和邪恶势力的夺命追逐中，他们必须要利用自身技能，并肩作战，才能赢得游戏，而这也是他们重返现实的唯一途径⋯⋯","movie_director":"杰克·卡斯丹","movie_duration":"119分钟","movie_fg_name":"Jumanji: Welcome to the Jungle","movie_id":11,"movie_picture":"/file/upload/head/716578ec-308e-41b9-a581-e7613f7c548f.jpg","movie_score":4.0,"movie_state":1,"movie_type":"动作 冒险","releaseDate":1515686400000},{"movie_actor":"肖央:李维杰","movie_boxOffice":0.0,"movie_cn_name":"误杀","movie_commentCount":1,"movie_country":"中国大陆","movie_detail":"李维杰（肖央 饰）与妻子阿玉（谭卓 饰）打拼多年，膝下育有两个女儿。一个雨夜，一场意外，打破了这个家庭的宁静。而李维杰作为一个父亲，为了保全自己的家人，他不顾一切地决定瞒天过海……","movie_director":"柯文丽","movie_duration":"112分钟","movie_fg_name":"Sheep Without a Shepherd","movie_id":3,"movie_picture":"/file/upload/movies/c9dfbe5a616041ab8ccf593f46548f92.jpg","movie_score":3.7,"movie_state":1,"movie_type":"剧情 犯罪","releaseDate":1574956800000},{"movie_actor":"王宝强:唐仁,刘昊然:秦风,肖央:宋义,刘承羽:陈英","movie_boxOffice":0.0,"movie_cn_name":"唐人街探案2","movie_commentCount":1,"movie_country":"大陆","movie_detail":"秦风接到唐仁的邀请来纽约参加其与阿香的婚礼。壕气逼人的唐仁迎接秦风，极尽招摇。岂料“婚礼”是唐仁为巨额奖金而参加的世界名侦大赛，比赛的内容是寻找杀害唐人街教父七叔的孙子的凶手。 受骗的秦风怒极欲走，却被纽约华人刑警陈英送来的讯息所吸引。七叔孙子的死法离奇，寻人上升为悬赏缉凶。“名侦探”们各显“其能”，鸡飞狗跳。众人调查的同时另一起案件发生，作案手法极其相似。原本锁定的凶手竟有了不在场证明，秦风不禁对自己的推理产生了怀疑。第三起案件发生连环案件。秦风、唐仁二人再次披挂，摆脱各路纠缠，闹翻纽约，几欲接近真相。第四起，与凶手失之交臂，诡计呼之欲出。真凶伏法，动机令人不寒而栗。看似完美结案的背后却隐藏着另一个发人深省的谜题 。","movie_director":" 陈思诚","movie_duration":"121分钟","movie_fg_name":"Detective Chinatown 2","movie_id":8,"movie_picture":"/file/upload/head/d9e1bf6e-385f-4a0f-875d-46627e85dd55.jpg","movie_score":3.0,"movie_state":1,"movie_type":"喜剧 动作 悬疑","releaseDate":1518710400000},{"movie_actor":"2:2","movie_boxOffice":0.0,"movie_cn_name":"2","movie_commentCount":1,"movie_country":"2","movie_detail":"2","movie_director":"2","movie_duration":"2","movie_fg_name":"2","movie_id":16,"movie_picture":"/file/upload/head/81e455a3-21bb-488f-8ef3-13843751172c.jpg","movie_score":3.0,"movie_state":1,"movie_type":"2","releaseDate":1578067200000},{"movie_actor":"3:3","movie_boxOffice":0.0,"movie_cn_name":"3","movie_commentCount":1,"movie_country":"3","movie_detail":"3","movie_director":"3","movie_duration":"3","movie_fg_name":"3","movie_id":17,"movie_picture":"/file/upload/head/cbac3225-e231-4490-8ad7-360eaed02b75.jpg","movie_score":1.0,"movie_state":1,"movie_type":"3","releaseDate":1578067200000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"a","movie_commentCount":0,"movie_country":"a","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":13,"movie_picture":"/file/upload/head/a905a2dc-af5c-4543-9f78-806cb2cad8cd.jpg","movie_score":0.0,"movie_state":1,"movie_type":"a","releaseDate":1577894400000},{"movie_actor":"a:a","movie_boxOffice":0.0,"movie_cn_name":"a","movie_commentCount":0,"movie_country":"a","movie_detail":"a","movie_director":"a","movie_duration":"a","movie_fg_name":"a","movie_id":14,"movie_picture":"/file/upload/head/fc25b7bb-b95e-4246-8e24-422b1c302937.jpg","movie_score":0.0,"movie_state":1,"movie_type":"a","releaseDate":1577894400000},{"movie_actor":"4:4","movie_boxOffice":0.0,"movie_cn_name":"4","movie_commentCount":0,"movie_country":"4","movie_detail":"4","movie_director":"4","movie_duration":"4","movie_fg_name":"4","movie_id":18,"movie_picture":"/file/upload/head/0ba3641a-94af-4431-a04f-95cf6c0bf019.jpg","movie_score":0.0,"movie_state":1,"movie_type":"4","releaseDate":1578067200000},{"movie_actor":"13:1","movie_boxOffice":0.0,"movie_cn_name":"13","movie_commentCount":0,"movie_country":"31","movie_detail":"3","movie_director":"13","movie_duration":"13","movie_fg_name":"13","movie_id":20,"movie_picture":"/file/upload/head/dd76493e-4f8b-4636-8e7f-a275aef0e95a.jpg","movie_score":0.0,"movie_state":1,"movie_type":"13","releaseDate":1438963200000},{"movie_actor":"张译:杨锐,黄景瑜:顾顺,海清:夏楠,杜江:徐宏,蒋璐霞:佟莉","movie_boxOffice":0.0,"movie_cn_name":"红海行动","movie_commentCount":0,"movie_country":"大陆","movie_detail":"本片主要讲述了索马里海域外，中国商船遭遇劫持，船员全数沦为阶下囚。蛟龙突击队沉着应对，潜入商船进行突袭，成功解救全部人质。返航途中，非洲北部伊维亚共和国发生政变，恐怖组织连同叛军攻入首都，当地华侨面临危险，海军战舰接到上级命令改变航向，前往执行撤侨任务。蛟龙突击队八人，整装待发。时间紧迫，在“撤侨遇袭可反击，相反则必须避免交火，以免引起外交冲突”的大原则下，海军战舰及蛟龙突击队深入伊维亚，在恶劣的环境之下，借助海陆等多种装备，成功转移等候在码头的中国侨民，并在激烈的遭遇战之后，营救了被恐怖分子追击的中国领事馆巴士。然而事情尚未完结，就在掩护华侨撤离之际，蛟龙突击队收到中国人质被恐怖分子劫持的消息。众人深感责任重大，义无反顾地再度展开营救行动。前方路途险恶，蛟龙突击队即将遭遇的，远不止人质营救那么简单,恐怖分子的惊天阴谋即将浮出水面…..","movie_director":"林超贤","movie_duration":"138分钟","movie_fg_name":"Operation Red Sea","movie_id":21,"movie_picture":"/file/upload/head/3ea74b51-9d77-48b5-9bbb-6ea776e2de56.jpg","movie_score":0.0,"movie_state":1,"movie_type":"剧情 动作","releaseDate":1518710400000}],"type":[{"喜剧":0.0},{"动作":0.0},{"爱情":0.0},{"动画":0.0},{"科幻":0.0},{"惊悚":0.0},{"冒险":0.0},{"犯罪":0.0},{"悬疑":0.0}]};

        //设置按照评分排名的电影
        if(obj.sort.length<8){
            sortMovieList = obj.sort.length;
        }
        else{
            sortMovieList = 8;
        }
        var htmlSort='';
        for(var i=0;i<sortMovieList;i++){
            var releaseDate = obj.sort[i].releaseDate;

        }

    }
    function datefomate(value) {
        if(value==null || value == undefined){
            return "";
        }
        var date = new Date(value);

        Y = date.getFullYear(),
            m = date.getMonth()+1,
            d = date.getDate(),
            H = date.getHours(),
            i = date.getMinutes(),
            s = date.getSeconds();
        return Y+'-'+m+'-'+d;
    };
</script>
<!-- ------------------------------------------------------------------- -->
</body>
</html>
