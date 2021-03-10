<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divYear">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="col-md-12 no-padding">
            <table class="table table-bordered mb0 _tableHeight" data-height="23px">
                <colgroup>
                    <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
                    <col width="12.5%"/>
                </colgroup>
                <thead>
                <tr style="background-color: #b4c7e7">
                    <th rowspan="2"></th>
                    <th class="_totalDate" colspan="5" id="year_th_0"></th>
                </tr>
                <tr style="background-color: #dae3f3">
                    <th>건수</th>
                    <th>수량</th>
                    <th>결제</th>
                    <th>누적</th>
                    <th>취소</th>
                </tr>
                </thead>
                <tbody id="yearTableBody"></tbody>
            </table>
        </div>
        <div class="col-md-12 no-padding">
            <label class="font-bold" style="color: blue">※결제 수단 별</label>
            <table class="table table-bordered" style="font:message-box;">
                <colgroup>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                    <col width="2%"/><col width="2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_stateTopTh"></th>
                    <th colspan="3" class="_stateTopTh">총계</th>
                    <th colspan="3" class="_stateTopTh">휴대폰<i class="fa fa-tablet"></i></th>
                    <th colspan="3" class="_stateTopTh">카드<i class="fa fa-credit-card"></i></th>
                    <th colspan="3" class="_stateTopTh">인앱결제(아이폰)<i class="fa fa-apple"></i></th>
                    <th colspan="3" class="_stateTopTh">가상계좌아체<i class="fa fa-money"></i></th>
                    <th colspan="3" class="_stateTopTh">문화상품권<i class="fa fa-barcode"></i></th>
                    <th colspan="3" class="_stateTopTh">해피머니상품권<i class="fa fa-smile-o"></i></th>
                    <%--<th colspan="2" class="_stateTopTh">스마트문상(게임)<i class="fa fa-gamepad"></i></th>--%>
                    <%--<th colspan="2" class="_stateTopTh">도서문화상품권<i class="fa fa-book"></i></th>--%>
                    <th colspan="3" class="_stateTopTh">티머니<i class="fa fa-bus"></i></th>
                    <th colspan="3" class="_stateTopTh">캐시비<i class="fa fa-forumbee"></i></th>
                    <th colspan="3" class="_stateTopTh">페이코<i class="fa fa-paypal"></i></th>
                    <th colspan="3" class="_stateTopTh">카카오페이<i class="fa fa-comment"></i></th>
                    <th colspan="3" class="_stateTopTh">간편결제(계좌)<i class="fa fa-money"></i></th>
                </tr>
                <tr>
                    <th class="_stateSubTh">건<br/>(비율)</th>
                    <th class="_stateSubTh">수량<br/>(비율)</th>
                    <th class="_stateSubTh">금액<br/>(비율)</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <%--<th class="_stateSubTh">건</th>--%>
                    <%--<th class="_stateSubTh">수량</th>--%>
                    <%--<th class="_stateSubTh">금액</th>--%>
                    <%--<th class="_stateSubTh">건</th>--%>
                    <%--<th class="_stateSubTh">수량</th>--%>
                    <%--<th class="_stateSubTh">금액</th>--%>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                    <th class="_stateSubTh">건</th>
                    <th class="_stateSubTh">수량</th>
                    <th class="_stateSubTh">금액</th>
                </tr>
                </thead>
                <tbody id="wayYearTableBody"></tbody>
            </table>
        </div>
    </div>
    <div class="col-md-12 no-padding">
        <div class="main-content">
            <div class="widget">
                <div class="widget-content">
                    <div id='barArea' style="display: none"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<a id='yearExcel' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divYear', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script src='/js/lib/plotly-latest.min.js'></script>

