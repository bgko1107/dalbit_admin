<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="1%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/>
            </colgroup>
            <thead>
            <tr>
                <th colspan="21">Web, 안드로이드</th>
                <th style="background-color: white; border-bottom: hidden; border-top: hidden;"></th>
                <th colspan="15">IOS</th>
            </tr>
            <tr>
                <th rowspan="2"></th>
                <th colspan="2">총계</th>

                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0010.png" width="25px" height="25px"> 1,100원 </th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0050.png" width="25px" height="25px"> 5,500원 </th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0100.png" width="25px" height="25px"> 11,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0300.png" width="25px" height="25px"> 33,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0500.png" width="25px" height="25px"> 55,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_1000.png" width="25px" height="25px"> 110,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_2000.png" width="25px" height="25px"> 220,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_3000.png" width="25px" height="25px"> 330,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_5000.png" width="25px" height="25px"> 550,000원</th>
                <th style="background-color: white; border-bottom: hidden; border-top: hidden;"></th>
                <th rowspan="2"></th>
                <th colspan="2">총계</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_1.png" width="25px" height="25px"> 3,900원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_2.png" width="25px" height="25px"> 26,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_3.png" width="25px" height="25px"> 39,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_4.png" width="25px" height="25px"> 65,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_5.png" width="25px" height="25px"> 169,000원</th>
                <th colspan="2"><img src="https://image.dalbitlive.com/store/store_6.png" width="25px" height="25px"> 299,000원</th>
            </tr>
            <tr>
                <th>건<br/>(비율)</th>
                <th>금액<br/>(비율)</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th style="background-color: white; border-bottom: hidden; border-top: hidden;"></th>
                <th>건<br/>(비율)</th>
                <th>금액<br/>(비율)</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
                <th>건</th>
                <th>금액</th>
            </tr>
            </thead>
            <tbody id="codeTableBody"></tbody>
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
        getPayCodeList ();
    });

    function getPayCodeList (){
        util.getAjaxData("code", "/rest/enter/pay/code", $("#searchForm").serialize(), fn_codePay_success);
    }

    function fn_codePay_success(data, response){
        var sum_android_total_cnt = [
            response.data.totalInfo.sum_code01Cnt,
            response.data.totalInfo.sum_code02Cnt,
            response.data.totalInfo.sum_code03Cnt,
            response.data.totalInfo.sum_code04Cnt,
            response.data.totalInfo.sum_code05Cnt,
            response.data.totalInfo.sum_code06Cnt,
            response.data.totalInfo.sum_code13Cnt,
            response.data.totalInfo.sum_code14Cnt,
            response.data.totalInfo.sum_code15Cnt,
        ];
        var sum_android_total_amt = [
            response.data.totalInfo.sum_code01Amt,
            response.data.totalInfo.sum_code02Amt,
            response.data.totalInfo.sum_code03Amt,
            response.data.totalInfo.sum_code04Amt,
            response.data.totalInfo.sum_code05Amt,
            response.data.totalInfo.sum_code06Amt,
            response.data.totalInfo.sum_code13Amt,
            response.data.totalInfo.sum_code14Amt,
            response.data.totalInfo.sum_code15Amt,
        ];
        response.data.totalInfo["sum_android_total_cnt"] = common.getListSum(sum_android_total_cnt);
        response.data.totalInfo["sum_android_total_amt"] = common.getListSum(sum_android_total_amt);

        var sum_ios_total_cnt = [
            response.data.totalInfo.sum_code07Cnt,
            response.data.totalInfo.sum_code08Cnt,
            response.data.totalInfo.sum_code09Cnt,
            response.data.totalInfo.sum_code10Cnt,
            response.data.totalInfo.sum_code11Cnt,
            response.data.totalInfo.sum_code12Cnt,
        ];
        var sum_ios_total_amt = [
            response.data.totalInfo.sum_code07Amt,
            response.data.totalInfo.sum_code08Amt,
            response.data.totalInfo.sum_code09Amt,
            response.data.totalInfo.sum_code10Amt,
            response.data.totalInfo.sum_code11Amt,
            response.data.totalInfo.sum_code12Amt,
        ];
        response.data.totalInfo["sum_ios_total_cnt"] = common.getListSum(sum_ios_total_cnt);
        response.data.totalInfo["sum_ios_total_amt"] = common.getListSum(sum_ios_total_amt);

        // WEB/안드로이드 총 계/합
        for(var i=0;i<response.data.detailList.length;i++){
            var android_total_cnt = [
                response.data.detailList[i].code01Cnt,
                response.data.detailList[i].code02Cnt,
                response.data.detailList[i].code03Cnt,
                response.data.detailList[i].code04Cnt,
                response.data.detailList[i].code05Cnt,
                response.data.detailList[i].code06Cnt,
                response.data.detailList[i].code13Cnt,
                response.data.detailList[i].code14Cnt,
                response.data.detailList[i].code15Cnt,
            ];
            var android_total_amt = [
                response.data.detailList[i].code01Amt,
                response.data.detailList[i].code02Amt,
                response.data.detailList[i].code03Amt,
                response.data.detailList[i].code04Amt,
                response.data.detailList[i].code05Amt,
                response.data.detailList[i].code06Amt,
                response.data.detailList[i].code13Amt,
                response.data.detailList[i].code14Amt,
                response.data.detailList[i].code15Amt,
            ];
            response.data.detailList[i]["android_total_cnt"] = common.getListSum(android_total_cnt);
            response.data.detailList[i]["android_total_amt"] = common.getListSum(android_total_amt);
            response.data.detailList[i]["sum_android_total_cnt"] = common.getListSum(sum_android_total_cnt);
            response.data.detailList[i]["sum_android_total_amt"] = common.getListSum(sum_android_total_amt);

            // IOS 총 계/합
            var ios_total_cnt = [
                response.data.detailList[i].code07Cnt,
                response.data.detailList[i].code08Cnt,
                response.data.detailList[i].code09Cnt,
                response.data.detailList[i].code10Cnt,
                response.data.detailList[i].code11Cnt,
                response.data.detailList[i].code12Cnt,
            ];
            var ios_total_amt = [
                response.data.detailList[i].code07Amt,
                response.data.detailList[i].code08Amt,
                response.data.detailList[i].code09Amt,
                response.data.detailList[i].code10Amt,
                response.data.detailList[i].code11Amt,
                response.data.detailList[i].code12Amt,
            ];
            response.data.detailList[i]["ios_total_cnt"] = common.getListSum(ios_total_cnt);
            response.data.detailList[i]["ios_total_amt"] = common.getListSum(ios_total_amt);
            response.data.detailList[i]["sum_ios_total_cnt"] = common.getListSum(sum_ios_total_cnt);
            response.data.detailList[i]["sum_ios_total_amt"] = common.getListSum(sum_ios_total_amt);
        }

        var isDataEmpty = response.data.detailList == null;
        $("#codeTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_code').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#codeTableBody").append(totalHtml);

            response.data.detailList.slctType = $('input[name="slctType"]:checked').val();
        }

        var template = $('#tmp_codeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#codeTableBody").append(html);

        if(isDataEmpty){
            $("#codeTableBody td:last").remove();
        }else{
            $("#codeTableBody").append(totalHtml);
        }
    }
