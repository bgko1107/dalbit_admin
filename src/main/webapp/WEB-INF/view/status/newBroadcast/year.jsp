<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송현황 > 시간대별 -->
<div class="col-md-12 no-padding divTable">
    <span class="_searchDate font-bold " style="width: 60px"></span>
    <label class="" style="font-size: 11px;color: red;">
        * 총 수치(비중복 수치)로 표기된 현황입니다.<br/>
        * 게스트 수치는 청취자 수치에 포함됩니다.
    </label>
</div>
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-12 no-padding" id="div_yearBroad">
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
                <tbody id="yearTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding" style="display: none" id="div_yearDetailRadio">
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
                <tbody id="yearDetailRadioTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding" style="display: none" id="div_yearDetailVideo">
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
                <tbody id="yearDetailVideoTableBody"></tbody>
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
                <tbody  id="giftYearListBody">
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
                <tbody id="platformYearListBody">
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
                <tbody id="typeYearTableBody"></tbody>
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
        // getYearList();
    });
    function getYearList(){

        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년'));

        $(".yearBroad").find("#div_yearBroad").hide();
        $(".yearBroad").find("#div_yearDetailRadio").hide();
        $(".yearBroad").find("#div_yearDetailVideo").hide();


        var data = dataSet();
        data.slctType = 2;

        console.log(tabId);
        if(tabId == "tab_year"){
            console.log("------------- 0");
            $(".yearBroad").find("#div_yearBroad").show();
            util.getAjaxData("year", "/rest/status/newBroadcast/info/time/new", data, fn_year_success);
        }else{
            console.log("------------- 1");
            data.detailType = 1;
            data.roomType = 0;
            $(".yearBroad").find("#div_yearDetailRadio").show();
            $(".yearBroad").find("#div_yearDetailVideo").show();
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time/new", data, fn_yearDetailRadio_success);
            data.roomType = 1;
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time/new", data, fn_yearDetailVideo_success);
        }

        util.getAjaxData("broadcastGift", "/rest/status/broadcast/broadcastGift/list", data, fn_broadcastgiftYear_success);

        util.getAjaxData("memberList", "/rest/status/broadcast/info/platform", data, fn_platformYearList_success);

        util.getAjaxData("type", "/rest/status/newBroadcast/info/type", data, fn_typeYear_success);
    }

    function fn_year_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#yearTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_yearTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,6);
        }

        var template = $('#tmp_yearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#yearTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    // 라디오 방송 > 성별
    function fn_yearDetailRadio_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".yearBroad").find("#yearDetailRadioTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_yearDetailRadioTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,6);
        }

        var template = $('#tmp_yearDetailRadioList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".yearBroad").find("#yearDetailRadioTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    // 영상 방송 > 성별
    function fn_yearDetailVideo_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".yearBroad").find("#yearDetailVideoTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_yearDetailVideoTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,6);
        }

        var template = $('#tmp_yearDetailVideoList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".yearBroad").find("#yearDetailVideoTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_broadcastgiftYear_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $(".yearBroad").find("#giftYearListBody").empty();
        if(!isDataEmpty){

            // response.data.totalInfo.sum_totalGiftCnt = response.data.totalInfo.sum_normalGiftCnt + response.data.totalInfo.sum_guest_normalGiftCnt;
            // response.data.totalInfo.sum_totalGiftCmt = response.data.totalInfo.sum_normalGiftCmt + response.data.totalInfo.sum_guest_normalGiftCmt;
            // response.data.totalInfo.sum_totalGiftAmount = response.data.totalInfo.sum_normalGiftAmount + response.data.totalInfo.sum_guest_normalGiftAmount;
            // response.data.totalInfo.sum_totalSecretGiftCnt = response.data.totalInfo.sum_secretGiftCnt + response.data.totalInfo.sum_guest_secretGiftCnt;
            // response.data.totalInfo.sum_totalSecretGiftCmt = response.data.totalInfo.sum_secretGiftCmt + response.data.totalInfo.sum_guest_secretGiftCmt;
            // response.data.totalInfo.sum_totalSecretGiftAmount = response.data.totalInfo.sum_secretGiftAmount + response.data.totalInfo.sum_guest_secretGiftAmount;

            var template = $('#tmp_giftYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $(".yearBroad").find("#giftYearListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].month = response.data.detailList[i].monthly;
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + common.lpad(response.data.detailList[i].monthly,2,"0");

            // response.data.detailList[i].totalGiftCnt = response.data.detailList[i].normalGiftCnt + response.data.detailList[i].guest_normalGiftCnt;
            // response.data.detailList[i].totalGiftCmt = response.data.detailList[i].normalGiftCmt + response.data.detailList[i].guest_normalGiftCmt;
            // response.data.detailList[i].totalGiftAmount = response.data.detailList[i].normalGiftAmount + response.data.detailList[i].guest_normalGiftAmount;
            // response.data.detailList[i].totalSecretGiftCnt = response.data.detailList[i].secretGiftCnt + response.data.detailList[i].guest_secretGiftCnt;
            // response.data.detailList[i].totalSecretGiftCmt = response.data.detailList[i].secretGiftCmt + response.data.detailList[i].guest_secretGiftCmt;
            // response.data.detailList[i].totalSecretGiftAmount = response.data.detailList[i].secretGiftAmount + response.data.detailList[i].guest_secretGiftAmount;
        }

        var template = $('#tmp_giftYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $(".yearBroad").find("#giftYearListBody").append(html);

        if(isDataEmpty){
            $(".yearBroad").find("#giftYearListBody td:last").remove();
        }else{
            $(".yearBroad").find("#giftYearListBody").append(totalHtml);
        }
        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_platformYearList_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $(".yearBroad").find("#platformYearListBody").empty();
        if(!isDataEmpty){
            response.data.totalInfo.totalCnt = response.data.totalInfo.totalCreateCnt + response.data.totalInfo.v_totalCreateCnt;
            response.data.totalInfo.totalTime = response.data.totalInfo.totalBroadcastingTime + response.data.totalInfo.v_totalBroadcastingTime;

            var template = $('#tmp_platformYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $(".yearBroad").find("#platformYearListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].totalCnt = response.data.detailList[i].totalCreateCnt + response.data.detailList[i].v_totalCreateCnt;
            response.data.detailList[i].totalTime = response.data.detailList[i].totalBroadcastingTime + response.data.detailList[i].v_totalBroadcastingTime;

            response.data.detailList[i].month = response.data.detailList[i].monthly.substr(5,2);
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + response.data.detailList[i].monthly.substr(5,2);
        }

        var template = $('#tmp_platformYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $(".yearBroad").find("#platformYearListBody").append(html);

        if(isDataEmpty){
            $(".yearBroad").find("#platformYearListBody td:last").remove();
        }else{
            $(".yearBroad").find("#platformYearListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_typeYear_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $(".yearBroad").find("#typeYearTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_typeYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }


        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = moment().format("MM");
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].month = response.data.detailList[i].monthly.substr(5,2);
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + response.data.detailList[i].monthly.substr(5,2);
        }

        var template = $('#tmp_typeYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $(".yearBroad").find("#typeYearTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_yearTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_a_create_Cnt}}</td>
        <td>{{addComma sum_a_unique_dj_Cnt}}</td>
        <td>{{addComma sum_a_create_max_Cnt}}</td>
        <td>{{timeStampDay sum_a_airtime}}</td>
        <td>{{addComma sum_v_create_Cnt}}</td>
        <td>{{addComma sum_v_unique_dj_Cnt}}</td>
        <td>{{addComma sum_v_create_max_Cnt}}</td>
        <td>{{timeStampDay sum_v_airtime}}</td>
        <td>{{addComma sum_create_Cnt}}</td>
        <td>{{addComma sum_unique_dj_Cnt}}</td>
        <td>{{addComma sum_create_max_Cnt}}</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>{{addComma sum_listener_max_Cnt}}</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_yearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_date}}
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



<script type="text/x-handlebars-template" id="tmp_yearDetailRadioTotal">
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
        <td>{{addComma sum_create_max_Cnt}}</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_mCnt}}</td>
        <td>{{addComma sum_unique_listener_mCnt}}</td>
        <td>{{addComma sum_listener_fCnt}}</td>
        <td>{{addComma sum_unique_listener_fCnt}}</td>
        <td>{{addComma sum_listener_nCnt}}</td>
        <td>{{addComma sum_unique_listener_nCnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_listener_max_Cnt}}</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>
    </tr>
</script>
<script type="text/x-handlebars-template" id="tmp_yearDetailRadioList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_date}}
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
        <td class="_fontColor" data-fontColor="">{{addComma guest_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma guest_unique_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma listener_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma unique_listener_Cnt 'Y'}}</td>
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
<script type="text/x-handlebars-template" id="tmp_yearDetailVideoTotal">
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
        <td>{{addComma sum_create_max_Cnt}}</td>
        <td>{{timeStampDay sum_airtime}}</td>
        <td>{{addComma sum_listener_mCnt}}</td>
        <td>{{addComma sum_unique_listener_mCnt}}</td>
        <td>{{addComma sum_listener_fCnt}}</td>
        <td>{{addComma sum_unique_listener_fCnt}}</td>
        <td>{{addComma sum_listener_nCnt}}</td>
        <td>{{addComma sum_unique_listener_nCnt}}</td>
        <td>{{addComma sum_guest_Cnt}}</td>
        <td>{{addComma sum_guest_unique_Cnt}}</td>
        <td>{{addComma sum_listener_Cnt}}</td>
        <td>{{addComma sum_unique_listener_Cnt}}</td>
        <td>{{addComma sum_listener_max_Cnt}}</td>
        <td>{{addComma sum_gift_Cnt}}</td>
        <td>{{addComma sum_gift_Amt}}</td>
    </tr>
</script>
<script type="text/x-handlebars-template" id="tmp_yearDetailVideoList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_date}}
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
        <td class="_fontColor" data-fontColor="">{{addComma guest_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma guest_unique_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma listener_Cnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="">{{addComma unique_listener_Cnt 'Y'}}</td>
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





<script type="text/x-handlebars-template" id="tmp_giftYear">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_djGiftCnt}}</td>
        <td>{{addComma sum_djGiftCmt}}</td>
        <td>{{addComma sum_guestGiftCnt}}</td>
        <td>{{addComma sum_guestGiftCmt}}</td>
        <td>{{addComma sum_audioGiftCnt}}</td>
        <td>{{addComma sum_audioGiftCmt}}</td>
        <td>{{addComma sum_vedioGiftCnt}}</td>
        <td>{{addComma sum_vedioGiftCmt}}</td>
        <td>{{addComma sum_secretGiftCnt}}</td>
        <td>{{addComma sum_secretGiftCmt}}</td>
        <td>{{addComma sum_totalGiftCnt}}</td>
        <td>{{addComma sum_totalGiftCmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
        </td>
        <td>{{addComma djGiftCnt 'Y'}}</td>
        <td>{{addComma djGiftCmt 'Y'}}</td>
        <td>{{addComma guestGiftCnt 'Y'}}</td>
        <td>{{addComma guestGiftCmt 'Y'}}</td>
        <td>{{addComma audioGiftCnt 'Y'}}</td>
        <td>{{addComma audioGiftCmt 'Y'}}</td>
        <td>{{addComma vedioGiftCnt 'Y'}}</td>
        <td>{{addComma vedioGiftCmt 'Y'}}</td>
        <td>{{addComma secretGiftCnt 'Y'}}</td>
        <td>{{addComma secretGiftCmt 'Y'}}</td>
        <td>{{addComma totalGiftCnt 'Y'}}</td>
        <td>{{addComma totalGiftCmt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_platformYear">
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

<script type="text/x-handlebars-template" id="tmp_platformYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
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


<script type="text/x-handlebars-template" id="tmp_typeYear">
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

<script type="text/x-handlebars-template" id="tmp_typeYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
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
        <td {{#dalbit_if nowMonth '!=' month}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if totalCreateCnt '!=' 0}}{{addComma totalCreateCnt 'Y'}} ({{addComma unique_dj_Cnt}}){{/dalbit_if}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>