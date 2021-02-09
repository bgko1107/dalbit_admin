<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />

<!-- serachBox -->
<form id="searchForm">
    <div class="col-lg-12 no-padding form-inline">
        <div class="col-md-6 no-padding">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                        </th>
                        <td style="text-align: left">
                            <span id="searchRadio"></span>
                            <div class="input-group date" id="seldate" style="display: none;">
                                <label for="onedayDate" class="input-group-addon">
                                    <span><i class="fa fa-calendar" id="seldateDateBtn"></i></span>
                                </label>
                                <input type="text" class="form-control" id="onedayDate" name="onedayDate" style="width: 90px">
                            </div>
                            <span id="searchMemberArea" onchange="btSearchClick();"></span>
                            <span id="searchBroadArea" onchange="btSearchClick();" style="display: none"></span>
                            <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." ></label>

                            <button type="button" class="btn btn-success" id="bt_search">검색</button>

                            <span id="searchCheck">
                                <label class="control-inline fancy-checkbox custom-color-green">
                                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                    <span>테스트 아이디 제외</span>
                                </label>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="col-md-6 pull-right no-padding" id="divLive">
            <span id="live_summaryArea"></span>
            <%--<span id="dj_typeSummaryArea"></span>--%>
            <%--<span id="platform_summaryArea"></span>--%>
        </div>

        <div class="col-md-6 pull-right no-padding" id="divLiveListen" style="display: none">
            <div class="col-md-7 no-padding pull-right">
                <span id="live_summaryArea2"></span>
            </div>
            <div class="col-md-5 no-padding pull-right">
                <span id="liveListener_summaryArea"></span>
            </div>
        </div>

        <div class="col-md-6 pull-right no-padding" id="divLivelogin" style="display: none">
            <span id="login_summaryArea"></span>
        </div>

        <div class="col-md-6 pull-right no-padding" id="divLiveGuest" style="display: none">
            <span id="liveGuest_summaryArea"></span>
        </div>

    </div>
</form>

<jsp:include page="../../searchArea/daySearchFunction.jsp"/>