</script>
<script type="text/x-handlebars-template" id="tmp_code">
    <tr class="success font-bold">
        <td>소계</td>
        <td style="color:red;font-weight: bold;color: #ff5600">{{addComma sum_android_total_cnt}}<br/>({{average sum_android_total_cnt sum_android_total_cnt}}%)</td>
        <td style="color:red;font-weight: bold;color: #ff5600">{{vatMinus sum_android_total_amt}}<br/>({{average sum_android_total_amt sum_android_total_amt}}%)</td>
        <td>{{addComma sum_code13Cnt}}</td>
        <td>{{vatMinus sum_code13Amt}}</td>
        <td>{{addComma sum_code01Cnt}}</td>
        <td>{{vatMinus sum_code01Amt}}</td>
        <td>{{addComma sum_code02Cnt}}</td>
        <td>{{vatMinus sum_code02Amt}}</td>
        <td>{{addComma sum_code14Cnt}}</td>
        <td>{{vatMinus sum_code14Amt}}</td>
        <td>{{addComma sum_code03Cnt}}</td>
        <td>{{vatMinus sum_code03Amt}}</td>
        <td>{{addComma sum_code04Cnt}}</td>
        <td>{{vatMinus sum_code04Amt}}</td>
        <td>{{addComma sum_code05Cnt}}</td>
        <td>{{vatMinus sum_code05Amt}}</td>
        <td>{{addComma sum_code06Cnt}}</td>
        <td>{{vatMinus sum_code06Amt}}</td>
        <td>{{addComma sum_code15Cnt}}</td>
        <td>{{vatMinus sum_code15Amt}}</td>
        <td style="background-color: white; border-bottom: hidden; border-top: hidden;"></td>
        <td>소계</td>
        <td style="color:#ff5600;font-weight: bold">{{addComma sum_ios_total_cnt}}<br/>({{average sum_ios_total_cnt sum_ios_total_cnt}}%)</td>
        <td style="color:#ff5600;font-weight: bold">{{vatMinus sum_ios_total_amt}}<br/>({{average sum_ios_total_amt sum_ios_total_amt}}%)</td>
        <td>{{addComma sum_code07Cnt}}</td>
        <td>{{vatMinus sum_code07Amt}}</td>
        <td>{{addComma sum_code08Cnt}}</td>
        <td>{{vatMinus sum_code08Amt}}</td>
        <td>{{addComma sum_code09Cnt}}</td>
        <td>{{vatMinus sum_code09Amt}}</td>
        <td>{{addComma sum_code10Cnt}}</td>
        <td>{{vatMinus sum_code10Amt}}</td>
        <td>{{addComma sum_code11Cnt}}</td>
        <td>{{vatMinus sum_code11Amt}}</td>
        <td>{{addComma sum_code12Cnt}}</td>
        <td>{{vatMinus sum_code12Amt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_codeDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{substr data.daily 8}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma android_total_cnt}}<br/>({{average android_total_cnt sum_android_total_cnt}}%)</td>
        <td style="font-weight: bold">{{vatMinus android_total_amt}}<br/>({{average android_total_amt sum_android_total_amt}}%)</td>
        <td>{{addComma code13Cnt}}</td>
        <td>{{vatMinus code13Amt}}</td>
        <td>{{addComma code01Cnt}}</td>
        <td>{{vatMinus code01Amt}}</td>
        <td>{{addComma code02Cnt}}</td>
        <td>{{vatMinus code02Amt}}</td>
        <td>{{addComma code14Cnt}}</td>
        <td>{{vatMinus code14Amt}}</td>
        <td>{{addComma code03Cnt}}</td>
        <td>{{vatMinus code03Amt}}</td>
        <td>{{addComma code04Cnt}}</td>
        <td>{{vatMinus code04Amt}}</td>
        <td>{{addComma code05Cnt}}</td>
        <td>{{vatMinus code05Amt}}</td>
        <td>{{addComma code06Cnt}}</td>
        <td>{{vatMinus code06Amt}}</td>
        <td>{{addComma code15Cnt}}</td>
        <td>{{vatMinus code15Amt}}</td>
        <td style="background-color: white; border-bottom: hidden; border-top: hidden;"></td>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{substr data.daily 8}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma ios_total_cnt}}<br/>({{average ios_total_cnt sum_ios_total_cnt}}%)</td>
        <td style="font-weight: bold">{{vatMinus ios_total_amt}}<br/>({{average ios_total_amt sum_ios_total_amt}}%)</td>
        <td>{{addComma code07Cnt}}</td>
        <td>{{vatMinus code07Amt}}</td>
        <td>{{addComma code08Cnt}}</td>
        <td>{{vatMinus code08Amt}}</td>
        <td>{{addComma code09Cnt}}</td>
        <td>{{vatMinus code09Amt}}</td>
        <td>{{addComma code10Cnt}}</td>
        <td>{{vatMinus code10Amt}}</td>
        <td>{{addComma code11Cnt}}</td>
        <td>{{vatMinus code11Amt}}</td>
        <td>{{addComma code12Cnt}}</td>
        <td>{{vatMinus code12Amt}}</td>
    </tr>
    {{else}}
    <td colspan="11" class="noData">{{isEmptyData}}<td>
        {{/each}}
</script>