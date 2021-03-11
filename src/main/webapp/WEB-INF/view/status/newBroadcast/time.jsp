<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송현황 > 시간대별 -->
<div class="col-md-12 no-padding divTable">
    <span class="_searchDate font-bold " style="width: 144px"></span>
    <label class="" style="font-size: 11px;color: red;">
        * 중복(의 총합)ㅣ비중복(의 총합) 수치가 표기된 현황입니다.<br/>
        * 게스트 수치는 청취자 수치에 포함됩니다.
    </label>
</div>
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-12 no-padding" id="div_timeBroad">
            <span class="font-bold">◈방송 > 종합</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#8faadc">구분</th>
                    <th colspan="4" class="_bgColor" data-bgColor="#8faadc">라디오</th>
                    <th colspan="4" class="_bgColor" data-bgColor="#b4c7e7">영상</th>
                    <th colspan="4" class="_bgColor" data-bgcolor="#bfbfbf">총합</th>
                    <th colspan="5" class="_bgColor" data-bgColor="#f8cbad">청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#8faadc">선물 수</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#8faadc">선물 달</th>
                </tr>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#dae3f3">최대개설</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#dae3f3">방송시간</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#dae3f3">최대개설</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#dae3f3">방송시간</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#bfbfbf">최대개설</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#bfbfbf">방송시간</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">게스트</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#f8cbad">최대청취자</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                </tr>

                </thead>
                <tbody id="timeTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding" style="display: none" id="div_timeDetailRadio">
            <span class="font-bold">◈라디오 방송 > 성별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="8" class="_bgColor" data-bgColor="#b4c7e7">라디오 방송</th>
                    <th rowspan="3" class="_bgColor" data-bgcolor="#dae3f3">최대 개설</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">방송시간</th>
                    <th colspan="10" class="_bgColor" data-bgColor="#f8cbad">청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgcolor="#fbe5d6">최대 청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 수</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 달</th>
                </tr>
                <tr>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">게스트</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                </tr>
                </thead>
                <tbody id="timeDetailRadioTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding" style="display: none" id="div_timeDetailVideo">
            <span class="font-bold">◈영상 방송 > 성별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                    <col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/><col width="3.3%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="8" class="_bgColor" data-bgColor="#b4c7e7">영상 방송</th>
                    <th rowspan="3" class="_bgColor" data-bgcolor="#dae3f3">최대 개설</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">방송시간</th>
                    <th colspan="10" class="_bgColor" data-bgColor="#f8cbad">청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgcolor="#fbe5d6">최대 청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 수</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 달</th>
                </tr>
                <tr>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#dae3f3"></th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#fbe5d6"></th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">게스트</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">중복</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">비중복</th>
                </tr>
                </thead>
                <tbody id="timeDetailVideoTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈선물 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">DJ</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">게스트</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">라디오</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">영상</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">비밀</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d9d9d9">총합</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#dae3f3">건 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">달 수</th>
                    <th class="_bgColor" data-bgColor="#f8cbad">건 수</th>
                    <th class="_bgColor" data-bgColor="#f8cbad">달 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">건 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">달 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">건 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">달 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">건 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">달 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">달 수</th>
                </tr>
                </thead>
                <tbody  id="giftListBody">
                </tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈플랫폼 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                    <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                    <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="6" class="_bgColor" data-bgColor="#b4c7e7">라디오 방송</th>
                    <th colspan="6" class="_bgColor" data-bgColor="#b4c7e7">영상 방송</th>
                    <th rowspan="2" colspan="2" class="_bgColor" data-bgColor="#d9d9d9">소계</th>
                </tr>
                <tr>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">PC</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">AOS</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">IOS</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">PC</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">AOS</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#dae3f3">IOS</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">방송 시간</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">총 건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">총 방송 시간</th>
                </tr>
                </thead>
                <tbody id="platformTimeListBody">
                </tbody>
            </table>
        </div>
        <div class="col-md-8 no-padding">
            <span class="font-bold">◈방송 주제 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
                    <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
                    <col width="8.3%"/><col width="8.3%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">수다/챗</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">일상/소통</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">힐링</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">노래/연주</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">미팅/소개팅</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">고민/사연</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">책/여행</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">ASMR</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">성우</th>
                    <th class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                </thead>
                <tbody id="typeTimeTableBody"></tbody>
            </table>
        </div>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        // getTimeList();
    });


    function getTimeList(){
        var data = dataSet();
        data.slctType = 0;
        data.detailType = 0;
        var timeDay = week[moment(data.startDate).add('days', 0).day()];

        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월 DD일') + "(" + timeDay + ")");


        $(".timeBroad").find("#div_timeBroad").hide();
        $(".timeBroad").find("#div_timeDetailRadio").hide();
        $(".timeBroad").find("#div_timeDetailVideo").hide();
        if(tabId == "tab_time"){
            $(".timeBroad").find("#div_timeBroad").show();
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time/new", data, fn_time_success);
        }else{
            data.detailType = 1;
            data.roomType = 0;
            $(".timeBroad").find("#div_timeDetailRadio").show();
            $(".timeBroad").find("#div_timeDetailVideo").show();
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time/new", data, fn_timeDetailRadio_success);
            data.roomType = 1;
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time/new", data, fn_timeDetailVideo_success);
        }

        util.getAjaxData("broadcastGift", "/rest/status/broadcast/broadcastGift/list", data, fn_broadcastGift_success);

        util.getAjaxData("memberList", "/rest/status/broadcast/info/platform", data, fn_platformTimeList_success);

        util.getAjaxData("type", "/rest/status/newBroadcast/info/type", data, fn_typeTime_success);
    }

    function fn_time_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".timeBroad").find("#timeTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_timeTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
        }

        var template = $('#tmp_timeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#timeTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    // 라디오 방송 > 성별
    function fn_timeDetailRadio_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".timeBroad").find("#timeDetailRadioTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_timeDetailRadioTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
        }

        var template = $('#tmp_timeDetailRadioList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#timeDetailRadioTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    // 영상 방송 > 성별
    function fn_timeDetailVideo_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".timeBroad").find("#timeDetailVideoTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_timeDetailVideoTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
        }

        var template = $('#tmp_timeDetailVideoList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#timeDetailVideoTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }



    function fn_broadcastGift_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $(".timeBroad").find("#giftListBody").empty();
        if(!isDataEmpty){

            // response.data.totalInfo.sum_totalGiftCnt = response.data.totalInfo.sum_normalGiftCnt + response.data.totalInfo.sum_guest_normalGiftCnt;
            // response.data.totalInfo.sum_totalGiftCmt = response.data.totalInfo.sum_normalGiftCmt + response.data.totalInfo.sum_guest_normalGiftCmt;
            // response.data.totalInfo.sum_totalGiftAmount = response.data.totalInfo.sum_normalGiftAmount + response.data.totalInfo.sum_guest_normalGiftAmount;
            // response.data.totalInfo.sum_totalSecretGiftCnt = response.data.totalInfo.sum_secretGiftCnt + response.data.totalInfo.sum_guest_secretGiftCnt;
            // response.data.totalInfo.sum_totalSecretGiftCmt = response.data.totalInfo.sum_secretGiftCmt + response.data.totalInfo.sum_guest_secretGiftCmt;
            // response.data.totalInfo.sum_totalSecretGiftAmount = response.data.totalInfo.sum_secretGiftAmount + response.data.totalInfo.sum_guest_secretGiftAmount;

            var template = $('#tmp_giftTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#giftListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].daily.substr(8,2);

            toDay = week[moment(response.data.detailList[i].daily.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;

            // response.data.detailList[i].totalGiftCnt = response.data.detailList[i].normalGiftCnt + response.data.detailList[i].guest_normalGiftCnt;
            // response.data.detailList[i].totalGiftCmt = response.data.detailList[i].normalGiftCmt + response.data.detailList[i].guest_normalGiftCmt;
            // response.data.detailList[i].totalGiftAmount = response.data.detailList[i].normalGiftAmount + response.data.detailList[i].guest_normalGiftAmount;
            // response.data.detailList[i].totalSecretGiftCnt = response.data.detailList[i].secretGiftCnt + response.data.detailList[i].guest_secretGiftCnt;
            // response.data.detailList[i].totalSecretGiftCmt = response.data.detailList[i].secretGiftCmt + response.data.detailList[i].guest_secretGiftCmt;
            // response.data.detailList[i].totalSecretGiftAmount = response.data.detailList[i].secretGiftAmount + response.data.detailList[i].guest_secretGiftAmount;

        }

        var template = $('#tmp_giftDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $(".timeBroad").find("#giftListBody").append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#giftListBody td:last").remove();
        }else{
            $(".timeBroad").find("#giftListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_platformTimeList_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $(".timeBroad").find("#platformTimeListBody").empty();
        if(!isDataEmpty){

            response.data.totalInfo.totalCnt = response.data.totalInfo.totalCreateCnt + response.data.totalInfo.v_totalCreateCnt;
            response.data.totalInfo.totalTime = response.data.totalInfo.totalBroadcastingTime + response.data.totalInfo.v_totalBroadcastingTime;

            var template = $('#tmp_platformTime').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#platformTimeListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].totalCnt = response.data.detailList[i].totalCreateCnt + response.data.detailList[i].v_totalCreateCnt;
            response.data.detailList[i].totalTime = response.data.detailList[i].totalBroadcastingTime + response.data.detailList[i].v_totalBroadcastingTime;
        }

        var template = $('#tmp_platformTimeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $(".timeBroad").find("#platformTimeListBody").append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#platformTimeListBody td:last").remove();
        }else{
            $(".timeBroad").find("#platformTimeListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_typeTime_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".timeBroad").find("#typeTimeTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_typeTime').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }


        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].daily.substr(8,2);

            toDay = week[moment(response.data.detailList[i].daily.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;

        }

        var template = $('#tmp_typeTimeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".timeBroad").find("#typeTimeTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

</script>

<script type="text/x-handlebars-template" id="tmp_timeTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_a_create_Cnt}}</td>
        <td>{{addComma sum_a_unique_dj_Cnt}}</td>
        <td>-</td>
        <td>{{timeStampDay sum_a_airtime}}</td>
        <td>{{addComma sum_v_create_Cnt}}</td>
        <td>{{addComma sum_v_unique_dj_Cnt}}</td>
        <td>-</td>
        <td>{{timeStampDay sum_v_airtime}}</td>
        <td>{{addComma sum_create_Cnt}}</td>
        <td>{{addComma sum_unique_dj_Cnt}}</td>
        <td>-</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>-</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>

    </tr>
</script>
<script type="text/x-handlebars-template" id="tmp_timeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_hr}}시
        </td>
        <td class="_fontColor" data-fontColor="">{{addComma a_create_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma a_unique_dj_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma a_create_max_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{timeStampDay a_airtime 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma v_create_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma v_unique_dj_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma v_create_max_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{timeStampDay v_airtime 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma create_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma unique_dj_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma create_max_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{timeStampDay airtime 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma listener_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma unique_listener_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma guest_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma guest_unique_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma listener_max_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma gift_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma gift_Amt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<%--라디오방송 성별--%>
<script type="text/x-handlebars-template" id="tmp_timeDetailRadioTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_create_mCnt}}</td>
        <td>{{addComma sum_unique_dj_mCnt}}</td>
        <td>{{addComma sum_create_fCnt}}</td>
        <td>{{addComma sum_unique_dj_fCnt}}</td>
        <td>{{addComma sum_create_nCnt}}</td>
        <td>{{addComma sum_unique_dj_nCnt}}</td>
        <td>{{addComma sum_create_Cnt}}</td>
        <td>{{addComma sum_unique_dj_Cnt}}</td>
        <td>-</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_mCnt}}</td>
        <td>{{addComma sum_unique_listener_mCnt}}</td>
        <td>{{addComma sum_listener_fCnt}}</td>
        <td>{{addComma sum_unique_listener_fCnt}}</td>
        <td>{{addComma sum_listener_nCnt}}</td>
        <td>{{addComma sum_unique_listener_nCnt}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>-</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>
    </tr>
</script>
<script type="text/x-handlebars-template" id="tmp_timeDetailRadioList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
    <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
    {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
    {{data.the_hr}}시
    </td>
    <td class="_fontColor" data-fontColor="">{{addComma create_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_max_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{timeStampDay airtime 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma guest_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma guest_unique_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_max_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma gift_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma gift_Amt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<%--영상방송 성별--%>
<script type="text/x-handlebars-template" id="tmp_timeDetailVideoTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_create_mCnt}}</td>
        <td>{{addComma sum_unique_dj_mCnt}}</td>
        <td>{{addComma sum_create_fCnt}}</td>
        <td>{{addComma sum_unique_dj_fCnt}}</td>
        <td>{{addComma sum_create_nCnt}}</td>
        <td>{{addComma sum_unique_dj_nCnt}}</td>
        <td>{{addComma sum_create_Cnt}}</td>
        <td>{{addComma sum_unique_dj_Cnt}}</td>
        <td>-</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_mCnt}}</td>
        <td>{{addComma sum_unique_listener_mCnt}}</td>
        <td>{{addComma sum_listener_fCnt}}</td>
        <td>{{addComma sum_unique_listener_fCnt}}</td>
        <td>{{addComma sum_listener_nCnt}}</td>
        <td>{{addComma sum_unique_listener_nCnt}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>-</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>
    </tr>
</script>
<script type="text/x-handlebars-template" id="tmp_timeDetailVideoList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
    <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
    {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
    {{data.the_hr}}시
    </td>
    <td class="_fontColor" data-fontColor="">{{addComma create_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_dj_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma create_max_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{timeStampDay airtime 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_mCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_fCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_nCnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma unique_listener_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma guest_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma guest_unique_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma listener_max_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma gift_Cnt 'Y'}}</td>
    <td class="_fontColor" data-fontColor="">{{addComma gift_Amt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>





<script type="text/x-handlebars-template" id="tmp_giftTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_djGiftCnt}}</td>
        <td>{{addComma sum_djGiftAmount}}</td>
        <td>{{addComma sum_guestGiftCnt}}</td>
        <td>{{addComma sum_guestGiftAmount}}</td>
        <td>{{addComma sum_audioGiftCnt}}</td>
        <td>{{addComma sum_audioGiftAmount}}</td>
        <td>{{addComma sum_vedioGiftCnt}}</td>
        <td>{{addComma sum_vedioGiftAmount}}</td>
        <td>{{addComma sum_secretGiftCnt}}</td>
        <td>{{addComma sum_secretGiftAmount}}</td>
        <td>{{addComma sum_totalGiftCnt}}</td>
        <td>{{addComma sum_totalGiftAmount}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' hour}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.hour}}시
        </td>
        <td>{{addComma djGiftCnt 'Y'}}</td>
        <td>{{addComma djGiftAmount 'Y'}}</td>
        <td>{{addComma guestGiftCnt 'Y'}}</td>
        <td>{{addComma guestGiftAmount 'Y'}}</td>
        <td>{{addComma audioGiftCnt 'Y'}}</td>
        <td>{{addComma audioGiftAmount 'Y'}}</td>
        <td>{{addComma vedioGiftCnt 'Y'}}</td>
        <td>{{addComma vedioGiftAmount 'Y'}}</td>
        <td>{{addComma secretGiftCnt 'Y'}}</td>
        <td>{{addComma secretGiftAmount 'Y'}}</td>
        <td>{{addComma totalGiftCnt 'Y'}}</td>
        <td>{{addComma totalGiftAmount 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="13" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_platformTime">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_pcCnt 'Y'}}</td>
        <td>{{timeStampDay sum_pcTime}}</td>
        <td>{{addComma sum_androidCnt 'Y'}}</td>
        <td>{{timeStampDay sum_androidTime}}</td>
        <td>{{addComma sum_iosCnt 'Y'}}</td>
        <td>{{timeStampDay sum_iosTime}}</td>
        <td>{{addComma sum_v_pcCnt 'Y'}}</td>
        <td>{{timeStampDay sum_v_pcTime}}</td>
        <td>{{addComma sum_v_androidCnt 'Y'}}</td>
        <td>{{timeStampDay sum_v_androidTime}}</td>
        <td>{{addComma sum_v_iosCnt 'Y'}}</td>
        <td>{{timeStampDay sum_v_iosTime}}</td>
        <td>{{addComma sum_totalCnt 'Y'}}</td>
        <td>{{timeStampDay sum_totalTime}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_platformTimeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' hour}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.hour}}시
        </td>
        <td>{{addComma pcCnt 'Y'}}</td>
        <td>{{timeStampDay pcTime}}</td>
        <td>{{addComma androidCnt 'Y'}}</td>
        <td>{{timeStampDay androidTime}}</td>
        <td>{{addComma iosCnt 'Y'}}</td>
        <td>{{timeStampDay iosTime}}</td>
        <td>{{addComma v_pcCnt 'Y'}}</td>
        <td>{{timeStampDay v_pcTime}}</td>
        <td>{{addComma v_androidCnt 'Y'}}</td>
        <td>{{timeStampDay v_androidTime}}</td>
        <td>{{addComma v_iosCnt 'Y'}}</td>
        <td>{{timeStampDay v_iosTime}}</td>
        <td>{{addComma totalCnt 'Y'}}</td>
        <td>{{timeStampDay totalTime}}</td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_typeTime">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_create03Cnt}}</td>
        <td>{{addComma sum_create00Cnt}}</td>
        <td>{{addComma sum_create01Cnt}}</td>
        <td>{{addComma sum_create02Cnt}}</td>
        <td>{{addComma sum_create04Cnt}}</td>
        <td>{{addComma sum_create05Cnt}}</td>
        <td>{{addComma sum_create06Cnt}}</td>
        <td>{{addComma sum_create09Cnt}}</td>
        <td>{{addComma sum_create13Cnt}}</td>
        <td>{{addComma sum_totalCreateCnt}} ({{addComma sum_unique_dj_Cnt}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_typeTimeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' hour}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.hour}}시
        </td>
        <td>{{addComma create03Cnt 'Y'}}</td>
        <td>{{addComma create00Cnt 'Y'}}</td>
        <td>{{addComma create01Cnt 'Y'}}</td>
        <td>{{addComma create02Cnt 'Y'}}</td>
        <td>{{addComma create04Cnt 'Y'}}</td>
        <td>{{addComma create05Cnt 'Y'}}</td>
        <td>{{addComma create06Cnt 'Y'}}</td>
        <td>{{addComma create09Cnt 'Y'}}</td>
        <td>{{addComma create13Cnt 'Y'}}</td>
        <td {{#dalbit_if nowHour '!=' hour}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if totalCreateCnt '!=' 0}}{{addComma totalCreateCnt 'Y'}} ({{addComma unique_dj_Cnt}}){{/dalbit_if}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>