<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결제취소 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divMonth_new">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
            <div id="_paywayType" style="width:150px;"></div>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered mb0 _tableHeight" data-height="23px">
            <colgroup>
                <col width="5%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="5" id="month_new_th_2"></th><td class="_noBorder"></td>
                <th class="_totalDate" colspan="5" id="month_new_th_1"></th><td class="_noBorder"></td>
                <th class="_totalDate" colspan="5" id="month_new_th_0" style="background-color: #ffe699"></th><td class="_noBorder"></td>
                <th colspan="5" title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">평균</th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>
                <td class="_noBorder"></td>

                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>
                <td class="_noBorder"></td>

                <th style="background-color: #fff2cc">건수</th>
                <th style="background-color: #fff2cc">수량</th>
                <th style="background-color: #fff2cc">결제</th>
                <th style="background-color: #fff2cc">누적</th>
                <th style="background-color: #fff2cc">취소</th>
                <td class="_noBorder"></td>

                <th title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">건수</th>
                <th title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">수량</th>
                <th title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">결제</th>
                <th title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">누적</th>
                <th title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다.">취소</th>

            </tr>
            </thead>
            <tbody id="monthTableBody_new"></tbody>
        </table>

        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="5%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="0.1%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
            </colgroup>
            <thead>
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th class="_totalDate" colspan="5" id="month_new_th_6"></th><td class="_noBorder"></td>
                <th class="_totalDate" colspan="5" id="month_new_th_5"></th><td class="_noBorder"></td>
                <th class="_totalDate" colspan="5" id="month_new_th_4"></th><td class="_noBorder"></td>
                <th class="_totalDate" colspan="5" id="month_new_th_3"></th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>
                <td class="_noBorder"></td>

                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>
                <td class="_noBorder"></td>

                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>
                <td class="_noBorder"></td>

                <th>건수</th>
                <th>수량</th>
                <th>결제</th>
                <th>누적</th>
                <th>취소</th>

            </tr>
            </thead>
            <tbody id="monthTableBody_new2"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>
