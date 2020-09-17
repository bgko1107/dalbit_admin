<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding" style="height: 57px;">
        <div class="container-fluid col-lg-9 no-padding" style="margin-left: 15px">
            <form id="searchForm">
                <div class="row form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>
                            <div>
                                <div class="input-group date" id="oneDayDatePicker">
                                    <label for="onedayDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar" id="onedayDateBtn"></i></span>
                                    </label>
                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">
                                </div>

                                <div class="input-group date" id="monthDatepicker" style="display:none;">
                                    <label for="monthDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar"></i></span>
                                    </label>
                                    <input id="monthDate" type="text" class="form-control"/>
                                </div>

                                <div class="input-group date" id="yearDatepicker" style="display:none;">
                                    <label for="yearDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar"></i></span>
                                    </label>
                                    <input id="yearDate" type="text" class="form-control"/>
                                </div>

                                <div class="input-group date" id="rangeDatepicker" style="display:none;">
                                    <label for="displayDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar"></i></span>
                                    </label>
                                    <input type="text" name="displayDate" id="displayDate" class="form-control" />
                                </div>

                                <input type="hidden" name="startDate" id="startDate">
                                <input type="hidden" name="endDate" id="endDate" />

                                <%--<input name="startDate" id="startDate">--%>
                                <%--<input name="endDate" id="endDate" />--%>
                                <input type="text" class="form-control" id="txt_search" name="txt_search" style="display: none">

                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                <a href="javascript://" class="_prevSearch">[이전]</a>
                                <a href="javascript://" class="_todaySearch">[오늘]</a>
                                <a href="javascript://" class="_nextSearch">[다음]</a>

                                <label class="control-inline fancy-checkbox custom-color-green">
                                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                    <span id="checkTestid" style="display: none">테스트 아이디 제외</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-3 no-padding pull-right" style="margin-left: 5px;width: 350px">
            <div id="liveResourceData"></div>
        </div>
    </div>
    <!-- tab -->
    <div class="widget-content">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="topTab">
            <li class="active"><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(0);">시간대별</a></li>
            <li><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(1);">월간별</a></li>
            <li><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(2);">연간별</a></li>
            <li><a href="#memberDataList" role="tab" data-toggle="tab" onclick="memberDataListTabClick(3);">회원Data</a></li>
            <li><a href="#buyDalDataList" role="tab" data-toggle="tab" onclick="buyDalDataListTabClick(4);">달 결제내역</a></li>
            <li><a href="#useDalDataList" role="tab" data-toggle="tab" onclick="useDalDataListTabClick(5);">달 사용내역</a></li>
            <li><a href="/money/item/list" id="tab_changeList" title="교환페이지로 이동합니다.">교환내역</a></li>
            <li><a href="/status/exchange/info" id="tab_exchangeList" title="환전내역으로 이동합니다.">환전내역</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade in active" id="resourceState" >
                <div class="tab-content no-padding">
                    <div id="infoTable_dal"></div>
                    <div id="infoTable_byeol" style="display: none"></div>
                </div>
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li class="active" style="width: 60px;text-align: center;"><a href="#dal" role="tab" data-toggle="tab" onclick="itemTabClick(1);">달</a></li>
                    <li style="width: 60px;text-align: center;"><a href="#byeol" role="tab" data-toggle="tab" onclick="itemTabClick(0);">별</a></li>
                </ul>
                <div class="tab-content no-padding">
                    <div class="tab-pane fade in active" id="dal">
                        <div id="dalListTable">
                        </div>
                    </div>              <!-- 달 -->
                    <div class="tab-pane fade" id="byeol">
                        <div id="byeolListTable"></div>
                    </div>          <!-- 별 -->
                </div>
            </div>
            <div class="tab-pane fade" id="memberDataList"><jsp:include page="memberDataList.jsp"/></div>
            <div class="tab-pane fade" id="buyDalDataList"><jsp:include page="buyDalDataList.jsp"/></div>
            <div class="tab-pane fade" id="useDalDataList"><jsp:include page="useDalDataList.jsp"/></div>
            <%--<div class="tab-pane fade" id="resourceState" ></div>--%>
        </div>
    </div>
    <!-- //tab -->
</div>

