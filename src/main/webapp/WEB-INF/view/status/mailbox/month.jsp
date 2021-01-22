<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!-- 로그인 현황 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span><br>
        <span class="font-bold">◈ 참여회원 성별ㅣ개설/대화/이미지ㅣ 선물</span>
        <div class="col-md-12 no-padding">
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3"> 구분</th>
                    <th colspan="9" class="_yesterday"></th>
                    <th colspan="9" class="_today">금월</th>
                </tr>
                <tr>
                    <th colspan="3" class="_bgColor" data-bgcolor="#fbe5d6">참여회원 (명)</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">개설 건</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">대화 건</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">이미지 건</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">선물</th>
                    <th colspan="3" class="_bgColor" data-bgcolor="#dae3f3">참여회원 (명)</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">개설 건</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">대화 건</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">이미지 건</th>
                    <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">선물</th>
                </tr>
                <tr>
                    <th class="_bgColor _sex_male" data-bgcolor="#f2f2f2"></th>
                    <th class="_bgColor _sex_female" data-bgcolor="#f2f2f2"></th>
                    <th class="_bgColor _sex_none" data-bgcolor="#f2f2f2"></th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달</th>
                    <th class="_sex_male data-bgcolor="#f2f2f2""></th>
                    <th class="_sex_female" data-bgcolor="#f2f2f2"></th>
                    <th class="_sex_none" data-bgcolor="#f2f2f2"></th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
                    <th class="_bgColor" data-bgcolor="#f2f2f2">달</th>
                </tr>
                </thead>
                <tbody id="monthTableBody"></tbody>
                </tbody>
            </table>
        </div>

        <div class="col-md-12 no-padding">
            <span class="font-bold">◈ 연령대</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                    <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                    <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                    <col width="5.8%"/><col width="5.8%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2"> 구분</th>
                    <th colspan="8" class="_yesterday"></th>
                    <th colspan="8" class="_today"></th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">미선택</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">10대</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">20대</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">30대</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">40대</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">50대</th>
                    <th class="_bgColor" data-bgcolor="#fbe5d6">60대 이상</th>
                    <th class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">미선택</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">10대</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">20대</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">30대</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">40대</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">50대</th>
                    <th class="_bgColor" data-bgcolor="#dae3f3">60대 이상</th>
                    <th class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
                </tr>

                </thead>
                <tbody id="monthAgeTableBody"></tbody>
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

    function getMonth(){

        console.log("------------------------------------------- 1");
        var slctType_date = [];
        for(i = 31; 0 < i; i-- ){
            slctType_date.push(i);
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_monthDetailList').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#monthTableBody").html(html);

        var template = $('#tmp_monthAgeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#monthAgeTableBody").html(html);

        $("._yesterday").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM'));
        $("._today").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM'));

        var total_th_1 = moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD');
        var total_th_0 = moment($("#startDate").val()).add('months', 0).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD');

        var dateList = total_th_1 + "@" + total_th_0  + "@";
        var data = {};
        data.dateList = dateList;
        data.slctType = 1;
        data.timeType = slctType;
        util.getAjaxData("month", "/rest/status/mailbox/time", data, fn_month_success);

        data.slctType = 0;
        util.getAjaxData("month", "/rest/status/mailbox/time", data, fn_monthAge_success);

    }

    function fn_month_success(data, response){

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0].split(".")[2];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 1) + ")").html(common.addComma(detail.male_uniqueCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 2) + ")").html(common.addComma(detail.female_uniqueCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 3) + ")").html(common.addComma(detail.none_uniqueCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 4) + ")").html(common.addComma(detail.total_uniqueCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 5) + ")").html(common.addComma(detail.total_createCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 6) + ")").html(common.addComma(detail.msgCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 7) + ")").html(common.addComma(detail.imgCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 8) + ")").html(common.addComma(detail.giftCnt,"Y"));
                $("#monthTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 9) + 9) + ")").html(common.addComma(detail.giftDal,"Y"));
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            //총합
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_male_uniqueCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_female_uniqueCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_none_uniqueCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_uniqueCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_createCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_msgCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_imgCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftCnt));
            $("#monthTableBody tr:eq(0) td:eq(" + ((i*9) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftDal));
            //총합
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_male_uniqueCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_female_uniqueCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_none_uniqueCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_uniqueCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_createCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_msgCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_imgCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftCnt));
            $("#monthTableBody tr:eq(32) td:eq(" + ((i*9) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftDal));
        }
        ui.paintColor();
        ui.tableHeightSet();

        for(var i = 1; i < 19 ; i ++){
            $("#monthTableBody tr._tr_" + (Number(tmp_day.split(":")[0])) + " td:eq(" + i + ")").css("background-color", "#dae3f3");
            $("#monthTableBody tr._tr_" + (Number(tmp_day.split(":")[0])) + " td:eq(" + i + ")").css("font-weight", "bold");
        }
    }

    function fn_monthAge_success(data, response){
        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0].split(".")[2];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                var sum_total = [
                    detail.Cnt00,
                    detail.Cnt10,
                    detail.Cnt20,
                    detail.Cnt30,
                    detail.Cnt40,
                    detail.Cnt50,
                    detail.Cnt60,
                ];
                var total = common.getListSum(sum_total);

                console.log(detail.the_day);
                console.log(total);

                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 1) + ")").html(common.addComma(detail.Cnt00,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 2) + ")").html(common.addComma(detail.Cnt10,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 3) + ")").html(common.addComma(detail.Cnt20,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 4) + ")").html(common.addComma(detail.Cnt30,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 5) + ")").html(common.addComma(detail.Cnt40,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 6) + ")").html(common.addComma(detail.Cnt50,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 7) + ")").html(common.addComma(detail.Cnt60,"Y"));
                $("#monthAgeTableBody tr._tr_" + detail.the_day + " td:eq(" + ((index * 8) + 8) + ")").html(common.addComma(total,"Y"));
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            var sum_total = [
                response.data[i].totalInfo.sum_00Cnt,
                response.data[i].totalInfo.sum_10Cnt,
                response.data[i].totalInfo.sum_20Cnt,
                response.data[i].totalInfo.sum_30Cnt,
                response.data[i].totalInfo.sum_40Cnt,
                response.data[i].totalInfo.sum_50Cnt,
                response.data[i].totalInfo.sum_60Cnt,
            ];
            var total = common.getListSum(sum_total);

            //총합
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_00Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_10Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_20Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_30Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_40Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_50Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_60Cnt));
            $("#monthAgeTableBody tr:eq(0) td:eq(" + ((i*8) + 8) + ")").html(common.addComma(total));
            //총합
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_00Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_10Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_20Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_30Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_40Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_50Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_60Cnt));
            $("#monthAgeTableBody tr:eq(32) td:eq(" + ((i*8) + 8) + ")").html(common.addComma(total));
        }
        ui.paintColor();
        ui.tableHeightSet();

        for(var i = 1; i < 17 ; i ++){
            $("#monthAgeTableBody tr._tr_" + (Number(tmp_day.split(":")[0])) + " td:eq(" + i + ")").css("background-color", "#dae3f3");
            $("#monthAgeTableBody tr._tr_" + (Number(tmp_day.split(":")[0])) + " td:eq(" + i + ")").css("font-weight", "bold");
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_monthDetailList">
    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}} 일</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>
</script>


<script type="text/x-handlebars-template" id="tmp_monthAgeDetailList">
    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}} 일</td>
        <<td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td style="background-color: #d9d9d9"></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="background-color: #d9d9d9"></td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td></td>
    </tr>
</script>