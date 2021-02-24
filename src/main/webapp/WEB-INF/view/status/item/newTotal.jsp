<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 로그인 현황 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span><br>
        <span class="font-bold" style="color: red;">아이템 통계 현황은 방송/클립/우체통 선물에 대한 현황입니다.</span>
        <div class="col-md-12 no-padding" id="div_totalTime">
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3"> 구분</th>
                    <th colspan="14" class="_yesterday"></th>
                    <th colspan="14" class="_today _bgColor" data-bgcolor="#b4c7e7"></th>
                </tr>
                <tr>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">방송선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">클립선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">우체통선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">누적</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">교환</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">직접선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">방송선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">클립선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">우체통선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">누적</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">교환</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">직접선물</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                </tr>
                </thead>
                <tbody id="totalTableBody"></tbody>
                </tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding" id="div_totalWeek" style="display: none">
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                    <%--<col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>--%>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2"> 구분</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">방송선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">클립선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">우체통선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#d9d9d9">누적</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">교환</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">직접선물</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건수</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달수</th>
                </tr>
                </thead>
                <tbody id="totalWeekTableBody"></tbody>
                </tbody>
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

    function getTotalList(){
        var slctType_date = [];
        if($('input[name="slctType"]:checked').val() == 0){
            for(i = 23; -1 < i; i-- ){
                slctType_date.push(i + " 시");
            }
        }else if($('input[name="slctType"]:checked').val() == 1){
            var slctType_date = [];
            for(i = 31; 0 < i; i-- ){
                slctType_date.push(i + " 일");
            }
        }else if($('input[name="slctType"]:checked').val() == 2){
            for(i = 12; 0 < i; i-- ){
                slctType_date.push(i);
            }
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_totalDetailList').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#totalTableBody").html(html);

        $("#div_totalTime").hide();
        $("#div_totalWeek").hide();

        var total_th_1;
        var total_th_0;
        var dateList;

        var data = {};
        data.dateList = dateList;
        data.slctType = $('input[name="slctType"]:checked').val();
        if($('input[name="slctType"]:checked').val() == 0){
            $("#div_totalTime").show();
            $("._yesterday").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
            $("._today").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

            total_th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
            total_th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');
            data.dateList = total_th_1 + "@" + total_th_0  + "@";
            util.getAjaxData("total", "/rest/status/item/total/list", data, fn_total_success);

        }else if($('input[name="slctType"]:checked').val() == 4){
            $("#div_totalWeek").show();
            data.startDate = $("#startDate").val();
            util.getAjaxData("total", "/rest/status/item/total/week/list", data, fn_totalWeek_success);

        }else if($('input[name="slctType"]:checked').val() == 1){
            $("#div_totalTime").show();

            $("._yesterday").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
            $("._today").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));

            total_th_1 = moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD');
            total_th_0 = moment($("#startDate").val()).add('months', 0).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD');
            data.dateList = total_th_1 + "@" + total_th_0  + "@";
            util.getAjaxData("total", "/rest/status/item/total/list", data, fn_total_success);

        }else if($('input[name="slctType"]:checked').val() == 2){
            $("#div_totalTime").show();

            $("._yesterday").text(moment($("#startDate").val()).add('years', -1).format('YYYY'));
            $("._today").text(moment($("#startDate").val()).add('years', 0).format('YYYY'));

            total_th_1 = moment($("#startDate").val()).add('years', -1).format('YYYY.01.01') + "-" + moment($("#startDate").val()).add('years', -1).format('YYYY.12.31');
            total_th_0 = moment($("#startDate").val()).add('years', 0).format('YYYY.01.01') + "-" + moment($("#startDate").val()).add('years', 0).format('YYYY.12.31');
            data.dateList = total_th_1 + "@" + total_th_0  + "@";
            util.getAjaxData("total", "/rest/status/item/total/list", data, fn_total_success);
        }


    }

    function fn_total_success(data, response){

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                var tmp_tr =0;
                if($('input[name="slctType"]:checked').val() == 0){
                    tmp_tr = detail.hour;
                }else if($('input[name="slctType"]:checked').val() == 1){
                    tmp_tr = detail.the_day;
                }else if($('input[name="slctType"]:checked').val() == 2){
                    tmp_tr = detail.monthly;
                }
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 1) + ")").html(common.addComma(detail.broadgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 2) + ")").html(common.addComma(detail.broadgiftAmt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 3) + ")").html(common.addComma(detail.castgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 4) + ")").html(common.addComma(detail.castgiftAmt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 5) + ")").html(common.addComma(detail.mailboxCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 6) + ")").html(common.addComma(detail.mailboxAmt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 7) + ")").html(common.addComma(detail.totalCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 8) + ")").html(common.addComma(detail.totalAmt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 9) + ")").html(common.addComma(detail.totalCntAccum,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 10) + ")").html(common.addComma(detail.totalAmtAccum,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 11) + ")").html(common.addComma(detail.changeCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 12) + ")").html(common.addComma(detail.changeAmt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 13) + ")").html(common.addComma(detail.dalgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + ((index * 14) + 14) + ")").html(common.addComma(detail.dalgiftAmt,"Y"));
            });
        });
        var tmp_i =0;
        if($('input[name="slctType"]:checked').val() == 0){
            tmp_i = 25;
        }else if($('input[name="slctType"]:checked').val() == 1){
            tmp_i = 32;
        }else if($('input[name="slctType"]:checked').val() == 2){
            tmp_i = 13;
        }
        for(var i=0 ; i<response.data.length;i++){

            console.log(response.data[i].totalInfo.sum_totalCnt);

            //총합
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftAmt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftAmt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxAmt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 10) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmtAccum));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 11) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 12) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeAmt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 13) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftCnt));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 14) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftAmt));
            //총합
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftAmt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftAmt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxAmt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 10) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmtAccum));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 11) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 12) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeAmt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 13) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftCnt));
            $("#totalTableBody tr:eq( " + tmp_i + ") td:eq(" + ((i*14) + 14) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftAmt));
        }
        ui.paintColor();
        ui.tableHeightSet();

        var tmp_tr =0;
        if($('input[name="slctType"]:checked').val() == 0){
            tmp_tr = (Number(tmp_time.split(":")[0]));
        }else if($('input[name="slctType"]:checked').val() == 1){
            tmp_tr = (Number(tmp_day.split(".")[2]));
        }else if($('input[name="slctType"]:checked').val() == 2){
            tmp_tr = (Number(tmp_day.split(".")[1]));
        }
        for(var i = 1; i < 29 ; i ++){
            $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + i + ")").css("background-color", "#fff2cc");
            $("#totalTableBody tr._tr_" + tmp_tr + " td:eq(" + i + ")").css("font-weight", "bold");
        }
    }

    function fn_totalWeek_success(dst_id, response){
        var isDataEmpty = response.data.detailList == null;
        $("#totalWeekTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_totalWeekTableTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#totalWeekTableBody").append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++) {
            var tmpDay = common.lpad(Number(moment().format("DD")), 2, "0");
            var tmpStartDay = Number(response.data.detailList[i].start_date.substr(8,2));
            var tmpEndDay = Number(response.data.detailList[i].end_date.substr(8,2));

            if (tmpStartDay <= tmpDay && tmpEndDay >= tmpDay) {
                response.data.detailList[i].color = 1;
            } else {
                response.data.detailList[i].color = 0;
            }
        }

        var template = $('#tmp_totalWeekTableList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#totalWeekTableBody").append(html);


        if(isDataEmpty){
            $("#totalWeekTableBody td:last").remove();
        }else{
            $("#totalWeekTableBody").append(totalHtml);
        }
    }

