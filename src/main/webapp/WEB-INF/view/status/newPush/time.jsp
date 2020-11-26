<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span><br/>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
            </colgroup>
            <thead>
            <tr class="_stateTopTh">
                <th rowspan="2"></th>
                <th colspan="4" class="_sex_male">남성</th>
                <th colspan="4" class="_sex_female">여성</th>
                <th colspan="4" class="_sex_none">알수없음</th>
                <th colspan="5">합계</th>
            </tr>

            <tr class="_stateSubTh">
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>성공누적건수</th>
                <th>실패건수</th>
                <th>성공율</th>
            </tr>
            </thead>
            <tbody id="tableTotalBody"></tbody>
        </table>

        <div class="col-md-12 no-padding">
            <span>* 상위 당일 수치, 하위 당일을 기준으로 전6일동안의 푸시 성공/실패 건을 포함한 발송 수치 현황입니다.</span>
        </div>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
            </colgroup>
            <thead>
            <tr class="_stateTopTh">
                <th></th>
                <th colspan="4" id="time_th_5"></th>
                <th colspan="4" id="time_th_4"></th>
                <th colspan="4" id="time_th_3"></th>
                <th colspan="4" id="time_th_2"></th>
                <th colspan="4" id="time_th_1"></th>
                <th colspan="4" id="time_th_0"></th>
            </tr>
            <tr class="_stateSubTh">
                <th>구분</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
                <th class="_sex_male">남성</th>
                <th class="_sex_female">여성</th>
                <th class="_sex_none">알수없음</th>
                <th>누적</th>
            </tr>
            </thead>
            <tbody id="timeTableBody"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        // $("#slctType").html(util.getCommonCodeSelect('-1', push_push_slct));
    });

    function getTotal(){

        var slctType_date = [];
        for(i = 23; -1 < i; i-- ){
            slctType_date.push(i + " 시");
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_timeTableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#timeTableBody").html(html);

        $("#time_th_5").text(moment($("#startDate").val()).add('days', -5).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -5).day()] + ")");
        $("#time_th_4").text(moment($("#startDate").val()).add('days', -4).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -4).day()] + ")");
        $("#time_th_3").text(moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -3).day()] + ")");
        $("#time_th_2").text(moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -2).day()] + ")");
        $("#time_th_1").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
        $("#time_th_0").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

        var total_th_5 = moment($("#startDate").val()).add('days', -5).format('YYYY.MM.DD');
        var total_th_4 = moment($("#startDate").val()).add('days', -4).format('YYYY.MM.DD');
        var total_th_3 = moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD');
        var total_th_2 = moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD');
        var total_th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
        var total_th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');

        util.getAjaxData("total", "/rest/status/push/total", getData(), fn_total_success);

        var dateList = total_th_5 + "@" + total_th_4 + "@" + total_th_3 + "@" + total_th_2 + "@" + total_th_1 + "@" + total_th_0  + "@";
        var data = {};
        console.log(dateList);
        data.dateList = dateList;
        data.slctType = 0;
        util.getAjaxData("total", "/rest/status/push/time", data, fn_pushTime_success);
    }

    function fn_total_success(data, response){

        var isDataEmpty = response.data.detailList == null;
        $("#tableTotalBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableTotalBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }



        var template = $('#tmp_totalDetail').html();
        var templateScript = Handlebars.compile(template);
        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableTotalBody").append(html);

        if(isDataEmpty){
            $("#tableTotalBody td:last").remove();
        }

        ui.tableHeightSet();
    }

    function fn_pushTime_success(data, response){
        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){

                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 4) + 1) + ")").html(common.addComma(detail.male_succ_cnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 4) + 2) + ")").html(common.addComma(detail.female_succ_cnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 4) + 3) + ")").html(common.addComma(detail.none_succ_cnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 4) + 4) + ")").html(common.addComma(detail.total_succ_cnt,"Y"));
                if(Number(tmp_time.split(":")[0]) == detail.the_hr) {
                    for(var i = 1; i < 5 ; i ++){
                        $("#timeTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + ((index*4) + i) + ")").css("background-color", "#e3ecfb");
                        $("#timeTableBody tr._tr_" + (detail.the_hr) + " td:eq(" + ((index*4) + i) + ")").css("font-weight", "bold");
                    }
                }
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            //총합
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*4) + 1) + ")").html(common.addComma(response.data[i].totalInfo.maleSuccCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*4) + 2) + ")").html(common.addComma(response.data[i].totalInfo.femaleSuccCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*4) + 3) + ")").html(common.addComma(response.data[i].totalInfo.noneSuccCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*4) + 4) + ")").html(common.addComma(response.data[i].totalInfo.totalSuccCnt));
            //총합
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*4) + 1) + ")").html(common.addComma(response.data[i].totalInfo.maleSuccCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*4) + 2) + ")").html(common.addComma(response.data[i].totalInfo.femaleSuccCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*4) + 3) + ")").html(common.addComma(response.data[i].totalInfo.noneSuccCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*4) + 4) + ")").html(common.addComma(response.data[i].totalInfo.totalSuccCnt));
        }
        ui.paintColor();
        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_total">
    <tr class="font-bold _stateSumTd" style="color: #ff5600;">
        <td>합계</td>
        <td>{{addComma sum_male_send_cnt}}</td>
        <td>{{addComma sum_male_succ_cnt}}</td>
        <td>{{addComma sum_male_fail_cnt}}</td>
        <td>{{sum_male_succ_rate}}%</td>
        <td>{{addComma sum_female_send_cnt}}</td>
        <td>{{addComma sum_female_succ_cnt}}</td>
        <td>{{addComma sum_female_fail_cnt}}</td>
        <td>{{sum_female_succ_rate}}%</td>
        <td>{{addComma sum_none_send_cnt}}</td>
        <td>{{addComma sum_none_succ_cnt}}</td>
        <td>{{addComma sum_none_fail_cnt}}</td>
        <td>{{sum_none_succ_rate}}%</td>
        <td>{{addComma sum_total_send_cnt}}</td>
        <td>{{addComma sum_total_succ_cnt}}</td>
        <td>{{addComma sum_total_succ_cnt}}</td>
        <td>{{addComma sum_total_fail_cnt}}</td>
        <td>{{sum_total_succ_rate}}%</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_totalDetail">
    {{#each this as |data|}}
    <tr
            {{#dalbit_if ../slctType '==' '0'}}{{#dalbit_if ../nowHour '==' hour}} class="font-bold _stateSubTh" {{/dalbit_if}}{{/dalbit_if}}
            {{#dalbit_if ../slctType '==' '1'}}{{#dalbit_if ../nowDay '==' day}} class="font-bold _stateSubTh" {{/dalbit_if}}{{/dalbit_if}}
            {{#dalbit_if ../slctType '==' '2'}}{{#dalbit_if ../nowMonth '==' month}} class="font-bold _stateSubTh" {{/dalbit_if}}{{/dalbit_if}}
    >
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.month}}월 {{data.day}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.year}}년 {{data.month}}월{{/equal}}
        </td>
        <td>{{addComma male_send_cnt}}</td>
        <td>{{addComma male_succ_cnt}}</td>
        <td>{{addComma male_fail_cnt}}</td>
        <td>{{male_succ_rate}}%</td>
        <td>{{addComma female_send_cnt}}</td>
        <td>{{addComma female_succ_cnt}}</td>
        <td>{{addComma female_fail_cnt}}</td>
        <td>{{female_succ_rate}}%</td>
        <td>{{addComma none_send_cnt}}</td>
        <td>{{addComma none_succ_cnt}}</td>
        <td>{{addComma none_fail_cnt}}</td>
        <td>{{none_succ_rate}}%</td>
        <td>{{addComma total_send_cnt}}</td>
        <td>{{addComma total_succ_cnt}}</td>
        <td>{{addComma accum_total_succ_cnt}}</td>
        <td>{{addComma total_fail_cnt}}</td>
        <td>{{total_succ_rate}}%</td>
    </tr>
    {{else}}
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_timeTableBody">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;">
        <td style="background-color: #dae3f3">총합</td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;">
        <td style="background-color: #dae3f3">총합</td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td>
    </tr>
</script>