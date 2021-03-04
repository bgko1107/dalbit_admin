<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divWay">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/>
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
                <th colspan="3" class="_stateTopTh">카카오페이(카드)<i class="fa fa-comment"></i></th>
                <th colspan="3" class="_stateTopTh">카카오페이(머니)<i class="fa fa-comment"></i></th>
                <th colspan="3" class="_stateTopTh">간편결제(계좌)<i class="fa fa-money"></i></th>
            </tr>
            <tr>
                <th class="_stateSubTh">건(비율)</th>
                <th class="_stateSubTh">수량(비율)</th>
                <th class="_stateSubTh">금액(비율)</th>
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
                <th class="_stateSubTh">건</th>
                <th class="_stateSubTh">수량</th>
                <th class="_stateSubTh">금액</th>
            </tr>
            </thead>
            <tbody id="wayTableBody"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>
<a id='wayExcel' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divWay', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">
    $(function(){
        // getPayWayList();
    });

    function getPayWayList(){
        $("#wayExcel").attr('download' , "결제현황_결제수단별_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + "_" +  moment($("#endDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("way", "/rest/enter/pay/way", data, fn_wayPay_success);
    }

    function fn_wayPay_success(data, response){
        if(response.result == "fail"){
            searchDate();
            getPayWayList();
            return;
        }
        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i]["sum_totalCnt"] = response.data.totalInfo.sum_totalCnt;
            response.data.detailList[i]["sum_totalCmt"] = response.data.totalInfo.sum_totalCmt;
            response.data.detailList[i]["sum_totalAmt"] = response.data.totalInfo.sum_totalAmt;
        }
        var isDataEmpty = response.data.detailList == null;
        $("#wayTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_way').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#wayTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tmp_wayDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#wayTableBody").append(html);

        if(isDataEmpty){
            $("#wayTableBody td:last").remove();
        }else{
            $("#wayTableBody").append(totalHtml);
        }
        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_way">
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
        <%--<td>{{vatMinus sum_ggCnt}}</td>--%>
        <%--<td>{{vatMinus sum_ggCmt}}</td>--%>
        <%--<td>{{vatMinus sum_ggAmt}}</td>--%>
        <%--<td>{{vatMinus sum_gcCnt}}</td>--%>
        <%--<td>{{vatMinus sum_gcCmt}}</td>--%>
        <%--<td>{{vatMinus sum_gcAmt}}</td>--%>

        <td>{{vatMinus sum_tmoneyCnt}}</td>
        <td>{{vatMinus sum_tmoneyCmt}}</td>
        <td>{{vatMinus sum_tmoneyAmt}}</td>
        <td>{{vatMinus sum_cashbeeCnt}}</td>
        <td>{{vatMinus sum_cashbeeCmt}}</td>
        <td>{{vatMinus sum_cashbeeAmt}}</td>
        <td>{{vatMinus sum_paycoCnt}}</td>
        <td>{{vatMinus sum_paycoCmt}}</td>
        <td>{{vatMinus sum_paycoAmt}}</td>
        <td>{{vatMinus sum_kakaopayCnt}}</td>
        <td>{{vatMinus sum_kakaopayCmt}}</td>
        <td>{{vatMinus sum_kakaopayAmt}}</td>
        <td>{{vatMinus sum_kakaomoneyCnt}}</td>
        <td>{{vatMinus sum_kakaomoneyCmt}}</td>
        <td>{{vatMinus sum_kakaomoneyAmt}}</td>
        <td>{{vatMinus sum_simpleCnt}}</td>
        <td>{{vatMinus sum_simpleCmt}}</td>
        <td>{{vatMinus sum_simpleAmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_wayDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{substr data.daily 8}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
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
        <%--<td>{{vatMinus ggCmt}}</td>--%>
        <%--<td>{{vatMinus ggAmt}}</td>--%>
        <%--<td>{{vatMinus gcCnt}}</td>--%>
        <%--<td>{{vatMinus gcCmt}}</td>--%>
        <%--<td>{{vatMinus gcAmt}}</td>--%>

        <td>{{vatMinus tmoneyCnt}}</td>
        <td>{{vatMinus tmoneyCmt}}</td>
        <td>{{vatMinus tmoneyAmt}}</td>
        <td>{{vatMinus cashbeeCnt}}</td>
        <td>{{vatMinus cashbeeCmt}}</td>
        <td>{{vatMinus cashbeeAmt}}</td>
        <td>{{vatMinus paycoCnt}}</td>
        <td>{{vatMinus paycoCmt}}</td>
        <td>{{vatMinus paycoAmt}}</td>
        <td>{{vatMinus kakaopayCnt}}</td>
        <td>{{vatMinus kakaopayCmt}}</td>
        <td>{{vatMinus kakaopayAmt}}</td>
        <td>{{vatMinus kakaomoneyCnt}}</td>
        <td>{{vatMinus kakaomoneyCmt}}</td>
        <td>{{vatMinus kakaomoneyAmt}}</td>
        <td>{{vatMinus simpleCnt}}</td>
        <td>{{vatMinus simpleCmt}}</td>
        <td>{{vatMinus simpleAmt}}</td>
    </tr>
    {{else}}
    <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>