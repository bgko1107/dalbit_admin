<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />

<!-- DATA TABLE -->
<div class="col-lg-12 no-padding form-inline">

    <!-- DATA TABLE -->
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="liveList" >
            <div class="widget widget-table">
                <div id="div_video" class="col-md-12 no-padding">
                    <div class="col-md-12 no-padding">
                        <div class="list-group">
                            <form id="videoForm"></form>
                        </div>
                    </div>
                    <div class="dataTables_paginate paging_full_numbers" id="videoList_info_paginate"></div>
                    자동 세로고침 시간 설정 :
                    <select class="form-control searchType" id="_refreshTime">
                        <option value="10">10분</option>
                        <option value="30">30분</option>
                        <option value="0">안함</option>
                    </select>
                    페이징 갯수
                    <select class="form-control searchType" id="_pageCnt">
                        <option value="24">24개</option>
                        <option value="36">36개</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- DATA TABLE END -->

<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script src="/js/webrtc_wowza_play.js"></script>
<script type="text/javascript">

    var videoPagingInfo= new PAGING_INFO(0, 1, $("#_pageCnt").val());

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

    $(document).ready(function() {
        videoList();

        configAutoRefresh();
    });

    var autoRefreshId = '';
    var minute = 1000 * 60;
    function configAutoRefresh(){
        var refreshTime = $("#_refreshTime").val();
        if(0 < refreshTime){
            autoRefreshId = setInterval(refreshVideoList, refreshTime * minute);
        }
    }

    function broadCastLivePopUp(room_no, type){
        var popupUrl = "/broadcast/broadcast/popup/broadcastPopup?roomNo="+room_no + "&type=" + type;
        util.windowOpen(popupUrl,"1450", "700","방송정보");
    }

    function refreshVideoList(){
        videoList(videoPagingInfo.pageNo);
    }

    function videoList(pagingNo) {

        videoStop();

        if(!common.isEmpty(pagingNo)){
            videoPagingInfo.pageNo = pagingNo;
        }else{
            videoPagingInfo.pageNo = 1;
        }

        var data={};
        var slctType = '1';
        data.slctType = slctType;
        data.dj_slctType = $("select[name='searchType_broad']").val();
        data.dj_searchText = tmp_searchText;
        data.room_slctType = -1;
        data.room_searchText = "";
        data.ortStartDate =2;

        data.room_liveType = 1;

        data.startDate = moment(date).format("YYYY.MM.DD 00:00:00");
        data.endDate =  moment(date).format("YYYY.MM.DD 23:59:59");
        data.pageNo = videoPagingInfo.pageNo;
        data.pageCnt = videoPagingInfo.pageCnt;

        util.getAjaxData("video", "/rest/broadcast/broadcast/video/list", data, fn_video_success);

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

        var totalCnt = 0;
        if(response.result == 'success'){
            totalCnt = response.pagingVo.totalCnt;
        }
        videoPagingInfo.totalCnt = totalCnt;
        util.renderPagingNavigation("videoList_info_paginate", videoPagingInfo);

        ui.paintColor();
    };

    var adapterList = new array();

    function videoPlay(me){
        var video_state = $(me).parent().find('._video_state');

        var adapter;
        let info = {
            wsUrl : WOWZA_VIDEO_SERVER_URL,
            applicationName : 'edge',
            streamName : WOWZA_PREFIX+me.data('roomno')+WOWZA_SUFFIX
        };

        adapter = WebRTCPlayAdapter();
        adapterList.push(adapter);

        adapter.on('error', error => {
            if(error !== undefined){
                video_state.text(" [플레이어 실행 오류] " + error);
                //wowza_reconnect(me);
                if(adapter.repeaterRetryCount < 10){
                    wowza_reconnect(me);
                }
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
                //wowza_reconnect(me);
                return false;
            }
        });

        adapter.start(info);
        video_state.text("방송방 연결시도중..");
    }

    function videoStop(){
        adapterList.forEach(function(adapter, index){
            adapter.stop();
        })
    }

    function wowza_reconnect(me){
        console.log('reconnect');
        var video_refresh_btn = $(me).parent().parent().find('._refresh');
        var video_state = $(me).parent().find('._video_state');

        if(video_state.text != '재연결 시도중입니다.'){
            video_refresh_btn.click();
            video_state.text("재연결 시도중입니다.");
        }

    }

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "videoList_info_paginate"){
            videoPagingInfo = pagingInfo;
            videoList(pagingInfo.pageNo);
        }
    }

    $(document).on('click', '._refresh', function(){
        var me = $(this);

        //이전 동영상 play stop
        //adapterList
        var target = $("#video_"+me.data('roomno'));

        var videoIndex = $('._videoPlayer').index(target);
        adapterList.remove(videoIndex)

        videoPlay(target);

        var icon = me.find('i._spin');
        icon.toggleClass('rotate');

    });

    $(document).on('change', '#_refreshTime', function(){
        var val = $("#_refreshTime").val();
        clearInterval(autoRefreshId);
        if(0 < val){
            autoRefreshId = setInterval(refreshVideoList, val * minute);
        }

    });

    $(document).on('change', '#_pageCnt', function(){
        refreshVideoList()
    });
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
        <div class="item col-md-1 col-sm-1 mb15" style="padding-right: 3px;padding-left: 3px;display:inline;border:solid 1px;overflow:hidden;height:300px">
            <div style="height:100px;">
                <ul class="list-unstyled">
                    <li>
                        <strong>제목:</strong> <a href="javascript://" class="_openVideoPlayerPop" data-roomno="{{data.room_no}}">{{{roomNoLink data.title data.room_no}}}</a>
                        <a href="javascript://" class="_refresh" data-roomno="{{data.room_no}}"><i class="fa fa-refresh _spin pull-right" style="font-size: 20px"></i></a>
                    </li>
                    <li><strong>닉네임</strong> {{replaceHtml data.dj_nickname}}(<a href="javascript://" class="_openMemberPop" data-memno="{{data.dj_mem_no}}" >{{data.dj_mem_no}}</a>)</li>
                </ul>
            </div>
            <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;">
                <span class="_video_state"></span>
                <video id="video_{{data.room_no}}" class="_videoPlayer" data-roomno={{data.room_no}} style="width:141px;height:188px" autoplay="autoplay" controls="controls" muted></video>
            </div>
        </div>
    {{/equal}}
{{else}}
    <div class="col-md-12" style="text-align:center">
        <label>{{isEmptyData}}</label>
    </div>
{{/each}}
</script>