<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송현황 > 시간대별 -->
<span class="_searchDate font-bold"></span>
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-11 no-padding" >
            <span class="font-bold">◈클립등록자 성별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col />
                    <col width="4.3%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.3%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.3%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.3%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="5" class="_bgColor _sex_male" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor _sex_female" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor _sex_none" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor" data-bgColor="#d0cece">총합계</th>
                </tr>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e2e2e2">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e2e2e2">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e2e2e2">삭제</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">공개</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">비공개</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">본인</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">운영자</th>
                </tr>
                </thead>
                <tbody id="dayTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈선물 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col/>
                    <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                    <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">건수</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">달수</th>
                </tr>
                </thead>
                <tbody  id="giftDayListBody">
                </tbody>
            </table>
        </div>

        <div class="col-md-9 no-padding">
            <span class="font-bold">◈연령대 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col/>
                    <col width="11.2%"/><col width="11.2%"/><col width="11.2%"/><col width="11.2%"/>
                    <col width="11.2%"/><col width="11.2%"/><col width="11.2%"/><col width="11.2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">12세~16세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">17세~19세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">20세~25세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">26세~30세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">31세~35세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">36세~40세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">40세이상</th>
                    <th class="_bgColor" data-bgColor="#d0cece">누적합계</th>
                </tr>
                </thead>
                <tbody id="ageDayTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding">
            <span class="font-bold">◈클립 주제 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                    <col width="5.15%"/><col width="5.15%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor subject01" data-bgColor="#b4c7e7">01</th>
                    <th colspan="2" class="_bgColor subject02" data-bgColor="#b4c7e7">02</th>
                    <th colspan="2" class="_bgColor subject03" data-bgColor="#b4c7e7">03</th>
                    <th colspan="2" class="_bgColor subject04" data-bgColor="#b4c7e7">04</th>
                    <th colspan="2" class="_bgColor subject05" data-bgColor="#b4c7e7">05</th>
                    <th colspan="2" class="_bgColor subject06" data-bgColor="#b4c7e7">06</th>
                    <th colspan="2" class="_bgColor subject07" data-bgColor="#b4c7e7">07</th>
                    <th colspan="2" class="_bgColor subject08" data-bgColor="#b4c7e7">08</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">누적합계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e2e2e2">청취자 수</th>
                </tr>
                </thead>
                <tbody id="typeDayTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈플랫폼 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col/>
                    <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                    <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">클립 등록 (삭제) 수</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">클립 청취자 수</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">PC웹</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">안드로이드</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">아이폰</th>

                    <th class="_bgColor" data-bgColor="#e9ebf5">PC웹</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">안드로이드</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">아이폰</th>
                </tr>
                </thead>
                <tbody id="platformDayListBody">
                </tbody>
            </table>
        </div>

    </div>
</div>
<div class="widget-footer">
    <span>
        <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
    </span>
</div>