<a id='monthExcel_new' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divMonth_new', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $(function() {
        $('#_paywayType').html(util.getCommonCodeSelect('all', payWay_new));
    });

    $('#_paywayType').on('change', function() {
        getPayMonthWayList();
    });

    function getPayMonthWayList(){
        $("#monthExcel_new").attr('download' , "결제현황_월간결제_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var slctType_date = [];
        for(i = 31; 0 < i; i-- ){
            slctType_date.push(i + " 일");
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_monthTableBody_new').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#monthTableBody_new").html(html);

        var template = $('#tmp_monthTableBody_new2').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#monthTableBody_new2").html(html);

        $("#month_new_th_6").text(moment($("#startDate").val()).add('months', -6).format('YYYY.MM'));
        $("#month_new_th_5").text(moment($("#startDate").val()).add('months', -5).format('YYYY.MM'));
        $("#month_new_th_4").text(moment($("#startDate").val()).add('months', -4).format('YYYY.MM'));
        $("#month_new_th_3").text(moment($("#startDate").val()).add('months', -3).format('YYYY.MM'));
        $("#month_new_th_2").text(moment($("#startDate").val()).add('months', -2).format('YYYY.MM'));
        $("#month_new_th_1").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $("#month_new_th_0").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));

        var total_th_6 = moment($("#startDate").val()).add('months', -6).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', -5).add('days', -1).format('YYYY.MM.DD');
        var total_th_5 = moment($("#startDate").val()).add('months', -5).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', -4).add('days', -1).format('YYYY.MM.DD');
        var total_th_4 = moment($("#startDate").val()).add('months', -4).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', -3).add('days', -1).format('YYYY.MM.DD');
        var total_th_3 = moment($("#startDate").val()).add('months', -3).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', -2).add('days', -1).format('YYYY.MM.DD');
        var total_th_2 = moment($("#startDate").val()).add('months', -2).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', -1).add('days', -1).format('YYYY.MM.DD');
        var total_th_1 = moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD');
        var total_th_0 = moment($("#startDate").val()).add('months', 0).format('YYYY.MM.01') + "-" + moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD');

        var dateList = total_th_2 + "@" + total_th_1 + "@" + total_th_0 + "@" + total_th_6 + "@" + total_th_5 + "@" + total_th_4  + "@" +  total_th_3;
        var data = {};

        console.log(dateList);

        data.dateList = dateList;
        data.slctType = 1;
        data.paywayType = $('select[name="payway"]').val();
        util.getAjaxData("total", "/rest/enter/pay/month/way", data, fn_paywayMonth_success);
    }

    function fn_paywayMonth_success(data, response){
        var trValue = $('select[name="payway"]').val();
        if(trValue != 'all') {
            $('._totalHidden').hide();
        } else if(trValue == 'all') {
            $('._totalHidden').show();
        }
        tmp_index = -1;
        var title = "평균 합계의 경우 반올림된 평균 데이터의 총합이라\n항목별 합계와 다소 오차가 생길 수 있습니다.";

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            if(index > 2){
                ++tmp_index;
            }
            data.detailList.forEach(function(detail, detailIndex){
                if(detail.succAmt == 0){
                    detail.accumAmt = 0;
                }
                $("#monthTableBody_new tr.__tr_" + detail.hour + " td:eq(" + (3 * 6 + 1) + ")").attr('title',title);
                $("#monthTableBody_new tr.__tr_" + detail.hour + " td:eq(" + (3 * 6 + 2) + ")").attr('title',title);
                $("#monthTableBody_new tr.__tr_" + detail.hour + " td:eq(" + (3 * 6 + 3) + ")").attr('title',title);
                $("#monthTableBody_new tr.__tr_" + detail.hour + " td:eq(" + (3 * 6 + 4) + ")").attr('title',title);

                var succCnt = detail.succCnt;
                var succCmt = detail.succCmt;
                var succAmt = detail.succAmt;
                var accumAmt = detail.accumAmt;
                var cancAmt = detail.cancAmt;
                if(succCnt == 0)
                    succCnt = "null";
                if(succCmt == 0)
                    succCmt = "null";
                if(succAmt == 0)
                    succAmt = "null";
                if(accumAmt == 0)
                    accumAmt = "null";
                if(cancAmt == 0)
                    cancAmt = "null";

                //상단
                if (index == 0) {
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index + 1) + ")").html(common.addComma(succCnt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index + 2) + ")").html(common.addComma(succCmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index + 3) + ")").html(common.vatMinus(succAmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index + 4) + ")").html(common.vatMinus(accumAmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index + 5) + ")").html(common.vatMinus(cancAmt));
                    for (var i = 1; i < 6; i++) {
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (index + i) + ")").css("background-color", "#e3ecfb");
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (index + i) + ")").css("font-weight", "bold");
                    }
                } else if (index == 1 || index == 2) {
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index * 6 + 1) + ")").html(common.addComma(succCnt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index * 6 + 2) + ")").html(common.addComma(succCmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index * 6 + 3) + ")").html(common.vatMinus(succAmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index * 6 + 4) + ")").html(common.vatMinus(accumAmt));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (index * 6 + 5) + ")").html(common.vatMinus(cancAmt));
                    for (var i = 1; i < 6; i++) {
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (index * 6 + i) + ")").css("background-color", "#e3ecfb");
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (index * 6 + i) + ")").css("font-weight", "bold");
                    }
                } else if(index == 7) {     //평균
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (3 * 6 + 1) + ")").html(common.addComma((succCnt/7).toFixed(1)));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (3 * 6 + 2) + ")").html(common.addComma((succCmt/7).toFixed(1)));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (3 * 6 + 3) + ")").html(common.vatMinus(succAmt/7));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (3 * 6 + 4) + ")").html(common.vatMinus(accumAmt/7));
                    $("#monthTableBody_new tr.__tr_" + (detail.day) + " td:eq(" + (3 * 6 + 5) + ")").html(common.vatMinus(cancAmt/7));
                    for (var i = 1; i < 6; i++) {
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (3 * 6 + i) + ")").css("background-color", "#e3ecfb");
                        $("#monthTableBody_new tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (3 * 6 + i) + ")").css("font-weight", "bold");
                    }
                }
                // 하단
                if (index == 3) {
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index + 1) + ")").html(common.addComma(succCnt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index + 2) + ")").html(common.addComma(succCmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index + 3) + ")").html(common.vatMinus(succAmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index + 4) + ")").html(common.vatMinus(accumAmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index + 5) + ")").html(common.vatMinus(cancAmt));
                    for (var i = 1; i < 6; i++) {
                        $("#monthTableBody_new2 tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (tmp_index + i) + ")").css("background-color", "#e3ecfb");
                        $("#monthTableBody_new2 tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (tmp_index + i) + ")").css("font-weight", "bold");
                    }
                } else if (index == 4 || index == 5 || index == 6){
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index * 6 + 1) + ")").html(common.addComma(succCnt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index * 6 + 2) + ")").html(common.addComma(succCmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index * 6 + 3) + ")").html(common.vatMinus(succAmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index * 6 + 4) + ")").html(common.vatMinus(accumAmt));
                    $("#monthTableBody_new2 tr.__tr_" + (detail.day) + " td:eq(" + (tmp_index * 6 + 5) + ")").html(common.vatMinus(cancAmt));
                    for (var i = 1; i < 6; i++) {
                        $("#monthTableBody_new2 tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (tmp_index * 6 + i) + ")").css("background-color", "#e3ecfb");
                        $("#monthTableBody_new2 tr:eq(" + (34 - Number(tmp_day.split(".")[2])) + ") td:eq(" + (tmp_index * 6+ i) + ")").css("font-weight", "bold");
                    }
                }
            });
        });


        tmp_index = -1;
        for(var i=0 ; i<response.data.length;i++){
            var totalInfo = response.data[i].totalInfo;
            if(i > 2){
                ++tmp_index;
            }

            var sum_succCnt = totalInfo.sum_succCnt;
            var sum_succCmt = totalInfo.sum_succCmt;
            var sum_succAmt = totalInfo.sum_succAmt;
            var sum_firstCnt = totalInfo.sum_firstCnt;
            var sum_firstCmt = totalInfo.sum_firstCmt;
            var sum_firstAmt = totalInfo.sum_firstAmt;
            var sum_reCnt = totalInfo.sum_reCnt;
            var sum_reCmt = totalInfo.sum_reCmt;
            var sum_reAmt = totalInfo.sum_reAmt;
            var sum_cancCnt = totalInfo.sum_cancCnt;
            var sum_cancCmt = totalInfo.sum_cancCmt;
            var sum_cancAmt = totalInfo.sum_cancAmt;

            if(sum_succCnt == 0)
                sum_succCnt = "null";
            if(sum_succCmt == 0)
                sum_succCmt = "null";
            if(sum_succAmt == 0)
                sum_succAmt = "null";
            if(sum_firstCnt == 0)
                sum_firstCnt = "null";
            if(sum_firstCmt == 0)
                sum_firstCmt = "null";
            if(sum_firstAmt == 0)
                sum_firstAmt = "null";
            if(sum_reCnt == 0)
                sum_reCnt = "null";
            if(sum_reCmt == 0)
                sum_reCmt = "null";
            if(sum_reAmt == 0)
                sum_reAmt = "null";
            if(sum_cancCnt == 0)
                sum_cancCnt = "null";
            if(sum_cancCmt == 0)
                sum_cancCmt = "null";
            if(sum_cancAmt == 0)
                sum_cancAmt = "null";

            if(i == 0){
                //총합
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i + 1) + ")").html(common.addComma(sum_succCnt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i + 2) + ")").html(common.addComma(sum_succCmt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i + 3) + ")").html(common.vatMinus(sum_succAmt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i + 4) + ")").html(common.vatMinus(sum_cancAmt));
                //첫구매
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i + 1) + ")").html(common.addComma(sum_firstCnt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i + 2) + ")").html(common.addComma(sum_firstCmt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i + 3) + ")").html(common.vatMinus(sum_firstAmt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i + 4) + ")").html();
                //재구매
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i + 1) + ")").html(common.addComma(sum_reCnt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i + 2) + ")").html(common.addComma(sum_reCmt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i + 3) + ")").html(common.vatMinus(sum_reAmt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i + 4) + ")").html();
            }else if(i == 1 || i == 2) {
                //총합
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i * 5 + 1) + ")").html(common.addComma(sum_succCnt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i * 5 + 2) + ")").html(common.addComma(sum_succCmt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i * 5 + 3) + ")").html(common.vatMinus(sum_succAmt));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (i * 5 + 4) + ")").html(common.vatMinus(sum_cancAmt));
                //첫구매
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i * 5 + 1) + ")").html(common.addComma(sum_firstCnt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i * 5 + 2) + ")").html(common.addComma(sum_firstCmt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i * 5 + 3) + ")").html(common.vatMinus(sum_firstAmt));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (i * 5 + 4) + ")").html();
                //재구매
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i * 5 + 1) + ")").html(common.addComma(sum_reCnt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i * 5 + 2) + ")").html(common.addComma(sum_reCmt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i * 5 + 3) + ")").html(common.vatMinus(sum_reAmt));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (i * 5 + 4) + ")").html();
            }else if(i == 7){
                //총합
                $("#monthTableBody_new tr:eq(0) td:eq(" + (3 * 5 + 1) + ")").html(common.addComma((sum_succCnt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (3 * 5 + 2) + ")").html(common.addComma((sum_succCmt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (3 * 5 + 3) + ")").html(common.vatMinus(sum_succAmt/7));
                $("#monthTableBody_new tr:eq(0) td:eq(" + (3 * 5 + 4) + ")").html(common.vatMinus(sum_cancAmt/7));
                //첫구매
                $("#monthTableBody_new tr:eq(1) td:eq(" + (3 * 5 + 1) + ")").html(common.addComma((sum_firstCnt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (3 * 5 + 2) + ")").html(common.addComma((sum_firstCmt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (3 * 5 + 3) + ")").html(common.vatMinus(sum_firstAmt/7));
                $("#monthTableBody_new tr:eq(1) td:eq(" + (3 * 5 + 4) + ")").html();
                //재구매
                $("#monthTableBody_new tr:eq(2) td:eq(" + (3 * 5 + 1) + ")").html(common.addComma((sum_reCnt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (3 * 5 + 2) + ")").html(common.addComma((sum_reCmt/7).toFixed(1)));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (3 * 5 + 3) + ")").html(common.vatMinus(sum_reAmt/7));
                $("#monthTableBody_new tr:eq(2) td:eq(" + (3 * 5 + 4) + ")").html();
            }

            if(i == 3){
                //총합
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index + 1) + ")").html(common.addComma(sum_succCnt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index + 2) + ")").html(common.addComma(sum_succCmt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index + 3) + ")").html(common.vatMinus(sum_succAmt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index + 4) + ")").html(common.vatMinus(sum_cancAmt));
                //첫구매
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index + 1) + ")").html(common.addComma(sum_firstCnt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index + 2) + ")").html(common.addComma(sum_firstCmt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index + 3) + ")").html(common.vatMinus(sum_firstAmt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index + 4) + ")").html();
                //재구매
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index + 1) + ")").html(common.addComma(sum_reCnt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index + 2) + ")").html(common.addComma(sum_reCmt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index + 3) + ")").html(common.vatMinus(sum_reAmt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index + 4) + ")").html();
            }else if(i == 4 || i == 5 || i == 6) {
                //총합
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index * 5 + 1) + ")").html(common.addComma(sum_succCnt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index * 5 + 2) + ")").html(common.addComma(sum_succCmt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index * 5 + 3) + ")").html(common.vatMinus(sum_succAmt));
                $("#monthTableBody_new2 tr:eq(0) td:eq(" + (tmp_index * 5 + 4) + ")").html(common.vatMinus(sum_cancAmt));
                //첫구매
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index * 5 + 1) + ")").html(common.addComma(sum_firstCnt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index * 5 + 2) + ")").html(common.addComma(sum_firstCmt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index * 5 + 3) + ")").html(common.vatMinus(sum_firstAmt));
                $("#monthTableBody_new2 tr:eq(1) td:eq(" + (tmp_index * 5 + 4) + ")").html();
                //재구매
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index * 5 + 1) + ")").html(common.addComma(sum_reCnt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index * 5 + 2) + ")").html(common.addComma(sum_reCmt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index * 5 + 3) + ")").html(common.vatMinus(sum_reAmt));
                $("#monthTableBody_new2 tr:eq(2) td:eq(" + (tmp_index * 5 + 4) + ")").html();
            }
        }
        ui.tableHeightSet();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_monthTableBody_new">
    <tr class="__tr_{{this}} font-bold" style="color: #ff5600;">
        <td style="background-color: #dae3f3">총합</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td colspan="2" style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다." colspan="2"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
    </tr>
    <tr class="__tr_{{this}} _totalHidden" style="background-color: #f2f2f2">
        <td class="font-bold">첫구매</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td colspan="2" style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다." colspan="2"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
    </tr>
    <tr class="__tr_{{this}} _totalHidden" style="background-color: #f2f2f2">
        <td class="font-bold">재구매</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td colspan="2" style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다." colspan="2"></td>
        <td title="평균 합계의 경우 반올림된 평균 데이터의 총합이라&#10;항목별 합계와 다소 오차가 생길 수 있습니다."></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="__tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="background-color: #FFF7E5"></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_monthTableBody_new2">
    <tr class="__tr_{{this}} font-bold" style="color: #ff5600;">
        <td style="background-color: #dae3f3">총합</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>
    <tr class="__tr_{{this}} _totalHidden" style="background-color: #f2f2f2">
        <td class="font-bold">첫구매</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>
    <tr class="__tr_{{this}} _totalHidden" style="background-color: #f2f2f2">
        <td class="font-bold">재구매</td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td><td style="border-bottom: hidden;border-top: hidden;background-color: white"></td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>
    {{#each this.slctType_date}}
    <tr class="__tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td></td><td style="border-bottom: hidden;border-top: hidden"></td>
        <td></td><td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}
</script>