<!-- //serachBox -->
<!-- DATA TABLE -->
<div class="col-lg-12 no-padding form-inline">

    <!-- DATA TABLE -->
    <ul class="nav nav-tabs nav-tabs-custom-colored mt5">
        <li class="active"><a href="#liveList" role="tab" data-toggle="tab" id="tab_liveList" onclick="liveList(1);" >실시간 방송</a></li>
        <li><a href="#liveListener" role="tab" data-toggle="tab" id="tab_liveListener" onclick="getListenUserList_tabClick(3);">실시간 청취자</a></li>
        <li><a href="#liveGuest" role="tab" data-toggle="tab" id="tab_liveGuest" onclick="getliveGuest_tabClick(5);">실시간/종료 게스트</a></li>
        <li><a href="#loginUserList" role="tab" data-toggle="tab" id="tab_LoginUser" onclick="getLoginUserList_tabClick(4);">방송 외 접속 회원</a></li>
        <li><a href="#liveList" role="tab" data-toggle="tab" id="tab_endBrodList" onclick="liveList(2);">종료 방송</a></li>
    </ul>
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="liveList" >
            <div class="widget widget-table">
                <div class="col-md-12">
                    <br/>
                    <label id="liveTitle">
                        ㆍ실시간 생방송 시작된 방송이 최상위 누적되어 보여집니다.<br/>
                        ㆍDJ가 방송을 완료한 경우 해당 방송은 리스트에서 삭제됩니다.<br/>
                        ㆍ실시간 방송 랭킹 점수 산출 방법<br/>
                        &nbsp&nbsp&nbsp: 받은별(부스터 제외) 1점 + 누적청취자 2점 + 좋아요(부스터 제외) 1점 + 부스터(만료) 20점 + 부스터(진행) 30점 <br/>
                        &nbsp※ 스페셜DJ 부스터 효과는 부스터0건(진행중 1건)으로 표기 및 좋아요 10개 비누적 되며 10점이 추가됩니다.
                    </label>
                    <br/>
                    <span id="liveSort" onchange="sortChange();"></span>
                    <span id="endSort" style="display: none" onchange="sortChange();"></span>

                <c:if test="${fn:contains('|양대기|이재은|이형원|고병권|이재호|양효진|김자운|박창욱|황호성|이자연|전보선|', principal.getUserInfo().getName())}">
                    <button class="btn btn-green btn-sm print-btn" type="button" id="videoList" onclick="videoList_click();" style="background-color: #8556f6;color: white;">영상 모아보기</button>
                    <button class="btn btn-green btn-sm print-btn" type="button" onclick="videoListPop_click();" style="background-color: #8556f6;color: white;">영상 모아보기 팝업</button>
                </c:if>

                <c:if test="${fn:contains('|이재은|이형원|고병권|이재호|양효진|이상훈|', principal.getUserInfo().getName())}">
                    <button class="btn btn-danger btn-sm print-btn pull-right" type="button" id="inspection" onclick="inspection_click();">임시점검</button>
                </c:if>
                </div>
                <div id="div_allMedia">
                    <div class="widget-content" style="border-top-width:0px;">
                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                            <thead id="tableTop"></thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                        <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="liveexcelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                    </div>
                </div>
                <div id="div_video" style="display: none;" class="col-md-12 no-padding">
                    <div class="dataTables_paginate paging_full_numbers" id="videoList_info_paginate_top"></div>
                    <div class="col-md-12 no-padding">
                        <div class="list-group">
                            <form id="videoForm"></form>
                        </div>
                    </div>
                    <div class="dataTables_paginate paging_full_numbers" id="videoList_info_paginate"></div>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="liveListener"><jsp:include page="listenUser.jsp"/></div>
        <div class="tab-pane fade" id="liveGuest"><jsp:include page="liveGuest.jsp"/></div>
        <div class="tab-pane fade" id="loginUserList"><jsp:include page="loginUser.jsp"/></div>
    </div>
</div>
<!-- DATA TABLE END -->

