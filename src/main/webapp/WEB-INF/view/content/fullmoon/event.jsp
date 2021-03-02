<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />

<!-- 보름달 On/Off -->
<form id="condition5">
    <div class="col-lg-12 form-inline mt15 mb15">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3>보름달 기록</h3>
                <button type="button" class="btn btn-default btn-sm pull-right _fullmoonEventDetail" style="margin-top:2px;" id="regBtn" data-idx="0">신규 등록</button>
            </div>
            <div class="widget-content mt10">
                <table id="fullmoonYn" class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="5%"/>
                        <col width="5%"/>
                        <col width="20%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>진행중<br />여부</th>
                        <th>이벤트기간</th>
                        <th>보름달 완료<br />방송 합계</th>
                        <th>기본 보름달</th>
                        <th>슈퍼문</th>
                        <th>공헌 인원<br />합계</th>
                    </tr>
                    </thead>
                    <tbody id="fullmoonEventList">
                    </tbody>
                </table>

                <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
            </div>
        </div>

        <div class="mt15" id="fullmoonEventDetailArea"></div>

    </div>
</form>
<!-- //보름달 On/Off -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var fullmoonEventPagingInfo = new PAGING_INFO(0, 1, 20);

    function getFullmoonEventList(){
        var data = {
            pageNo : fullmoonEventPagingInfo.pageNo
            , pageCnt : fullmoonEventPagingInfo.pageCnt
        };
        util.getAjaxData("getFullmoonEventList", "/rest/content/fullmoon/event/list", data, function(dst_id, response) {
            var template = $("#tmp_fullmoonEventList").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#fullmoonEventList").html(html);
            $("#fullmoonEventDetailArea").empty();
        });
    }

    function render_detailTab(data){

        /*if(data.idx == 0){
            $("#fullmoonEventDetailArea").empty();
        }*/

        //if(0 == $("#fullmoonEventDetailArea #tabContainer").length){
            var template = $("#tmp_fullmoonEventDetail").html();
            var templateScript = Handlebars.compile(template);
            var context = data;
            var html = templateScript(context);
            $("#fullmoonEventDetailArea").html(html);
        //}
    }

    $(document).on('click', '._fullmoonEventDetail', function(){
        var me = $(this);
        var idx = me.data('idx');

        var data = {
            idx : me.data('idx')
        }

        render_detailTab(data);

        if(idx == 0){
            detailView(null);
            $('#start_date').datepicker();
            $('#end_date').datepicker();
            $('#banner_start_date').datepicker();
            $('#banner_end_date').datepicker();
        }else{
            getFullmoonDetail(data);
        }
    });

    function getFullmoonDetail(data){
        util.getAjaxData("getFullmoonEventList", "/rest/content/fullmoon/event/detail", data, function(dst_id, response) {
            var data = response.data;

            detailView(data);

            $('#start_date').datepicker('setDates', data.start_date);
            $('#end_date').datepicker('setDates', data.end_date);
            $('#banner_start_date').datepicker('setDates', data.banner_start_date);
            $('#banner_end_date').datepicker('setDates', data.banner_end_date);

            $('._previewBtn').click();

            util.commonCheckMarkingPlatform($("#fullmoonEventDetailArea"), "platform", data.platform);
        });
    }

    function detailView(data){

        var template = $("#tmp_fullmoonEventDetail_tabDetail").html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);
        $("#fullmoonTabContent").html(html);

        $("#start_date_hour").prop('style', 'width:45px;');
        $("#start_date_minute").prop('style', 'width:45px;');

        $("#end_date_hour").prop('style', 'width:45px;');
        $("#end_date_minute").prop('style', 'width:45px;');

        $("#banner_start_date_hour").prop('style', 'width:45px;');
        $("#banner_start_date_minute").prop('style', 'width:45px;');

        $("#banner_end_date_hour").prop('style', 'width:45px;');
        $("#banner_end_date_minute").prop('style', 'width:45px;');
    }


    $(document).on('click', '._previewBtn', function(){
        var me = $(this);
        var image_url = me.parent().find('.form-control').val();
        var imgae = '<img class="thumbnail fullSize_background no-margin no-padding" style="border:0px; border-radius:0px; width:100%;" src="'+image_url+'" /></a>';
        me.parent().parent().find('._prevArea').html(imgae);
    });

    $(document).on('click', '._saveBtn', function(){
        var data = makeFullmoonParameter();
        if(data != false){
            if(confirm('수정하시겠습니까?')){
                util.getAjaxData("updateFullmoonEvent", "/rest/content/fullmoon/event/update", data, function(dst_id, response) {
                    alert(response.message);
                    if(response.result == 'success'){
                        getFullmoonEventList();
                    }
                });
            }
        }
    });

    function makeFullmoonParameter(){

        var start_date = $("#start_date");
        if(common.isEmpty(start_date.val())){
            alert('이벤트 시작일을 입력해주세요.');
            start_date.focus();
            return false;
        }

        var end_date = $("#end_date");
        if(common.isEmpty(end_date.val())){
            alert('이벤트 종료일을 입력해주세요.');
            end_date.focus();
            return false;
        }

        var fullmoon_text = $("#fullmoon_text");
        if(common.isEmpty(fullmoon_text.val())){
            alert('보름달이 뜨는 날을 입력해주세요.');
            fullmoon_text.focus();
            return false;
        }

        var banner_start_date = $("#banner_start_date");
        if(common.isEmpty(banner_start_date.val())){
            alert('배너 시작일을 입력해주세요.');
            banner_start_date.focus();
            return false;
        }

        var banner_end_date = $("#banner_end_date");
        if(common.isEmpty(banner_end_date.val())){
            alert('배너 종료일을 입력해주세요.');
            banner_end_date.focus();
            return false;
        }


        var fullmoon_duration = $("#fullmoon_duration");
        if(common.isEmpty(fullmoon_duration.val())){
            alert('보름달 띄우기 이벤트 기간을 입력해주세요.');
            fullmoon_duration.focus();
            return false;
        }


        var platformCnt = $("#fullmoonDetailTable").find("input[name=platform]").length;
        if(platformCnt == 0){
            alert('플랫폼을 하나 이상 선택해주세요.');
            return false;
        }
        var platform = "111";
        var platform_all = $("#platform-1");
        if(!platform_all.prop('checked')){
            for(var i = 0; i < platformCnt; i++){
                if($("#fullmoonDetailTable").find("#platform"+(i+1)).is(":checked")){
                    platform += "1";
                }else{
                    platform += "0";
                }
            }
        }

        var pc_img_url= $("#pc_img_url");
        if(common.isEmpty(pc_img_url.val())){
            alert('pc 배너 이미지를 입력해주세요.');
            pc_img_url.focus();
            return false;
        }

        var mobile_img_url= $("#mobile_img_url");
        if(common.isEmpty(mobile_img_url.val())){
            alert('모바일 배너 이미지를 입력해주세요.');
            mobile_img_url.focus();
            return false;
        }

        var pc_link_url= $("#pc_link_url");
        if(common.isEmpty(pc_link_url.val())){
            alert('pc 링크를 입력해주세요.');
            pc_link_url.focus();
            return false;
        }

        var mobile_link_url= $("#mobile_link_url");
        if(common.isEmpty(mobile_link_url.val())){
            alert('모바일 링크를 입력해주세요.');
            mobile_link_url.focus();
            return false;
        }

        var view_yn = $("#detail_view_yn").prop('checked') ? 1 : 0;
        var is_view = $("#detail_is_view").prop('checked') ? 1 : 0;
        var ios_judge_view_on = $("#detail_ios_judge_view_on").prop('checked') ? 1 : 0;

        var data = {
            idx : common.isEmpty($("#idx").val()) ? 0 : $("#idx").val()
            , start_date : start_date.val() + ' ' +$("#start_date_hour").val() + ':' + $("#start_date_minute").val() + ':00'
            , end_date : end_date.val() + ' ' +$("#end_date_hour").val() + ':' + $("#end_date_minute").val() + ':59'
            , view_yn : view_yn
            , fullmoon_text : fullmoon_text.val()
            , banner_start_date : banner_start_date.val() + ' ' +$("#banner_start_date_hour").val() + ':' + $("#banner_start_date_minute").val() + ':00'
            , banner_end_date : banner_end_date.val() + ' ' +$("#banner_end_date_hour").val() + ':' + $("#banner_end_date_minute").val() + ':59'
            , is_view : is_view
            , fullmoon_duration : fullmoon_duration.val()
            , banner_idx : common.isEmpty($("#banner_idx").val()) ? 0 : $("#banner_idx").val()
            , platform : platform
            , ios_judge_view_on : ios_judge_view_on
            , pc_img_url : pc_img_url.val()
            , mobile_img_url : mobile_img_url.val()
            , pc_link_url : pc_link_url.val()
            , mobile_link_url : mobile_link_url.val()
        }

        return data;
    }

    $(document).on('click', '#tab_dj_rank', function(){
        var data = {
            fullmoon_idx : $(this).data('idx')
            , slct_type : 1
        }
        getFullmoonRank(data);
    });

    $(document).on('click', '#tab_listen_rank', function(){
        var data = {
            fullmoon_idx : $(this).data('idx')
            , slct_type : 2
        }
        getFullmoonRank(data);

    });

    function getFullmoonRank(data){
        util.getAjaxData("getFullmoonEventRanking", "/rest/content/fullmoon/event/ranking", data, function(dst_id, response, param) {
            var template = $("#tmp_fullmoonEventDetail_tabRank").html();
            var templateScript = Handlebars.compile(template);
            response.param = param;
            var context = response;
            var html = templateScript(context);
            $("#fullmoonTabContent").html(html);
        });
    }

    $(document).on('click', '#tab_event_detail', function(){
        console.log('event_detail');
        var data = {
            idx : $(this).data('idx')
        }
        getFullmoonDetail(data);
    });

