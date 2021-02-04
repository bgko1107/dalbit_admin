<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 > 총계 -->
<div class="widget widget-table mb10 col-md-10">
    <div class="widget-content mt10">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="0.1%"/>
                <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#d9d9d9">구분</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgColor="#b4c7e7">성 별</th>
                <th class="_noBorder"></th>
                <th colspan="3" class="_bgColor _fontColor" data-bgColor="#f8cbad">플랫폼 별</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#d9d9d9">총 탈퇴 수</th>
            </tr>
            <tr>
                <th class="_bgColor _sex_male" data-bgColor="#dae3f3">남성</th>
                <th class="_bgColor _sex_female" data-bgColor="#dae3f3">여성</th>
                <th class="_bgColor _sex_none" data-bgColor="#dae3f3">알수없음</th>
                <th class="_noBorder"></th>
                <th class="_bgColor" data-bgColor="#fbe5d6">AOS</th>
                <th class="_bgColor" data-bgColor="#fbe5d6">IOS</th>
                <th class="_bgColor" data-bgColor="#fbe5d6">PC</th>
            </tr>
            </thead>
            <tbody id="monthTableBody"></tbody>
        </table>


        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="0.1%"/>
                <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#d9d9d9">구분</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgColor="#b4c7e7">성 별</th>
                <th class="_noBorder"></th>
                <th colspan="3" class="_bgColor _fontColor" data-bgColor="#f8cbad">플랫폼 별</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#d9d9d9">총 탈퇴 수</th>
            </tr>
            <tr>
                <th class="_bgColor _sex_male" data-bgColor="#dae3f3">남성</th>
                <th class="_bgColor _sex_female" data-bgColor="#dae3f3">여성</th>
                <th class="_bgColor _sex_none" data-bgColor="#dae3f3">알수없음</th>
                <th class="_noBorder"></th>
                <th class="_bgColor" data-bgColor="#fbe5d6">AOS</th>
                <th class="_bgColor" data-bgColor="#fbe5d6">IOS</th>
                <th class="_bgColor" data-bgColor="#fbe5d6">PC</th>
            </tr>
            </thead>
            <tbody id="monthTableBody2"></tbody>
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

    });

    function getMonth(){

        beforeSDate = moment($("#startDate").val()).add("months", -1).format('YYYY.MM.01');
        var monthLastDate = new Date(beforeSDate.substr(0,4),beforeSDate.substr(5,7),-1);
        beforeEDate = beforeSDate.substr(0,8) +(monthLastDate.getDate() + 1);

        twoAgoSDate = moment($("#startDate").val()).add("months", -2).format('YYYY.MM.01');
        var monthLastDate = new Date(twoAgoSDate.substr(0,4),twoAgoSDate.substr(5,7),-1);
        twoAgoEDate = twoAgoSDate.substr(0,8) +(monthLastDate.getDate() + 1);

        var data = {
            startDate: $("#startDate").val()
            , endDate: $("#endDate").val()
            , beforeStartDate: beforeSDate
            , beforeEndDate: beforeEDate
            , twoAgoStartDate: twoAgoSDate
            , twoAgoEndDate: twoAgoEDate
            , slctType: 2
            , slctTab: 2
        };

        util.getAjaxData("month", "/rest/enter/newjoin2/info/state", data, fn_month_success);

    }

    function fn_month_success(dst_id, response){
        accum_total_join_cnt = 0;
        accum_total_join_before_cnt = 0;
        accum_total_out_cnt = 0;
        accum_total_out_before_cnt = 0;

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")), 2, "0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8, 2);
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5, 2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            var sw = false;
            var total_before_cnt = 0;

            var total_out_cnt = [
                response.data.detailList[i].aos_total_out_cnt
                ,response.data.detailList[i].ios_total_out_cnt
                ,response.data.detailList[i].pc_total_out_cnt
            ];
            response.data.detailList[i].total_out_cnt = common.getListSum(total_out_cnt);
            accum_total_out_cnt = accum_total_out_cnt + common.getListSum(total_out_cnt);

            accum_total_join_cnt = accum_total_join_cnt + response.data.detailList[i].total_join_cnt;

            for(var j=0;j<response.data.detailList2.length;j++){
                if(response.data.detailList[i].daily == response.data.detailList2[j].daily){
                    sw = true;
                    var total_out_cnt2 = [
                        response.data.detailList2[j].aos_total_out_cnt
                        ,response.data.detailList2[j].ios_total_out_cnt
                        ,response.data.detailList2[j].pc_total_out_cnt
                    ];
                    total_before_cnt = common.getListSum(total_out_cnt2);
                    accum_total_out_before_cnt = accum_total_out_before_cnt + total_before_cnt;

                    accum_total_join_before_cnt = accum_total_join_before_cnt + response.data.detailList2[j].total_join_cnt;
                }
            }
            response.data.detailList[i].total_inc_cnt = response.data.detailList[i].total_out_cnt - total_before_cnt;
        }

        response.data.totalInfo.sum_total_out_cnt = response.data.totalInfo.sum_pc_total_out_cnt + response.data.totalInfo.sum_aos_total_out_cnt + response.data.totalInfo.sum_ios_total_out_cnt
        response.data.totalInfo2.sum_total_out_cnt = response.data.totalInfo2.sum_pc_total_out_cnt + response.data.totalInfo2.sum_aos_total_out_cnt + response.data.totalInfo2.sum_ios_total_out_cnt
        response.data.totalInfo.sum_inc_total_cnt = response.data.totalInfo.sum_total_out_cnt - accum_total_out_before_cnt;

        var template = $('#tmp_dummymonth').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#monthTableBody").html(html);

        var accum_total_join_cnt2 = 0;
        var accum_total_join_before_cnt2 = 0;
        var accum_total_out_cnt2 = 0;
        var accum_total_out_before_cnt2 = 0;

        for(var i=0;i<response.data.detailList2.length;i++){
            response.data.detailList2[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList2[i].nowDay = common.lpad(Number(moment().format("DD")), 2, "0");
            response.data.detailList2[i].nowHour = Number(moment().format("HH"));

            response.data.detailList2[i].day = response.data.detailList2[i].the_date.substr(8, 2);
            response.data.detailList2[i].month = response.data.detailList2[i].the_date.substr(5, 2);

            toDay = week[moment(response.data.detailList2[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList2[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList2[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList2[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")";
            }
            response.data.detailList2[i].date = toDay;

            var sw = false;
            var total_before_cnt = 0;

            var total_out_cnt = [
                response.data.detailList2[i].aos_total_out_cnt
                ,response.data.detailList2[i].ios_total_out_cnt
                ,response.data.detailList2[i].pc_total_out_cnt
            ];
            response.data.detailList2[i].total_out_cnt = common.getListSum(total_out_cnt);
            accum_total_out_cnt2 = accum_total_out_cnt2 + common.getListSum(total_out_cnt);

            accum_total_join_cnt2 = accum_total_join_cnt2 + response.data.detailList2[i].total_join_cnt;
            for(var j=0;j<response.data.detailList3.length;j++){
                if(response.data.detailList2[i].daily == response.data.detailList3[j].daily){
                    sw = true;
                    var total_out_cnt2 = [
                        response.data.detailList3[j].aos_total_out_cnt
                        ,response.data.detailList3[j].ios_total_out_cnt
                        ,response.data.detailList3[j].pc_total_out_cnt
                    ];
                    total_before_cnt = common.getListSum(total_out_cnt2);
                    accum_total_out_before_cnt2 = accum_total_out_before_cnt2 + common.getListSum(total_out_cnt2);

                    accum_total_join_before_cnt2 = accum_total_join_before_cnt2 + response.data.detailList3[j].total_join_cnt;
                }
            }
            response.data.detailList2[i].total_inc_cnt = response.data.detailList2[i].total_out_cnt - total_before_cnt;
        }

        response.data.totalInfo2.sum_total_out_cnt = response.data.totalInfo2.sum_pc_total_out_cnt + response.data.totalInfo2.sum_aos_total_out_cnt + response.data.totalInfo2.sum_ios_total_out_cnt
        response.data.totalInfo3.sum_total_out_cnt = response.data.totalInfo3.sum_pc_total_out_cnt + response.data.totalInfo3.sum_aos_total_out_cnt + response.data.totalInfo3.sum_ios_total_out_cnt
        response.data.totalInfo2.sum_inc_total_cnt = response.data.totalInfo2.sum_total_out_cnt - accum_total_out_before_cnt2;

        var template = $('#tmp_dummymonth2').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#monthTableBody2").html(html);

        ui.tableHeightSet();
        ui.paintColor();

        setSummary(response.data);
    }

</script>

<script type="text/x-handlebars-template" id="tmp_dummymonth">
    {{#each this.detailList as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{date}}}
        </td>
        <td>{{addComma total_out_mcnt 'Y'}}</td>
        <td>{{addComma total_out_fcnt 'Y'}}</td>
        <td>{{addComma total_out_ncnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma aos_total_out_cnt 'Y'}}</td>
        <td>{{addComma ios_total_out_cnt 'Y'}}</td>
        <td>{{addComma pc_total_out_cnt 'Y'}}</td>
        <td class="{{upAndDownClass total_inc_cnt}}"><span style="color: #555555">{{addComma total_out_cnt}}</span> (<i class="fa {{upAndDownIcon total_inc_cnt}}"></i> <span>{{addComma total_inc_cnt}}</span>)</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="background-color: #f2f2f2">
        <td>총합</td>
        <td>{{addComma totalInfo.sum_total_out_mcnt}} ({{average totalInfo.sum_total_out_mcnt totalInfo.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo.sum_total_out_fcnt}} ({{average totalInfo.sum_total_out_fcnt totalInfo.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo.sum_total_out_ncnt}} ({{average totalInfo.sum_total_out_ncnt totalInfo.sum_total_out_cnt}}%)</td>
        <td class="_noBorder"></td>
        <td>{{addComma totalInfo.sum_aos_total_out_cnt}} ({{average totalInfo.sum_aos_total_out_cnt totalInfo.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo.sum_ios_total_out_cnt}} ({{average totalInfo.sum_ios_total_out_cnt totalInfo.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo.sum_pc_total_out_cnt}} ({{average totalInfo.sum_pc_total_out_cnt totalInfo.sum_total_out_cnt}}%)</td>
        <td class="{{upAndDownClass totalInfo.sum_inc_total_cnt}}"><span style="color: #555555">{{addComma totalInfo.sum_total_out_cnt}}</span> (<i class="fa {{upAndDownIcon totalInfo.sum_inc_total_cnt}}"></i> <span>{{addComma totalInfo.sum_inc_total_cnt}}</span>)</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_dummymonth2">
    {{#each this.detailList2 as |data|}}
    <tr {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowDay '==' day}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowDay '!=' day}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{date}}}
        </td>
        <td>{{addComma total_out_mcnt 'Y'}}</td>
        <td>{{addComma total_out_fcnt 'Y'}}</td>
        <td>{{addComma total_out_ncnt 'Y'}}</td>
        <td class="_noBorder"></td>
        <td>{{addComma aos_total_out_cnt 'Y'}}</td>
        <td>{{addComma ios_total_out_cnt 'Y'}}</td>
        <td>{{addComma pc_total_out_cnt 'Y'}}</td>
        <td class="{{upAndDownClass total_inc_cnt}}"><span style="color: #555555">{{addComma total_out_cnt}}</span> (<i class="fa {{upAndDownIcon total_inc_cnt}}"></i> <span>{{addComma total_inc_cnt}}</span>)</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="background-color: #f2f2f2">
        <td>총합</td>
        <td>{{addComma totalInfo2.sum_total_out_mcnt}} ({{average totalInfo2.sum_total_out_mcnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo2.sum_total_out_fcnt}} ({{average totalInfo2.sum_total_out_fcnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo2.sum_total_out_ncnt}} ({{average totalInfo2.sum_total_out_ncnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td class="_noBorder"></td>
        <td>{{addComma totalInfo2.sum_aos_total_out_cnt}} ({{average totalInfo2.sum_aos_total_out_cnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo2.sum_ios_total_out_cnt}} ({{average totalInfo2.sum_ios_total_out_cnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td>{{addComma totalInfo2.sum_pc_total_out_cnt}} ({{average totalInfo2.sum_pc_total_out_cnt totalInfo2.sum_total_out_cnt}}%)</td>
        <td class="{{upAndDownClass totalInfo2.sum_inc_total_cnt}}"><span style="color: #555555">{{addComma totalInfo2.sum_total_out_cnt}}</span> (<i class="fa {{upAndDownIcon totalInfo2.sum_inc_total_cnt}}"></i> <span>{{addComma totalInfo2.sum_inc_total_cnt}}</span>)</td>
    </tr>
</script>
