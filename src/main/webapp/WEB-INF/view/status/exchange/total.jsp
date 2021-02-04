<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<span class="_searchDate font-bold"></span>
<div class="widget widget-table mb10">
    <div class="widget-content col-md-12">
        <span class="font-bold">◈ 월간별</span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>
                <col width="7.6%"/><col width="7.6%"/><col width="0.1%"/><col width="7.6%"/><col width="7.6%"/>
                <col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" style="background-color: #dae3f3"></th>
                <th colspan="6" style="background-color: #b4c7e7" id="beforMonth"></th>
                <th class="_noBorder"></th>
                <th colspan="6" style="background-color: #ffe699" id="nowMonth"></th>
            </tr>

            <tr>
                <th colspan="3" style="background-color: #ff9933">스페셜</th>
                <th colspan="3" style="background-color: #548235">일반</th>
                <th class="_noBorder"></th>
                <th colspan="3" style="background-color: #ff9933">스페셜</th>
                <th colspan="3" style="background-color: #548235">일반</th>
            </tr>
            <tr>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
                <th class="_noBorder"></th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
            </tr>
            </thead>
            <tbody id="monthTableBody"></tbody>
        </table>
    </div>

    <div class="widget-content col-md-12">
        <span class="font-bold">◈ 성별</span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="6%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/>
                <col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/>
                <col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="0.1%"/><col width="3.7%"/>
                <col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/>
                <col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/><col width="3.7%"/>
                <col width="3.7%"/>


            </colgroup>
            <thead>
            <tr>
                <th rowspan="4" style="background-color: #dae3f3"></th>
                <th colspan="12" style="background-color: #b4c7e7" id="beforGender"></th>
                <th class="_noBorder"></th>
                <th colspan="12" style="background-color: #ffe699" id="nowGender"></th>
            </tr>
            <tr>
                <th colspan="6" style="background-color: #ff9933">스페셜</th>
                <th colspan="6" style="background-color: #548235">일반</th>
                <th class="_noBorder"></th>
                <th colspan="6" style="background-color: #ff9933">스페셜</th>
                <th colspan="6" style="background-color: #548235">일반</th>
            </tr>
            <tr>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
                <th class="_noBorder"></th>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
            </tr>
            <tr>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
                <th class="_noBorder"></th>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
            </tr>
            </thead>
            <tbody id="genderTableBody"></tbody>
        </table>
    </div>

    <div class="widget-content col-md-10">
        <span class="font-bold">◈ 주간별</span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="5%"/><col width="15.2%"/><col width="11.2%"/><col width="11.2%"/><col width="11.2%"/><col width="11.2%"/>
                <col width="11.2%"/><col width="11.2%"/><col width="11.2%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" colspan="2" style="background-color: #dae3f3"></th>
                <th colspan="7" style="background-color: #b4c7e7" id="nowWeek"></th>
            </tr>

            <tr>
                <th colspan="3" style="background-color: #ff9933">스페셜</th>
                <th colspan="3" style="background-color: #548235">일반</th>
                <th rowspan="2">총합</th>
            </tr>
            <tr>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
            </tr>
            </thead>
            <tbody id="weekTableBody"></tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        // getMonthList();
    });

    function getMonthList(){
        $("#beforMonth").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $("#nowMonth").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));
        $("#beforGender").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $("#nowGender").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));
        $("#nowWeek").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));
        var data = {
            slctType : 1,
            beforStartDate : moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01'),
            beforEndDate : moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD'),
            startDate : $("#startDate").val(),
            endDate : $("#endDate").val(),
        };
        util.getAjaxData("month", "/rest/status/exchange/month", data, fn_month_success);

        data.slctType = 0;
        util.getAjaxData("gender", "/rest/status/exchange/gender", data, fn_gender_success);

        data.slctType = 2;
        util.getAjaxData("week", "/rest/status/exchange/week", data, fn_week_success);
    }

    function fn_month_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#monthTableBody").empty();

        var total_succ_cnt = response.data.totalInfo.tot_specialdj_succ_Cnt + response.data.totalInfo.tot_succ_Cnt;         // 총건
        var total_succ_amt = response.data.totalInfo.tot_specialdj_succ_Amt + response.data.totalInfo.tot_succ_Amt;         // 총 금액
        var total_succ_byeol = response.data.totalInfo.tot_specialdj_succ_byeol_Cnt + response.data.totalInfo.tot_succ_byeol_Cnt;   // 총 요청별

        var nTotal_succ_cnt = response.data.totalInfo.nTot_specialdj_succ_Cnt + response.data.totalInfo.nTot_succ_Cnt;
        var nTotal_succ_amt = response.data.totalInfo.nTot_specialdj_succ_Amt + response.data.totalInfo.nTot_succ_Amt;
        var nTotal_succ_byeol = response.data.totalInfo.nTot_specialdj_succ_byeol_Cnt + response.data.totalInfo.nTot_succ_byeol_Cnt;

        response.data.totalInfo.total_succ = "환전금액 총 : " + total_succ_cnt + "건 / 금액 : " +  total_succ_amt + " / " + total_succ_byeol + " 개";
        response.data.totalInfo.nTotal_succ = "환전금액 총 : " + nTotal_succ_cnt + "건 / 금액 : " +  nTotal_succ_amt + " / " + nTotal_succ_byeol + " 개";

        if(!isDataEmpty){
            var template = $('#tmp_month_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#monthTableBody").append(totalHtml);

            var template = $('#tmp_month').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#monthTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].index = common.lpad(Number(moment().format("HH")),2,"0");

            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));


            response.data.detailList[i].the_date = moment($("#startDate").val()).add('months', 0).format('YYYY.MM') + "." +common.lpad(response.data.detailList[i].day,2,"0");

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            response.data.detailList[i].beforMonth = $("#beforMonth").text();
            response.data.detailList[i].afterMonth = $("#nowMonth").text();
        }

        for(var i=0;i<response.data.detailList.length;i++) {
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"), 2, "0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
        }

        var template = $('#tmp_monthDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#monthTableBody").append(html);

        if(isDataEmpty){
            $("#monthTableBody td:last").remove();
        }else{
            $("#monthTableBody").append(totalHtml);

        }

        ui.paintColor();
        ui.tableHeightSet();
    }

    function fn_gender_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#genderTableBody").empty();

        var total_succ_spCnt =  response.data.totalInfo.tot_specialdj_succ_mCnt + response.data.totalInfo.tot_specialdj_succ_fcnt + response.data.totalInfo.tot_specialdj_succ_nCnt;
        var total_succ_spAmt = response.data.totalInfo.tot_specialdj_succ_mAmt + response.data.totalInfo.tot_specialdj_succ_fAmt + response.data.totalInfo.tot_specialdj_succ_nAmt;
        var total_succ_spByeol = response.data.totalInfo.tot_specialdj_succ_byeol_mCnt + response.data.totalInfo.tot_specialdj_succ_byeol_fCnt + response.data.totalInfo.tot_specialdj_succ_byeol_nCnt;

        var total_succ_noCnt = response.data.totalInfo.tot_succ_mCnt + response.data.totalInfo.tot_succ_fCnt + response.data.totalInfo.tot_succ_nCnt;
        var total_succ_noAmt = response.data.totalInfo.tot_succ_mAmt + response.data.totalInfo.tot_succ_fAmt + response.data.totalInfo.tot_succ_nAmt;
        var total_succ_noByeol = response.data.totalInfo.tot_succ_byeol_mCnt + response.data.totalInfo.tot_succ_byeol_fCnt + response.data.totalInfo.tot_succ_byeol_nCnt;

        response.data.totalInfo.total_succ_sp = "환전금액 총 : " + total_succ_spCnt + "건 / 금액 : " +  total_succ_spAmt + " / " + total_succ_spByeol + " 개";
        response.data.totalInfo.total_succ_no = "환전금액 총 : " + total_succ_noCnt + "건 / 금액 : " +  total_succ_noAmt + " / " + total_succ_noByeol + " 개";

        var b_total_succ_spCnt =  response.data.totalInfo.b_tot_specialdj_succ_mCnt + response.data.totalInfo.b_tot_specialdj_succ_fcnt + response.data.totalInfo.b_tot_specialdj_succ_nCnt;
        var b_total_succ_spAmt = response.data.totalInfo.b_tot_specialdj_succ_mAmt + response.data.totalInfo.b_tot_specialdj_succ_fAmt + response.data.totalInfo.b_tot_specialdj_succ_nAmt;
        var b_total_succ_spByeol = response.data.totalInfo.b_tot_specialdj_succ_byeol_mCnt + response.data.totalInfo.b_tot_specialdj_succ_byeol_fCnt + response.data.totalInfo.b_tot_specialdj_succ_byeol_nCnt;

        var b_total_succ_noCnt = response.data.totalInfo.b_tot_succ_mCnt + response.data.totalInfo.b_tot_succ_fCnt + response.data.totalInfo.b_tot_succ_nCnt;
        var b_total_succ_noAmt = response.data.totalInfo.b_tot_succ_mAmt + response.data.totalInfo.b_tot_succ_fAmt + response.data.totalInfo.b_tot_succ_nAmt;
        var b_total_succ_noByeol = response.data.totalInfo.b_tot_succ_byeol_mCnt + response.data.totalInfo.b_tot_succ_byeol_fCnt + response.data.totalInfo.b_tot_succ_byeol_nCnt;

        response.data.totalInfo.b_total_succ_sp = "환전금액 총 : " + b_total_succ_spCnt + "건 / 금액 : " +  b_total_succ_spAmt + " / " + b_total_succ_spByeol + " 개";
        response.data.totalInfo.b_total_succ_no = "환전금액 총 : " + b_total_succ_noCnt + "건 / 금액 : " +  b_total_succ_noAmt + " / " + b_total_succ_noByeol + " 개";

        if(!isDataEmpty){
            var template = $('#tmp_gender_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#genderTableBody").append(totalHtml);

            var template = $('#tmp_gender').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#genderTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].index = common.lpad(Number(moment().format("HH")),2,"0");

            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].the_date = moment($("#startDate").val()).add('months', 0).format('YYYY.MM') + "." +common.lpad(response.data.detailList[i].day,2,"0");
            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            response.data.detailList[i].beforMonth = $("#beforMonth").text();
            response.data.detailList[i].afterMonth = $("#nowMonth").text();
        }

        var template = $('#tmp_genderDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#genderTableBody").append(html);

        if(isDataEmpty){
            $("#genderTableBody td:last").remove();
        }else{
            $("#genderTableBody").append(totalHtml);
        }

        ui.paintColor();
        ui.tableHeightSet();
    }

    function fn_week_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#weekTableBody").empty();

        var total_succ_Cnt =  response.data.totalInfo.tot_specialdj_succ_Cnt + response.data.totalInfo.tot_succ_Cnt;
        var total_succ_Amt = response.data.totalInfo.tot_specialdj_succ_Amt + response.data.totalInfo.tot_succ_Amt;
        var total_succ_Byeol = response.data.totalInfo.tot_specialdj_succ_byeol_Cnt + response.data.totalInfo.tot_succ_byeol_Cnt;

        response.data.totalInfo.total_succ = "환전금액 총 : " + total_succ_Cnt + "건 / 금액 : " +  total_succ_Amt + " / " + total_succ_Byeol + " 개";

        if(!isDataEmpty){
            // var template = $('#tmp_week_total').html();
            // var templateScript = Handlebars.compile(template);
            // var totalContext = response.data.totalInfo;
            // var totalHtml = templateScript(totalContext);
            // $("#weekTableBody").append(totalHtml);

            var template = $('#tmp_week').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#weekTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++) {
            var tmpMonth;
            var tmpTCnt = 0;
            var tmpTAmt = 0;

            if (common.isEmpty(tmpMonth)) {
                tmpMonth = response.data.detailList[i].month;
                tmpTCnt = tmpTCnt + response.data.detailList[i].specialdj_succ_Cnt + response.data.detailList[i].succ_Cnt;
                tmpTAmt = tmpTAmt + response.data.detailList[i].specialdj_succ_Amt + response.data.detailList[i].succ_Amt;
            } else {
                if (tmpMonth == response.data.detailList[i].month) {
                    tmpTCnt = tmpTCnt + response.data.detailList[i].specialdj_succ_Cnt + response.data.detailList[i].succ_Cnt;
                } else {
                    tmpMonth = response.data.detailList[i].month;
                    tmpTCnt = 0;
                    tmpTAmt = 0;
                }
                tmpTAmt = tmpTAmt + response.data.detailList[i].specialdj_succ_Amt + response.data.detailList[i].succ_Amt;
            }

            response.data.detailList[i].totalCnt = tmpTCnt;
            response.data.detailList[i].totalAmt = tmpTAmt;

            var tmpDay = Number(moment().format("MM") + common.lpad(Number(moment().format("DD")), 2, "0"));
            var tmpStartDay = Number(response.data.detailList[i].week_startDate.substr(5).replace("-",""));
            var tmpEndDay = Number(response.data.detailList[i].week_endDate.substr(5).replace("-",""));

            if (tmpStartDay <= tmpDay && tmpEndDay >= tmpDay) {
                response.data.detailList[i].color = 1;
            } else {
                response.data.detailList[i].color = 0;
            }
        }

        var template = $('#tmp_weekDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#weekTableBody").append(html);

        if(isDataEmpty){
            $("#weekTableBody td:last").remove();
        }else{
            $("#weekTableBody").append(totalHtml);
        }

        monthRowspan("month");
        totalRowspan("total");
        ui.paintColor();
        ui.tableHeightSet();
    }

    function monthRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }
    function totalRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }
    function exchangeTotalClick(tmp){
        var month;
        if(tmp.month == "now"){
            month = tmp.aftermonth;
        }else{
            month = tmp.beformonth;
        }
        var popupUrl = "/status/exchange/popup/exchangeList?month=" +month + "&day=" + tmp.day + "&user=" + tmp.user + "&gender=" + tmp.gender;
        util.windowOpen(popupUrl,"1600","800","환전내역");
    }

