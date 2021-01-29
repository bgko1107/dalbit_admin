<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="8" id="ageNonOver_th_0"></th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th>소계</th>
                <th>미선택</th>
                <th>10대</th>
                <th>20대</th>
                <th>30대</th>
                <th>40대</th>
                <th>50대</th>
                <th>60대이상</th>
            </tr>
            </thead>
            <tbody id="ageNonOverTableBody"></tbody>
        </table>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="8" id="ageNonOver_th_1"></th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th>소계</th>
                <th>미선택</th>
                <th>10대</th>
                <th>20대</th>
                <th>30대</th>
                <th>40대</th>
                <th>50대</th>
                <th>60대이상</th>
            </tr>
            </thead>
            <tbody id="ageNonOverTableBody2"></tbody>
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
        // getAgeNonOver();
    });

    var top_tmp = 0;
    var bottom_tmp = 0;
    function getAgeNonOver(){
        var th_1;
        var th_0;

        $("#ageNonOver_th_1").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $("#ageNonOver_th_0").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));

        th_1 = moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01') + " - " + moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD');
        th_0 = moment($("#startDate").val()).add('months', 0).format('YYYY.MM.01') + " - " + moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD');

        var dateList = th_0 + "@" + th_1;
        var data = {};

        console.log(dateList);

        data.dateList = dateList;
        data.slctType = slctType;
        console.log(data);
        util.getAjaxData("age", "/rest/connect/login/info/age", data, fn_age_success);
    }

    function fn_age_success(data, response){

        top_tmp = response.data[0].detailList.length - 1;
        var slctType_date = [];
        for(var i = top_tmp; 0 < i; i-- ){
            slctType_date.push(i + " 일");
        }
        data = { slctType_date : slctType_date };

        var template = $('#tmp_dummyAgeNonOver').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#ageNonOverTableBody").html(html);

        bottom_tmp = response.data[1].detailList.length - 1;
        slctType_date = [];
        for(var i = bottom_tmp; 0 < i; i-- ){
            slctType_date.push(i + " 일");
        }
        data = { slctType_date : slctType_date };
        var template = $('#tmp_dummyAgeNonOver2').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#ageNonOverTableBody2").html(html);

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        var count=0;
        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                if(detail.succAmt == 0){
                    detail.accumAmt = 0;
                }

                var totalCnt = "";
                var age00Cnt = "";
                var age10Cnt = "";
                var age20Cnt = "";
                var age30Cnt = "";
                var age40Cnt = "";
                var age50Cnt = "";
                var age60Cnt = "";

                if(detail.totalCnt != 0){
                    totalCnt = common.addComma(detail.totalCnt);
                }
                if(detail.age00Cnt != 0){
                    age00Cnt = common.addComma(detail.age00Cnt);
                }
                if(detail.age10Cnt != 0){
                    age10Cnt = common.addComma(detail.age10Cnt);
                }
                if(detail.age20Cnt !=0){
                    age20Cnt = common.addComma(detail.age20Cnt);
                }
                if(detail.age30Cnt !=0){
                    age30Cnt = common.addComma(detail.age30Cnt);
                }
                if(detail.age40Cnt !=0){
                    age40Cnt = common.addComma(detail.age40Cnt);
                }
                if(detail.age50Cnt !=0){
                    age50Cnt = common.addComma(detail.age50Cnt);
                }
                if(detail.age60Cnt !=0){
                    age60Cnt = common.addComma(detail.age60Cnt);
                }
                //상단
                count = 0;
                if (index == 0) {
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(totalCnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age00Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age10Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age20Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age30Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age40Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age50Cnt);
                    $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age60Cnt);

                    if(Number(tmp_day.split(".")[2]) == detail.day) {
                        for(var i = 1; i < 8 ; i ++){
                            $("#ageNonOverTableBody tr._tr_" + (detail.day) + " td:eq(" + (i) + ")").css("font-weight", "bold");
                        }
                    }
                }

                // 하단
                count = 0;
                if (index == 1) {
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(totalCnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age00Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age10Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age20Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age30Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age40Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age50Cnt);
                    $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (++count) + ")").html(age60Cnt);

                    if(Number(tmp_day.split(".")[2]) == detail.day) {
                        for(var i = 1; i < 8 ; i ++){
                            $("#ageNonOverTableBody2 tr._tr_" + (detail.day) + " td:eq(" + (i) + ")").css("font-weight", "bold");
                        }
                    }
                }
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            var totalInfo = response.data[i].totalInfo;
            //상단
            count = 0;
            if(i == 0){
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age00Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age10Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age20Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age30Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age40Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age50Cnt));
                $("#ageNonOverTableBody tr:eq(0) td:eq(" + (++count)+ ")").html(common.addComma(totalInfo.sum_age60Cnt));
                count = 0;
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age00Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age10Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age20Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age30Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age40Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age50Cnt));
                $("#ageNonOverTableBody tr:eq(" + (top_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age60Cnt));
            }
            // 하단
            count = 0;
            if(i == 1){
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age00Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age10Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age20Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age30Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age40Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age50Cnt));
                $("#ageNonOverTableBody2 tr:eq(0) td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age60Cnt));
                count = 0;
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_totalCnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age00Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age10Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age20Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age30Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age40Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age50Cnt));
                $("#ageNonOverTableBody2 tr:eq( " + (bottom_tmp + 1) + ") td:eq(" + (++count) + ")").html(common.addComma(totalInfo.sum_age60Cnt));
            }
        }
        ui.tableHeightSet();
    }
</script>


<script type="text/x-handlebars-template" id="tmp_dummyAgeNonOver">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold"  style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_dummyAgeNonOver2">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><<td></td>
    </tr>
    {{/each}}
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총합</td>
        <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
    </tr>
</script>