<script type="text/javascript">
    $(function() {
    });

    function getPayYearList(){
        $("#yearExcel").attr('download' , "결제현황_년간결제_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        $("#year_th_1").text(moment($("#startDate").val()).add('years', -1).format('YYYY'));
        $("#year_th_0").text(moment($("#startDate").val()).add('years', 0).format('YYYY'));

        var total_th_1 = moment($("#startDate").val()).add('years', -1).format('YYYY.01.01') + "-" + moment($("#startDate").val()).add('years', -1).format('YYYY.12.31');
        var total_th_0 = moment($("#startDate").val()).add('years', 0).format('YYYY.01.01') + "-" + moment($("#startDate").val()).add('years', 0).format('YYYY.12.31');

        var dateList = total_th_1 + "@" + total_th_0 + "@";
        var data = {};

        data.dateList = dateList;
        data.slctType = 2;

        console.log(data);

        $("#yearTableBody").empty();
        $("#wayYearTableBody").empty();
        $("#barArea").hide();

        util.getAjaxData("total", "/rest/enter/pay/total", data, fn_payYear_success);
    }

    var yearResponseData;
    function fn_payYear_success(data, response){
        yearResponseData = response.data;

        var slctType_date = [];
        for(i = (response.data[1].detailList.length-1); 0 < i; i-- ){
            slctType_date.push(i + " 월");
        }
        data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_yearTableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);
        $("#yearTableBody").html(html);

        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        response.data.forEach(function(data, index){
            data.detailList.forEach(function(detail, detailIndex){
                if(detail.succAmt == 0){
                    detail.accumAmt = 0;
                }

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
                if (index == 1) {
                    $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (1) + ")").html(common.addComma(succCnt));
                    $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (2) + ")").html(common.addComma(succCmt));
                    $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (3) + ")").html(common.vatMinus(succAmt));
                    $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (4) + ")").html(common.vatMinus(accumAmt));
                    $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (5) + ")").html(common.vatMinus(cancAmt));

                    if(Number(tmp_day.split(".")[1]) == detail.monthly) {
                        for (var i = 1; i < 6; i++) {
                            $("#yearTableBody tr._tr_" + (detail.monthly) + " td:eq(" + (i) + ")").css("font-weight", "bold");
                        }
                    }
                }
            });
        });

        for(var i=0 ; i<response.data.length;i++){
            var totalInfo = response.data[i].totalInfo;
            var sum_succCnt = totalInfo.sum_succCnt;
            var sum_succCmt = totalInfo.sum_succCmt;
            var sum_succAmt = totalInfo.sum_succAmt;
            var sum_firstCnt = totalInfo.sum_firstCnt;
            var sum_firstCmt = totalInfo.sum_firstCmt;
            var sum_firstAmt = totalInfo.sum_firstAmt;
            var sum_reCnt = totalInfo.sum_reCnt;
            var sum_reCmt = totalInfo.sum_reCmt;
            var sum_reAmt = totalInfo.sum_reAmt;
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
            if(sum_cancAmt == 0)
                sum_cancAmt = "null";

            if(i == 1){
                //총합
                $("#yearTableBody tr:eq(0) td:eq(" + (1) + ")").html(common.addComma(sum_succCnt));
                $("#yearTableBody tr:eq(0) td:eq(" + (2) + ")").html(common.addComma(sum_succCmt));
                $("#yearTableBody tr:eq(0) td:eq(" + (3) + ")").html(common.vatMinus(sum_succAmt));
                $("#yearTableBody tr:eq(0) td:eq(" + (4) + ")").html(common.vatMinus(sum_cancAmt));
                //첫구매
                $("#yearTableBody tr:eq(1) td:eq(" + (1) + ")").html(common.addComma(sum_firstCnt));
                $("#yearTableBody tr:eq(1) td:eq(" + (2) + ")").html(common.addComma(sum_firstCmt));
                $("#yearTableBody tr:eq(1) td:eq(" + (3) + ")").html(common.vatMinus(sum_firstAmt));
                $("#yearTableBody tr:eq(1) td:eq(" + (4) + ")").html();
                //재구매
                $("#yearTableBody tr:eq(2) td:eq(" + (1) + ")").html(common.addComma(sum_reCnt));
                $("#yearTableBody tr:eq(2) td:eq(" + (2) + ")").html(common.addComma(sum_reCmt));
                $("#yearTableBody tr:eq(2) td:eq(" + (3) + ")").html(common.vatMinus(sum_reAmt));
                $("#yearTableBody tr:eq(2) td:eq(" + (4) + ")").html();
            }
        }
        ui.tableHeightSet();
        getPayWayYearList();
    }

    function getPayWayYearList(){
        var data = {};
        data.slctType = 2;
        data.startDate = moment($("#startDate").val()).add('years', 0).format('YYYY.01.01');
        data.endDate = moment($("#startDate").val()).add('years', 0).format('YYYY.12.31');
        console.log(data);
        util.getAjaxData("way", "/rest/enter/pay/way", data, fn_wayYearPay_success);
    }

    function fn_wayYearPay_success(data, response){
        if(response.result == "fail"){
            searchDate();
            getPayWayYearList();
            return;
        }
        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i]["sum_totalCnt"] = response.data.totalInfo.sum_totalCnt;
            response.data.detailList[i]["sum_totalCmt"] = response.data.totalInfo.sum_totalCmt;
            response.data.detailList[i]["sum_totalAmt"] = response.data.totalInfo.sum_totalAmt;
        }
        var isDataEmpty = response.data.detailList == null;
        $("#wayYearTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_wayYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#wayYearTableBody").append(totalHtml);
        }

        var template = $('#tmp_wayYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#wayYearTableBody").append(html);

        if(isDataEmpty){
            $("#wayYearTableBody td:last").remove();
        }else{
            $("#wayYearTableBody").append(totalHtml);
        }
        ui.tableHeightSet();
        chart();
    }
    function chart(){
        $("#barArea").show();

        yearResponseData = yearResponseData[1].detailList;
        var sortingField = "monthly";
        yearResponseData.sort(function(a, b) { // 오름차순
            return a[sortingField] - b[sortingField];
        });

        var xList = [];
        var yList = [];
        for(var i=0;i<(yearResponseData.length);i++){
            if(yearResponseData[i].monthly != 0){
                xList.push(yearResponseData[i].monthly + "월");
                yList.push(common.vatMinus(yearResponseData[i].succAmt));
            }
        }
        //console.log(yList);
        var year = {
            type: 'bar',
            x: xList,
            y: yList,
            marker: {
                color: '#e48701',
                line: {
                    width: 0
                }
            }
        };
        var data = [ year ];
        var layout = {
            autosize:true,
            /*width:'100%',
            height:500,*/
            font: {size: 13},
            xaxis: {
                autorange: true,
            },
            yaxis: {
                tickformat:",d"
            },
            separators : '.,',
            legend: {
                y: 1,
                y: 1,
                traceorder: 'reversed',
            }
        };
        var config = {responsive: false};
        Plotly.newPlot('barArea', data, layout, config );
    }