</script>

<script type="text/x-handlebars-template" id="tmp_month_total">
    <tr class="font-bold" style="background-color: #f2f2f2;color: black;">
        <td>총계</td>
        <td colspan="6">{{addComma total_succ}}</td>
        <td class="_noBorder"></td>
        <td colspan="6">{{addComma nTotal_succ}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_month">
    <tr class="font-bold" style="background-color: #f2f2f2;color: #fb782d;">
        <td>총합</td>
        <td>{{addComma tot_specialdj_succ_Cnt}}</td>
        <td>{{addComma tot_specialdj_succ_Amt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_Cnt}}</td>
        <td>{{addComma tot_succ_Cnt}}</td>
        <td>{{addComma tot_succ_Amt}}</td>
        <td>{{addComma tot_succ_byeol_Cnt}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma nTot_specialdj_succ_Cnt}}</td>
        <td>{{addComma nTot_specialdj_succ_Amt}}</td>
        <td>{{addComma nTot_specialdj_succ_byeol_Cnt}}</td>
        <td>{{addComma nTot_succ_Cnt}}</td>
        <td>{{addComma nTot_succ_Amt}}</td>
        <td>{{addComma nTot_succ_byeol_Cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_monthDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#dae3f3"  {{/dalbit_if}}>
        <td class="font-bold" style="background-color: #dae3f3">
            {{{date}}}
        </td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="special" data-month="befor"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma specialdj_succ_Cnt 'Y'}}</a></td>
        <td>{{addComma specialdj_succ_Amt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_Cnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="normal" data-month="befor"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma succ_Cnt 'Y'}}</a></td>
        <td>{{addComma succ_Amt 'Y'}}</td>
        <td>{{addComma succ_byeol_Cnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="special" data-month="now" {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma nSpecialdj_succ_Cnt 'Y'}}</a></td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSpecialdj_succ_Amt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSpecialdj_succ_byeol_Cnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="normal" data-month="now" {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma nSucc_Cnt 'Y'}}</a></td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSucc_Amt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSucc_byeol_Cnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_gender_total">
    <tr class="font-bold" style="background-color: #f2f2f2;color: black;">
        <td>총계</td>
        <td colspan="6">{{addComma b_total_succ_sp}}</td>
        <td colspan="6">{{addComma b_total_succ_no}}</td>
        <td class="_noBorder"></td>
        <td colspan="6">{{addComma total_succ_sp}}</td>
        <td colspan="6">{{addComma total_succ_no}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_gender">
    <tr class="font-bold" style="background-color: #f2f2f2;color: #fb782d;">
        <td>총합</td>
        <td>{{addComma b_tot_specialdj_succ_mCnt}}</td>
        <td>{{addComma b_tot_specialdj_succ_mAmt}}</td>
        <td>{{addComma b_tot_specialdj_succ_byeol_mCnt}}</td>
        <td>{{addComma b_tot_specialdj_succ_fcnt}}</td>
        <td>{{addComma b_tot_specialdj_succ_fAmt}}</td>
        <td>{{addComma b_tot_specialdj_succ_byeol_fCnt}}</td>
        <td>{{addComma b_tot_succ_mCnt}}</td>
        <td>{{addComma b_tot_succ_mAmt}}</td>
        <td>{{addComma b_tot_succ_byeol_mCnt}}</td>
        <td>{{addComma b_tot_succ_fCnt}}</td>
        <td>{{addComma b_tot_succ_fAmt}}</td>
        <td>{{addComma b_tot_succ_byeol_fCnt}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma tot_specialdj_succ_mCnt}}</td>
        <td>{{addComma tot_specialdj_succ_mAmt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_mCnt}}</td>
        <td>{{addComma tot_specialdj_succ_fcnt}}</td>
        <td>{{addComma tot_specialdj_succ_fAmt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_fCnt}}</td>
        <td>{{addComma tot_succ_mCnt}}</td>
        <td>{{addComma tot_succ_mAmt}}</td>
        <td>{{addComma tot_succ_byeol_mCnt}}</td>
        <td>{{addComma tot_succ_fCnt}}</td>
        <td>{{addComma tot_succ_fAmt}}</td>
        <td>{{addComma tot_succ_byeol_fCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_genderDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#dae3f3"  {{/dalbit_if}}>
        <td class="font-bold" style="background-color: #dae3f3">
            {{{date}}}
        </td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="special" data-month="befor" data-gender="m" ><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma b_specialdj_succ_mCnt 'Y'}}</a></td>
        <td>{{addComma b_specialdj_succ_mAmt 'Y'}}</td>
        <td>{{addComma b_specialdj_succ_byeol_mCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="special" data-month="befor" data-gender="f"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma b_specialdj_succ_fcnt 'Y'}}</a></td>
        <td>{{addComma b_specialdj_succ_fAmt 'Y'}}</td>
        <td>{{addComma b_specialdj_succ_byeol_fCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="normal" data-month="befor" data-gender="m"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma b_succ_mCnt 'Y'}}</a></td>
        <td>{{addComma b_succ_mAmt 'Y'}}</td>
        <td>{{addComma b_succ_byeol_mCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-beformonth="{{beforMonth}}" data-day="{{day}}" data-user="normal" data-month="befor" data-gender="f"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma b_succ_fCnt 'Y'}}</a></td>
        <td>{{addComma b_succ_fAmt 'Y'}}</td>
        <td>{{addComma b_succ_byeol_fCnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="special" data-month="now" data-gender="m"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma specialdj_succ_mCnt 'Y'}}</a></td>
        <td>{{addComma specialdj_succ_mAmt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_mCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="special" data-month="now" data-gender="f"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma specialdj_succ_fcnt 'Y'}}</a></td>
        <td>{{addComma specialdj_succ_fAmt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_fCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="normal" data-month="now" data-gender="m"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma succ_mCnt 'Y'}}</a></td>
        <td>{{addComma succ_mAmt 'Y'}}</td>
        <td>{{addComma succ_byeol_mCnt 'Y'}}</td>
        <td onclick="exchangeTotalClick($(this).data())" data-aftermonth="{{afterMonth}}" data-day="{{day}}" data-user="normal" data-month="now" data-gender="f"><a class="_data _fontColor" data-fontcolor="#555" href="javascript://">{{addComma succ_fCnt 'Y'}}</a></td>
        <td>{{addComma succ_fAmt 'Y'}}</td>
        <td>{{addComma succ_byeol_fCnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>

<%--<script type="text/x-handlebars-template" id="tmp_week_total">--%>
    <%--<tr class="font-bold" style="background-color: #f2f2f2;color: black;">--%>
        <%--<td colspan="2">총계</td>--%>
        <%--<td colspan="6">{{addComma total_succ}}</td>--%>
    <%--</tr>--%>
<%--</script>--%>

<script type="text/x-handlebars-template" id="tmp_week">
    <tr class="font-bold" style="background-color: #f2f2f2;color: #fb782d;">
        <td colspan="2">총합</td>
        <td>{{addComma tot_specialdj_succ_Cnt}}</td>
        <td>{{addComma tot_specialdj_succ_Amt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_Cnt}}</td>
        <td>{{addComma tot_succ_Cnt}}</td>
        <td>{{addComma tot_succ_Amt}}</td>
        <td>{{addComma tot_succ_byeol_Cnt}}</td>
        <td>{{addComma tot_month_succ_Cnt}}건<br/>/ {{addComma tot_month_succ_Amt}}원</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_weekDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if color '==' 1}} style="background-color:#fff2cc" {{/dalbit_if}} >
        <td class="font-bold month" {{#dalbit_if color '==' 1}} style="background-color:#fff2cc" {{else}} style="background-color: #b4c7e7" {{/dalbit_if}}> {{month}}월 </td>
        <td class="font-bold" {{#dalbit_if color '==' 1}} style="background-color:#fff2cc" {{else}} style="background-color: #dae3f3" {{/dalbit_if}} >
            {{monthWeek}}주 ({{substr week_startDate 5}} ~ {{substr week_endDate 5}})
        </td>
        <td>{{addComma specialdj_succ_Cnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_Amt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_Cnt 'Y'}}</td>
        <td>{{addComma succ_Cnt  'Y'}}</td>
        <td>{{addComma succ_Amt 'Y'}}</td>
        <td>{{addComma succ_byeol_Cnt 'Y'}}</td>
        <td class="total" data-month="{{month}}">
            <span style="display: none">{{month}}</span>
            {{addComma month_succ_Cnt}}건<br/>/ {{addComma month_succ_Amt}}원
        </td>
    </tr>
    {{/each}}
</script>