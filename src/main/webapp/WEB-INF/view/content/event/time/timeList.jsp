<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <div class="col-lg-12 no-padding">
            <form id="searchForm">
                <%--<div class="row col-lg-12 form-inline">--%>
                    <input type="hidden" name="pageStart" id="pageStart">
                    <input type="hidden" name="pageCnt" id="pageCnt">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 타임이벤트 현황</h3>
                            <%--<div>
                                <span id="searchArea"></span>
                                <label><input type="text" class="form-control" id="txt_search" name="txt_search"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </div>--%>
                        </div>
                    </div>
                <%--</div>--%>
            </form>
            </div>
            <!-- //serachBox -->

            <!-- DATA TABLE -->
            <div class="widget widget-table">
                <div class="widget-content" style="border-top-width:0px;">
                    <div class="widget-header _bgColor" data-bgcolor="#FFFFFF">
                        <span>
                            <button class="btn btn-sm btn-primary print-btn pull-right" type="button" id="regBtn"><i class="fa fa-print"></i> 등록</button>
                        </span>
                    </div>

                    <table id="shotList" class="table table-sorting table-hover table-bordered">
                        <colgroup>
                            <col width="3%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="15%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>이벤트 일시</th>
                                <th>이벤트 시간</th>
                                <th>지급 비율</th>
                                <th>등록일시</th>
                                <th>결제건수</th>
                                <th>결제수량</th>
                                <th>결제금액</th>
                                <th>결제 달</th>
                                <th>이벤트<br />지급 달</th>
                                <th>진행상태</th>
                                <th>상태변경</th>
                            </tr>
                        </thead>
                        <tbody id="shotTableBody">
                        </tbody>
                    </table>

                    <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>

                </div>
            </div>
            <!-- // DATA TABLE -->

            <div class="mt15" id="timeDetailArea" style="display:none;"></div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/handlebars/contentHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     shotListPagingInfo = new PAGING_INFO(0, 1, 30);

    $(function(){
        init();
    });

    function init(){
        var data = {

        }
        util.getAjaxData('shotList', "/rest/content/event/time/list", data, function(dst_id, response, params){
            var template = $('#tmp_timeList').html();
            var templateScript = Handlebars.compile(template);
            var context = response;
            var html = templateScript(context);
            $("#shotTableBody").html(html);

            var pagingInfo = response.pagingVo;
            shotListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', shotListPagingInfo);
            util.renderPagingNavigation('list_info_paginate', shotListPagingInfo);
        });

    }

    function handlebarsPaging(targetId, pagingInfo){
        shotListPagingInfo = pagingInfo;
        init();
    }

     $(document).on('click', '._timeDetail', function(){
         var me = $(this);
         var data = {
             idx : me.data('idx')
         }
         util.getAjaxData('good', "/rest/content/event/time/detail", data, function(dist_id, response){

             if(response.code == '0'){
                 alert(response.message);
                 return;
             }

             response.data.start_hour = moment(response.data.start_date).format('HH');
             response.data.start_minute = moment(response.data.start_date).format('mm');

             var template = $('#tmp_timeDetail').html();
             var templateScript = Handlebars.compile(template);
             var context = response.data;
             var html = templateScript(context);
             $("#timeDetailArea").html(html).show();

             //플랫폼 체크 박스 처리
             if(response.data.platform == "111"){
                 $("input[name='platform']").each(function () {
                     this.checked = true;
                 });
             }else {
                $("input[name='platform']").each(function () {
                     this.checked = false;
                 });

                 var arrayPlatform = response.data.platform.split('');
                 for (var idx in arrayPlatform) {
                     if (arrayPlatform[idx] == 1) {
                         var value = parseInt(idx) + 1;
                         $("input[name='platform'][id='platform" + value + "']").prop("checked", true);
                     }
                 }
             }

             $('#start_date').datepicker("setDate", moment(response.data.start_date).format('YYYY.MM.DD'));
             $('#copy_start_date').datepicker("setDate", moment(response.data.start_date).format('YYYY.MM.DD'));

             ui.bottomScroll();
             $('._previewBtn').each(function(){
                 $(this).click();
             });
         });
     });

     function handlebarsPaging(targetId, pagingInfo) {

         shotListPagingInfo = pagingInfo;
         init();
     }

     $(document).on('click', '#regBtn', function(){
         var template = $('#tmp_timeDetail').html();
         var templateScript = Handlebars.compile(template);
         var context = {
             idx : 0
             , main_center_banner_idx : 0
             , main_top_banner_idx : 0
             , store_banner_idx : 0
         };
         var html = templateScript(context);
         $("#timeDetailArea").html(html).show();

         $('#start_date').datepicker("setDate", new Date());
         ui.bottomScroll();
     });

     $(document).on('click', '#detailSaveBtn', function(){
         var data = generateTimeEventParam(false);
         if(data && confirm('저장하시겠습니까?')){
             util.getAjaxData('saveTimeEvent', "/rest/content/event/time/save", data, function(dst_id, response, params){

                 alert(response.message);
                 if(response.result == 'success'){
                     $("#timeDetailArea").empty();
                     init();
                 }
             });
         }
     });

     $(document).on('click', '#detailCopyBtn', function(){
        $(this).hide();
        $('._copyShow').show();
     });

     $(document).on('click', '#detailCopySubmitBtn', function(){
         var data = generateTimeEventParam(true);
         if(data && confirm('복사하시겠습니까?')){
             util.getAjaxData('saveTimeEvent', "/rest/content/event/time/copy", data, function(dst_id, response, params){

                 alert('복사 되었습니다.');

                 $("#timeDetailArea").empty();
                 init();
             });
         }
     });

     $(document).on('click', 'input[name="platform"]', function(){
        if($(this).val() == '전체'){
            if($(this).prop('checked')){
                $("input[name='platform']").each(function () {
                    this.checked = true;
                });
            }else{
                $("input[name='platform']").each(function () {
                    this.checked = false;
                });
            }
        }else{

            var all_checked = $("#platform-1").prop('checked');
            var p1_checked = $("#platform1").prop('checked');
            var p2_checked = $("#platform2").prop('checked');
            var p3_checked = $("#platform3").prop('checked');


            if($(this).prop('checked')){
                if(p1_checked && p2_checked && p3_checked){
                    $("#platform-1").prop('checked', true);
                }
            }else{
                if(all_checked){
                    $("#platform-1").prop('checked', false);
                }
            }

        }
     });

     /**
      * 등록/수정에 필요한 데이터 가공
      */
     function generateTimeEventParam(isCopy){

         //이벤트 정보
         var idx = $("#idx").val();
         idx = common.isEmpty(idx) ? 0 : idx;

         var start_date = $("#start_date").val();
         if(common.isEmpty(start_date)){
             alert('날짜를 선택해주세요.');
             return false;
         }
         var start_hour = $("#start_hour").val();
         var start_minute = $("#start_minute").val();
         var start_datetime = start_date + " " + start_hour + ":" + start_minute +":00";

         var event_time = $('input[name="event_time"]:checked').val();
         if(common.isEmpty(event_time)){
             alert('이벤트 시간을 선택해주세요.');
             return false;
         }

         if(isCopy){
             var copy_start_date = $("#copy_start_date").val();
             if(common.isEmpty(copy_start_date)){
                 alert('날짜를 선택해주세요.');
                 return false;
             }
             var copy_start_hour = $("#copy_start_hour").val();
             var copy_start_minute = $("#copy_start_minute").val();
             var start_datetime = copy_start_date + " " + copy_start_hour + ":" + copy_start_minute +":00";

         }

         if(moment(start_datetime).format('YYYYMMDDHHmmss') < moment(new Date()).format('YYYYMMDDHHmmss')){
             alert('이벤트 시간이 현재 시간보다 작습니다.');
             return false;
         }


         var rate = $('input[name="rate"]:checked').val();
         if(common.isEmpty(rate)){
             alert('지급 비율을 선택해주세요.');
             return false;
         }

         //배너 정보
         var platform_pc = $("#platform1").prop('checked') ? '1' : '0';
         var platform_aos = $("#platform2").prop('checked') ? '1' : '0';
         var platform_ios = $("#platform3").prop('checked') ? '1' : '0';
         var platform = platform_pc + platform_aos + platform_ios;
         if(platform == '000'){
             alert('플랫폼을 선택해주세요.');
             return false;
         }

         var detail_iosJudgeViewOn = $("#detail_iosJudgeViewOn").prop('checked') ? 1 : 0;
         var detail_is_cookie = $("#detail_is_cookie").prop('checked') ? 1 : 0;

         if($("#main_top_banner_link_yn").prop('checked') || $("#main_center_banner_link_yn").prop('checked') || $("#store_banner_link_yn").prop('checked')){
             if(common.isEmpty($("#pc_link_url").val())){
                 alert('pc링크 URL을 입력해주세요.');
                 return false;
             }

             if(common.isEmpty($("#mobile_link_url").val())){
                 alert('모바일 링크 URL을 입력해주세요.');
                 return false;
             }
         }

         var data = {
             idx : idx
             , start_date : start_datetime
             , end_date : moment(start_datetime).add(event_time, 'minutes').format('YYYY.MM.DD HH:mm:ss')
             , event_time : event_time
             , rate : rate

             , platform : platform
             , ios_judge_view_on : detail_iosJudgeViewOn
             , main_top_banner_idx : $("#main_top_banner_idx").val()
             , main_top_pc_image_url : $("#main_top_pc_image_url").val()
             , main_top_mobile_image_url : $("#main_top_mobile_image_url").val()
             , main_top_banner_link_yn : $('input[name="main_top_banner_link_yn"]').prop('checked') ? 1 : 0
             , is_cookie : detail_is_cookie
             /*, main_center_banner_idx : $("#main_center_banner_idx").val()
             , main_center_pc_image_url : $("#main_center_pc_image_url").val()
             , main_center_mobile_image_url : $("#main_center_mobile_image_url").val()
             , main_center_banner_link_yn : $('input[name="main_center_banner_link_yn"]').prop('checked') ? 1 : 0*/
             , store_banner_idx : $("#store_banner_idx").val()
             , store_pc_image_url : $("#store_pc_image_url").val()
             , store_mobile_image_url : $("#store_mobile_image_url").val()
             , store_banner_link_yn : $('input[name="store_banner_link_yn"]').prop('checked') ? 1 : 0
             , pc_link_url : $("#pc_link_url").val()
             , mobile_link_url : $("#mobile_link_url").val()
         }

         return data;
     }

     $(document).on('click', '._timeEventStopBtn', function(){
        if(confirm('진행 중지할 경우\n현재 시각 기준으로 완료 처리됩니다.\n진행 중지하시겠습니까?')){
            var data = {
                idx : $(this).data('idx')
            }
            util.getAjaxData('timeEventStop', '/rest/content/event/time/stop', data, function(){
                $("#timeDetailArea").empty();
                init();
            });
        }
     });

     $(document).on('click', '._timeEventDelBtn', function(){
         console.log($(this).data('idx'));
         if(confirm('예정된 이벤트를 취소할 경우\n자동으로 삭제됩니다.\n진행 중지하시겠습니까?')){
             var data = {
                 idx : $(this).data('idx')
             }
             util.getAjaxData('timeEventStop', '/rest/content/event/time/delete', data, function(){

                 alert('삭제 되었습니다.');

                 $("#timeDetailArea").empty();
                 init();
             });
         }
     });

     $(document).on('click', '._previewBtn', function(){
         var image_url = $(this).parent().find('.form-control').val();
         var html = '<img src="'+ image_url +'" width="100%" height="auto" />'
         $(this).parent().parent().find('._prevArea').html(html);
     });

