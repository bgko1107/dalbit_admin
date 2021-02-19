<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 로그인 현황 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span><br>
        <span class="font-bold" style="color: red;">아이템 통계 현황은 방송/클립/우체통 선물에 대한 현황입니다.</span>
        <div class="col-md-12 no-padding">
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
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">총합</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">누적</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">교환</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">직접선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">방송선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">클립선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">우체통선물</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">총합</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">누적</th>
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
        for(i = 23; -1 < i; i-- ){
            slctType_date.push(i);
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_totalDetailList').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#totalTableBody").html(html);

        $("._yesterday").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
        $("._today").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

        var total_th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
        var total_th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');

        var dateList = total_th_1 + "@" + total_th_0  + "@";
        var data = {};
        data.dateList = dateList;
        data.slctType = 0;
        data.totalType = slctType;
        util.getAjaxData("total", "/rest/status/item/total/list", data, fn_total_success);

    }

    function fn_total_success(data, response){

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){

                console.log('$("#totalTableBody tr._tr_"' + detail.hour + '" td:eq(" + ( ' + ((index * 14) + 1) + ' + ")").html(' + common.addComma(detail.broadgiftCnt + ',"Y"))'));

                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 1) + ")").html(common.addComma(detail.broadgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 2) + ")").html(common.addComma(detail.broadgiftAmt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 3) + ")").html(common.addComma(detail.castgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 4) + ")").html(common.addComma(detail.castgiftAmt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 5) + ")").html(common.addComma(detail.mailboxCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 6) + ")").html(common.addComma(detail.mailboxAmt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 7) + ")").html(common.addComma(detail.totalCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 8) + ")").html(common.addComma(detail.totalAmt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 9) + ")").html(common.addComma(detail.totalCntAccum,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 10) + ")").html(common.addComma(detail.totalAmtAccum,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 11) + ")").html(common.addComma(detail.changeCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 12) + ")").html(common.addComma(detail.changeAmt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 13) + ")").html(common.addComma(detail.totalCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 14) + ")").html(common.addComma(detail.totalCntAccum,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 15) + ")").html(common.addComma(detail.dalgiftCnt,"Y"));
                $("#totalTableBody tr._tr_" + detail.hour + " td:eq(" + ((index * 14) + 16) + ")").html(common.addComma(detail.dalgiftAmt,"Y"));
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            //총합
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftAmt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftAmt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxAmt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 10) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmtAccum,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 11) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 12) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeAmt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 13) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 14) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 15) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftCnt,"Y"));
            $("#totalTableBody tr:eq(0) td:eq(" + ((i*14) + 16) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftAmt,"Y"));
            //총합
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_broadgiftAmt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_castgiftAmt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_mailboxAmt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 10) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalAmtAccum,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 11) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 12) + ")").html(common.addComma(response.data[i].totalInfo.sum_changeAmt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 13) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 14) + ")").html(common.addComma(response.data[i].totalInfo.sum_totalCntAccum,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 15) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftCnt,"Y"));
            $("#totalTableBody tr:eq(25) td:eq(" + ((i*14) + 16) + ")").html(common.addComma(response.data[i].totalInfo.sum_dalgiftAmt,"Y"));
        }
        ui.paintColor();
        ui.tableHeightSet();

        for(var i = 1; i < 29 ; i ++){
            $("#totalTableBody tr._tr_" + (Number(tmp_time.split(":")[0])) + " td:eq(" + i + ")").css("background-color", "#fff2cc");
            $("#totalTableBody tr._tr_" + (Number(tmp_time.split(":")[0])) + " td:eq(" + i + ")").css("font-weight", "bold");
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
        <td class="font-bold" style="background-color: #dae3f3">{{this}} 시</td>
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