</script>


<script type="text/x-handlebars-template" id="tmp_fullmoonEventList">
    {{#each this}}
        <tr>
            <td>{{idx}}</td>
            <td>
                {{#equal view_yn '1'}}
                    {{{isCurrentDisplay start_date end_date}}}
                {{else}}
                    <span style="color:gray">OFF</span>
                {{/equal}}
            </td>
            <td>
                <a href="javascript://" class="_fullmoonEventDetail" data-idx={{idx}}>
                    {{start_date}} ~<br/>
                    {{end_date}}
                </a>
            </td>
            <td>{{addComma moon_total_cnt}}</td>
            <td>{{addComma fullmoon_cnt}}</td>
            <td>{{addComma supermoon_cnt}}</td>
            <td>{{addComma mem_cnt}}</td>
        </tr>

    {{else}}
        <tr>
            <td colspan="7">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_fullmoonEventDetail">

    <div id="tabContainer">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="fullmoonDetail_tablist">
            <li class="active"><a href="#detail_event" role="tab" data-toggle="tab" id="tab_event_detail" data-idx="{{idx}}" aria-expanded="false">이벤트 상세정보</a></li>
            {{^equal idx 0}}
                <li><a href="#dj_rank" role="tab" data-toggle="tab" id="tab_dj_rank" data-idx="{{../idx}}" aria-expanded="false">문법사 랭킹</a></li>
                <li><a href="#listen_rank" role="tab" data-toggle="tab" id="tab_listen_rank" data-idx="{{../idx}}" aria-expanded="true">문집사 랭킹</a></li>
            {{/equal}}
        </ul>
    </div>
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-desktop"></i> 보름달 노출 설정</h3>
        </div>
        <div class="widget-content mt15 mb15" id="fullmoonTabContent"></div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_fullmoonEventDetail_tabDetail">
    <form id="fullmoonDetailFrm">
        <input type="hidden" id="idx" name="idx" value="{{idx}}" />
        <input type="hidden" id="banner_idx" name="banner_idx" value="{{banner_idx}}" />
        <div class="row col-lg-12 form-inline mb15">
            <table class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="10%"/>
                    <col width="15%"/>
                    <col width="15%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th colspan="3">노출기간</th>
                    <th>게시여부</th>
                    <th>등록정보</th>
                    <th>수정정보</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>이벤트 기간</th>
                        <td>
                            <div class="input-group date" id="start_date_area">
                                <input type="text" class="form-control " id="start_date" name="start_date" value="{{start_date}}" style="width:85px;">
                                {{{getCommonCodeSelect start_date_hour 'timeHour' 'Y' 'start_date_hour'}}} {{{getCommonCodeSelect start_date_minute 'timeMinute' 'Y' 'start_date_minute'}}}
                            </div>
                        </td>
                        <td>
                            <div class="input-group date" id="end_date_area">
                                <input type="text" class="form-control " id="end_date" name="end_date" value="{{end_date}}" style="width:85px;">
                                {{{getCommonCodeSelect end_date_hour 'timeHour' 'Y' 'end_date_hour'}}} {{{getCommonCodeSelect end_date_minute 'timeMinute' 'Y' 'end_date_minute'}}}
                            </div>
                        </td>
                        <td>
                            {{{getOnOffSwitch view_yn 'view_yn'}}}
                        </td>
                        <th>보름달이 뜨는 날</th>
                        <td colspan="2">
                            <div class="input-group date" id="date_startSel">
                                <input type="text" class="form-control" name="fullmoon_text" id="fullmoon_text" value="{{fullmoon_text}}" />
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th>배너 기간</th>
                        <td>
                            <div class="input-group date" id="date_startSel">
                                <input type="text" class="form-control " id="banner_start_date" name="banner_start_date" value="{{banner_start_date}}" style="width:85px;">
                                {{{getCommonCodeSelect banner_start_date_hour 'timeHour' 'Y' 'banner_start_date_hour'}}} {{{getCommonCodeSelect banner_start_date_minute 'timeMinute' 'Y' 'banner_start_date_minute'}}}
                            </div>
                        </td>
                        <td>
                            <div class="input-group date" id="date_startSel">
                                <input type="text" class="form-control " id="banner_end_date" name="banner_end_date" value="{{banner_end_date}}" style="width:85px;">
                                {{{getCommonCodeSelect banner_end_date_hour 'timeHour' 'Y' 'banner_end_date_hour'}}} {{{getCommonCodeSelect banner_end_date_minute 'timeMinute' 'Y' 'banner_end_date_minute'}}}
                            </div>
                        </td>
                        <td>
                            {{{getOnOffSwitch is_view 'is_view'}}}
                        </td>
                        <th>보름달 띄우기<br />이벤트 기간</th>
                        <td colspan="2">
                            <input type="text" class="form-control" name="fullmoon_duration" id="fullmoon_duration" value="{{fullmoon_duration}}" />
                        </td>
                    </tr>

                    <tr>
                        <th>등록자</th>
                        <td>{{op_name}}</td>
                        <td>{{upd_date}}</td>

                        <th>수정자</th>
                        <td>{{last_op_name}}</td>
                        <td>{{last_upd_date}}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="row col-lg-12 form-inline">
            <table id="fullmoonDetailTable" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="30%"/>
                    <col width="20%"/>
                    <col width="30%"/>
                </colgroup>
                <thead>
                <tr>
                    <th colspan="5">배너 정보</th>
                </tr>
                </thead>
                <tr>
                    <th colspan="2">플랫폼</th>
                    <td>{{{getCommonCodeHorizontalCheck platform 'content_platform2'}}}</td>
                    <th>IOS 심사중 노출</th>
                    <td>{{{getOnOffSwitch ios_judge_view_on 'ios_judge_view_on'}}}</td>
                </tr>
                <tr>
                    <th rowspan="2">Main Center<br />팝업</th>
                    <th>PC 이미지</th>
                    <td colspan="2">
                        <input type="text" class="form-control" id="pc_img_url" style="width:70%" value="{{pc_img_url}}" maxlength="150" />
                        <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                    </td>
                    <td>
                        <div class="_prevArea"></div>
                    </td>
                </tr>
                <tr>
                    <th>모바일 이미지</th>
                    <td colspan="2">
                        <input type="text" class="form-control" id="mobile_img_url" style="width:70%" value="{{mobile_img_url}}" maxlength="150" />
                        <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                    </td>
                    <td>
                        <div class="_prevArea"></div>
                    </td>
                </tr>

                <tr>
                    <th colspan="2">PC 링크</th>
                    <td colspan="3">
                        <input type="text" class="form-control" id="pc_link_url" style="width:100%" value="{{pc_link_url}}" maxlength="150" />
                    </td>
                </tr>
                <tr>
                    <th colspan="2">모바일 링크</th>
                    <td colspan="3">
                        <input type="text" class="form-control" id="mobile_link_url" style="width:100%" value="{{mobile_link_url}}" maxlength="150" />
                    </td>
                </tr>
                </tbody>
            </table>

            <button type="button" class="btn btn-success btn-sm pull-right _saveBtn" style="margin-top:2px;">저장</button>
        </div>
    </form>
</script>

<script type="text/x-handlebars-template" id="tmp_fullmoonEventDetail_tabRank">
    <div class="row col-lg-12 form-inline">
        <table id="fullmoonDetailTable" class="table table-sorting table-hover table-bordered">
            <colgroup>
                <col width="10%"/>
                <!--<col width="10%"/>-->
                <col width="15%"/>
                <col width="20%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                {{#equal this.param.slct_type '2'}}
                    <col width="10%"/>
                {{/equal}}
            </colgroup>
            <thead>
                <tr>
                    <th>순위</th>
                    <!--<th>프로필<br />이미지</th>-->
                    <th>회원번호</th>
                    <th>닉네임</th>
                    <th>성별</th>
                    <th>이벤트 기간 내<br />보름달 띄운 횟수</th>
                    <th>이벤트 기간 내<br />보름달 띄운 최근 일시</th>
                    {{#equal this.param.slct_type '2'}}
                        <th>이벤트 기간 내<br />청취 시간</th>
                    {{/equal}}
                </tr>
            </thead>
            <tbody>
                {{#each this.data as |data|}}
                    <tr>
                        <td>{{data.rank}}</td>
                        <!--<td>{{data.profileImage}}</td>-->
                        <td>{{{memNoLink data.mem_no data.mem_no}}}</td>
                        <td>{{data.nickName}}</td>
                        <td>{{data.memSex}}</td>
                        <td>{{addComma data.completeCnt}}</td>
                        <td>{{data.lastDate}}</td>
                        {{#equal ../this.param.slct_type '2'}}
                            <td>{{timeStampAll data.listenTime}}</td>
                        {{/equal}}
                    </tr>
                {{else}}
                    <tr>
                        <td colspan="{{#equal this.param.slct_type '2'}}7{{else}}6{{/equal}}">{{isEmptyData}}</td>
                    </tr>
                {{/each}}
            </tbody>
        </table>
    </div>
</script>