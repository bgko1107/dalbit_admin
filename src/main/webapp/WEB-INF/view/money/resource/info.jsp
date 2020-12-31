<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding" >
        <div class="container-fluid col-lg-9 no-padding" style="margin-left: 15px">
            <form id="searchForm">
                <div class="row widget widget-table searchBoxArea">
                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                            </th>
                            <th id="th_bottonList">
                                <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                <div>
                                    <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                    <div id="div_monthButton" style="display: none"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    <div id="div_yearButton" style="display: none"><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                <div class="col-md-3 no-padding" id="div_input">
                                    <input id="onedayDate" type="text" class="form-control" >
                                    <input id="monthDate" type="text" class="form-control" style="display: none"/>
                                    <input id="yearDate" type="text" class="form-control" style="display: none"/>
                                </div>

                                <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                <a href="javascript://" class="_prevSearch">[이전]</a>
                                <a href="javascript://" class="_todaySearch">[오늘]</a>
                                <a href="javascript://" class="_nextSearch">[다음]</a>

                                <span id="searchCheck" style="display: none">
                                    <label class="control-inline fancy-checkbox custom-color-green">
                                        <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                        <span>테스트 아이디 제외</span>
                                    </label>
                                </span>
                            </td>
                        </tr>
                    </table>
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
            <li class="active"><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(0);">시간대</a></li>
            <li><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(1);">월간</a></li>
            <li><a href="#resourceState" role="tab" data-toggle="tab" onclick="infoTabClick(2);">연간</a></li>
            <li><a href="#memberDataList" role="tab" data-toggle="tab" id="tab_memberDataList" onclick="memberDataListTabClick();">회원Data</a></li>
            <li><a href="#buyDalDataList" role="tab" data-toggle="tab" id="tab_buyDalDataList" onclick="buyDalDataListTabClick();">달 결제내역</a></li>
            <li><a href="#useDalDataList" role="tab" data-toggle="tab" id="tab_useDalDataList" onclick="useDalDataListTabClick();">달 사용내역</a></li>
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

    var _itemClick = 1;

    $(function(){
        slctType = 0;
        setDayButton();

        if(!common.isEmpty(tabType)){
            $('#topTab li:eq(' + tabType + ') a').tab('show');
            _itemClick = 1;
            dateType(slctType);
        }else{
            getResourceInfo();
        }
    });

    $("#bt_search").on('click', function(){
        if(common.isEmpty(tabType)){
            tabType = 0;
        }
        if(tabType == 0 || tabType == 1 || tabType == 2){
            getResourceInfo();
        }else if (tabType == 3){
            memberDataList();
        }else if (tabType == 4){
            buyDalList();
        }else if (tabType == 5){
            useDalList();
        }
    });

    $('input[id="searchText"]').keydown(function() {
        if (event.keyCode === 13) {
            $("#bt_search").click();
        };
    });

    function infoTabClick(tmp){
        tabType = tmp;
        slctType = tmp;
        dateType(slctType);

        $("#searchText").hide();
        $("#resourceState").show();
        $("._prevSearch").show();
        $("._todaySearch").show();
        $("._nextSearch").show();
        $("#div_input").show();
        $("#txt_search").hide();
        $("#checkTestid").hide();
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
        data.slctType = slctType;
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
            response.data.totalInfo.autochange_mCnt,
            response.data.totalInfo.join_mCnt,
            response.data.totalInfo.levelup_mCnt,
            response.data.totalInfo.ranking_mCnt,
            response.data.totalInfo.attendance_mCnt,
            response.data.totalInfo.recovery_mCnt,
            response.data.totalInfo.eventauto_mCnt,
            response.data.totalInfo.eventdirect_mCnt,
            response.data.totalInfo.specialdj_mCnt,
            response.data.totalInfo.testin_mCnt,
            response.data.totalInfo.roulette_mCnt,
        ];
        response.data.totalInfo["dalInc_total_mCnt"] = common.getListSum(dalInc_total_mCnt);

        var dalInc_total_fCnt = [
            response.data.totalInfo.charge_fCnt,
            response.data.totalInfo.dalgiftget_fCnt,
            response.data.totalInfo.change_fCnt,
            response.data.totalInfo.autochange_fCnt,
            response.data.totalInfo.join_fCnt,
            response.data.totalInfo.levelup_fCnt,
            response.data.totalInfo.ranking_fCnt,
            response.data.totalInfo.attendance_fCnt,
            response.data.totalInfo.recovery_fCnt,
            response.data.totalInfo.eventauto_fCnt,
            response.data.totalInfo.eventdirect_fCnt,
            response.data.totalInfo.specialdj_fCnt,
            response.data.totalInfo.testin_fCnt,
            response.data.totalInfo.roulette_fCnt,
        ];
        response.data.totalInfo["dalInc_total_fCnt"] = common.getListSum(dalInc_total_fCnt);

        var dalInc_total_nCnt = [
            response.data.totalInfo.charge_nCnt,
            response.data.totalInfo.dalgiftget_nCnt,
            response.data.totalInfo.change_nCnt,
            response.data.totalInfo.autochange_nCnt,
            response.data.totalInfo.join_nCnt,
            response.data.totalInfo.levelup_nCnt,
            response.data.totalInfo.ranking_nCnt,
            response.data.totalInfo.attendance_nCnt,
            response.data.totalInfo.recovery_nCnt,
            response.data.totalInfo.eventauto_nCnt,
            response.data.totalInfo.eventdirect_nCnt,
            response.data.totalInfo.specialdj_nCnt,
            response.data.totalInfo.testin_nCnt,
            response.data.totalInfo.roulette_nCnt,
        ];
        response.data.totalInfo["dalInc_total_nCnt"] = common.getListSum(dalInc_total_nCnt);

        var dalInc_total_tCnt = [
            response.data.totalInfo.charge_tCnt,
            response.data.totalInfo.dalgiftget_tCnt,
            response.data.totalInfo.change_tCnt,
            response.data.totalInfo.autochange_tCnt,
            response.data.totalInfo.join_tCnt,
            response.data.totalInfo.levelup_tCnt,
            response.data.totalInfo.ranking_tCnt,
            response.data.totalInfo.attendance_tCnt,
            response.data.totalInfo.recovery_tCnt,
            response.data.totalInfo.eventauto_tCnt,
            response.data.totalInfo.eventdirect_tCnt,
            response.data.totalInfo.specialdj_tCnt,
            response.data.totalInfo.testin_tCnt,
            response.data.totalInfo.roulette_tCnt,
        ];
        response.data.totalInfo["dalInc_total_tCnt"] = common.getListSum(dalInc_total_tCnt);

        response.data.totalInfo.dalInc_total_Cnt = response.data.totalInfo.dalInc_total_mCnt +
            response.data.totalInfo.dalInc_total_fCnt +
            response.data.totalInfo.dalInc_total_nCnt +
            response.data.totalInfo.dalInc_total_tCnt;

        // 총합

        response.data.totalInfo["charge_total_Cnt"] = response.data.totalInfo.charge_mCnt + response.data.totalInfo.charge_fCnt + response.data.totalInfo.charge_nCnt + response.data.totalInfo.charge_tCnt;
        response.data.totalInfo["dalgiftget_total_Cnt"] = response.data.totalInfo.dalgiftget_mCnt + response.data.totalInfo.dalgiftget_fCnt + response.data.totalInfo.dalgiftget_nCnt + response.data.totalInfo.dalgiftget_tCnt;
        response.data.totalInfo["change_total_Cnt"] = response.data.totalInfo.change_mCnt + response.data.totalInfo.change_fCnt + response.data.totalInfo.change_nCnt + response.data.totalInfo.change_tCnt;
        response.data.totalInfo["autochange_total_Cnt"] = response.data.totalInfo.autochange_mCnt + response.data.totalInfo.autochange_fCnt + response.data.totalInfo.autochange_nCnt + response.data.totalInfo.autochange_tCnt;
        response.data.totalInfo["join_total_Cnt"] = response.data.totalInfo.join_mCnt + response.data.totalInfo.join_fCnt + response.data.totalInfo.join_nCnt + response.data.totalInfo.join_tCnt;
        response.data.totalInfo["levelup_total_Cnt"] = response.data.totalInfo.levelup_mCnt + response.data.totalInfo.levelup_fCnt + response.data.totalInfo.levelup_nCnt + response.data.totalInfo.levelup_tCnt;
        response.data.totalInfo["ranking_total_Cnt"] = response.data.totalInfo.ranking_mCnt + response.data.totalInfo.ranking_fCnt + response.data.totalInfo.ranking_nCnt + response.data.totalInfo.ranking_tCnt;
        response.data.totalInfo["attendance_total_Cnt"] = response.data.totalInfo.attendance_mCnt + response.data.totalInfo.attendance_fCnt + response.data.totalInfo.attendance_nCnt + response.data.totalInfo.attendance_tCnt;
        response.data.totalInfo["roulette_Cnt"] = response.data.totalInfo.roulette_mCnt + response.data.totalInfo.roulette_fCnt + response.data.totalInfo.roulette_nCnt + response.data.totalInfo.roulette_tCnt;
        response.data.totalInfo["recovery_total_Cnt"] = response.data.totalInfo.recovery_mCnt + response.data.totalInfo.recovery_fCnt + response.data.totalInfo.recovery_nCnt + response.data.totalInfo.recovery_tCnt;
        response.data.totalInfo["eventauto_total_Cnt"] = response.data.totalInfo.eventauto_mCnt + response.data.totalInfo.eventauto_fCnt + response.data.totalInfo.eventauto_nCnt + response.data.totalInfo.eventauto_tCnt;
        response.data.totalInfo["eventdirect_total_Cnt"] = response.data.totalInfo.eventdirect_mCnt + response.data.totalInfo.eventdirect_fCnt + response.data.totalInfo.eventdirect_nCnt + response.data.totalInfo.eventdirect_tCnt;
        response.data.totalInfo["specialdj_total_Cnt"] = response.data.totalInfo.specialdj_mCnt + response.data.totalInfo.specialdj_fCnt + response.data.totalInfo.specialdj_nCnt + response.data.totalInfo.specialdj_tCnt;
        response.data.totalInfo["testin_total_Cnt"] = response.data.totalInfo.testin_mCnt + response.data.totalInfo.testin_fCnt + response.data.totalInfo.testin_nCnt + response.data.totalInfo.testin_tCnt;
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

        if(response.data.totalInfo.dalInc_total_Cnt < response.data.totalInfo.dalDec_total_Cnt){
            response.data.totalInfo.dal_total_Cnt_inc = "1";
        }else{
            response.data.totalInfo.dal_total_Cnt_inc = "0";
        }
        response.data.totalInfo.dal_total_Cnt = response.data.totalInfo.dalInc_total_Cnt - response.data.totalInfo.dalDec_total_Cnt;

        //총합
        response.data.totalInfo.dalgiftsend_total_Cnt = response.data.totalInfo.dalgiftsend_mCnt + response.data.totalInfo.dalgiftsend_fCnt + response.data.totalInfo.dalgiftsend_nCnt + response.data.totalInfo.dalgiftsend_tCnt;
        response.data.totalInfo.itemuse_total_Cnt = response.data.totalInfo.itemuse_mCnt + response.data.totalInfo.itemuse_fCnt + response.data.totalInfo.itemuse_nCnt + response.data.totalInfo.itemuse_tCnt;
        response.data.totalInfo.cancel_total_Cnt = response.data.totalInfo.cancel_mCnt + response.data.totalInfo.cancel_fCnt + response.data.totalInfo.cancel_nCnt + response.data.totalInfo.cancel_tCnt;
        response.data.totalInfo.block_total_Cnt = response.data.totalInfo.block_mCnt + response.data.totalInfo.block_fCnt + response.data.totalInfo.block_nCnt + response.data.totalInfo.block_tCnt;
        response.data.totalInfo.withdrawal_total_Cnt = response.data.totalInfo.withdrawal_mCnt + response.data.totalInfo.withdrawal_fCnt + response.data.totalInfo.withdrawal_nCnt + response.data.totalInfo.withdrawal_tCnt;
        response.data.totalInfo.testout_total_Cnt = response.data.totalInfo.testout_mCnt + response.data.totalInfo.testout_fCnt + response.data.totalInfo.testout_nCnt + response.data.totalInfo.testout_tCnt;
        // 감소합 --------------------------------------------------------------------------

        var template = $('#tmp_infoTable_dal').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html = templateScript(context);
        $("#infoTable_dal").html(html);

        response.data.detailList.slctType = slctType;

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        var total_charge_Cnt = 0;
        var total_autochange_Cnt = 0;
        var total_dalgiftget_Cnt = 0;
        var total_change_Cnt = 0;
        var total_changeAuto_Cnt = 0;
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
        var total_roulette_Cnt = 0;
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
                response.data.detailList[i].autochange_Cnt,
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
                response.data.detailList[i].roulette_Cnt,
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

            response.data.detailList[i].sub_inc_Cnt = response.data.detailList[i].sub_incTotal_Cnt - response.data.detailList[i].increaseCnt;
            response.data.detailList[i].sub_dec_Cnt = response.data.detailList[i].sub_decTotal_Cnt - response.data.detailList[i].decreaseCnt;

            total_charge_Cnt = total_charge_Cnt + response.data.detailList[i].charge_Cnt;
            total_dalgiftget_Cnt = total_dalgiftget_Cnt + response.data.detailList[i].dalgiftget_Cnt;
            total_change_Cnt = total_change_Cnt + response.data.detailList[i].change_Cnt;
            total_changeAuto_Cnt = total_changeAuto_Cnt + response.data.detailList[i].autochange_Cnt;
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
            total_roulette_Cnt = total_roulette_Cnt + response.data.detailList[i].roulette_Cnt;
        }
        response.data.totalInfo.total_charge_Cnt = total_charge_Cnt;
        response.data.totalInfo.total_dalgiftget_Cnt = total_dalgiftget_Cnt;
        response.data.totalInfo.total_change_Cnt = total_change_Cnt;
        response.data.totalInfo.total_changeAuto_Cnt = total_changeAuto_Cnt;
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
        response.data.totalInfo.total_roulette_Cnt = total_roulette_Cnt;

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
            response.data.totalInfo.event_auto_mcnt,
            response.data.totalInfo.event_direct_mcnt,
            response.data.totalInfo.cancel_mcnt,
            response.data.totalInfo.recovery_mcnt,
            response.data.totalInfo.test_in_mcnt,
        ];
        response.data.totalInfo["byeolInc_total_mCnt"] = common.getListSum(byeolInc_total_mCnt);

        var byeolInc_total_fCnt = [
            response.data.totalInfo.byeolgift_fcnt,
            response.data.totalInfo.levelup_fcnt,
            response.data.totalInfo.event_auto_fcnt,
            response.data.totalInfo.event_direct_fcnt,
            response.data.totalInfo.cancel_fcnt,
            response.data.totalInfo.recovery_fcnt,
            response.data.totalInfo.test_in_fcnt,
        ];
        response.data.totalInfo["byeolInc_total_fCnt"] = common.getListSum(byeolInc_total_fCnt);

        var byeolInc_total_nCnt = [
            response.data.totalInfo.byeolgift_ncnt,
            response.data.totalInfo.levelup_ncnt,
            response.data.totalInfo.event_auto_ncnt,
            response.data.totalInfo.event_direct_ncnt,
            response.data.totalInfo.cancel_ncnt,
            response.data.totalInfo.recovery_ncnt,
            response.data.totalInfo.test_in_ncnt,
        ];
        response.data.totalInfo["byeolInc_total_nCnt"] = common.getListSum(byeolInc_total_nCnt);

        var byeolInc_total_tCnt = [
            response.data.totalInfo.byeolgift_tcnt,
            response.data.totalInfo.levelup_tcnt,
            response.data.totalInfo.event_auto_tcnt,
            response.data.totalInfo.event_direct_tcnt,
            response.data.totalInfo.cancel_tcnt,
            response.data.totalInfo.recovery_tcnt,
            response.data.totalInfo.test_in_tcnt,
        ];
        response.data.totalInfo["byeolInc_total_tCnt"] = common.getListSum(byeolInc_total_tCnt);


        var byeolDec_total_mCnt = [
            response.data.totalInfo.exchange_mcnt,
            response.data.totalInfo.change_mcnt,
            response.data.totalInfo.autochange_mcnt,
            response.data.totalInfo.block_mcnt,
            response.data.totalInfo.withdrawal_mcnt,
            response.data.totalInfo.test_out_mcnt,
        ];
        response.data.totalInfo["byeolDec_total_mCnt"] = common.getListSum(byeolDec_total_mCnt);

        var byeolDec_total_fCnt = [
            response.data.totalInfo.exchange_fcnt,
            response.data.totalInfo.change_fcnt,
            response.data.totalInfo.autochange_fcnt,
            response.data.totalInfo.block_fcnt,
            response.data.totalInfo.withdrawal_fcnt,
            response.data.totalInfo.test_out_fcnt,
        ];
        response.data.totalInfo["byeolDec_total_fCnt"] = common.getListSum(byeolDec_total_fCnt);

        var byeolDec_total_nCnt = [
            response.data.totalInfo.exchange_ncnt,
            response.data.totalInfo.change_ncnt,
            response.data.totalInfo.autochange_ncnt,
            response.data.totalInfo.block_ncnt,
            response.data.totalInfo.withdrawal_ncnt,
            response.data.totalInfo.test_out_ncnt,
        ];
        response.data.totalInfo["byeolDec_total_nCnt"] = common.getListSum(byeolDec_total_nCnt);

        var byeolDec_total_tCnt = [
            response.data.totalInfo.exchange_tcnt,
            response.data.totalInfo.change_tcnt,
            response.data.totalInfo.autochange_tcnt,
            response.data.totalInfo.block_tcnt,
            response.data.totalInfo.withdrawal_tcnt,
            response.data.totalInfo.test_out_tcnt,
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

        response.data.totalInfo["byeol_total_Cnt"] = response.data.totalInfo.byeolInc_total_Cnt - response.data.totalInfo.byeolDec_total_Cnt;

        //총합 ------------------------------------
        response.data.totalInfo["byeolgift_total_cnt"] = response.data.totalInfo.byeolgift_mcnt + response.data.totalInfo.byeolgift_fcnt + response.data.totalInfo.byeolgift_ncnt + response.data.totalInfo.byeolgift_tcnt ;
        response.data.totalInfo["levelup_total_cnt"] = response.data.totalInfo.levelup_mcnt + response.data.totalInfo.levelup_fcnt + response.data.totalInfo.levelup_ncnt + response.data.totalInfo.levelup_tcnt;
        response.data.totalInfo["event_auto_total_cnt"] = response.data.totalInfo.event_auto_mcnt + response.data.totalInfo.event_auto_fcnt + response.data.totalInfo.event_auto_ncnt + response.data.totalInfo.event_auto_tcnt;
        response.data.totalInfo["event_direct_total_cnt"] = response.data.totalInfo.event_direct_mcnt + response.data.totalInfo.event_direct_fcnt + response.data.totalInfo.event_direct_ncnt + response.data.totalInfo.event_direct_tcnt;
        response.data.totalInfo["cancel_total_cnt"] = response.data.totalInfo.cancel_mcnt + response.data.totalInfo.cancel_fcnt + response.data.totalInfo.cancel_ncnt + response.data.totalInfo.cancel_tcnt ;
        response.data.totalInfo["recovery_total_cnt"] = response.data.totalInfo.recovery_mcnt + response.data.totalInfo.recovery_fcnt + response.data.totalInfo.recovery_ncnt + response.data.totalInfo.recovery_tcnt;
        response.data.totalInfo["test_in_total_cnt"] = response.data.totalInfo.test_in_mcnt + response.data.totalInfo.test_in_fcnt + response.data.totalInfo.test_in_ncnt + response.data.totalInfo.test_in_tcnt;

        response.data.totalInfo["exchange_total_cnt"] = response.data.totalInfo.exchange_mcnt + response.data.totalInfo.exchange_fcnt + response.data.totalInfo.exchange_ncnt + response.data.totalInfo.exchange_tcnt;
        response.data.totalInfo["change_total_cnt"] = response.data.totalInfo.change_mcnt + response.data.totalInfo.change_fcnt + response.data.totalInfo.change_ncnt + response.data.totalInfo.change_tcnt ;
        response.data.totalInfo["autochange_total_cnt"] = response.data.totalInfo.autochange_mcnt + response.data.totalInfo.autochange_fcnt + response.data.totalInfo.autochange_mcnt + response.data.totalInfo.autochange_tcnt ;
        response.data.totalInfo["block_total_cnt"] = response.data.totalInfo.block_mcnt + response.data.totalInfo.block_fcnt + response.data.totalInfo.block_ncnt + response.data.totalInfo.block_tcnt;
        response.data.totalInfo["withdrawal_total_cnt"] = response.data.totalInfo.withdrawal_mcnt + response.data.totalInfo.withdrawal_fcnt + response.data.totalInfo.withdrawal_ncnt + response.data.totalInfo.withdrawal_tcnt;
        response.data.totalInfo["test_out_total_cnt"] = response.data.totalInfo.test_out_mcnt + response.data.totalInfo.test_out_fcnt + response.data.totalInfo.test_out_ncnt + response.data.totalInfo.test_out_tcnt;

        var template = $('#tmp_infoTable_byeol').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html = templateScript(context);
        $("#infoTable_byeol").html(html);

        response.data.detailList.slctType = slctType;

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));


        var total_byeolgift_Cnt = 0;
        var total_levelup_Cnt = 0;
        var total_eventdirect_Cnt = 0;
        var total_eventauto_Cnt = 0;
        var total_cancel_Cnt = 0;
        var total_recovery_Cnt = 0;
        var total_testin_Cnt = 0;
        var total_exchange_Cnt = 0;
        var total_change_Cnt = 0;
        var total_autochange_Cnt = 0;
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
                response.data.detailList[i].eventauto_Cnt,
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

            response.data.detailList[i].sub_inc_Cnt = response.data.detailList[i].sub_incByeolTotal_Cnt - response.data.detailList[i].increaseCnt;
            response.data.detailList[i].sub_dec_Cnt = response.data.detailList[i].sub_decByeolTotal_Cnt - response.data.detailList[i].decreaseCnt;

            total_byeolgift_Cnt = total_byeolgift_Cnt + response.data.detailList[i].byeolgift_Cnt;
            total_levelup_Cnt = total_levelup_Cnt + response.data.detailList[i].levelup_Cnt;
            total_eventauto_Cnt = total_eventauto_Cnt + response.data.detailList[i].eventauto_Cnt;
            total_eventdirect_Cnt = total_eventdirect_Cnt + response.data.detailList[i].eventdirect_Cnt;
            total_cancel_Cnt = total_cancel_Cnt + response.data.detailList[i].cancel_Cnt;
            total_recovery_Cnt = total_recovery_Cnt + response.data.detailList[i].recovery_Cnt;
            total_testin_Cnt = total_testin_Cnt + response.data.detailList[i].testin_Cnt;
            total_exchange_Cnt = total_exchange_Cnt + response.data.detailList[i].exchange_Cnt;
            total_change_Cnt = total_change_Cnt + response.data.detailList[i].change_Cnt;
            total_autochange_Cnt = total_autochange_Cnt + response.data.detailList[i].autochange_Cnt;
            total_block_Cnt = total_block_Cnt + response.data.detailList[i].block_Cnt;
            total_withdrawal_Cnt = total_withdrawal_Cnt + response.data.detailList[i].withdrawal_Cnt;
            total_testout_Cnt = total_testout_Cnt + response.data.detailList[i].testout_Cnt;
        }
        response.data.totalInfo.total_byeolgift_Cnt = total_byeolgift_Cnt;
        response.data.totalInfo.total_levelup_Cnt = total_levelup_Cnt;
        response.data.totalInfo.total_eventauto_Cnt = total_eventauto_Cnt;
        response.data.totalInfo.total_eventdirect_Cnt = total_eventdirect_Cnt;
        response.data.totalInfo.total_cancel_Cnt = total_cancel_Cnt;
        response.data.totalInfo.total_recovery_Cnt = total_recovery_Cnt;
        response.data.totalInfo.total_testin_Cnt = total_testin_Cnt;
        response.data.totalInfo.total_exchange_Cnt = total_exchange_Cnt;
        response.data.totalInfo.total_change_Cnt = total_change_Cnt;
        response.data.totalInfo.total_autochange_Cnt = total_autochange_Cnt;
        response.data.totalInfo.total_block_Cnt = total_block_Cnt;
        response.data.totalInfo.total_withdrawal_Cnt = total_withdrawal_Cnt;
        response.data.totalInfo.total_testout_Cnt = total_testout_Cnt;

        response.data.totalInfo.total_incbyeol_Cnt = total_byeolgift_Cnt + total_levelup_Cnt + total_eventauto_Cnt + total_eventdirect_Cnt + total_cancel_Cnt + total_testin_Cnt + total_recovery_Cnt;
        response.data.totalInfo.total_decbyeol_Cnt = total_exchange_Cnt + total_change_Cnt + total_autochange_Cnt + total_block_Cnt + total_withdrawal_Cnt + total_testout_Cnt;

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

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "memberData_paginate_top" || targetId == "memberData_paginate"){
            memberDataPagingInfo = pagingInfo;
            memberDataList(pagingInfo.pageNo);
        }else if(targetId == "buyDal_paginate_top" || targetId == "buyDal_paginate"){
            buyDalPagingInfo = pagingInfo;
            buyDalList(pagingInfo.pageNo);
        }else if(targetId == "useDal_paginate_top" || targetId == "useDal_paginate"){
            useDalPagingInfo = pagingInfo;
            useDalList(pagingInfo.pageNo);
        }
    }

    function resourceDalClick(data){
        var popupUrl = "/money/resource/popup/dal?sDate=" + $("#startDate").val() + "&eDate=" + $("#endDate").val() + "&type=" + data.type + "&gender=" + data.gender +"&slctType="+ slctType;
        if(data.type == "1" || data.type == "3" || data.type == "3-1" || data.type == "4" || data.type == "5" || data.type == "6"
            || data.type == "7" || data.type == "8" || data.type == "9-1" || data.type == "9-2" || data.type == "10"
            || data.type == "12" || data.type == "13" || data.type == "14" || data.type == "15" || data.type == "19"|| data.type == "22"
        ){
            util.windowOpen(popupUrl,"745","550","달 정보 데이터");
        }else{
            util.windowOpen(popupUrl,"900","550","달 정보 데이터");
        }
    }

    function resourceByeolClick(data){
        var popupUrl = "/money/resource/popup/byeol?sDate=" + $("#startDate").val() + "&eDate=" + $("#endDate").val() + "&type=" + data.type + "&gender=" + data.gender +"&slctType="+ slctType;
        if(data.type != "11"){
            util.windowOpen(popupUrl,"745","550","별 정보 데이터");
        }else{
            util.windowOpen(popupUrl,"900","550","별 정보 데이터");
        }
    }