<script type="text/javascript">

    var tabType = <%=in_tabType%>;

    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var toDay = week[moment(new Date()).day()];
    setTimeDate(dateTime);

    var _datePicker = 0;
    var _itemClick = 1;

    $(function(){
        $('#onedayDate').datepicker("onedayDate", new Date()).on('changeDate', function (dateText) {
            var selectDate = moment(dateText.date).format("YYYY.MM.DD");
            $("#startDate").val(selectDate);
            $("#endDate").val(selectDate);
        });
        // 월 선택 -------------------------------------
        $('#monthDate').datepicker({
            minViewMode: 'months',
            format: 'yyyy.mm',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            language: 'kr',
        });
        $("#monthDate").on('change', function () {
            var monthLastDate = new Date($("#monthDate").val().substr(0,4),$("#monthDate").val().substr(5,6),-1);
            $("#startDate").val($("#monthDate").val() + '.01');
            $("#endDate").val($("#monthDate").val() + "." +  (monthLastDate.getDate() + 1));
            $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월'));
        });

        // 년 선택 --------------------------------
        $('#yearDate').datepicker({
            minViewMode: 'years',
            format: 'yyyy',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            language: 'kr',
        });
        $("#yearDate").on('change', function () {
            $("#startDate").val($("#yearDate").val() + '.01.01');
            $("#endDate").val($("#yearDate").val() + ".12.31");
            $("._searchDate").html(moment($("#startDate").val()).format('YYYY년'));
        });
        if(!common.isEmpty(tabType)){
            $('#topTab li:eq(' + tabType + ') a').tab('show');
            _datePicker = tabType;
            _itemClick = 1;
            changeDatepicker();
        }else{
            getResourceInfo();
        }
    });

    $("#bt_search").on('click', function(){
        if(_datePicker == 0 || _datePicker == 1 || _datePicker == 2){
            getResourceInfo();
        }else if (_datePicker == 3){
            memberDataListTabClick();
        }else if (_datePicker == 4){
            buyDalDataListTabClick();
        }else if (_datePicker == 5){
            useDalDataListTabClick();
        }
    });

    $('input[id="txt_search"]').keydown(function() {
        if (event.keyCode === 13) {
            $("#bt_search").click();
        };
    });

    function setTimeDate(dateTime){
        $("#onedayDate").val(dateTime);
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);

        $("._searchDate").html(dateTime + " (" + toDay + ")");
    }

    $(document).on('click', '._prevSearch', function(){
        searchDate('prev');
    });

    $(document).on('click', '._nextSearch', function(){
        searchDate('next');
    });

    $(document).on('click', '._todaySearch', function(){
        toDay = week[moment(new Date()).day()];
        changeDatepicker();

        setTimeDate(dateTime);
    });

    function changeDatepicker(){
        if(_datePicker == 0 || _datePicker == 4 || _datePicker == 5){
            $("#oneDayDatePicker").show();
            $("#monthDatepicker").hide();
            $("#yearDatepicker").hide();
            $("#rangeDatepicker").hide();
        }else if(_datePicker == 1) {
            $("#oneDayDatePicker").hide();
            $("#monthDatepicker").show();
            $("#yearDatepicker").hide();
            $("#rangeDatepicker").hide();
        }else if(_datePicker == 2) {
            $("#oneDayDatePicker").hide();
            $("#monthDatepicker").hide();
            $("#yearDatepicker").show();
            $("#rangeDatepicker").hide();
        }
        searchDate();
    }

    function searchDate(dateType){
        if(_datePicker == 0 || _datePicker == 4 || _datePicker == 5){ //시간별 , 일간    (시간대별/달 결제 내역)
            if(common.isEmpty(dateType)){
                console.log("-------------------------   3");
                $("#startDate").val(moment(new Date()).format('YYYY.MM.DD'));
                $("#endDate").val(moment(new Date()).format('YYYY.MM.DD'));
                $("._searchDate").html(moment(new Date()).format('YYYY.MM.DD') + " (" + toDay + ")");
                $("#onedayDate").val(moment(new Date()).format('YYYY.MM.DD'));
            }else if(dateType == 'prev'){
                setDay(-1);
            }else{
                setDay(1);
            }
        }else if(_datePicker == 1){ // 월간
            if(common.isEmpty(dateType)){
                $("#startDate").val(moment(new Date()).format('YYYY.MM.01'));
                $("#endDate").val(moment(moment(new Date()).format('YYYY.MM.01')).add('months', 1).add('days', -1).format('YYYY.MM.DD'));
                $("._searchDate").html(moment(new Date()).format('YYYY년 MM월'));
                $("#monthDate").val(moment(new Date()).format('YYYY.MM'));
            }else if(dateType == 'prev'){
                setMonth(-1);
            }else if(dateType == 'next'){
                setMonth(1);
            }
        }else if(_datePicker == 2){ // 연간
            if(common.isEmpty(dateType)){
                $("#startDate").val(moment(new Date()).format('YYYY.01.01'));
                $("#endDate").val(moment(new Date()).format('YYYY.12.31'));
                $("._searchDate").html(moment(new Date()).format('YYYY년'));
                $("#yearDate").val(moment(new Date()).format('YYYY'));
            }else if(dateType == 'prev'){
                setYear(-1);

            }else if(dateType == 'next'){
                setYear(1);
            }
        }
        $("#bt_search").click();
    }

    function setDay(days){
        toDay = week[moment($("#startDate").val()).add('days', days).day()];
        $("#startDate").val(moment($("#startDate").val()).add('days', days).format('YYYY.MM.DD'));
        $("#endDate").val($("#startDate").val());
        $("._searchDate").html($("#startDate").val() + " (" + toDay + ")");
        $("#onedayDate").val($("#startDate").val());
    }

    function setMonth(months){
        $("#startDate").val(moment($("#startDate").val()).add('months', months).format('YYYY.MM.01'));
        $("#endDate").val(moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD'));
        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월'));
        $("#monthDate").val(moment($("#startDate").val()).format('YYYY.MM'));
    }

    function setYear(years){
        $("#startDate").val(moment($("#startDate").val()).add('years', years).format('YYYY.01.01'));
        $("#endDate").val(moment($("#startDate").val()).add('years', 1).add('days', -1).format('YYYY.12.31'));
        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년'));
        $("#yearDate").val(moment($("#startDate").val()).format('YYYY'));
    }

    function infoTabClick(tmp){
        _datePicker = tmp;
        $("#resourceState").show();
        $("._prevSearch").show();
        $("._todaySearch").show();
        $("._nextSearch").show();
        $("#txt_search").hide();
        $("#checkTestid").hide();
        changeDatepicker();
        $("#liveResourceData").show();

    }
    function itemTabClick(tmp){
        _itemClick = tmp;
        if(tmp == 1){
            $("#infoTable_dal").show();
            $("#infoTable_byeol").hide();
        }else{
            $("#infoTable_dal").hide();
            $("#infoTable_byeol").show();
        }
        $("#bt_search").click();
    }

    function getResourceInfo() {
        var data = {};
        data.slctType = _datePicker;
        data.startDate = $("#startDate").val();
        data.endDate = $("#endDate").val();
        data.slctResource = _itemClick;

        if (_itemClick == 1) {
            util.getAjaxData("statResourceInfo", "/rest/money/resource/info", data, fn_dal_success);
        }else if (_itemClick == 0){
            util.getAjaxData("statResourceInfo", "/rest/money/resource/info", data, fn_byeol_success);

        }
    }
    function fn_dal_success(dst_id, response) {

        // 증가합 --------------------------------------------------------------------------
        var dalInc_total_mCnt = [
            response.data.totalInfo.charge_mCnt,
            response.data.totalInfo.dalgiftget_mCnt,
            response.data.totalInfo.change_mCnt,
            response.data.totalInfo.join_mCnt,
            response.data.totalInfo.levelup_mCnt,
            response.data.totalInfo.ranking_mCnt,
            response.data.totalInfo.attendance_mCnt,
            response.data.totalInfo.recovery_mCnt,
            response.data.totalInfo.eventauto_mCnt,
            response.data.totalInfo.eventdirect_mCnt,
            response.data.totalInfo.specialdj_mCnt,
            response.data.totalInfo.testin_mCnt,
        ];
        response.data.totalInfo["dalInc_total_mCnt"] = common.getListSum(dalInc_total_mCnt);

        var dalInc_total_fCnt = [
            response.data.totalInfo.charge_fCnt,
            response.data.totalInfo.dalgiftget_fCnt,
            response.data.totalInfo.change_fCnt,
            response.data.totalInfo.join_fCnt,
            response.data.totalInfo.levelup_fCnt,
            response.data.totalInfo.ranking_fCnt,
            response.data.totalInfo.attendance_fCnt,
            response.data.totalInfo.recovery_fCnt,
            response.data.totalInfo.eventauto_fCnt,
            response.data.totalInfo.eventdirect_fCnt,
            response.data.totalInfo.specialdj_fCnt,
            response.data.totalInfo.testin_fCnt,
        ];
        response.data.totalInfo["dalInc_total_fCnt"] = common.getListSum(dalInc_total_fCnt);

        var dalInc_total_nCnt = [
            response.data.totalInfo.charge_nCnt,
            response.data.totalInfo.dalgiftget_nCnt,
            response.data.totalInfo.change_nCnt,
            response.data.totalInfo.join_nCnt,
            response.data.totalInfo.levelup_nCnt,
            response.data.totalInfo.ranking_nCnt,
            response.data.totalInfo.attendance_nCnt,
            response.data.totalInfo.recovery_nCnt,
            response.data.totalInfo.eventauto_nCnt,
            response.data.totalInfo.eventdirect_nCnt,
            response.data.totalInfo.specialdj_nCnt,
            response.data.totalInfo.testin_nCnt,
        ];
        response.data.totalInfo["dalInc_total_nCnt"] = common.getListSum(dalInc_total_nCnt);

        var dalInc_total_tCnt = [
            response.data.totalInfo.charge_tCnt,
            response.data.totalInfo.dalgiftget_tCnt,
            response.data.totalInfo.change_tCnt,
            response.data.totalInfo.join_tCnt,
            response.data.totalInfo.levelup_tCnt,
            response.data.totalInfo.ranking_tCnt,
            response.data.totalInfo.attendance_tCnt,
            response.data.totalInfo.recovery_tCnt,
            response.data.totalInfo.eventauto_tCnt,
            response.data.totalInfo.eventdirect_tCnt,
            response.data.totalInfo.specialdj_tCnt,
            response.data.totalInfo.testin_tCnt,
        ];
        response.data.totalInfo["dalInc_total_tCnt"] = common.getListSum(dalInc_total_tCnt);

        response.data.totalInfo.dalInc_total_Cnt = response.data.totalInfo.dalInc_total_mCnt +
            response.data.totalInfo.dalInc_total_fCnt +
            response.data.totalInfo.dalInc_total_nCnt +
            response.data.totalInfo.dalInc_total_tCnt;
        // 증가합 --------------------------------------------------------------------------

        // 감소합 --------------------------------------------------------------------------
        var dalDec_total_mCnt = [
            response.data.totalInfo.dalgiftsend_mCnt,
            response.data.totalInfo.itemuse_mCnt,
            response.data.totalInfo.cancel_mCnt,
            response.data.totalInfo.block_mCnt,
            response.data.totalInfo.withdrawal_mCnt,
            response.data.totalInfo.testout_mCnt,
        ];
        response.data.totalInfo["dalDec_total_mCnt"] = common.getListSum(dalDec_total_mCnt);

        var dalDec_total_fCnt = [
            response.data.totalInfo.dalgiftsend_fCnt,
            response.data.totalInfo.itemuse_fCnt,
            response.data.totalInfo.cancel_fCnt,
            response.data.totalInfo.block_fCnt,
            response.data.totalInfo.withdrawal_fCnt,
            response.data.totalInfo.testout_fCnt,
        ];
        response.data.totalInfo["dalDec_total_fCnt"] = common.getListSum(dalDec_total_fCnt);

        var dalDec_total_nCnt = [
            response.data.totalInfo.dalgiftsend_nCnt,
            response.data.totalInfo.itemuse_nCnt,
            response.data.totalInfo.cancel_nCnt,
            response.data.totalInfo.block_nCnt,
            response.data.totalInfo.withdrawal_nCnt,
            response.data.totalInfo.testout_nCnt,
        ];
        response.data.totalInfo["dalDec_total_nCnt"] = common.getListSum(dalDec_total_nCnt);

        var dalDec_total_tCnt = [
            response.data.totalInfo.dalgiftsend_tCnt,
            response.data.totalInfo.itemuse_tCnt,
            response.data.totalInfo.cancel_tCnt,
            response.data.totalInfo.block_tCnt,
            response.data.totalInfo.withdrawal_tCnt,
            response.data.totalInfo.testout_tCnt,
        ];
        response.data.totalInfo["dalDec_total_tCnt"] = common.getListSum(dalDec_total_tCnt);

        response.data.totalInfo.dalDec_total_Cnt = response.data.totalInfo.dalDec_total_mCnt +
            response.data.totalInfo.dalDec_total_fCnt +
            response.data.totalInfo.dalDec_total_nCnt +
            response.data.totalInfo.dalDec_total_tCnt;

        response.data.totalInfo.dal_total_Cnt = response.data.totalInfo.dalInc_total_Cnt + response.data.totalInfo.dalDec_total_Cnt;
        // 감소합 --------------------------------------------------------------------------

        var template = $('#tmp_infoTable_dal').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html = templateScript(context);
        $("#infoTable_dal").html(html);

        response.data.detailList.slctType = _datePicker;

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        var total_charge_Cnt = 0;
        var total_dalgiftget_Cnt = 0;
        var total_change_Cnt = 0;
        var total_join_Cnt = 0;
        var total_levelup_Cnt = 0;
        var total_ranking_Cnt = 0;
        var total_attendance_Cnt = 0;
        var total_recovery_Cnt = 0;
        var total_eventauto_Cnt = 0;
        var total_eventdirect_Cnt = 0;
        var total_specialdj_Cnt = 0;
        var total_testin_Cnt = 0;
        var total_dalgiftsend_Cnt = 0;
        var total_itemuse_Cnt = 0;
        var total_cancel_Cnt = 0;
        var total_block_Cnt = 0;
        var total_withdrawal_Cnt = 0;
        var total_testout_Cnt = 0;
        var total_incTotal_Cnt = 0;
        var total_decTotal_Cnt = 0;
        for(var i=0; i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            var sub_incTotal_Cnt = [
                response.data.detailList[i].charge_Cnt,
                response.data.detailList[i].dalgiftget_Cnt,
                response.data.detailList[i].change_Cnt,
                response.data.detailList[i].join_Cnt,
                response.data.detailList[i].levelup_Cnt,
                response.data.detailList[i].ranking_Cnt,
                response.data.detailList[i].attendance_Cnt,
                response.data.detailList[i].recovery_Cnt,
                response.data.detailList[i].eventauto_Cnt,
                response.data.detailList[i].eventdirect_Cnt,
                response.data.detailList[i].specialdj_Cnt,
                response.data.detailList[i].testin_Cnt,
            ];
            response.data.detailList[i].sub_incTotal_Cnt = common.getListSum(sub_incTotal_Cnt);
            var sub_decTotal_Cnt = [
                response.data.detailList[i].dalgiftsend_Cnt,
                response.data.detailList[i].itemuse_Cnt,
                response.data.detailList[i].cancel_Cnt,
                response.data.detailList[i].block_Cnt,
                response.data.detailList[i].withdrawal_Cnt,
                response.data.detailList[i].testout_Cnt,
            ];
            response.data.detailList[i].sub_decTotal_Cnt = common.getListSum(sub_decTotal_Cnt);

            total_charge_Cnt = total_charge_Cnt + response.data.detailList[i].charge_Cnt;
            total_dalgiftget_Cnt = total_dalgiftget_Cnt + response.data.detailList[i].dalgiftget_Cnt;
            total_change_Cnt = total_change_Cnt + response.data.detailList[i].change_Cnt;
            total_join_Cnt = total_join_Cnt + response.data.detailList[i].join_Cnt;
            total_levelup_Cnt = total_levelup_Cnt + response.data.detailList[i].levelup_Cnt;
            total_ranking_Cnt = total_ranking_Cnt + response.data.detailList[i].ranking_Cnt;
            total_attendance_Cnt = total_attendance_Cnt + response.data.detailList[i].attendance_Cnt;
            total_recovery_Cnt = total_recovery_Cnt + response.data.detailList[i].recovery_Cnt;
            total_eventauto_Cnt = total_eventauto_Cnt + response.data.detailList[i].eventauto_Cnt;
            total_eventdirect_Cnt = total_eventdirect_Cnt + response.data.detailList[i].eventdirect_Cnt;
            total_specialdj_Cnt = total_specialdj_Cnt + response.data.detailList[i].specialdj_Cnt;
            total_testin_Cnt = total_testin_Cnt + response.data.detailList[i].testin_Cnt;
            total_dalgiftsend_Cnt = total_dalgiftsend_Cnt + response.data.detailList[i].dalgiftsend_Cnt;
            total_itemuse_Cnt = total_itemuse_Cnt + response.data.detailList[i].itemuse_Cnt;
            total_cancel_Cnt = total_cancel_Cnt + response.data.detailList[i].cancel_Cnt;
            total_block_Cnt = total_block_Cnt + response.data.detailList[i].block_Cnt;
            total_withdrawal_Cnt = total_withdrawal_Cnt + response.data.detailList[i].withdrawal_Cnt;
            total_testout_Cnt = total_testout_Cnt + response.data.detailList[i].testout_Cnt;
            total_incTotal_Cnt = total_incTotal_Cnt + response.data.detailList[i].sub_incTotal_Cnt;
            total_decTotal_Cnt = total_decTotal_Cnt + response.data.detailList[i].sub_decTotal_Cnt;
        }
        response.data.totalInfo.total_charge_Cnt = total_charge_Cnt;
        response.data.totalInfo.total_dalgiftget_Cnt = total_dalgiftget_Cnt;
        response.data.totalInfo.total_change_Cnt = total_change_Cnt;
        response.data.totalInfo.total_join_Cnt = total_join_Cnt;
        response.data.totalInfo.total_levelup_Cnt = total_levelup_Cnt;
        response.data.totalInfo.total_ranking_Cnt = total_ranking_Cnt;
        response.data.totalInfo.total_attendance_Cnt = total_attendance_Cnt;
        response.data.totalInfo.total_recovery_Cnt = total_recovery_Cnt;
        response.data.totalInfo.total_eventauto_Cnt = total_eventauto_Cnt;
        response.data.totalInfo.total_eventdirect_Cnt = total_eventdirect_Cnt;
        response.data.totalInfo.total_specialdj_Cnt = total_specialdj_Cnt;
        response.data.totalInfo.total_testin_Cnt = total_testin_Cnt;
        response.data.totalInfo.total_dalgiftsend_Cnt = total_dalgiftsend_Cnt;
        response.data.totalInfo.total_itemuse_Cnt = total_itemuse_Cnt;
        response.data.totalInfo.total_cancel_Cnt = total_cancel_Cnt;
        response.data.totalInfo.total_block_Cnt = total_block_Cnt;
        response.data.totalInfo.total_withdrawal_Cnt = total_withdrawal_Cnt;
        response.data.totalInfo.total_testout_Cnt = total_testout_Cnt;
        response.data.totalInfo.total_incTotal_Cnt = total_incTotal_Cnt;
        response.data.totalInfo.total_decTotal_Cnt = total_decTotal_Cnt;

        var template = $('#tmp_dalListTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#dalListTable").html(html);

        ui.paintColor();
        ui.tableHeightSet();

        liveResourceData();
    }

    function fn_byeol_success(dst_id, response) {

        var byeolInc_total_mCnt = [
            response.data.totalInfo.byeolgift_mcnt,
            response.data.totalInfo.levelup_mcnt,
            response.data.totalInfo.event_direct_mcnt,
            response.data.totalInfo.cancel_mcnt,
            response.data.totalInfo.recovery_mcnt,
            response.data.totalInfo.test_in_mcnt,
        ];
        response.data.totalInfo["byeolInc_total_mCnt"] = common.getListSum(byeolInc_total_mCnt);

        var byeolInc_total_fCnt = [
            response.data.totalInfo.byeolgift_fcnt,
            response.data.totalInfo.levelup_fcnt,
            response.data.totalInfo.event_direct_fcnt,
            response.data.totalInfo.cancel_fcnt,
            response.data.totalInfo.recovery_fcnt,
            response.data.totalInfo.test_in_fcnt,
        ];
        response.data.totalInfo["byeolInc_total_fCnt"] = common.getListSum(byeolInc_total_fCnt);

        var byeolInc_total_nCnt = [
            response.data.totalInfo.byeolgift_nCnt,
            response.data.totalInfo.levelup_nCnt,
            response.data.totalInfo.event_direct_nCnt,
            response.data.totalInfo.cancel_nCnt,
            response.data.totalInfo.recovery_nCnt,
            response.data.totalInfo.test_in_nCnt,
        ];
        response.data.totalInfo["byeolInc_total_nCnt"] = common.getListSum(byeolInc_total_nCnt);

        var byeolInc_total_tCnt = [
            response.data.totalInfo.byeolgift_tCnt,
            response.data.totalInfo.levelup_tCnt,
            response.data.totalInfo.event_direct_tCnt,
            response.data.totalInfo.cancel_tCnt,
            response.data.totalInfo.recovery_tCnt,
            response.data.totalInfo.test_in_tCnt,
        ];
        response.data.totalInfo["byeolInc_total_tCnt"] = common.getListSum(byeolInc_total_tCnt);


        var byeolDec_total_mCnt = [
            response.data.totalInfo.exchange_mcnt,
            response.data.totalInfo.change_mcnt,
            response.data.totalInfo.block_mcnt,
            response.data.totalInfo.withdrawal_mcnt,
            response.data.totalInfo.test_out_mcnt,
        ];
        response.data.totalInfo["byeolDec_total_mCnt"] = common.getListSum(byeolDec_total_mCnt);

        var byeolDec_total_fCnt = [
            response.data.totalInfo.exchange_fCnt,
            response.data.totalInfo.change_fCnt,
            response.data.totalInfo.block_fCnt,
            response.data.totalInfo.withdrawal_fCnt,
            response.data.totalInfo.test_out_fCnt,
        ];
        response.data.totalInfo["byeolDec_total_fCnt"] = common.getListSum(byeolDec_total_fCnt);

        var byeolDec_total_nCnt = [
            response.data.totalInfo.exchange_nCnt,
            response.data.totalInfo.change_nCnt,
            response.data.totalInfo.block_nCnt,
            response.data.totalInfo.withdrawal_nCnt,
            response.data.totalInfo.test_out_nCnt,
        ];
        response.data.totalInfo["byeolDec_total_nCnt"] = common.getListSum(byeolDec_total_nCnt);

        var byeolDec_total_tCnt = [
            response.data.totalInfo.exchange_tCnt,
            response.data.totalInfo.change_tCnt,
            response.data.totalInfo.block_tCnt,
            response.data.totalInfo.withdrawal_tCnt,
            response.data.totalInfo.test_out_tCnt,
        ];
        response.data.totalInfo["byeolDec_total_tCnt"] = common.getListSum(byeolDec_total_tCnt);


        response.data.totalInfo["byeolInc_total_Cnt"] = response.data.totalInfo.byeolInc_total_mCnt +
            response.data.totalInfo.byeolInc_total_fCnt +
            response.data.totalInfo.byeolInc_total_nCnt +
            response.data.totalInfo.byeolInc_total_tCnt ;

        response.data.totalInfo["byeolDec_total_Cnt"] = response.data.totalInfo.byeolDec_total_mCnt +
            response.data.totalInfo.byeolDec_total_fCnt +
            response.data.totalInfo.byeolDec_total_nCnt +
            response.data.totalInfo.byeolDec_total_tCnt ;

        response.data.totalInfo["byeol_total_Cnt"] = response.data.totalInfo.byeolInc_total_Cnt + response.data.totalInfo.byeolDec_total_Cnt;


        var template = $('#tmp_infoTable_byeol').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html = templateScript(context);
        $("#infoTable_byeol").html(html);

        response.data.detailList.slctType = _datePicker;

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));


        var total_byeolgift_Cnt = 0;
        var total_levelup_Cnt = 0;
        var total_eventdirect_Cnt = 0;
        var total_cancel_Cnt = 0;
        var total_recovery_Cnt = 0;
        var total_testin_Cnt = 0;
        var total_exchange_Cnt = 0;
        var total_change_Cnt = 0;
        var total_block_Cnt = 0;
        var total_withdrawal_Cnt = 0;
        var total_testout_Cnt = 0;

        for(var i=0; i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            var sub_incByeolTotal_Cnt = [
                response.data.detailList[i].byeolgift_Cnt,
                response.data.detailList[i].levelup_Cnt,
                response.data.detailList[i].eventdirect_Cnt,
                response.data.detailList[i].cancel_Cnt,
                response.data.detailList[i].recovery_Cnt,
                response.data.detailList[i].testin_Cnt,
            ];
            response.data.detailList[i].sub_incByeolTotal_Cnt = common.getListSum(sub_incByeolTotal_Cnt);

            var sub_decByeolTotal_Cnt = [
                response.data.detailList[i].exchange_Cnt,
                response.data.detailList[i].change_Cnt,
                response.data.detailList[i].block_Cnt,
                response.data.detailList[i].withdrawal_Cnt,
                response.data.detailList[i].testout_Cnt,
            ];
            response.data.detailList[i].sub_decByeolTotal_Cnt = common.getListSum(sub_decByeolTotal_Cnt);

            total_byeolgift_Cnt = total_byeolgift_Cnt + response.data.detailList[i].byeolgift_Cnt;
            total_levelup_Cnt = total_levelup_Cnt + response.data.detailList[i].levelup_Cnt;
            total_eventdirect_Cnt = total_eventdirect_Cnt + response.data.detailList[i].eventdirect_Cnt;
            total_cancel_Cnt = total_cancel_Cnt + response.data.detailList[i].cancel_Cnt;
            total_recovery_Cnt = total_recovery_Cnt + response.data.detailList[i].recovery_Cnt;
            total_testin_Cnt = total_testin_Cnt + response.data.detailList[i].testin_Cnt;
            total_exchange_Cnt = total_exchange_Cnt + response.data.detailList[i].exchange_Cnt;
            total_change_Cnt = total_change_Cnt + response.data.detailList[i].change_Cnt;
            total_block_Cnt = total_block_Cnt + response.data.detailList[i].block_Cnt;
            total_withdrawal_Cnt = total_withdrawal_Cnt + response.data.detailList[i].withdrawal_Cnt;
            total_testout_Cnt = total_testout_Cnt + response.data.detailList[i].testout_Cnt;
        }
        response.data.totalInfo.total_byeolgift_Cnt = total_byeolgift_Cnt;
        response.data.totalInfo.total_levelup_Cnt = total_levelup_Cnt;
        response.data.totalInfo.total_eventdirect_Cnt = total_eventdirect_Cnt;
        response.data.totalInfo.total_cancel_Cnt = total_cancel_Cnt;
        response.data.totalInfo.total_recovery_Cnt = total_recovery_Cnt;
        response.data.totalInfo.total_testin_Cnt = total_testin_Cnt;
        response.data.totalInfo.total_exchange_Cnt = total_exchange_Cnt;
        response.data.totalInfo.total_change_Cnt = total_change_Cnt;
        response.data.totalInfo.total_block_Cnt = total_block_Cnt;
        response.data.totalInfo.total_withdrawal_Cnt = total_withdrawal_Cnt;
        response.data.totalInfo.total_testout_Cnt = total_testout_Cnt;

        response.data.totalInfo.total_incbyeol_Cnt = total_byeolgift_Cnt + total_levelup_Cnt + total_eventdirect_Cnt + total_cancel_Cnt + total_recovery_Cnt + total_testin_Cnt;
        response.data.totalInfo.total_decbyeol_Cnt = total_exchange_Cnt + total_change_Cnt + total_block_Cnt + total_withdrawal_Cnt + total_testout_Cnt;

        var template = $('#tmp_byeolListTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#byeolListTable").html(html);

        ui.paintColor();
        ui.tableHeightSet();
        liveResourceData();
    }
    function liveResourceData(){
        util.getAjaxData("liveResourceData", "/rest/money/resource/live", "", fn_liveResourceData_success);
    }
    function fn_liveResourceData_success(dat_id, response){
        var template = $('#tmp_liveResourceData').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html = templateScript(context);
        $("#liveResourceData").html(html);
        ui.paintColor();
        ui.tableHeightSet();
    }

</script>
<script type="text/x-handlebars-template" id="tmp_infoTable_dal">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered mb10 mt5 _tableHeight" data-height="23px">
            <tr>
                <th rowspan="6" class="_bgColor" data-bgcolor="#8faadc">달 증가</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 결제</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 직접 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">가입 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">랭킹 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">출석이멘트</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 직접지급)</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">스페셜DJ</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">증가 합</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#000000" data-fontcolor="white">총 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">(자동)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">(운영자 직접지급)</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'm'}}}</th>
                <td>{{addComma charge_mCnt 'Y'}}</td>
                <td>{{addComma dalgiftget_mCnt 'Y'}}</td>
                <td>{{addComma change_mCnt 'Y'}}</td>
                <td>{{addComma join_mCnt 'Y'}}</td>
                <td>{{addComma levelup_mCnt 'Y'}}</td>
                <td>{{addComma ranking_mCnt 'Y'}}</td>
                <td>{{addComma attendance_mCnt 'Y'}}</td>
                <td>{{addComma recovery_mCnt 'Y'}}</td>
                <td>{{addComma eventauto_mCnt 'Y'}}</td>
                <td>{{addComma eventdirect_mCnt 'Y'}}</td>
                <td>{{addComma specialdj_mCnt 'Y'}}</td>
                <td>{{addComma testin_mCnt 'Y'}}</td>
                <td>{{addComma dalInc_total_mCnt 'Y'}}</td>
                <td rowspan="4">{{addComma dalInc_total_Cnt 'Y'}}</td>
                <td rowspan="9">{{addComma dal_total_Cnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'f'}}}</th>
                <td>{{addComma charge_fCnt 'Y'}}</td>
                <td>{{addComma dalgiftget_fCnt 'Y'}}</td>
                <td>{{addComma change_fCnt 'Y'}}</td>
                <td>{{addComma join_fCnt 'Y'}}</td>
                <td>{{addComma levelup_fCnt 'Y'}}</td>
                <td>{{addComma ranking_fCnt 'Y'}}</td>
                <td>{{addComma attendance_fCnt 'Y'}}</td>
                <td>{{addComma recovery_fCnt 'Y'}}</td>
                <td>{{addComma eventauto_fCnt 'Y'}}</td>
                <td>{{addComma eventdirect_fCnt 'Y'}}</td>
                <td>{{addComma specialdj_fCnt 'Y'}}</td>
                <td>{{addComma testin_fCnt 'Y'}}</td>
                <td>{{addComma dalInc_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'n'}}}</th>
                <td>{{addComma charge_nCnt 'Y'}}</td>
                <td>{{addComma dalgiftget_nCnt 'Y'}}</td>
                <td>{{addComma change_nCnt 'Y'}}</td>
                <td>{{addComma join_nCnt 'Y'}}</td>
                <td>{{addComma levelup_nCnt 'Y'}}</td>
                <td>{{addComma ranking_nCnt 'Y'}}</td>
                <td>{{addComma attendance_nCnt 'Y'}}</td>
                <td>{{addComma recovery_nCnt 'Y'}}</td>
                <td>{{addComma eventauto_nCnt 'Y'}}</td>
                <td>{{addComma eventdirect_nCnt 'Y'}}</td>
                <td>{{addComma specialdj_nCnt 'Y'}}</td>
                <td>{{addComma testin_nCnt 'Y'}}</td>
                <td>{{addComma dalInc_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">테스트</th>
                <td>{{addComma charge_tCnt 'Y'}}</td>
                <td>{{addComma dalgiftget_tCnt 'Y'}}</td>
                <td>{{addComma change_tCnt 'Y'}}</td>
                <td>{{addComma join_tCnt 'Y'}}</td>
                <td>{{addComma levelup_tCnt 'Y'}}</td>
                <td>{{addComma ranking_tCnt 'Y'}}</td>
                <td>{{addComma attendance_tCnt 'Y'}}</td>
                <td>{{addComma recovery_tCnt 'Y'}}</td>
                <td>{{addComma eventauto_tCnt 'Y'}}</td>
                <td>{{addComma eventdirect_tCnt 'Y'}}</td>
                <td>{{addComma specialdj_tCnt 'Y'}}</td>
                <td>{{addComma testin_tCnt 'Y'}}</td>
                <td>{{addComma dalInc_total_tCnt 'Y'}}</td>
            </tr>
            <tr>
                <th rowspan="5" class="_bgColor" data-bgcolor="#f4b183">달 감소</th>
                <th class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">달 직접 선물</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">아이템 사용</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">결제 취소</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <td colspan="6" rowspan="5"></td>
                <th class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">감소 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'm'}}}</th>
                <td>{{addComma dalgiftsend_mCnt 'Y'}}</td>
                <td>{{addComma itemuse_mCnt 'Y'}}</td>
                <td>{{addComma cancel_mCnt 'Y'}}</td>
                <td>{{addComma block_mCnt 'Y'}}</td>
                <td>{{addComma withdrawal_mCnt 'Y'}}</td>
                <td>{{addComma testout_mCnt 'Y'}}</td>
                <td>{{addComma dalDec_total_mCnt 'Y'}}</td>
                <td rowspan="4">{{addComma dalDec_total_Cnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'f'}}}</th>
                <td>{{addComma dalgiftsend_fCnt 'Y'}}</td>
                <td>{{addComma itemuse_fCnt 'Y'}}</td>
                <td>{{addComma cancel_fCnt 'Y'}}</td>
                <td>{{addComma block_fCnt 'Y'}}</td>
                <td>{{addComma withdrawal_fCnt 'Y'}}</td>
                <td>{{addComma testout_fCnt 'Y'}}</td>
                <td>{{addComma dalDec_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'n'}}}</th>
                <td>{{addComma dalgiftsend_nCnt 'Y'}}</td>
                <td>{{addComma itemuse_nCnt 'Y'}}</td>
                <td>{{addComma cancel_nCnt 'Y'}}</td>
                <td>{{addComma block_nCnt 'Y'}}</td>
                <td>{{addComma withdrawal_nCnt 'Y'}}</td>
                <td>{{addComma testout_nCnt 'Y'}}</td>
                <td>{{addComma dalDec_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">테스트</th>
                <td>{{addComma dalgiftsend_tCnt 'Y'}}</td>
                <td>{{addComma itemuse_tCnt 'Y'}}</td>
                <td>{{addComma cancel_tCnt 'Y'}}</td>
                <td>{{addComma block_tCnt 'Y'}}</td>
                <td>{{addComma withdrawal_tCnt 'Y'}}</td>
                <td>{{addComma testout_tCnt 'Y'}}</td>
                <td>{{addComma dalDec_total_tCnt 'Y'}}</td>
            </tr>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_infoTable_byeol">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered mb10 mt5 _tableHeight" data-height="23px">
            <tr>
                <th rowspan="5" class="_bgColor" data-bgcolor="#8faadc">별 증가</th>
                <th class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">레벨업 보상</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">아이템 선물<br/>(비밀선물)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급<br/>(운영자 직접 지급)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">환전 불가</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 직접지급)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">증가 합</th>
                <th class="_bgColor _fontColor" data-bgcolor="#000000" data-fontcolor="white">총 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'm'}}}</th>
                <td>{{addComma byeolgift_mCnt 'Y'}}</td>
                <td>{{addComma levelup_mCnt 'Y'}}</td>
                <td>{{addComma event_direct_mCnt 'Y'}}</td>
                <td>{{addComma cancel_mCnt 'Y'}}</td>
                <td>{{addComma recovery_mCnt 'Y'}}</td>
                <td>{{addComma test_in_mCnt 'Y'}}</td>
                <td>{{addComma byeolInc_total_mCnt 'Y'}}</td>
                <td rowspan="4">{{addComma byeolInc_total_Cnt 'Y'}}</td>
                <td rowspan="9">{{addComma byeol_total_Cnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'f'}}}</th>
                <td>{{addComma byeolgift_fCnt 'Y'}}</td>
                <td>{{addComma levelup_fCnt 'Y'}}</td>
                <td>{{addComma event_direct_fCnt 'Y'}}</td>
                <td>{{addComma cancel_fCnt 'Y'}}</td>
                <td>{{addComma recovery_fCnt 'Y'}}</td>
                <td>{{addComma test_in_fCnt 'Y'}}</td>
                <td>{{addComma byeolInc_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'n'}}}</th>
                <td>{{addComma byeolgift_nCnt 'Y'}}</td>
                <td>{{addComma levelup_nCnt 'Y'}}</td>
                <td>{{addComma event_direct_nCnt 'Y'}}</td>
                <td>{{addComma cancel_nCnt 'Y'}}</td>
                <td>{{addComma recovery_nCnt 'Y'}}</td>
                <td>{{addComma test_in_nCnt 'Y'}}</td>
                <td>{{addComma byeolInc_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">테스트</th>
                <td>{{addComma byeolgift_tCnt 'Y'}}</td>
                <td>{{addComma levelup_tCnt 'Y'}}</td>
                <td>{{addComma event_direct_tCnt 'Y'}}</td>
                <td>{{addComma cancel_tCnt 'Y'}}</td>
                <td>{{addComma recovery_tCnt 'Y'}}</td>
                <td>{{addComma test_in_tCnt 'Y'}}</td>
                <td>{{addComma byeolInc_total_tCnt 'Y'}}</td>
            </tr>

            <tr>
                <th rowspan="5" class="_bgColor" data-bgcolor="#f4b183">별 감소</th>
                <th class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">환전 승인</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">교환</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <td rowspan="5"></td>
                <th class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">감소 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'm'}}}</th>
                <td>{{addComma exchange_mCnt 'Y'}}</td>
                <td>{{addComma change_mCnt 'Y'}}</td>
                <td>{{addComma block_mCnt 'Y'}}</td>
                <td>{{addComma withdrawal_mCnt 'Y'}}</td>
                <td>{{addComma test_out_mCnt 'Y'}}</td>
                <td>{{addComma byeolDec_total_mCnt 'Y'}}</td>
                <td rowspan="4">{{addComma byeolDec_total_Cnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'f'}}}</th>
                <td>{{addComma exchange_fCnt 'Y'}}</td>
                <td>{{addComma change_fCnt 'Y'}}</td>
                <td>{{addComma block_fCnt 'Y'}}</td>
                <td>{{addComma withdrawal_fCnt 'Y'}}</td>
                <td>{{addComma test_out_fCnt 'Y'}}</td>
                <td>{{addComma byeolDec_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'n'}}}</th>
                <td>{{addComma exchange_nCnt 'Y'}}</td>
                <td>{{addComma change_nCnt 'Y'}}</td>
                <td>{{addComma block_nCnt 'Y'}}</td>
                <td>{{addComma withdrawal_nCnt 'Y'}}</td>
                <td>{{addComma test_out_nCnt 'Y'}}</td>
                <td>{{addComma byeolDec_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">테스트</th>
                <td>{{addComma exchange_tCnt 'Y'}}</td>
                <td>{{addComma change_tCnt 'Y'}}</td>
                <td>{{addComma block_tCnt 'Y'}}</td>
                <td>{{addComma withdrawal_tCnt 'Y'}}</td>
                <td>{{addComma test_out_tCnt 'Y'}}</td>
                <td>{{addComma byeolDec_total_tCnt 'Y'}}</td>
            </tr>
        </table>
    </div>
</script>


<script type="text/x-handlebars-template" id="tmp_dalListTable">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <%--<colgroup>--%>
            <%--<col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>--%>
            <%--<col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>--%>
            <%--<col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>--%>
            <%--</colgroup>--%>
            <thead>
            <tr>
                <th colspan="14" class="_bgColor" data-bgcolor="#8faadc">달 증가</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th colspan="8" class="_bgColor" data-bgcolor="#f4b183">달 감소</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 결제</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 직접 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">가입보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">랭킹 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">출석이벤트</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 직접지급)</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">스페셜DJ</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="2" style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">달 직접 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">아이템 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">결제 취소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">(자동)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">(운영자 직접지급)</th>
            </tr>
            </thead>
            <tbody>
            <tr class="font-bold" style="background-color: #d9d9d9">
                <td>총합</td>
                <td>{{addComma totalInfo.total_charge_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_dalgiftget_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_join_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_ranking_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_attendance_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_specialdj_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_incTotal_Cnt 'Y'}}</td>
                <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                <td>총합</td>
                <td>{{addComma totalInfo.total_dalgiftsend_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_itemuse_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_decTotal_Cnt 'Y'}}</td>
            </tr>
            {{#each detailList}}
            <tr
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{#dalbit_if ../detailList.nowHour '==' the_hr}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{#dalbit_if ../detailList.nowDay '==' day}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{#dalbit_if ../detailList.nowMonth '==' day}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
            >
            <td class="font-bold _bgColor" data-bgcolor="#dae3f3">
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{the_hr}}시{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{{date}}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{the_date}}월{{/dalbit_if}}
            </td>
            <td>{{addComma charge_Cnt 'Y'}}</td>
            <td>{{addComma dalgiftget_Cnt 'Y'}}</td>
            <td>{{addComma change_Cnt 'Y'}}</td>
            <td>{{addComma join_Cnt 'Y'}}</td>
            <td>{{addComma levelup_Cnt 'Y'}}</td>
            <td>{{addComma ranking_Cnt 'Y'}}</td>
            <td>{{addComma attendance_Cnt 'Y'}}</td>
            <td>{{addComma recovery_Cnt 'Y'}}</td>
            <td>{{addComma eventauto_Cnt 'Y'}}</td>
            <td>{{addComma eventdirect_Cnt 'Y'}}</td>
            <td>{{addComma specialdj_Cnt 'Y'}}</td>
            <td>{{addComma testin_Cnt 'Y'}}</td>
            <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_incTotal_Cnt 'Y'}}</td>
            <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
            <td class="font-bold _bgColor" data-bgcolor="#fbe5d6">
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{the_hr}}시{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{{date}}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{the_date}}월{{/dalbit_if}}
            </td>
            <td>{{addComma dalgiftsend_Cnt 'Y'}}</td>
            <td>{{addComma itemuse_Cnt 'Y'}}</td>
            <td>{{addComma cancel_Cnt 'Y'}}</td>
            <td>{{addComma block_Cnt 'Y'}}</td>
            <td>{{addComma withdrawal_Cnt 'Y'}}</td>
            <td>{{addComma testout_Cnt 'Y'}}</td>
            <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_decTotal_Cnt 'Y'}}</td>
            </tr>
            {{else}}
            <td colspan="23" class="noData">{{isEmptyData}}<td>
                {{/each}}
                <tr class="font-bold" style="background-color: #d9d9d9">
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_charge_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_dalgiftget_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_join_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_ranking_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_attendance_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_specialdj_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_incTotal_Cnt 'Y'}}</td>
                    <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_dalgiftsend_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_itemuse_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_decTotal_Cnt 'Y'}}</td>
                </tr>
            </tbody>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_byeolListTable">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <%--<colgroup>--%>
            <%--<col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>--%>
            <%--<col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>--%>
            <%--<col width="9%"/>--%>
            <%--</colgroup>--%>
            <thead>
            <tr>
                <th colspan="8" class="_bgColor" data-bgcolor="#8faadc">별 증가</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th colspan="7" class="_bgColor" data-bgcolor="#f4b183">별 감소</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">레벨업 보상</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">아이템 선물<br/>(비밀 선물)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급<br/>(운영자 직접지급)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">환전 불가</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 직접지급)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">환전 승인</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">교환</th> 
                <th class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
            </tr>
            </thead>
            <tbody>
            <tr class="font-bold" style="background-color: #d9d9d9">
                <td>총합</td>
                <td>{{addComma totalInfo.total_byeolgift_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_incbyeol_Cnt 'Y'}}</td>
                <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                <td>총합</td>
                <td>{{addComma totalInfo.total_exchange_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_decbyeol_Cnt 'Y'}}</td>
            </tr>
            {{#each detailList}}
            <tr
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{#dalbit_if ../detailList.nowHour '==' the_hr}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{#dalbit_if ../detailList.nowDay '==' day}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{#dalbit_if ../detailList.nowMonth '==' day}} class="font-bold _bgColor" data-bgcolor="#fff2cc" {{/dalbit_if}}{{/dalbit_if}}
            >
            <td class="font-bold _bgColor" data-bgcolor="#dae3f3">
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{the_hr}}시{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{{date}}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{the_date}}월{{/dalbit_if}}
            </td>
            <td>{{addComma byeolgift_Cnt 'Y'}}</td>
            <td>{{addComma levelup_Cnt 'Y'}}</td>
            <td>{{addComma eventdirect_Cnt 'Y'}}</td>
            <td>{{addComma cancel_Cnt 'Y'}}</td>
            <td>{{addComma recovery_Cnt 'Y'}}</td>
            <td>{{addComma testin_Cnt 'Y'}}</td>
            <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_incByeolTotal_Cnt 'Y'}}</td>
            <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
            <td class="font-bold _bgColor" data-bgcolor="#fbe5d6">
                {{#dalbit_if ../detailList.slctType '==' '0'}}{{the_hr}}시{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '1'}}{{{date}}}{{/dalbit_if}}
                {{#dalbit_if ../detailList.slctType '==' '2'}}{{the_date}}월{{/dalbit_if}}
            </td>
            <td>{{addComma exchange_Cnt 'Y'}}</td>
            <td>{{addComma change_Cnt 'Y'}}</td>
            <td>{{addComma block_Cnt 'Y'}}</td>
            <td>{{addComma withdrawal_Cnt 'Y'}}</td>
            <td>{{addComma testout_Cnt 'Y'}}</td>
            <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_decByeolTotal_Cnt 'Y'}}</td>
            </tr>
            {{/each}}
            <tr class="font-bold" style="background-color: #d9d9d9">
                <td>총합</td>
                <td>{{addComma totalInfo.total_byeolgift_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_incbyeol_Cnt 'Y'}}</td>
                <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                <td>총합</td>
                <td>{{addComma totalInfo.total_exchange_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_decbyeol_Cnt 'Y'}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_liveResourceData">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <thead>
            <tr>
                <th colspan="4" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">현재 총 보유</th>
            </tr>
            <tr>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">달</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">별</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{{addComma total_Dal 'Y'}} 개</td>
                <td>{{addComma havecount_Dal 'Y'}} 명</td>
                <td>{{addComma total_Byeol 'Y'}} 개</td>
                <td>{{addComma havecount_Byeol 'Y'}} 명</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>