<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script src="/js/webrtc_wowza_play.js"></script>
<script>
    $("#searchType_broad").html(util.getCommonCodeSelect(-1, searchType_broad));
    $("#searchRadio").html(util.getCommonCodeRadio(1, searchRadio));

    $("#liveSort").html(util.getCommonCodeSelect(0, liveSort));
    $("#endSort").html(util.getCommonCodeSelect(0, endSort));

    $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
    $("#searchBroadArea").html(util.getCommonCodeSelect(1, searchBroad));


    var date = new Date();
    var sDate;
    var eDate;

    var liveState = 1;
    var room_liveType = 1;
    var dtList_info="";
    // liveList(1);

    var tmp_slctType = -1;
    var tmp_dj_slctType = -1;
    var tmp_dj_searchText;
    var tmp_room_slctType = -1;
    var tmp_room_searchText;
    var tmp_searchText = "";
    var mediaType = 0;

    $("#onedayDate").val(date.getFullYear() +"-"+ common.lpad(date.getMonth() + 1,2,"0") +"-"+ common.lpad(date.getDate(),2,"0"));
    $('#seldate').datetimepicker({
        format: 'L',
        maxDate:new Date(),
        format: "YYYY-MM-DD",
    });
    sDate = date.getFullYear()  +"-"+ common.lpad(date.getMonth() + 1,2,"0")  +"-"+ common.lpad(date.getDate(),2,"0");        //오늘

    $(document).ready(function() {
        getSearch();
        livePageTabCount();
    });

    $('#searchRadio').change(function() {
        $("#searchMemberArea").hide();
        $("#searchBroadArea").hide();
        if($('input[name="searchRadio"]:checked').val() == "1"){
            $("#searchMemberArea").show();
            $("#searchType_broad").html(util.getCommonCodeSelect(-1, searchType_broad));
        }else{
            $("#searchBroadArea").show();
            $("#searchType_broad").html(util.getCommonCodeSelect(-1, searchBroad_broad));
        }
    });

    $('input[id="searchText"]').keydown(function() {
        if (event.keyCode === 13) {
            $('#bt_search').click();
        };
    });

    $('#bt_search').on('click', function(){
        livePageTabCount();

        if(liveState == 1 || liveState == 2){
            getSearch();
        }else if(liveState == 3){
            getListenUserList_tabClick();
        }else if(liveState == 4){
            getLoginUserList_tabClick();
        }else if(liveState == 5){
            getliveGuest_tabClick();
        }
    });

    $("#seldate").hide();

    var dtList_info_data = function (data) {
        var slctType = $('input[name="searchRadio"]:checked').val();
        data.slctType = slctType;
        if(slctType == "1"){      // DJ정보
            data.dj_slctType = $("select[name='searchType_broad']").val();
            data.dj_searchText = tmp_searchText;
            data.room_slctType = -1;
            data.room_searchText = "";
            data.ortStartDate =2;
        }else {                                                              // 방송정보
            data.dj_slctType = -1;
            data.dj_searchText = "";
            data.room_slctType = $("select[name='searchBroad_broad']").val();
            data.room_searchText = tmp_searchText;
            data.ortStartDate =2;
        }
        data.newSearchType = slctType == 1 ? $("#searchMember").val() : $("#searchBroad").val();
        data.room_liveType = room_liveType;

        /*
        *   정렬 부분
        */
        if(liveState == 1) {
            if($("select[name='liveSort']").val() != 0){
                if ($("select[name='liveSort']").val() == 1)
                    data.sortStartDate = 1;
                if ($("select[name='liveSort']").val() == 2)
                    data.sortAirTime = 1;
                if ($("select[name='liveSort']").val() == 3)
                    data.sortListener = 1;
                if ($("select[name='liveSort']").val() == 4)
                    data.sortListener = 0;
                if ($("select[name='liveSort']").val() == 5)
                    data.sortGift = 1;
                if ($("select[name='liveSort']").val() == 6)
                    data.sortByeol = 1;
                if ($("select[name='liveSort']").val() == 7)
                    data.sortMoon = 1;
            }
        }else if(liveState == 2) {
            if($("select[name='endSort']").val() != 0){
                if ($("select[name='endSort']").val() == 2)
                    data.sortAirTime = 1;
                if ($("select[name='endSort']").val() == 3)
                    data.sortListener = 1;
                if ($("select[name='endSort']").val() == 4)
                    data.sortListener = 0;
                if ($("select[name='endSort']").val() == 5)
                    data.sortGift = 1;
                if ($("select[name='endSort']").val() == 6)
                    data.sortByeol = 1;
                if ($("select[name='endSort']").val() == 7)
                    data.sortMoon = 1;
            }
        }
        data.startDate = $("#onedayDate").val() + ' 00:00:00';
        data.endDate = $("#onedayDate").val() + ' 23:59:59';
    };
    if(liveState == 1){
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, BroadcastDataTableSource.liveList);
    }else{
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, BroadcastDataTableSource.endLiveList);
    }
    dtList_info.useCheckBox(false);
    dtList_info.useIndex(true);
    dtList_info.setPageLength(100);
    dtList_info.createDataTable(summary_table);


    function liveList(tmp){
        liveState = tmp;
        if(tmp == 1){
            $("#liveTitle").html("ㆍ실시간 생방송 시작된 방송이 최상위 누적되어 보여집니다.<br/>ㆍDJ가 방송을 완료한 경우 해당 방송은 리스트에서 삭제됩니다.");
            $("#liveSort").show();
            $("#endSort").hide();
            $("#seldate").hide();
        }else if(tmp == 2){
            $("#liveTitle").html("ㆍ종료된 방송은 방송종료일을 기준으로 최상위 누적되어 보여집니다.<br/>" +
                "ㆍDJ가 방송을 완료한 경우 해당 방송은 리스트에서 추가됩니다.");
            $("#liveSort").hide();
            $("#endSort").show();
            $("#seldate").show();
        }

        $("#divLive").show();
        $("#divLiveListen").hide();
        $("#divLivelogin").hide();
        $("#divLiveGuest").hide();

        room_liveType = tmp;

        if(liveState != 1){
            dtList_info.changeReload(null,dtList_info_data,BroadcastDataTableSource.endLiveList,summary_table);
        }
        if(liveState == 1){
            dtList_info.changeReload(null,dtList_info_data,BroadcastDataTableSource.liveList,summary_table);
        }

        livePageTabCount();

        // getSearch();
    }

    function summary_table(json){
        if(!common.isEmpty(json.summary)){
            json.summary.liveState = liveState;
            var template = $("#live_tableSummary").html();
            var templateScript = Handlebars.compile(template);
            var data = {
                content : json.summary
                , length : json.recordsTotal
            };
            var html = templateScript(data);
            $("#live_summaryArea").html(html);
        }
    }

    function fn_inspection_check_success(dst_id, response){
        response.data.type == "1" ? $("#inspection").text("임시점검") : $("#inspection").text("임시점검 해제");
    }

    function getSearch(){
        /* 엑셀저장을 위해 조회조건 임시저장 */
        tmp_searchText = $('#searchText').val();
        var slctType = $('input[name="searchRadio"]:checked').val();
        tmp_slctType = slctType;
        tmp_dj_searchText = $('#searchText').val();
        tmp_room_searchText = $('#searchText').val();
        // if(slctType == "1"){
        //     tmp_dj_slctType = $("select[name='searchType_broad']").val();
        // }else {
        //     tmp_room_slctType = $("select[name='searchBroad_broad']").val();
        // }
        dtList_info.reload(summary_table);

        console.log(mediaType);
        if(mediaType == 1){
            videoList();
        }
    }

    function sortChange(){
        dtList_info.reload(summary_table);
    }

    /*=============엑셀==================*/
    $('#liveexcelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("slctType", tmp_slctType);
        formData.append("dj_slctType", tmp_dj_slctType);
        formData.append("dj_searchText", tmp_dj_searchText);
        formData.append("room_slctType", tmp_room_slctType);
        formData.append("room_liveType", room_liveType);
        formData.append("startDate", $("#onedayDate").val() + ' 00:00:00');
        formData.append("endDate", $("#onedayDate").val() + ' 23:59:59');
        util.excelDownload($(this), "/rest/broadcast/broadcast/liveListExcel", formData)
    });

    function forcedEnd(cancelData){
        if(confirm("방송강제 종료 시도 하시겠습니까?")){
            var data = {};
            data.mem_no = cancelData.memno;
            data.room_no = cancelData.roomno;
            util.getAjaxData("forcedEnd", "/rest/member/broadcast/forcedEnd",data, forced_success);
        }else return false;
    }
    function forced_success(dst_id, response) {
        alert(response.message);
        dtList_info.reload(summary_table);
    }

    function broadCastLivePopUp(room_no, type){
        var popupUrl = "/broadcast/broadcast/popup/broadcastPopup?roomNo="+room_no + "&type=" + type;
        util.windowOpen(popupUrl,"1450", "700","방송정보");
    }

    function livePageTabCount(){
        var data = {};

        util.getAjaxData("livePageTabCount", "/rest/broadcast/broadcast/tabCount",data, tabCount_success);

        var data = {};

        util.getAjaxData("inspection", "/rest/member/broadcast/inspection/check",data, fn_inspection_check_success);
    }

    function tabCount_success(dst_id, response){
        for(var i=0;i<response.data.length;i++){
            if(response.data[i].tabType == "live"){
                if(liveState == 1) {
                    $("#tab_liveList").text("실시간 방송(" + response.data[i].totalCnt + ")");
                }
            }else if(response.data[i].tabType == "lis"){
                $("#tab_liveListener").text("실시간 청취자(" + response.data[i].totalCnt + ")");
            }else if(response.data[i].tabType == "guest"){
                $("#tab_liveGuest").text("실시간/종료 게스트(" + response.data[i].totalCnt + ")");
            }else if(response.data[i].tabType == "login"){
                $("#tab_LoginUser").text("방송 외 접속 회원(" + response.data[i].totalCnt + ")");
            }
        }
    }

    function inspection_click(){
        if($("#inspection").text() == "임시점검"){
            if(confirm("임시점검 설정 입니다.\n진행중인방이 전부 종료되고 방 생성이 임시 정지 됩니다.")){
                $("#inspection").text("임시점검 해제");
                var data = {};
                data.type = "1";
                // data.roomNo="91607910501425";
                util.getAjaxData("inspection", "/rest/member/broadcast/inspection",data, fn_inspection_success);
            }
        }else{
            if(confirm("방생성 제한 기능이 해제 됩니다.")){
                $("#inspection").text("임시점검");
                var data = {};
                data.type = "0";
                util.getAjaxData("inspection", "/rest/member/broadcast/inspection",data, fn_inspection_success);
            }
        }
    }

    function fn_inspection_success(dst_id, response, param){
        if(param.type == "1"){
            alert("임시점검 설정");
        }else{
            alert("임시점검 해제");
        }
        $("#bt_search").click();
    }

    //=------------------------------ video--------------------------------------------
    var videoPagingInfo= new PAGING_INFO(0, 1, 12);

    function videoList_click(){
        $("#div_allMedia").hide();
        $("#div_video").hide();
        if($("#videoList").text() == "영상 모아보기"){
            mediaType = 1;
            $("#videoList").text("영상 모아보기 해제");
            $("#div_video").show();
        }else{
            mediaType = 0;
            $("#videoList").text("영상 모아보기");
            $("#div_allMedia").show();
        }
        $('#bt_search').click();
    }

    function videoListPop_click(){
        util.windowOpen("/broadcast/live/popup/cctv");
    }

    function videoList(pagingNo) {
        if(!common.isEmpty(pagingNo)){
            videoPagingInfo.pageNo = pagingNo;
        }else{
            videoPagingInfo.pageNo = 1;
        }

        var data={};
        var slctType = $('input[name="searchRadio"]:checked').val();
        data.slctType = slctType;
        if(slctType == "1"){      // DJ정보
            data.dj_slctType = $("select[name='searchType_broad']").val();
            data.dj_searchText = tmp_searchText;
            data.room_slctType = -1;
            data.room_searchText = "";
            data.ortStartDate =2;
        }else {                                                              // 방송정보
            data.dj_slctType = -1;
            data.dj_searchText = "";
            data.room_slctType = $("select[name='searchBroad_broad']").val();
            data.room_searchText = tmp_searchText;
            data.ortStartDate =2;
        }
        data.room_liveType = 1;
        /*
        *   정렬 부분
        */
        if($("select[name='liveSort']").val() != 0){
            if ($("select[name='liveSort']").val() == 1)
                data.sortStartDate = 1;
            if ($("select[name='liveSort']").val() == 2)
                data.sortAirTime = 1;
            if ($("select[name='liveSort']").val() == 3)
                data.sortListener = 1;
            if ($("select[name='liveSort']").val() == 4)
                data.sortListener = 0;
            if ($("select[name='liveSort']").val() == 5)
                data.sortGift = 1;
            if ($("select[name='liveSort']").val() == 6)
                data.sortByeol = 1;
            if ($("select[name='liveSort']").val() == 7)
                data.sortMoon = 1;
        }
        data.startDate = $("#onedayDate").val() + ' 00:00:00';
        data.endDate = $("#onedayDate").val() + ' 23:59:59';
        data.pageNo = videoPagingInfo.pageNo;
        data.pageCnt = videoPagingInfo.pageCnt;

        console.log(data);
        util.getAjaxData("video", "/rest/broadcast/broadcast/video/list", data, fn_video_success, fn_fail);
    };

    function fn_video_success(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_videoSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $("#videoForm").html(html);

        //video play
        $('._videoPlayer').each(function(){
            videoPlay($(this));
        });

        videoPagingInfo.totalCnt = response.pagingVo.totalCnt;

        console.log(videoPagingInfo);
        util.renderPagingNavigation("videoList_info_paginate_top", videoPagingInfo);
        util.renderPagingNavigation("videoList_info_paginate", videoPagingInfo);

        $("#summaryArea").empty();

        var template = $('#tmp_videoSummary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $('#summaryArea').html(html);

        ui.paintColor();
    };

    function videoPlay(me){
        var video_state = $(me).parent().find('._video_state');

        var adapter;
        let info = {
            wsUrl : WOWZA_VIDEO_SERVER_URL,
            applicationName : 'edge',
            streamName : WOWZA_PREFIX+me.data('roomno')+WOWZA_SUFFIX
        };

        adapter = WebRTCPlayAdapter();
        adapter.on('error', error => {
            if(error !== undefined){
                video_state.text(" [플레이어 실행 오류] " + error);
                return false;
            }
        });

        adapter.on('pcStateChange', state => {
            if(state == 'connecting'){
                video_state.text("방송방 연결중....");
            }
            if (state == 'connected') {
                video_state.text("");
                remoteVideo = document.getElementById('video_'+me.data('roomno'));
                try{
                    remoteVideo.srcObject = adapter.getStream();
                } catch (error){
                    remoteVideo.src = window.URL.createObjectURL(adapter.getStream());
                }
            }
            if (state == 'disconnected' || state == 'failed') {
                stop();
                video_state.text("연결이 종료되었습니다.");
            }
        });

        adapter.start(info);
        video_state.text("방송방 연결시도중..");
    }

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "videoList_info_paginate_top" || targetId == "videoList_info_paginate"){
            videoPagingInfo = pagingInfo;
            videoList(pagingInfo.pageNo);
        }
    }

    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);
        console.log(data, textStatus, jqXHR);
    }

    function videoPopUp(data){
        console.log(data);
    }

    $(document).on('click', '._refresh', function(){
        var me = $(this);
        var target = $("#video_"+me.data('roomno'));
        videoPlay(target);

        var icon = me.find('i._spin');
        icon.toggleClass('rotate');

    });

    function btSearchClick(){
        $("#bt_search").click();
    }