</script>

<script type="text/x-handlebars-template" id="tmp_yearTableBody">
    <tr class="_tr_{{this}} font-bold" style="color: #ff5600;">
        <td style="background-color: #dae3f3">총합</td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>
    <tr class="_tr_{{this}}" style="background-color: #f2f2f2">
        <td class="font-bold">첫구매</td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>
    <tr class="_tr_{{this}}" style="background-color: #f2f2f2">
        <td class="font-bold">재구매</td>
        <td></td><td></td><td colspan="2"></td><td></td>
    </tr>

    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}">
        <td class="font-bold" style="background-color: #dae3f3">{{this}}</td>
        <td></td><td></td><td></td><td></td><td></td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_wayYear">
    <tr class="font-bold _stateSumTd">
        <td>소계</td>
        <td style="font-weight:bold;color: #ff5600;">{{addComma sum_totalCnt}}<br/>({{average sum_totalCnt sum_totalCnt}}%)</td>
        <td style="font-weight:bold;color: #ff5600;"><b>{{addComma sum_totalCmt}}<br/>({{average sum_totalCmt sum_totalCmt}}%)</b></td>
        <td style="font-weight:bold;color: #ff5600;"><b>{{vatMinus sum_totalAmt}}<br/>({{average sum_totalAmt sum_totalAmt}}%)</b></td>
        <td>{{addComma sum_mcCnt}}</td>
        <td>{{addComma sum_mcCmt}}</td>
        <td>{{vatMinus sum_mcAmt}}</td>
        <td>{{addComma sum_cnCnt}}</td>
        <td>{{addComma sum_cnCmt}}</td>
        <td>{{vatMinus sum_cnAmt}}</td>
        <td>{{addComma sum_inappCnt}}</td>
        <td>{{addComma sum_inappCmt}}</td>
        <td>{{vatMinus sum_inappAmt}}</td>
        <td>{{addComma sum_vaCnt}}</td>
        <td>{{addComma sum_vaCmt}}</td>
        <td>{{vatMinus sum_vaAmt}}</td>
        <td>{{addComma sum_gmCnt}}</td>
        <td>{{addComma sum_gmCmt}}</td>
        <td>{{vatMinus sum_gmAmt}}</td>
        <td>{{addComma sum_hmCnt}}</td>
        <td>{{addComma sum_hmCmt}}</td>
        <td>{{vatMinus sum_hmAmt}}</td>
        <%--<td>{{addComma sum_ggCnt}}</td>--%>
        <%--<td>{{addComma sum_ggCmt}}</td>--%>
        <%--<td>{{vatMinus sum_ggAmt}}</td>--%>
        <%--<td>{{addComma sum_gcCnt}}</td>--%>
        <%--<td>{{addComma sum_gcCmt}}</td>--%>
        <%--<td>{{vatMinus sum_gcAmt}}</td>--%>

        <td>{{addComma sum_tmoneyCnt}}</td>
        <td>{{addComma sum_tmoneyCmt}}</td>
        <td>{{vatMinus sum_tmoneyAmt}}</td>
        <td>{{addComma sum_cashbeeCnt}}</td>
        <td>{{addComma sum_cashbeeCmt}}</td>
        <td>{{vatMinus sum_cashbeeAmt}}</td>
        <td>{{addComma sum_paycoCnt}}</td>
        <td>{{addComma sum_paycoCmt}}</td>
        <td>{{vatMinus sum_paycoAmt}}</td>
        <td>{{addComma sum_kakaopayCnt}}</td>
        <td>{{addComma sum_kakaopayCmt}}</td>
        <td>{{vatMinus sum_kakaopayAmt}}</td>
        <td>{{addComma sum_simpleCnt}}</td>
        <td>{{addComma sum_simpleCmt}}</td>
        <td>{{vatMinus sum_simpleAmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_wayYearDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold _stateSubTh">
            {{data.monthly}}월
        </td>
        <td>{{addComma totalCnt}}<br/>({{average totalCnt sum_totalCnt}}%)</td>
        <td>{{addComma totalCmt}}<br/>({{average totalCmt sum_totalCmt}}%)</td>
        <td style="font-weight:bold">{{vatMinus totalAmt}}<br/>({{average totalAmt sum_totalAmt}}%)</td>
        <td>{{addComma mcCnt}}</td>
        <td>{{addComma mcCmt}}</td>
        <td>{{vatMinus mcAmt}}</td>
        <td>{{addComma cnCnt}}</td>
        <td>{{addComma cnCmt}}</td>
        <td>{{vatMinus cnAmt}}</td>
        <td>{{addComma inappCnt}}</td>
        <td>{{addComma inappCmt}}</td>
        <td>{{vatMinus inappAmt}}</td>
        <td>{{addComma vaCnt}}</td>
        <td>{{addComma vaCmt}}</td>
        <td>{{vatMinus vaAmt}}</td>
        <td>{{addComma gmCnt}}</td>
        <td>{{addComma gmCmt}}</td>
        <td>{{vatMinus gmAmt}}</td>
        <td>{{addComma hmCnt}}</td>
        <td>{{addComma hmCmt}}</td>
        <td>{{vatMinus hmAmt}}</td>
        <%--<td>{{vatMinus ggCnt}}</td>--%>
        <%--<td>{{addComma ggCmt}}</td>--%>
        <%--<td>{{vatMinus ggAmt}}</td>--%>
        <%--<td>{{vatMinus gcCnt}}</td>--%>
        <%--<td>{{addComma gcCmt}}</td>--%>
        <%--<td>{{vatMinus gcAmt}}</td>--%>

        <td>{{addComma tmoneyCnt}}</td>
        <td>{{addComma tmoneyCmt}}</td>
        <td>{{vatMinus tmoneyAmt}}</td>
        <td>{{addComma cashbeeCnt}}</td>
        <td>{{addComma cashbeeCmt}}</td>
        <td>{{vatMinus cashbeeAmt}}</td>
        <td>{{addComma paycoCnt}}</td>
        <td>{{addComma paycoCmt}}</td>
        <td>{{vatMinus paycoAmt}}</td>
        <td>{{addComma kakaopayCnt}}</td>
        <td>{{addComma kakaopayCmt}}</td>
        <td>{{vatMinus kakaopayAmt}}</td>
        <td>{{addComma simpleCnt}}</td>
        <td>{{addComma simpleCmt}}</td>
        <td>{{vatMinus simpleAmt}}</td>

    </tr>
    {{else}}
    <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>
