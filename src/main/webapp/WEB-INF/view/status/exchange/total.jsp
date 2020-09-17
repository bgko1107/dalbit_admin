<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content col-md-12">
        <span class="_searchDate font-bold"></span><br/>
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
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="%5.2"/>
                <col width="0.1%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>

            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" style="background-color: #dae3f3"></th>
                <th colspan="9" style="background-color: #ff9933">스페셜</th>
                <th class="_noBorder"></th>
                <th colspan="9" style="background-color: #548235">일반</th>
            </tr>
            <tr>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
                <th class="_sex_none" colspan="3"></th>
                <th class="_noBorder"></th>
                <th class="_sex_male" colspan="3"></th>
                <th class="_sex_female" colspan="3"></th>
                <th class="_sex_none" colspan="3"></th>
            </tr>
            <tr>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
                <th class="_noBorder"></th>
                <th style="color: blue">건수</th>
                <th style="color: blue">금액</th>
                <th style="color: blue">요청 별</th>
                <th style="color: red">건수</th>
                <th style="color: red">금액</th>
                <th style="color: red">요청 별</th>
                <th>건수</th>
                <th>금액</th>
                <th>요청 별</th>
            </tr>
            </thead>
            <tbody id="genderTableBody"></tbody>
        </table>
    </div>

    <div class="widget-content col-md-6">
        <span class="font-bold">◈ 주간별</span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="14.2%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/>
                <col width="14.2%"/><col width="14.2%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" style="background-color: #dae3f3"></th>
                <th colspan="6" style="background-color: #b4c7e7" id="nowWeek"></th>
            </tr>

            <tr>
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
            </tr>
            </thead>
            <tbody id="weekTableBody"></tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        getMonthList();
    });

    function getMonthList(){
        $("#beforMonth").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $("#nowMonth").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));
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
        if(!isDataEmpty){
            var template = $('#tmp_month').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#monthTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
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
        if(!isDataEmpty){
            var template = $('#tmp_gender').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#genderTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++) {
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"), 2, "0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = Number(response.data.detailList[i].the_date.substr(8,2));
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
        if(!isDataEmpty){
            var template = $('#tmp_week').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#weekTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
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

        ui.paintColor();
        ui.tableHeightSet();
    }
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
            {{day}}일
        </td>
        <td>{{addComma specialdj_succ_Cnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_Amt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_Cnt 'Y'}}</td>
        <td>{{addComma succ_Cnt 'Y'}}</td>
        <td>{{addComma succ_Amt 'Y'}}</td>
        <td>{{addComma succ_byeol_Cnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSpecialdj_succ_Cnt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSpecialdj_succ_Amt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSpecialdj_succ_byeol_Cnt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSucc_Cnt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSucc_Amt 'Y'}}</td>
        <td {{#dalbit_if nowDay '!=' day}} style="background-color: #FFF7E5" {{/dalbit_if}}>{{addComma nSucc_byeol_Cnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_gender">
    <tr class="font-bold" style="background-color: #f2f2f2;color: #fb782d;">
        <td>총합</td>
        <td>{{addComma tot_specialdj_succ_mCnt}}</td>
        <td>{{addComma tot_specialdj_succ_mAmt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_mCnt}}</td>
        <td>{{addComma tot_specialdj_succ_fcnt}}</td>
        <td>{{addComma tot_specialdj_succ_fAmt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_fCnt}}</td>
        <td>{{addComma tot_specialdj_succ_nCnt}}</td>
        <td>{{addComma tot_specialdj_succ_nAmt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_nCnt}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma tot_succ_mCnt}}</td>
        <td>{{addComma tot_succ_mAmt}}</td>
        <td>{{addComma tot_succ_byeol_mCnt}}</td>
        <td>{{addComma tot_succ_fCnt}}</td>
        <td>{{addComma tot_succ_fAmt}}</td>
        <td>{{addComma tot_succ_byeol_fCnt}}</td>
        <td>{{addComma tot_succ_nCnt}}</td>
        <td>{{addComma tot_succ_nAmt}}</td>
        <td>{{addComma tot_succ_byeol_nCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_genderDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#dae3f3"  {{/dalbit_if}}>
        <td class="font-bold" style="background-color: #dae3f3">
            {{day}}일
        </td>
        <td>{{addComma specialdj_succ_mCnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_mAmt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_mCnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_fcnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_fAmt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_fCnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_nCnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_nAmt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_nCnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma succ_mCnt 'Y'}}</td>
        <td>{{addComma succ_mAmt 'Y'}}</td>
        <td>{{addComma succ_byeol_mCnt 'Y'}}</td>
        <td>{{addComma succ_fCnt 'Y'}}</td>
        <td>{{addComma succ_fAmt 'Y'}}</td>
        <td>{{addComma succ_byeol_fCnt 'Y'}}</td>
        <td>{{addComma succ_nCnt 'Y'}}</td>
        <td>{{addComma succ_nAmt 'Y'}}</td>
        <td>{{addComma succ_byeol_nCnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_week">
    <tr class="font-bold" style="background-color: #f2f2f2;color: #fb782d;">
        <td>총합</td>
        <td>{{addComma tot_specialdj_succ_Cnt}}</td>
        <td>{{addComma tot_specialdj_succ_Amt}}</td>
        <td>{{addComma tot_specialdj_succ_byeol_Cnt}}</td>
        <td>{{addComma tot_succ_Cnt}}</td>
        <td>{{addComma tot_succ_Amt}}</td>
        <td>{{addComma tot_succ_byeol_Cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_weekDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold" style="background-color: #dae3f3">
            {{substr week_startDate 5}} ~ {{substr week_endDate 5}}
        </td>
        <td>{{addComma specialdj_succ_Cnt 'Y'}}</td>
        <td>{{addComma specialdj_succ_Amt 'Y'}}</td>
        <td>{{addComma specialdj_succ_byeol_Cnt 'Y'}}</td>
        <td>{{addComma succ_Cnt  'Y'}}</td>
        <td>{{addComma succ_Amt 'Y'}}</td>
        <td>{{addComma succ_byeol_Cnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>