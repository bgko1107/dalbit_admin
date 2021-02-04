<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                <col width="0.1%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                <col width="0.1%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="4" id="timeOver_th_2"></th>
                <td class="_noBorder"></td>
                <th class="_totalDate" colspan="4" id="timeOver_th_1"></th>
                <td class="_noBorder"></td>
                <th class="_totalDate" colspan="4" id="timeOver_th_0" style="background-color: #ffe699"></th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th class="_sex_male"></th>
                <th class="_sex_female"></th>
                <th>알수없음</th>
                <th>소계</th>
                <td class="_noBorder"></td>

                <th class="_sex_male"></th>
                <th class="_sex_female"></th>
                <th>알수없음</th>
                <th>소계</th>
                <td class="_noBorder"></td>

                <th class="_sex_male" style="background-color: #fff2cc"></th>
                <th class="_sex_female" style="background-color: #fff2cc"></th>
                <th style="background-color: #fff2cc">알수없음</th>
                <th style="background-color: #fff2cc">소계</th>
            </tr>
            </thead>
            <tbody id="timeOverTableBody"></tbody>
        </table>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                <col width="0.1%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                <col width="0.1%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="4" id="timeOver_th_5"></th>
                <td class="_noBorder"></td>
                <th class="_totalDate" colspan="4" id="timeOver_th_4"></th>
                <td class="_noBorder"></td>
                <th class="_totalDate" colspan="4" id="timeOver_th_3"></th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th class="_sex_male"></th>
                <th class="_sex_female"></th>
                <th>알수없음</th>
                <th>소계</th>
                <td class="_noBorder"></td>

                <th class="_sex_male"></th>
                <th class="_sex_female"></th>
                <th>알수없음</th>
                <th>소계</th>
                <td class="_noBorder"></td>

                <th class="_sex_male"></th>
                <th class="_sex_female"></th>
                <th>알수없음</th>
                <th>소계</th>
            </tr>
            </thead>
            <tbody id="timeOverTableBody2"></tbody>
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
        getTimeOver();
    });

    var tmp = 0;
    var tmp_end = 0;
    var type;
    function getTimeOver(){
        tmp_end = 0;
        tmp = 24;
        type = "시";

        var slctType_date = [];
        for(var i = tmp_end; i < tmp; i++ ){
            slctType_date.push(i + " " + type);
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_dummyTimeOver').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#timeOverTableBody").html(html);

        var template = $('#tmp_dummyTimeOver2').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#timeOverTableBody2").html(html);

        $("#timeOver_th_5").text(moment($("#startDate").val()).add('days', -5).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -5).day()] + ")");
        $("#timeOver_th_4").text(moment($("#startDate").val()).add('days', -4).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -4).day()] + ")");
        $("#timeOver_th_3").text(moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -3).day()] + ")");
        $("#timeOver_th_2").text(moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -2).day()] + ")");
        $("#timeOver_th_1").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
        $("#timeOver_th_0").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

        var th_5 = moment($("#startDate").val()).add('days', -5).format('YYYY.MM.DD');
        var th_4 = moment($("#startDate").val()).add('days', -4).format('YYYY.MM.DD');
        var th_3 = moment($("#startDate").val()).add('days', -3).format('YYYY.MM.DD');
        var th_2 = moment($("#startDate").val()).add('days', -2).format('YYYY.MM.DD');
        var th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
        var th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');
        var dateList = th_2 + "@" + th_1 + "@" + th_0 + "@" + th_5 + "@" + th_4  + "@" +  th_3;
        var data = {};
        data.dateList = dateList;
        data.slctType = slctType;
        util.getAjaxData("total", "/rest/connect/login/info/totalAll", data, fn_timeOver_success);
    }

    function fn_timeOver_success(data, response){

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        tmp_index = -1;

        response.data.forEach(function(data, index){
            if(index > 2){
                ++tmp_index;
            }
            data.detailList.forEach(function(detail, detailIndex){
                if(detail.succAmt == 0){
                    detail.accumAmt = 0;
                }

                var maleCnt;
                var femaleCnt;
                var femaleAvg;
                var noneCnt;
                var totalCnt;

                if(detail.maleCnt != 0){
                    maleCnt = common.addComma(detail.maleCnt);
                }
                if(detail.femaleCnt !=0){
                    femaleCnt = common.addComma(detail.femaleCnt);
                    femaleAvg = common.average(detail.femaleCnt , detail.totalCnt) + "%";
                }
                if(detail.noneCnt !=0){
                    noneCnt = common.addComma(detail.noneCnt);
                }
                if(detail.totalCnt !=0){
                    totalCnt = common.addComma(detail.totalCnt);
                }

                // 상단
                if (index == 0) {
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index + 1) + ")").html(maleCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index + 2) + ")").html(femaleCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index + 3) + ")").html(noneCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index + 4) + ")").html(totalCnt);
                    if(Number(tmp_time.split(":")[0]) == detail.hour) {
                        for(var i = 1; i < 5 ; i ++){
                            $("#timeOverTableBody tr._tr_" + (detail.hour) + " td:eq(" + (index + i) + ")").css("background-color", "#e3ecfb");
                            $("#timeOverTableBody tr._tr_" + (detail.hour) + " td:eq(" + (index + i) + ")").css("font-weight", "bold");
                        }
                    }
                } else if (index == 1 || index == 2) {
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index * 5 + 1) + ")").html(maleCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index * 5 + 2) + ")").html(femaleCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index * 5 + 3) + ")").html(noneCnt);
                    $("#timeOverTableBody tr._tr_" + detail.hour + " td:eq(" + (index * 5 + 4) + ")").html(totalCnt);
                    if(Number(tmp_time.split(":")[0]) == detail.hour) {
                        for(var i = 1; i < 5 ; i ++){
                            $("#timeOverTableBody tr._tr_" + (detail.hour) + " td:eq(" + (index * 5 + i) + ")").css("background-color", "#e3ecfb");
                            $("#timeOverTableBody tr._tr_" + (detail.hour) + " td:eq(" + (index * 5 + i) + ")").css("font-weight", "bold");
                        }
                    }
                }
                // 하단
                if (index == 3) {
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index + 1) + ")").html(maleCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index + 2) + ")").html(femaleCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index + 3) + ")").html(noneCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index + 4) + ")").html(totalCnt);
                    if(Number(tmp_time.split(":")[0]) == detail.hour) {
                        for(var i = 1; i < 5 ; i ++){
                            $("#timeOverTableBody2 tr._tr_" + (detail.hour) + " td:eq(" + (tmp_index + i) + ")").css("background-color", "#e3ecfb");
                            $("#timeOverTableBody2 tr._tr_" + (detail.hour) + " td:eq(" + (tmp_index + i) + ")").css("font-weight", "bold");
                        }
                    }
                }else if(index == 4 || index == 5){
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index * 5 + 1) + ")").html(maleCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index * 5 + 2) + ")").html(femaleCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index * 5 + 3) + ")").html(noneCnt);
                    $("#timeOverTableBody2 tr._tr_" + detail.hour + " td:eq(" + (tmp_index * 5 + 4) + ")").html(totalCnt);
                    if(Number(tmp_time.split(":")[0]) == detail.hour) {
                        for(var i = 1; i < 4 ; i ++){
                            $("#timeOverTableBody2 tr._tr_" + (detail.hour) + " td:eq(" + (tmp_index * 5 + i) + ")").css("background-color", "#e3ecfb");
                            $("#timeOverTableBody2 tr._tr_" + (detail.hour) + " td:eq(" + (tmp_index * 5 + i) + ")").css("font-weight", "bold");
                        }
                    }
                }
            });
        });

        tmp_index = -1;
        for(var i=0 ; i<response.data.length;i++){
            if(i > 2){
                ++tmp_index;
            }
            var totalInfo = response.data[i].totalInfo;
            //상단

            if(i == 0){
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
            }else if(i == 1 || i == 2){
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i * 5 + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i * 5 + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i * 5 + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody tr:eq(0) td:eq(" + (i * 5 + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i * 5 + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i * 5 + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i * 5 + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody tr:eq(25) td:eq(" + (i * 5 + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
            }

            // 하단
            if(i == 3){
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
            }else if(i == 4 || i == 5){
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (tmp_index * 5 + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (tmp_index * 5 + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (tmp_index * 5 + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody2 tr:eq(0) td:eq(" + (tmp_index * 5 + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (tmp_index * 5 + 1) + ")").html(common.addComma(totalInfo.sum_maleCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (tmp_index * 5 + 2) + ")").html(common.addComma(totalInfo.sum_femaleCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (tmp_index * 5 + 3) + ")").html(common.addComma(totalInfo.sum_noneCnt));
                $("#timeOverTableBody2 tr:eq(25) td:eq(" + (tmp_index * 5 + 4) + ")").html(common.addComma(totalInfo.sum_totalCnt));
            }
        }
        ui.tableHeightSet();
    }
</script>


<script type="text/x-handlebars-template" id="tmp_dummyTimeOver">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold"  style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><<td>0</td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><<td>0</td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td>0</td><td>0</td><td>0</td><<td>0</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_dummyTimeOver2">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td></td><td></td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td></td><td></td>
    </tr>
</script>