</script>

<script type="text/x-handlebars-template" id="tmp_timeList">
    {{#each this.data as |item|}}
    <tr>
        <td>
            {{indexDesc ../pagingVo.totalCnt item.rowNum}}
        </td>
        <td>
            <a href="javascript://" class="_timeDetail" data-idx={{item.idx}}>
                {{start_date}} ~<br/>
                {{end_date}}
            </a>
        </td>
        <td>{{event_time}}</td>
        <td>{{item.rate}}</td>
        <td>{{item.reg_date}}</td>
        <td>{{addComma item.pay_cnt}}건</td>
        <td>{{addComma item.pay_cmt}}개</td>
        <td>{{addComma item.pay_amt}}원</td>
        <td>{{addComma item.pay_dal}}달</td>
        <td>{{addComma item.event_dal}}달</td>
        <td>{{timeEventStatus item.start_date item.end_date item.state}}</td>
        <td>{{{timeEventStatusButton item.start_date item.end_date item.state item.idx}}}</td>
    </tr>

    {{else}}
        <tr>
            <td colspan="17">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_timeDetail">
    <div class="widget widget-table">
        <div class="widget-header">
        <h3><i class="fa fa-desktop"></i> 이벤트 상세정보</h3>
    </div>
    <div class="widget-content mt15 mb15">
        <form id="detailFrm">
            <input type="hidden" id="idx" name="idx" value="{{idx}}" />
            <input type="hidden" id="main_top_banner_idx" name="main_top_banner_idx" value="{{main_top_banner_idx}}" />
            <!--<input type="hidden" id="main_center_banner_idx" name="main_center_banner_idx" value="{{main_center_banner_idx}}" />-->
            <input type="hidden" id="store_banner_idx" name="store_banner_idx" value="{{store_banner_idx}}" />
            <div class="col-lg-12 form-inline mb15">
                <div class="row">
                    <div class="col-sm-7">
                        <table id="shotList" class="table table-sorting table-hover table-bordered">
                            <colgroup>
                                <col width="25%"/>
                                <col width="20%"/>
                                <col width="25%"/>
                                <col width="20%"/>
                                <col width="10%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">이벤트 일시</th>
                                    <th>이벤트 시간</th>
                                    <th>지급 비율</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="input-group date" id="date_startSel">
                                            <input type="text" class="form-control " id="start_date" name="start_date" value="{{start_date}}"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" id="i_startSel"></i></span>
                                        </div>
                                    </td>
                                    <td>
                                        {{{getCommonCodeSelect start_hour 'timeHour' 'Y' 'start_hour'}}}
                                        <span> : </span>
                                        {{{getCommonCodeSelect start_minute 'timeMinute' 'Y' 'start_minute'}}}
                                    </td>
                                    <td>
                                        {{{getCommonCodeRadio event_time 'time_event_event_time'}}}
                                    </td>
                                    <td>
                                        {{{getCommonCodeRadio rate 'time_event_rate'}}}
                                    </td>
                                    <td>{{{timeEventStatusButton start_date end_date state idx}}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-5">
                        <button class="btn btn-sm btn-success" type="button" id="detailSaveBtn"> 저장</button>
                        {{^equal idx 0}}
                            <button class="btn btn-sm btn-primary" type="button" id="detailCopyBtn"> 복사하기</button>
                            <span class="_copyShow" style="display:none;">
                                * 복사 시 들어갈 이벤트 일시를 선택해주세요.
                                <input type="text" class="form-control" id="copy_start_date" name="copy_start_date" style="width:100px" />
                                {{{getCommonCodeSelect start_hour 'timeHour' 'Y' 'copy_start_hour'}}}
                                {{{getCommonCodeSelect start_minute 'timeMinute' 'Y' 'copy_start_minute'}}}
                                <button class="btn btn-sm btn-primary" type="button" id="detailCopySubmitBtn"> 복사실행</button>
                            </span>
                        {{/equal}}
                    </div>
                </div>
            </div>

            <div class="row col-lg-12 form-inline">
                <table id="shotList" class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="30%"/>
                        <col width="20%"/>
                        <col width="20%"/>
                        <col width="10%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="7">배너 정보</th>
                    </tr>
                    </thead>
                        <tr>
                            <th colspan="2">플랫폼</th>
                            <td>{{{getCommonCodeHorizontalCheck platform 'content_platform2'}}}</td>
                            <th>IOS 심사중 노출</th>
                            <td colspan="3">{{{getOnOffSwitch ios_judge_view_on 'iosJudgeViewOn'}}}</td>
                        </tr>
                        <tr>
                            <th rowspan="2">Main 이미지 팝업</th>
                            <th>PC 이미지</th>
                            <td>
                                <input type="text" class="form-control" id="main_top_pc_image_url" style="width:70%" value="{{main_top_pc_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                            <td rowspan="2">
                                {{{getCommonCodeHorizontalCheck main_top_banner_link_yn 'time_event_link_yn' 'Y' 'main_top_banner_link_yn'}}}
                            </td>
                            <th rowspan="2">
                               오늘하루 열지않기
                            </th>
                            <td rowspan="2">
                                {{{getOnOffSwitch is_cookie 'is_cookie'}}}
                            </td>
                        </tr>
                        <tr>
                            <th>모바일 이미지</th>
                            <td>
                                <input type="text" class="form-control" id="main_top_mobile_image_url" style="width:70%" value="{{main_top_mobile_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                        </tr>
                        <!--<tr>
                            <th rowspan="2">Main Center</th>
                            <th>PC 이미지 링크</th>
                            <td>
                                <input type="text" class="form-control" id="main_center_pc_image_url" style="width:70%" value="{{main_center_pc_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                            <td rowspan="2">
                                {{{getCommonCodeHorizontalCheck main_center_banner_link_yn 'time_event_link_yn' 'Y' 'main_center_banner_link_yn'}}}
                            </td>
                        </tr>
                        <tr>
                            <th>모바일 링크</th>
                            <td>
                                <input type="text" class="form-control" id="main_center_mobile_image_url" style="width:70%" value="{{main_center_mobile_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                        </tr>-->

                        <tr>
                            <th rowspan="2">스토어 배너</th>
                            <th>PC 이미지 링크</th>
                            <td>
                                <input type="text" class="form-control" id="store_pc_image_url" style="width:70%" value="{{store_pc_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                            <td rowspan="2">
                                {{{getCommonCodeHorizontalCheck store_banner_link_yn 'time_event_link_yn' 'Y' 'store_banner_link_yn'}}}
                            </td>
                            <td rowspan="2" colspan="2">-</td>
                        </tr>
                        <tr>
                            <th>모바일 링크</th>
                            <td>
                                <input type="text" class="form-control" id="store_mobile_image_url" style="width:70%" value="{{store_mobile_image_url}}" maxlength="150" />
                                <button class="btn btn-sm btn-default _previewBtn" type="button">미리보기</button>
                            </td>
                            <td>
                                <div class="_prevArea"></div>
                            </td>
                        </tr>

                        <tr>
                            <th colspan="2">PC 링크</th>
                            <td colspan="5">
                                <input type="text" class="form-control" id="pc_link_url" style="width:100%" value="{{pc_link_url}}" maxlength="150" />
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">모바일 링크</th>
                            <td colspan="5">
                                <input type="text" class="form-control" id="mobile_link_url" style="width:100%" value="{{mobile_link_url}}" maxlength="150" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</script>