<script type="text/javascript">
    $(function(){
        // getDayList();
    });

    function getDayList(){
        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월'));

        var data = dataSet();
        data.slctType = 1;
        util.getAjaxData("time", "/rest/clip/status/info/time", data, fn_day_success);

        // 선물 현황
        util.getAjaxData("clipStatusGift", "/rest/clip/status/gift", data, fn_clipStatusGiftDay_success);
        // 연령별
        util.getAjaxData("age", "/rest/clip/status/info/age", data, fn_clipStatusAgeDay_success);
        // 클립 주제별
        util.getAjaxData("type", "/rest/clip/status/info/type", data, fn_typeDay_success);
        // 플랫폼 별
        util.getAjaxData("platform", "/rest/clip/status/info/platform", data, fn_platformDayList_success);
    }

    function fn_day_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#dayTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var total_create_totalCnt = [
                response.data.totalInfo.total_create_mCnt,
                response.data.totalInfo.total_create_fCnt,
                response.data.totalInfo.total_create_nCnt,
            ];
            response.data.totalInfo["total_create_totalCnt"] = common.getListSum(total_create_totalCnt);

            var total_listener_totalCnt = [
                response.data.totalInfo.total_listener_mCnt,
                response.data.totalInfo.total_listener_fCnt,
                response.data.totalInfo.total_listener_nCnt,
            ];
            response.data.totalInfo["total_listener_totalCnt"] = common.getListSum(total_listener_totalCnt);

            var template = $('#tmp_dayTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].index = common.lpad(Number(moment().format("HH")),2,"0");

            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")";
            }
            response.data.detailList[i].the_date = toDay;
        }

        //현재 객체 배열을 정렬
        response.data.detailList.sort(function (a, b) {
            return a.index < b.index ? 1 : -1;
        });

        var tmp_create_totalCnt = 0;
        var tmp_listener_totalCnt = 0;
        for(var i=0;i<response.data.detailList.length;i++){
            var create_totalCnt = [
                response.data.detailList[i].create_mCnt,
                response.data.detailList[i].create_fCnt,
                response.data.detailList[i].create_nCnt,
            ];
            if(common.getListSum(create_totalCnt) != 0 ){
                response.data.detailList[i].create_totalCnt = common.getListSum(create_totalCnt);
                response.data.detailList[i].create_accuTotalCnt = tmp_create_totalCnt + common.getListSum(create_totalCnt);
                tmp_create_totalCnt = tmp_create_totalCnt + common.getListSum(create_totalCnt);
            }else{
                response.data.detailList[i].create_totalCnt = 0;
                response.data.detailList[i].create_accuTotalCnt = 0;
            }
            var listener_totalCnt = [
                response.data.detailList[i].listener_mCnt,
                response.data.detailList[i].listener_fCnt,
                response.data.detailList[i].listener_nCnt,
            ];
            if(common.getListSum(listener_totalCnt) != 0){
                response.data.detailList[i].listener_totalCnt = common.getListSum(listener_totalCnt);
                response.data.detailList[i].listener_accuTotalCnt = tmp_listener_totalCnt + common.getListSum(listener_totalCnt);
                tmp_listener_totalCnt = tmp_listener_totalCnt + common.getListSum(listener_totalCnt);
            }else{
                response.data.detailList[i].listener_accuTotalCnt = 0;
                response.data.detailList[i].listener_totalCnt = 0;
            }
        }
        //현재 객체 배열을 정렬
        response.data.detailList.sort(function (a, b) {
            return a.index < b.index ? 1 : -1;
        });


        var template = $('#tmp_dayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#dayTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_clipStatusGiftDay_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#giftDayListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_giftDay').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#giftDayListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].daily.substr(8,2);

            toDay = week[moment(response.data.detailList[i].daily.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].daily.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].daily.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].daily.replace(/-/gi,".") + " (" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;
        }

        var template = $('#tmp_giftDayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#giftDayListBody").append(html);

        if(isDataEmpty){
            $("#giftDayListBody td:last").remove();
        }else{
            $("#giftDayListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_clipStatusAgeDay_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#ageDayTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_ageDay').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#ageDayTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].date.replace(/-/gi,".") + " (" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;
        }

        var template = $('#tmp_ageDayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#ageDayTableBody").append(html);

        if(isDataEmpty){
            $("#ageDayTableBody td:last").remove();
        }else{
            $("#ageDayTableBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_platformDayList_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#platformDayListBody").empty();

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];

            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;

            response.data.detailList[i].reg_total_cnt =  response.data.detailList[i].reg_and_cnt
                + response.data.detailList[i].reg_ios_cnt
                + response.data.detailList[i].reg_pc_cnt;
            response.data.detailList[i].del_total_cnt =  response.data.detailList[i].del_and_cnt
                + response.data.detailList[i].del_ios_cnt
                + response.data.detailList[i].del_pc_cnt;
            response.data.detailList[i].listen_total_cnt =  response.data.detailList[i].listen_and_cnt
                + response.data.detailList[i].listen_ios_cnt
                + response.data.detailList[i].listen_pc_cnt;

            response.data.totalInfo.sum_reg_total_cnt +=  response.data.detailList[i].reg_total_cnt;
            response.data.totalInfo.sum_del_total_cnt +=  response.data.detailList[i].del_total_cnt;
            response.data.totalInfo.sum_listen_total_cnt +=  response.data.detailList[i].listen_total_cnt;
        }

        if(!isDataEmpty){
            var template = $('#tmp_platformDay').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#platformDayListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tmp_platformDayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#platformDayListBody").append(html);

        if(isDataEmpty){
            $("#platformDayListBody td:last").remove();
        }else{
            $("#platformDayListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_typeDay_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#typeDayTableBody");

        tableBody.empty();
        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")"+ '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")"+ '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + " (" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            response.data.detailList[i].reg_total_cnt =  response.data.detailList[i].reg_01_cnt
                + response.data.detailList[i].reg_02_cnt
                + response.data.detailList[i].reg_03_cnt
                + response.data.detailList[i].reg_04_cnt
                + response.data.detailList[i].reg_05_cnt
                + response.data.detailList[i].reg_06_cnt
                + response.data.detailList[i].reg_07_cnt
                + response.data.detailList[i].reg_08_cnt
                + response.data.detailList[i].reg_09_cnt
                + response.data.detailList[i].reg_10_cnt ;
            response.data.detailList[i].del_total_cnt =  response.data.detailList[i].del_01_cnt
                + response.data.detailList[i].del_02_cnt
                + response.data.detailList[i].del_03_cnt
                + response.data.detailList[i].del_04_cnt
                + response.data.detailList[i].del_05_cnt
                + response.data.detailList[i].del_06_cnt
                + response.data.detailList[i].del_07_cnt
                + response.data.detailList[i].del_08_cnt
                + response.data.detailList[i].del_09_cnt
                + response.data.detailList[i].del_10_cnt ;
            response.data.detailList[i].play_total_cnt =  response.data.detailList[i].play_01_cnt
                + response.data.detailList[i].play_02_cnt
                + response.data.detailList[i].play_03_cnt
                + response.data.detailList[i].play_04_cnt
                + response.data.detailList[i].play_05_cnt
                + response.data.detailList[i].play_06_cnt
                + response.data.detailList[i].play_07_cnt
                + response.data.detailList[i].play_08_cnt
                + response.data.detailList[i].play_09_cnt
                + response.data.detailList[i].play_10_cnt ;

            response.data.totalInfo.sum_reg_total_cnt +=  response.data.detailList[i].reg_total_cnt;
            response.data.totalInfo.sum_del_total_cnt +=  response.data.detailList[i].del_total_cnt;
            response.data.totalInfo.sum_play_total_cnt +=  response.data.detailList[i].play_total_cnt;

        }

        if(!isDataEmpty){
            var template = $('#tmp_typeDay').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }


        var template = $('#tmp_typeDayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#typeDayTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();

        getClipSubjectTypeCodeDefine();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_dayTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="2" data-searchSex="m" data-searchGroupBy="1" style="cursor:pointer;">{{addComma sum_maleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="m" style="cursor:pointer;">{{addComma sum_open_reg_maleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="m" style="cursor:pointer;">{{addComma sum_notopen_reg_maleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="m" style="cursor:pointer;">{{addComma sum_mem_del_maleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="m" style="cursor:pointer;">{{addComma sum_op_del_maleCnt}}</span></td>

        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="2" data-searchSex="f" data-searchGroupBy="1" style="cursor:pointer;">{{addComma sum_femaleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="f" style="cursor:pointer;">{{addComma sum_open_reg_femaleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="f" style="cursor:pointer;">{{addComma sum_notopen_reg_femaleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="f" style="cursor:pointer;">{{addComma sum_mem_del_femaleCnt}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="f" style="cursor:pointer;">{{addComma sum_op_del_femaleCnt}}</span></td>

        <td class="_fontColor"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="2" data-searchSex="n" data-searchGroupBy="1" style="cursor:pointer;">{{addComma sum_noneCnt}}</span></td>
        <td class="_fontColor"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="n" style="cursor:pointer;">{{addComma sum_open_reg_noneCnt}}</span></td>
        <td class="_fontColor"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-1" data-searchSex="n" style="cursor:pointer;">{{addComma sum_notopen_reg_noneCnt}}</span></td>
        <td class="_fontColor"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="n" style="cursor:pointer;">{{addComma sum_mem_del_noneCnt}}</span></td>
        <td class="_fontColor"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="1-2" data-searchSex="n" style="cursor:pointer;">{{addComma sum_op_del_noneCnt}}</span></td>

        <td class="_fontColor">{{addComma sum_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_open_reg_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_notopen_reg_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_mem_del_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_op_del_totalCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_dayDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{data.the_date}}}
        </td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="2" data-searchSex="m" data-searchGroupBy="1" style="cursor:pointer;">{{addComma maleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="m" style="cursor:pointer;">{{addComma open_reg_maleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="m"  style="cursor:pointer;">{{addComma notopen_reg_maleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="m"  style="cursor:pointer;">{{addComma mem_del_maleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="m"  style="cursor:pointer;">{{addComma op_del_maleCnt 'Y'}}</span></td>

        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="2" data-searchSex="f" data-searchGroupBy="1" style="cursor:pointer;">{{addComma femaleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="f" style="cursor:pointer;">{{addComma open_reg_femaleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="f" style="cursor:pointer;">{{addComma notopen_reg_femaleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="f" style="cursor:pointer;">{{addComma mem_del_femaleCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="f" style="cursor:pointer;">{{addComma op_del_femaleCnt 'Y'}}</span></td>

        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="2" data-searchSex="n" data-searchGroupBy="1" style="cursor:pointer;">{{addComma noneCnt 'Y'}}</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="n" style="cursor:pointer;">{{addComma open_reg_noneCnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-1" data-searchSex="n" style="cursor:pointer;">{{addComma notopen_reg_noneCnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="n" style="cursor:pointer;">{{addComma mem_del_noneCnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="1-2" data-searchSex="n" style="cursor:pointer;">{{addComma op_del_noneCnt 'Y'}}</span></td>

        <td>{{addComma totalCnt 'Y'}}</td>
        <td>{{addComma open_reg_totalCnt 'Y'}}</td>
        <td>{{addComma notopen_reg_totalCnt 'Y'}}</td>
        <td>{{addComma mem_del_totalCnt 'Y'}}</td>
        <td>{{addComma op_del_totalCnt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_giftDay">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="m" style="cursor:pointer;">{{addComma sum_maleGiftCnt}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="m" style="cursor:pointer;">{{addComma sum_maleGiftAmount}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="f" style="cursor:pointer;">{{addComma sum_femaleGiftCnt}}</span></td>
        <td class="_fontColor" data-fontColor="red"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="f" style="cursor:pointer;">{{addComma sum_femaleGiftAmount}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="n" style="cursor:pointer;">{{addComma sum_noneGiftCnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="3" data-searchSex="n" style="cursor:pointer;">{{addComma sum_noneGiftAmount}}</span></td>
        <td>{{addComma sum_totalGiftCnt}}</td>
        <td>{{addComma sum_totalGiftAmount}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftDayDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{data.date}}}
        </td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="m" style="cursor:pointer;">{{addComma maleGiftCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="blue"><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="m" style="cursor:pointer;">{{addComma maleGiftAmount 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="red"> <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="f" style="cursor:pointer;">{{addComma femaleGiftCnt 'Y'}}</span></td>
        <td class="_fontColor" data-fontColor="red"> <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="f" style="cursor:pointer;">{{addComma femaleGiftAmount 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="n" style="cursor:pointer;">{{addComma noneGiftCnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="3" data-searchSex="n" style="cursor:pointer;">{{addComma noneGiftAmount 'Y'}}</span></td>
        <td>{{addComma totalGiftCnt 'Y'}}</td>
        <td>{{addComma totalGiftAmount 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_ageDay">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="1" style="cursor:pointer;">{{addComma sum_reg_12_16_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="1" style="cursor:pointer;">{{addComma sum_del_12_16_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="2" style="cursor:pointer;">{{addComma sum_reg_17_19_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="2" style="cursor:pointer;">{{addComma sum_del_17_19_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="3" style="cursor:pointer;">{{addComma sum_reg_20_25_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="3" style="cursor:pointer;">{{addComma sum_del_20_25_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="4" style="cursor:pointer;">{{addComma sum_reg_26_30_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="4" style="cursor:pointer;">{{addComma sum_del_26_30_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="5" style="cursor:pointer;">{{addComma sum_reg_31_35_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="5" style="cursor:pointer;">{{addComma sum_del_31_35_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="6" style="cursor:pointer;">{{addComma sum_reg_36_40_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="6" style="cursor:pointer;">{{addComma sum_del_36_40_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="4-1" data-searchAgeType="7" style="cursor:pointer;">{{addComma sum_reg_41_00_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="7" style="cursor:pointer;">{{addComma sum_del_41_00_cnt}}</span>)</td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_ageDayDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{data.date}}}
        <td>
            {{#dalbit_if reg_12_16_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="1" style="cursor:pointer;">{{addComma reg_12_16_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="1"  style="cursor:pointer;">{{addComma del_12_16_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_12_16_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="1" style="cursor:pointer;">{{addComma reg_12_16_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="1"  style="cursor:pointer;">{{addComma del_12_16_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_17_19_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="2" style="cursor:pointer;">{{addComma reg_17_19_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="2"  style="cursor:pointer;">{{addComma del_17_19_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_17_19_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="2" style="cursor:pointer;">{{addComma reg_17_19_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="2"  style="cursor:pointer;">{{addComma del_17_19_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_20_25_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="3" style="cursor:pointer;">{{addComma reg_20_25_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="3"  style="cursor:pointer;">{{addComma del_20_25_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_20_25_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="3" style="cursor:pointer;">{{addComma reg_20_25_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="3"  style="cursor:pointer;">{{addComma del_20_25_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_26_30_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="4" style="cursor:pointer;">{{addComma reg_26_30_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="4"  style="cursor:pointer;">{{addComma del_26_30_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_26_30_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="4" style="cursor:pointer;">{{addComma reg_26_30_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="4"  style="cursor:pointer;">{{addComma del_26_30_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_31_35_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="5" style="cursor:pointer;">{{addComma reg_31_35_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="5"  style="cursor:pointer;">{{addComma del_31_35_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_31_35_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="5" style="cursor:pointer;">{{addComma reg_31_35_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="5"  style="cursor:pointer;">{{addComma del_31_35_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_36_40_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="6" style="cursor:pointer;">{{addComma reg_36_40_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="6"  style="cursor:pointer;">{{addComma del_36_40_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_36_40_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="6" style="cursor:pointer;">{{addComma reg_36_40_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="6"  style="cursor:pointer;">{{addComma del_36_40_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_41_00_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="7" style="cursor:pointer;">{{addComma reg_41_00_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="7"  style="cursor:pointer;">{{addComma del_41_00_cnt}}</span>)
            {{else}}
            {{#dalbit_if del_41_00_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-1" data-searchAgeType="7" style="cursor:pointer;">{{addComma reg_41_00_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="4-2" data-searchAgeType="7"  style="cursor:pointer;">{{addComma del_41_00_cnt}}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>{{#dalbit_if reg_total_cnt '!=' '0'}}{{addComma reg_total_cnt}} ({{addComma del_total_cnt}}){{else}}{{#dalbit_if del_total_cnt '!=' '0'}}{{addComma reg_total_cnt}} ({{addComma del_total_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_platformDay">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="7-1" data-searchOsType="3" style="cursor:pointer;">{{addComma sum_reg_pc_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="3" style="cursor:pointer;">{{addComma sum_del_pc_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="7-1" data-searchOsType="1" style="cursor:pointer;">{{addComma sum_reg_and_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="1" style="cursor:pointer;">{{addComma sum_del_and_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="7-1" data-searchOsType="2" style="cursor:pointer;">{{addComma sum_reg_ios_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="2" style="cursor:pointer;">{{addComma sum_del_ios_cnt}}</span>)</td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="8" data-searchOsType="3" style="cursor:pointer;">{{addComma sum_listen_pc_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="8" data-searchOsType="1" style="cursor:pointer;">{{addComma sum_listen_and_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="8" data-searchOsType="2" style="cursor:pointer;">{{addComma sum_listen_ios_cnt}}</span></td>
        <td>{{addComma sum_listen_total_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_platformDayDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{data.date}}}
        </td>
        <td>
            {{#dalbit_if reg_pc_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="3" style="cursor:pointer;">{{addComma reg_pc_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="3" style="cursor:pointer;">{{addComma del_pc_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_pc_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="3" style="cursor:pointer;">{{addComma reg_pc_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="3" style="cursor:pointer;">{{addComma del_pc_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_and_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="1" style="cursor:pointer;">{{addComma reg_and_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="1" style="cursor:pointer;">{{addComma del_and_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_and_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="1" style="cursor:pointer;">{{addComma reg_and_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="1" style="cursor:pointer;">{{addComma del_and_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_ios_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="2" style="cursor:pointer;">{{addComma reg_ios_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="2" style="cursor:pointer;">{{addComma del_ios_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_ios_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" data-searchOsType="2" style="cursor:pointer;">{{addComma reg_ios_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" data-searchOsType="2" style="cursor:pointer;">{{addComma del_ios_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td>
            {{#dalbit_if reg_total_cnt '!=' '0'}}
                <%--<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" style="cursor:pointer;">{{addComma reg_total_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" style="cursor:pointer;">{{addComma del_total_cnt }}</span>)--%>
                {{addComma reg_total_cnt }} ({{addComma del_total_cnt }})
            {{else}}
                {{#dalbit_if del_total_cnt '!=' '0'}}
                    <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-1" style="cursor:pointer;">{{addComma reg_total_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="7-2" style="cursor:pointer;">{{addComma del_total_cnt }}</span>)
                    {{addComma reg_total_cnt }} ({{addComma del_total_cnt }})
                {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="8" data-searchOsType="3" style="cursor:pointer;">{{addComma listen_pc_cnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="8" data-searchOsType="1" style="cursor:pointer;">{{addComma listen_and_cnt 'Y'}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="8" data-searchOsType="2" style="cursor:pointer;">{{addComma listen_ios_cnt 'Y'}}</span></td>
        <td>{{addComma listen_total_cnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_typeDay">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="01" style="cursor:pointer;">{{addComma sum_reg_01_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="01" style="cursor:pointer;">{{addComma sum_del_01_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="01" style="cursor:pointer;">{{addComma sum_play_01_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="02" style="cursor:pointer;">{{addComma sum_reg_02_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="02" style="cursor:pointer;">{{addComma sum_del_02_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="02" style="cursor:pointer;">{{addComma sum_play_02_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="03" style="cursor:pointer;">{{addComma sum_reg_03_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="03" style="cursor:pointer;">{{addComma sum_del_03_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="03" style="cursor:pointer;">{{addComma sum_play_03_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="04" style="cursor:pointer;">{{addComma sum_reg_04_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="04" style="cursor:pointer;">{{addComma sum_del_04_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="04" style="cursor:pointer;">{{addComma sum_play_04_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="05" style="cursor:pointer;">{{addComma sum_reg_05_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="05" style="cursor:pointer;">{{addComma sum_del_05_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="05" style="cursor:pointer;">{{addComma sum_play_05_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="06" style="cursor:pointer;">{{addComma sum_reg_06_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="06" style="cursor:pointer;">{{addComma sum_del_06_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="06" style="cursor:pointer;">{{addComma sum_play_06_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="07" style="cursor:pointer;">{{addComma sum_reg_07_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="07" style="cursor:pointer;">{{addComma sum_del_07_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="07" style="cursor:pointer;">{{addComma sum_play_07_cnt}}</span></td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="5-1" data-subjectType="08" style="cursor:pointer;">{{addComma sum_reg_08_cnt}}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-sDay="{{day}}" data-type="5-2" data-subjectType="08" style="cursor:pointer;">{{addComma sum_del_08_cnt}}</span>)</td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="2" data-type="6" data-subjectType="08" style="cursor:pointer;">{{addComma sum_play_08_cnt}}</span></td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
        <td>{{addComma sum_play_total_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_typeDayDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{data.date}}}
        </td>
        <td>
            {{#dalbit_if reg_01_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="01" style="cursor:pointer;">{{addComma reg_01_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="01" style="cursor:pointer;">{{addComma del_01_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_01_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="01" style="cursor:pointer;">{{addComma reg_01_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="01" style="cursor:pointer;">{{addComma del_01_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="01" style="cursor:pointer;">{{addComma play_01_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_02_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="02" style="cursor:pointer;">{{addComma reg_02_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="02" style="cursor:pointer;">{{addComma del_02_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_02_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="02" style="cursor:pointer;">{{addComma reg_02_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="02" style="cursor:pointer;">{{addComma del_02_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="02" style="cursor:pointer;">{{addComma play_02_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_03_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="03" style="cursor:pointer;">{{addComma reg_03_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="03" style="cursor:pointer;">{{addComma del_03_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_03_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="03" style="cursor:pointer;">{{addComma reg_03_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="03" style="cursor:pointer;">{{addComma del_03_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="03" style="cursor:pointer;">{{addComma play_03_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_04_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="04" style="cursor:pointer;">{{addComma reg_04_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="04" style="cursor:pointer;">{{addComma del_04_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_04_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="04" style="cursor:pointer;">{{addComma reg_04_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="04" style="cursor:pointer;">{{addComma del_04_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="04" style="cursor:pointer;">{{addComma play_04_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_05_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="05" style="cursor:pointer;">{{addComma reg_05_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="05" style="cursor:pointer;">{{addComma del_05_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_05_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="05" style="cursor:pointer;">{{addComma reg_05_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="05" style="cursor:pointer;">{{addComma del_05_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="05" style="cursor:pointer;">{{addComma play_05_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_06_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="06" style="cursor:pointer;">{{addComma reg_06_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="06" style="cursor:pointer;">{{addComma del_06_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_06_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="06" style="cursor:pointer;">{{addComma reg_06_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="06" style="cursor:pointer;">{{addComma del_06_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="06" style="cursor:pointer;">{{addComma play_06_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_07_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="07" style="cursor:pointer;">{{addComma reg_07_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="07" style="cursor:pointer;">{{addComma del_07_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_07_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="07" style="cursor:pointer;">{{addComma reg_07_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="07" style="cursor:pointer;">{{addComma del_07_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="07" style="cursor:pointer;">{{addComma play_07_cnt 'Y'}}</span></td>
        <td>
            {{#dalbit_if reg_08_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="08" style="cursor:pointer;">{{addComma reg_08_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="08" style="cursor:pointer;">{{addComma del_08_cnt }}</span>)
            {{else}}
            {{#dalbit_if del_08_cnt '!=' '0'}}
            <span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-1" data-subjectType="08" style="cursor:pointer;">{{addComma reg_08_cnt }}</span> (<span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="5-2" data-subjectType="08" style="cursor:pointer;">{{addComma del_08_cnt }}</span>)
            {{/dalbit_if}}
            {{/dalbit_if}}
        </td>
        <td><span onclick="resourceClipStatusClick($(this).data())" data-slctType="1" data-sDay="{{day}}" data-type="6" data-subjectType="08" style="cursor:pointer;">{{addComma play_08_cnt 'Y'}}</span></td>
        <td>{{#dalbit_if reg_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{else}}{{#dalbit_if del_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{addComma play_total_cnt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>