</script>
<script type="text/x-handlebars-template" id="tmp_infoTable_dal">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered mb10 mt5 _tableHeight" data-height="23px">
            <colgroup>
                <col width="3%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="4%"/><col width="3%"/><col width="3%"/><col width="5%"/><col width="3%"/>
                <col width="3%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="5%"/><col width="5%"/><col width="5%"/>
            </colgroup>
            <tbody>
            <tr>
                <th rowspan="7" class="_bgColor" data-bgcolor="#8faadc">달 증가</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 결제</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 직접 선물</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">가입 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">랭킹 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자지급)</th>
                <th colspan="5" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#8faadc" style="border:solid 2px black">소계</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#8faadc" style="border:solid 2px black">증가 합</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#000000" data-fontcolor="white" style="border:solid 2px black">총 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">일반</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">자동</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">스페셜DJ</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">출석</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">룰렛</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">기타 자동</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">운영자 직접</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'm'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="1"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma charge_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="2-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftget_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="4"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma join_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="5"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="6"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma ranking_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="8"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="22"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma specialdj_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="7"   data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma attendance_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="19"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma roulette_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventauto_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-2" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventdirect_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="10"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testin_mCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'm'}}}</th>
                <td style="border:solid 2px black">{{addComma dalInc_total_mCnt 'Y'}}</td>
                <td rowspan="5" style="border:solid 2px black"><span class="font-bold" style="font-size: 15px">{{addComma dalInc_total_Cnt 'Y'}}</span></td>
                <td rowspan="12" class="{{upAndDownClass dal_total_Cnt}}" style="border:solid 2px black">
                    <i class="fa {{upAndDownIcon dal_total_Cnt}}" style="font-size: 20px"></i>
                    <span style="font-size: 20px">{{addComma dal_total_Cnt}}</span>
                </td>

            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'f'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="1"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma charge_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="2-1" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftget_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="4"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma join_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="5"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="6"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma ranking_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="8"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="2"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma specialdj_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="7"   data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma attendance_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="19"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma roulette_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-1" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventauto_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-2" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventdirect_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="10"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testin_fCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'f'}}}</th>
                <td style="border:solid 2px black">{{addComma dalInc_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'n'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="1"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma charge_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="2-1" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftget_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="4"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma join_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="5"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="6"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma ranking_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="8"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="22"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma specialdj_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="7"   data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma attendance_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="19"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma roulette_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-1" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventauto_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-2" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventdirect_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="10"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testin_nCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'n'}}}</th>
                <td style="border:solid 2px black">{{addComma dalInc_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">테스트</th>
                <td onclick="resourceDalClick($(this).data())" data-type="1"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma charge_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="2-1" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftget_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="3-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="4"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma join_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="5"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="6"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma ranking_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="8"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="22"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma specialdj_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="7"   data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma attendance_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="19"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma roulette_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-1" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventauto_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="9-2" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventdirect_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="10"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testin_tCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">테스트</th>
                <td style="border:solid 2px black">{{addComma dalInc_total_tCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dad9d7">총합</th>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="1"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma charge_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="2-1" data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftget_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="3"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="3-1"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="4"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma join_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="5"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="6"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma ranking_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="8"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="22"  data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma specialdj_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="7"   data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma attendance_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="19"  data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma roulette_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="9-1" data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventauto_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="9-2" data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma eventdirect_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="10"  data-gender="a" ><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testin_total_Cnt 'Y'}}</span></a></td>
                <td colspan="2" style="border:solid 2px black"></td>
            </tr>
            <tr>
                <th rowspan="7" class="_bgColor" data-bgcolor="#f4b183">달 감소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">달 직접 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">아이템 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">결제 취소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <td colspan="6" rowspan="7"></td>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">소계</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">감소 합</th>
            </tr>
            <tr></tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'm'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="2-2" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftsend_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="11"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma itemuse_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="12"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="13"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="14"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_mCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="15"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testout_mCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'm'}}}</th>
                <td style="border:solid 2px black">{{addComma dalDec_total_mCnt 'Y'}}</td>
                <td rowspan="5" style="border:solid 2px black"><span class="font-bold" style="font-size: 15px">{{addComma dalDec_total_Cnt 'Y'}}</span></td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'f'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="2-2" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftsend_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="11"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma itemuse_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="12"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="13"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="14"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_fCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="15"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testout_fCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'f'}}}</th>
                <td style="border:solid 2px black">{{addComma dalDec_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'n'}}}</th>
                <td onclick="resourceDalClick($(this).data())" data-type="2-2" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftsend_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="11"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma itemuse_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="12"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="13"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="14"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_nCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="15"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testout_nCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'n'}}}</th>
                <td style="border:solid 2px black">{{addComma dalDec_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">테스트</th>
                <td onclick="resourceDalClick($(this).data())" data-type="2-2" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftsend_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="11"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma itemuse_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="12"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="13"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="14"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_tCnt 'Y'}}</span></a></td>
                <td onclick="resourceDalClick($(this).data())" data-type="15"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testout_tCnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">테스트</th>
                <td style="border:solid 2px black">{{addComma dalDec_total_tCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dad9d7">총합</th>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="2-2" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma dalgiftsend_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="11"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma itemuse_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="12"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="13"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="14"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_total_Cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceDalClick($(this).data())" data-type="15"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma testout_total_Cnt 'Y'}}</span></a></td>
                <td colspan="2" style="border:solid 2px black"></td>
            </tr>
            </tbody>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_infoTable_byeol">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered mb10 mt5 _tableHeight" data-height="23px">
            <colgroup>
                <col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/>
                <col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/>
                <col width="8%"/><col width="8%"/><col width="8%"/>
            </colgroup>
            <tbody>
            <tr>
                <th rowspan="7" class="_bgColor" data-bgcolor="#8faadc">별 증가</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨업 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">아이템 선물<br/>(비밀선물)</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">환전 취소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 지급)</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">소계</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">증가 합</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#000000" data-fontcolor="white" style="border:solid 2px black">총 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">(자동)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">(운영자지급)</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'm'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="5" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="11"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma byeolgift_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9-1"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_auto_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_direct_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="16" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="8"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="10" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_in_mcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'm'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolInc_total_mCnt 'Y'}}</td>
                <td rowspan="5" style="border:solid 2px black"><span class="font-bold" style="font-size: 15px">{{addComma byeolInc_total_Cnt 'Y'}}</span></td>
                <td rowspan="12" class="{{upAndDownClass byeol_total_Cnt}}" style="border:solid 2px black">
                    <i class="fa {{upAndDownIcon byeol_total_Cnt}}" style="font-size: 20px"></i>
                    <span style="font-size: 20px">{{addComma byeol_total_Cnt}}</span>
                </td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'f'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="5" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="11"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma byeolgift_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9-1"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_auto_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_direct_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="16" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="8"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="10" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_in_fcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'f'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolInc_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'n'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="5" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="11"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma byeolgift_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9-1"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_auto_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_direct_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="16" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="8"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="10" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_in_ncnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">{{{sexIcon 'n'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolInc_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#b4c7e7">테스트</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="5" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="11"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma byeolgift_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9-1"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_auto_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="9"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_direct_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="16" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="8"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="10" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_in_tcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#b4c7e7" style="border:solid 2px black">테스트</th>
                <td style="border:solid 2px black">{{addComma byeolInc_total_tCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dad9d7">총합</th>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="5" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma levelup_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="11"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma byeolgift_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="9-1"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_auto_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="9"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma event_direct_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="16" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma cancel_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="8"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma recovery_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="10" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_in_total_cnt 'Y'}}</span></a></td>
                <td colspan="2" style="border:solid 2px black"></td>
            </tr>

            <tr>
                <th rowspan="7" class="_bgColor" data-bgcolor="#f4b183">별 감소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">환전 승인</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <td rowspan="7"></td>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">소계</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">감소 합</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#fbe5d6">일반</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">자동</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'm'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="17" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma exchange_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3"  data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3-1" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="13" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="18" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_mcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="15" data-gender="m"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_out_mcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'm'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolDec_total_mCnt 'Y'}}</td>
                <td rowspan="5" style="border:solid 2px black"><span class="font-bold" style="font-size: 15px">{{addComma byeolDec_total_Cnt 'Y'}}</span></td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'f'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="17" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma exchange_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3"  data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3-1" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="13" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="18" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_fcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="15" data-gender="f"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_out_fcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'f'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolDec_total_fCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">{{{sexIcon 'n'}}}</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="17" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma exchange_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3"  data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3-1" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="13" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="18" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_ncnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="15" data-gender="n"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_out_ncnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">{{{sexIcon 'n'}}}</th>
                <td style="border:solid 2px black">{{addComma byeolDec_total_nCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f8cbad">테스트</th>
                <td onclick="resourceByeolClick($(this).data())" data-type="17" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma exchange_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3"  data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="3-1" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="13" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="18" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_tcnt 'Y'}}</span></a></td>
                <td onclick="resourceByeolClick($(this).data())" data-type="15" data-gender="t"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_out_tcnt 'Y'}}</span></a></td>
                <th class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">테스트</th>
                <td style="border:solid 2px black">{{addComma byeolDec_total_tCnt 'Y'}}</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dad9d7">총합</th>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="17" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma exchange_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="3"  data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma change_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="3-1" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma autochange_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="13" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma block_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="18" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma withdrawal_total_cnt 'Y'}}</span></a></td>
                <td class="_bgColor" data-bgcolor="#dad9d7" onclick="resourceByeolClick($(this).data())" data-type="15" data-gender="a"><a href="javascript://"><span class="_data _fontColor" data-fontcolor="#555">{{addComma test_out_total_cnt 'Y'}}</span></a></td>
                <td colspan="2" style="border:solid 2px black"></td>
            </tr>
            </tbody>
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
                <th colspan="17" class="_bgColor" data-bgcolor="#8faadc">달 증가</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th colspan="9" class="_bgColor" data-bgcolor="#f4b183">달 감소</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 결제</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 직접 선물</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">달 교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">가입보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">랭킹 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 지급)</th>
                <th colspan="5" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="3" class="_bgColor" data-bgcolor="#d9d9d9">증감</th>
                <th rowspan="2" style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">달 직접 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">아이템 선물</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">결제 취소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="3" class="_bgColor" data-bgcolor="#d9d9d9">증감</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">일반</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">자동</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">스페셜DJ</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">출석</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">룰렛</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">기타 자동</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">운영자 직접</th>
            </tr>
            <tr class="font-bold" style="background-color: #d9d9d9">
                <td>총합</td>
                <td>{{addComma totalInfo.total_charge_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_dalgiftget_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_changeAuto_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_join_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_ranking_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_specialdj_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_attendance_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_roulette_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
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
            </thead>
            <tbody>
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
                    <td>{{addComma autochange_Cnt 'Y'}}</td>
                    <td>{{addComma join_Cnt 'Y'}}</td>
                    <td>{{addComma levelup_Cnt 'Y'}}</td>
                    <td>{{addComma ranking_Cnt 'Y'}}</td>
                    <td>{{addComma recovery_Cnt 'Y'}}</td>
                    <td>{{addComma specialdj_Cnt 'Y'}}</td>
                    <td>{{addComma attendance_Cnt 'Y'}}</td>
                    <td>{{addComma roulette_Cnt 'Y'}}</td>
                    <td>{{addComma eventauto_Cnt 'Y'}}</td>
                    <td>{{addComma eventdirect_Cnt 'Y'}}</td>
                    <td>{{addComma testin_Cnt 'Y'}}</td>
                    <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_incTotal_Cnt 'Y'}}</td>
                    <td class="{{upAndDownClass sub_inc_Cnt}}"> <i class="fa {{upAndDownIcon sub_inc_Cnt}}"></i> {{addComma sub_inc_Cnt 'Y'}} </td>
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
                    <td class="{{upAndDownClass sub_dec_Cnt}}"> <i class="fa {{upAndDownIcon sub_dec_Cnt}}"></i> {{addComma sub_dec_Cnt 'Y'}} </td>
                </tr>
                {{/each}}
                <tr class="font-bold" style="background-color: #d9d9d9">
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_charge_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_dalgiftget_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_changeAuto_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_join_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_ranking_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_specialdj_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_attendance_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_roulette_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_incTotal_Cnt 'Y'}}</td>
                    <td></td>
                    <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_dalgiftsend_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_itemuse_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_decTotal_Cnt 'Y'}}</td>
                    <td></td>
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
                <th colspan="10" class="_bgColor" data-bgcolor="#8faadc">별 증가</th>
                <th style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th colspan="9" class="_bgColor" data-bgcolor="#f4b183">별 감소</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor" data-bgcolor="#b4c7e7">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">레벨업 보상</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">아이템 선물<br/>(비밀 선물)</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">이벤트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">환전 취소</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">소실금액 복구<br/>(운영자 지급)</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="3" class="_bgColor" data-bgcolor="#d9d9d9">증감</th>
                <th rowspan="2" style="background-color: white; border-bottom: hidden;border-top: hidden;"></th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#f8cbad">구분</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">환전 승인</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">교환</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">영구정지</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">탈퇴</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">테스트 회수</th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                <th rowspan="3" class="_bgColor" data-bgcolor="#d9d9d9">증감</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#dae3f3">(자동)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">(운영자 지급)</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">일반</th>
                <th class="_bgColor" data-bgcolor="#fbe5d6">자동</th>
            </tr>
            <tr class="font-bold" style="background-color: #d9d9d9">
                <td>총합</td>
                <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_byeolgift_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_incbyeol_Cnt 'Y'}}</td>
                <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                <td>총합</td>
                <td>{{addComma totalInfo.total_exchange_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_autochange_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                <td>{{addComma totalInfo.total_decbyeol_Cnt 'Y'}}</td>
            </tr>
            </thead>
            <tbody>
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
                    <td>{{addComma levelup_Cnt 'Y'}}</td>
                    <td>{{addComma byeolgift_Cnt 'Y'}}</td>
                    <td>{{addComma eventauto_Cnt 'Y'}}</td>
                    <td>{{addComma eventdirect_Cnt 'Y'}}</td>
                    <td>{{addComma cancel_Cnt 'Y'}}</td>
                    <td>{{addComma recovery_Cnt 'Y'}}</td>
                    <td>{{addComma testin_Cnt 'Y'}}</td>
                    <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_incByeolTotal_Cnt 'Y'}}</td>
                    <td class="{{upAndDownClass sub_inc_Cnt}}"> <i class="fa {{upAndDownIcon sub_inc_Cnt}}"></i> {{addComma sub_inc_Cnt 'Y'}} </td>
                    <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                    <td class="font-bold _bgColor" data-bgcolor="#fbe5d6">
                        {{#dalbit_if ../detailList.slctType '==' '0'}}{{the_hr}}시{{/dalbit_if}}
                        {{#dalbit_if ../detailList.slctType '==' '1'}}{{{date}}}{{/dalbit_if}}
                        {{#dalbit_if ../detailList.slctType '==' '2'}}{{the_date}}월{{/dalbit_if}}
                    </td>
                    <td>{{addComma exchange_Cnt 'Y'}}</td>
                    <td>{{addComma change_Cnt 'Y'}}</td>
                    <td>{{addComma autochange_Cnt 'Y'}}</td>
                    <td>{{addComma block_Cnt 'Y'}}</td>
                    <td>{{addComma withdrawal_Cnt 'Y'}}</td>
                    <td>{{addComma testout_Cnt 'Y'}}</td>
                    <td class="_bgColor" data-bgcolor="#d9d9d9">{{addComma sub_decByeolTotal_Cnt 'Y'}}</td>
                    <td class="{{upAndDownClass sub_dec_Cnt}}"> <i class="fa {{upAndDownIcon sub_dec_Cnt}}"></i> {{addComma sub_dec_Cnt 'Y'}} </td>
                    </tr>
                {{/each}}
                <tr class="font-bold" style="background-color: #d9d9d9">
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_levelup_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_byeolgift_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventauto_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_eventdirect_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_cancel_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_recovery_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testin_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_incbyeol_Cnt 'Y'}}</td>
                    <td></td>
                    <td style="background-color: white; border-bottom: hidden;border-top: hidden;"></td>
                    <td>총합</td>
                    <td>{{addComma totalInfo.total_exchange_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_change_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_autochange_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_block_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_withdrawal_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_testout_Cnt 'Y'}}</td>
                    <td>{{addComma totalInfo.total_decbyeol_Cnt 'Y'}}</td>
                    <td></td>
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
                <th colspan="4" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white" style="border:solid 2px black">현재 총 보유</th>
            </tr>
            <tr>
                <th colspan="2" class="_bgColor" data-bgcolor="#8faadc" style="border:solid 2px black">달</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#f8cbad" style="border:solid 2px black">별</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="border:solid 2px black">{{addComma total_Dal 'Y'}} 개</td>
                <td style="border:solid 2px black">{{addComma havecount_Dal 'Y'}} 명</td>
                <td style="border:solid 2px black">{{addComma total_Byeol 'Y'}} 개</td>
                <td style="border:solid 2px black">{{addComma havecount_Byeol 'Y'}} 명</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>