</script>

<script id="live_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <tr>
            <th colspan="10" style="background-color: #8faadc">방송방</th>
            <th colspan="4" style="background-color: #f4b183">청취자</th>
        </tr>
        <tr>
            <th colspan="2" style="background-color: #dae3f3;">방송구분</th>
            <th colspan="2" style="background-color: #dae3f3;">DJ구분</th>
            <th colspan="3" style="background-color: #dae3f3;">플랫폼</th>
            <th colspan="3" style="background-color: #dae3f3;">DJ성별</th>
            <th colspan="4" style="background-color: #fbe5d6;">청취자(게스트)성별</th>
        </tr>
        <tr>
            <th style="background-color: #b4c7e7">라디오</th>
            <th style="background-color: #b4c7e7">영상</th>
            <th style="background-color: #b4c7e7">일반(스페셜DJ)</th>
            <th style="background-color: #b4c7e7">신입</th>
            <th style="background-color: #b4c7e7">Android</th>
            <th style="background-color: #b4c7e7">IOS</th>
            <th style="background-color: #b4c7e7">PC</th>
            <th style="background-color: #b4c7e7">{{{sexIcon 'm'}}}</th>
            <th style="background-color: #b4c7e7">{{{sexIcon 'f'}}}</th>
            <th style="background-color: #b4c7e7">{{{sexIcon 'n'}}}</th>
            <th style="background-color: #f8cbad">신입</th>
            <th style="background-color: #f8cbad">{{{sexIcon 'm'}}}</th>
            <th style="background-color: #f8cbad">{{{sexIcon 'f'}}}</th>
            <th style="background-color: #f8cbad">{{{sexIcon 'n'}}}</th>
        </tr>
        <tr>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalAudioCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalVideoCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.normalDjCnt}} ({{addComma content.specialDjCnt}})</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.newDjCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalAosCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalIosCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalPcCnt}}</td>
            <td>{{addComma content.broadMaleCnt}}</td>
            <td>{{addComma content.broadFemaleCnt}}</td>
            <td>{{addComma content.broadNoneCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.newCnt}}명</td>
            <td>{{#dalbit_if content.liveState '==' 1}} {{addComma content.liveListenMaleCnt}} {{else}} {{addComma content.totalListenMaleCnt}} {{/dalbit_if}} ({{addComma content.guestMaleCnt}})</td>
            <td>{{#dalbit_if content.liveState '==' 1}} {{addComma content.liveListenFemaleCnt}} {{else}} {{addComma content.totalListenFemaleCnt}} {{/dalbit_if}} ({{addComma content.guestFemaleCnt}})</td>
            <td>{{#dalbit_if content.liveState '==' 1}} {{addComma content.liveListenNoneCnt}} {{else}} {{addComma content.totalListenNoneCnt}} {{/dalbit_if}} ({{addComma content.guestNoneCnt}})</td>
        </tr>
        <tr>
            <td class="font-bold" style="background-color: #d8d8d8;" colspan="4">총 수(방송중/끊김)</td>
            <td class="font-bold" style="background-color: #f2f2f2; color: #ed7d31" colspan="6">{{addComma content.totalBroadCastCnt}} ({{addComma content.broadStateNomal}}/{{addComma content.broadBreak}})</td>
            <td class="font-bold" style="background-color: #d8d8d8;" >총 수</td>
            <td class="font-bold" style="background-color: #f2f2f2; color: #ed7d31" colspan="3">{{#dalbit_if content.liveState '==' 1}} {{addComma content.liveListenerCnt}} {{else}} {{addComma content.totalListenerCnt}} {{/dalbit_if}} ({{addComma content.totalGuestCnt}})</td>
        </tr>
    </table>
</script>


<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_videoSelectFrm" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
    {{^equal data.image_path ''}}
    {{#dalbit_if data.inner '==' 1}}
        <div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
    {{else}}
        <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
    {{/dalbit_if}}
            <div>
                <label>NO.{{indexDesc ../../pagingVo.totalCnt data.rowNum}}</label>
                <a href="javascript://" class="_openVideoPlayerPop" data-roomno="{{data.room_no}}"><i class="fa fa-play-circle-o" style="font-size: 20px"></i></a>
                <a href="javascript://" class="_refresh" data-roomno="{{data.room_no}}"><i class="fa fa-refresh _spin pull-right" style="font-size: 20px"></i></a>
            </div>
            <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 480px;">
                <span class="_video_state"></span>
                <video id="video_{{data.room_no}}" class="_videoPlayer" data-roomno={{data.room_no}} style="width:100%;height:auto;" autoplay="autoplay" controls="controls" muted></video>
                <div>
                    <h4 class="inner list-group-item-heading broadcast_title">
                        {{{roomNoLink data.title data.room_no}}}
                    </h4>
                    <ul class="list-unstyled">
                        <li><strong>방송시작일시:</strong> {{substr data.start_date 0 19}}</li>
                        <li><strong>Nick:</strong> {{replaceHtml data.dj_nickname}}</li>
                        <li><strong>No:</strong> <a href="javascript://" class="_openMemberPop" data-memno="{{data.dj_mem_no}}" >{{data.dj_mem_no}} </a> </li>
                        <li class="sexType"><strong>Sex:</strong> {{{sexIcon data.dj_memSex}}}</li>
                    </ul>
                </div>
            </div>
        </div>
        {{/equal}}
        {{else}}
        <div class="col-md-12" style="text-align:center">
            <label>{{isEmptyData}}</label>
        </div>
        {{/each}}
</script>