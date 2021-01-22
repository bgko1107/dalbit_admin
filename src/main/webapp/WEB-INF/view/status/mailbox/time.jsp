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
        <table class="table table-bordered _tableHeight" data-height="23px" id="timeTable">
            <colgroup>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
            </colgroup>
            <thead>
                <tr>
                    <th rowspan="3"> 구분</th>
                    <th colspan="9" id="th_yesterday"></th>
                    <th colspan="9" id="th_today">금월</th>
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
            <tbody id="timeTableBody"></tbody>
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">

    function getTime(){


        var slctType_date = [];
        for(i = 23; -1 < i; i-- ){
            slctType_date.push(i);
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_timeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#timeTableBody").html(html);

        $("#th_yesterday").text(moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', -1).day()] + ")");
        $("#th_today").text(moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + " (" + week[moment($("#startDate").val()).add('days', 0).day()] + ")");

        var total_th_1 = moment($("#startDate").val()).add('days', -1).format('YYYY.MM.DD');
        var total_th_0 = moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD');

        var dateList = total_th_1 + "@" + total_th_0  + "@";
        var data = {};
        data.dateList = dateList;
        data.slctType = 1;
        data.timeType = slctType;
        util.getAjaxData("time", "/rest/status/mailbox/time", data, fn_time_success);
    }

    function fn_time_success(data, response){

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 1) + ")").html(common.addComma(detail.male_uniqueCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 2) + ")").html(common.addComma(detail.female_uniqueCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 3) + ")").html(common.addComma(detail.none_uniqueCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 4) + ")").html(common.addComma(detail.total_uniqueCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 5) + ")").html(common.addComma(detail.total_createCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 6) + ")").html(common.addComma(detail.msgCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 7) + ")").html(common.addComma(detail.imgCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 8) + ")").html(common.addComma(detail.giftCnt,"Y"));
                $("#timeTableBody tr._tr_" + detail.the_hr + " td:eq(" + ((index * 9) + 9) + ")").html(common.addComma(detail.giftDal,"Y"));
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            //총합
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_male_uniqueCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_female_uniqueCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_none_uniqueCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_uniqueCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_createCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_msgCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_imgCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftCnt));
            $("#timeTableBody tr:eq(0) td:eq(" + ((i*9) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftDal));
            //총합
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 1) + ")").html(common.addComma(response.data[i].totalInfo.sum_male_uniqueCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 2) + ")").html(common.addComma(response.data[i].totalInfo.sum_female_uniqueCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 3) + ")").html(common.addComma(response.data[i].totalInfo.sum_none_uniqueCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 4) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_uniqueCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 5) + ")").html(common.addComma(response.data[i].totalInfo.sum_total_createCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 6) + ")").html(common.addComma(response.data[i].totalInfo.sum_msgCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 7) + ")").html(common.addComma(response.data[i].totalInfo.sum_imgCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 8) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftCnt));
            $("#timeTableBody tr:eq(25) td:eq(" + ((i*9) + 9) + ")").html(common.addComma(response.data[i].totalInfo.sum_giftDal));
        }
        ui.paintColor();
        ui.tableHeightSet();
        $("#timeTableBody tr._tr_" + (Number(tmp_time.split(":")[0])) + "").css("background-color", "#dae3f3");
        $("#timeTableBody tr._tr_" + (Number(tmp_time.split(":")[0])) + "").css("font-weight", "bold");
    }
</script>

<script type="text/x-handlebars-template" id="tmp_timeDetailList">
    <tr class="_tr_{{this}} font-bold" style="background-color: #d9d9d9">
        <td>총합</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}} 시</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>
    {{/each}}

    <tr class="_tr_{{this}} font-bold">
        <td style="background-color: #d9d9d9">총합</td>
        <td style="color: red;"></td><td style="color: blue;"></td><td></td><td style="background-color: #d9d9d9"></td><td></td>
        <td></td><td></td><td></td><td></td><td></td>
        <td style="color: red;"></td><td style="color: blue;"></td><td style="background-color: #d9d9d9"></td><td></td><td></td><td></td>
        <td></td><td></td>
    </tr>



    <%--{{#each this as |data|}}--%>
    <%--<tr>--%>
        <%--<td class="font-bold" style="background-color: #dae3f3">--%>
            <%--{{the_hr}}--%>
        <%--</td>--%>
        <%--<td>{{addComma beforDetailList.male_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.female_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.none_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.total_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.total_createCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.msgCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.imgCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.giftCnt 'Y'}}</td>--%>
        <%--<td>{{addComma beforDetailList.giftDal 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.male_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.female_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.none_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.total_uniqueCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.total_createCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.msgCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.imgCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.giftCnt 'Y'}}</td>--%>
        <%--<td>{{addComma detailList.giftDal 'Y'}}</td>--%>
    <%--</tr>--%>
    <%--{{else}}--%>

    <%--<td colspan="10" class="noData">{{isEmptyData}}<td>--%>

    <%--{{/each}}--%>
</script>