</script>

<script type="text/x-handlebars-template" id="tmp_totalDetailList">
    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_totalWeekTableTotal">
    <tr class="font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td>{{addComma sum_broadgiftCnt}}</td>
        <td>{{addComma sum_broadgiftAmt}}</td>
        <td>{{addComma sum_castgiftCnt}}</td>
        <td>{{addComma sum_castgiftAmt}}</td>
        <td>{{addComma sum_mailboxCnt}}</td>
        <td>{{addComma sum_mailboxAmt}}</td>
        <td>{{addComma sum_totalCnt}}</td>
        <td>{{addComma sum_totalAmt}}</td>
        <td>{{addComma sum_totalCntAccum}}</td>
        <td>{{addComma sum_totalAmtAccum}}</td>
        <td>{{addComma sum_changeCnt}}</td>
        <td>{{addComma sum_changeAmt}}</td>
        <td>{{addComma sum_dalgiftCnt}}</td>
        <td>{{addComma sum_dalgiftAmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_totalWeekTableList">
    {{#each this as |data|}}
    <tr {{#dalbit_if color '==' 1}} style="background-color:#fff2cc" {{/dalbit_if}} >
        <td style="background-color: #f2f2f2">{{month}}월 {{weekNo}}주 {{substr start_date 5 5}}~{{substr end_date 5 5}}</td>
        <td>{{addComma broadgiftCnt 'Y'}}</td>
        <td>{{addComma broadgiftAmt 'Y'}}</td>
        <td>{{addComma castgiftCnt 'Y'}}</td>
        <td>{{addComma castgiftAmt 'Y'}}</td>
        <td>{{addComma mailboxCnt 'Y'}}</td>
        <td>{{addComma mailboxAmt 'Y'}}</td>
        <td>{{addComma totalCnt 'Y'}}</td>
        <td>{{addComma totalAmt 'Y'}}</td>
        <td>{{addComma totalCntAccum 'Y'}}</td>
        <td>{{addComma totalAmtAccum 'Y'}}</td>
        <td>{{addComma changeCnt 'Y'}}</td>
        <td>{{addComma changeAmt 'Y'}}</td>
        <td>{{addComma dalgiftCnt 'Y'}}</td>
        <td>{{addComma dalgiftAmt 'Y'}}</td>
    </tr>
    {{/each}}
</script>