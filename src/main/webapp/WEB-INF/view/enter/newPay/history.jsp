<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!-- 결제/환불 > 결제내역 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="div_payY">
        <div class="row form-inline" id="divHisroty">
            <div class="widget widget-table mb10">
                <div class="widget-header">
                    <h3><i class="fa fa-table"></i> 결제통계 현황</h3>
                    <%--<div class="btn-group widget-header-toolbar">--%>
                    <%--<a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand" onclick="slid();"><i class="fa fa-chevron-up" id="chevron"></i></a>--%>
                    <%--</div>--%>
                </div>
                <div id="div_top">
                    <div class="mt5 col-md-10 no-padding mr10" id="statPayTableBody1"></div>
                    <div class="mt5 col-md-2 no-padding mr10" style="width: 230px" id="PayTotalTableBody"></div>
                    <div class="mt5 col-md-12 no-padding" id="statPayTableBody2"></div>
                    <div class="mt5 col-md-12 no-padding" id="statPayTableBody3"></div>
                    <div class="mt5 col-md-12 no-padding" id="statPayTableBody4"></div>
                </div>
            </div>
        </div>
        <a id='historyExcel' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divHisroty', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

        <div class="top-left pull-left dataTable-div col-md-6 no-padding">
            <span class="_searchDate"></span><br/>
            <label id="payPlatformArea" onchange="sel_change_pay();"></label>
            <label id="payWayArea" onchange="sel_change_pay();"></label>
            <label id="payInnerArea" onchange="sel_change_pay();" style="border: 1px solid #632beb"></label>
        </div>

        <div class="col-md-4 no-padding pull-right mb5">
            <div class="no-padding pull-right" style="width: 227px">
                <span id="pay_summaryArea2"></span>
            </div>
            <div class="no-padding mr10 pull-right" style="width: 227px">
                <span id="pay_summaryArea"></span>
            </div>
        </div>

        <table class="table table-bordered" id="list_info">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
        </span>
    </div>
</div>

<script src="/js/lib/excellentexport.js"></script>
<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var dtList_info;

    var tmp_ostype = -1;
    var tmp_innerType = 0;
    var tmp_payWay = "all";

    function getStatPayInfo(){
        $("#historyExcel").attr('download' , "결제현황_일간결제_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {};
        data.slctType = 1;
        data.startDate = $("#startDate").val();
        data.endDate = $("#endDate").val();
        util.getAjaxData("statPayInfo", "/rest/enter/pay/info", data, fn_statPayInfo_success1);
    }
    function fn_statPayInfo_success1(data, response){
        $("#statPayTableBody1").empty();
        $("#statPayTableBody2").empty();
        $("#statPayTableBody3").empty();
        $("#statPayTableBody4").empty();
        $("#PayTotalTableBody").empty();

        // WEB/안드로이드 총 계/합
        var android_total_cnt = [
            response.data.info.code01_cnt,
            response.data.info.code02_cnt,
            response.data.info.code03_cnt,
            response.data.info.code04_cnt,
            response.data.info.code05_cnt,
            response.data.info.code06_cnt,
            response.data.info.code13_cnt,
            response.data.info.code14_cnt,
            response.data.info.code15_cnt,
            response.data.info.code23_cnt,
        ];
        var android_total_amt = [
            response.data.info.code01_amt,
            response.data.info.code02_amt,
            response.data.info.code03_amt,
            response.data.info.code04_amt,
            response.data.info.code05_amt,
            response.data.info.code06_amt,
            response.data.info.code13_amt,
            response.data.info.code14_amt,
            response.data.info.code15_amt,
            response.data.info.code23_amt,
        ];
        var android_total_cmt = [
            response.data.info.code01_cmt,
            response.data.info.code02_cmt,
            response.data.info.code03_cmt,
            response.data.info.code04_cmt,
            response.data.info.code05_cmt,
            response.data.info.code06_cmt,
            response.data.info.code13_cmt,
            response.data.info.code14_cmt,
            response.data.info.code15_cmt,
            response.data.info.code23_cmt,
        ];
        response.data.info["android_total_cnt"] = common.getListSum(android_total_cnt);
        response.data.info["android_total_amt"] = common.getListSum(android_total_amt);
        response.data.info["android_total_cmt"] = common.getListSum(android_total_cmt);

        // IOS 총 계/합
        var ios_total_cnt = [
            response.data.info.code07_cnt,
            response.data.info.code08_cnt,
            response.data.info.code09_cnt,
            response.data.info.code10_cnt,
            response.data.info.code11_cnt,
            response.data.info.code12_cnt,
            response.data.info.code16_cnt,
            response.data.info.code17_cnt,
            response.data.info.code18_cnt,
            response.data.info.code19_cnt,
            response.data.info.code20_cnt,
            response.data.info.code21_cnt,
            response.data.info.code22_cnt,
        ];
        var ios_total_amt = [
            response.data.info.code07_amt,
            response.data.info.code08_amt,
            response.data.info.code09_amt,
            response.data.info.code10_amt,
            response.data.info.code11_amt,
            response.data.info.code12_amt,
            response.data.info.code16_amt,
            response.data.info.code17_amt,
            response.data.info.code18_amt,
            response.data.info.code19_amt,
            response.data.info.code20_amt,
            response.data.info.code21_amt,
            response.data.info.code22_amt,
        ];
        var ios_total_cmt = [
            response.data.info.code07_cmt,
            response.data.info.code08_cmt,
            response.data.info.code09_cmt,
            response.data.info.code10_cmt,
            response.data.info.code11_cmt,
            response.data.info.code12_cmt,
            response.data.info.code16_cmt,
            response.data.info.code17_cmt,
            response.data.info.code18_cmt,
            response.data.info.code19_cmt,
            response.data.info.code20_cmt,
            response.data.info.code21_cmt,
            response.data.info.code22_cmt,
        ];
        response.data.info["ios_total_cnt"] = common.getListSum(ios_total_cnt);
        response.data.info["ios_total_amt"] = common.getListSum(ios_total_amt);
        response.data.info["ios_total_cmt"] = common.getListSum(ios_total_cmt);

        var template = $('#tmp_payTableSummary1').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.info;
        var html=templateScript(context);
        $("#statPayTableBody1").append(html);

        var template = $('#tmp_payTableSummary2').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.info;
        var html=templateScript(context);
        $("#statPayTableBody2").append(html);

        var template = $('#tmp_payTableSummary3').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.info;
        var html=templateScript(context);
        $("#statPayTableBody3").append(html);

        var template = $('#tmp_payTotalTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.info;
        var html=templateScript(context);
        $("#PayTotalTableBody").append(html);

        var template = $('#tmp_payTableSummary4').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.info;
        var html=templateScript(context);
        $("#statPayTableBody4").append(html);

        ui.paintColor();
        ui.tableHeightSet();
        getPayHistoryList();
    }


    var sDate;
    var eDate;
    function getPayHistoryList() {
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
        var dtList_info_data = function(data) {
            data.searchText = $('#txt_search').val();                        // 검색명
            data.sDate = sDate;
            data.eDate = eDate;
            data.ostype = tmp_ostype;
            data.searchPayStatus = 1;
            data.innerType = tmp_innerType;
            data.payWay = tmp_payWay ;
            data.memberDataType = 99;
            data.slctType = -1;
        };
        dtList_info = new DalbitDataTable($("#div_payY").find("#list_info"), dtList_info_data, payDataTableSource.payHistory);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable();

        $("#div_payY").find("#payPlatformArea").html(util.getCommonCodeSelect('-1', payPlatform));
        $("#div_payY").find("#payInnerArea").html(util.getCommonCodeSelect('0', innerType));
        $("#div_payY").find("#payWayArea").html(util.getCommonCodeSelect('all', payWay));
    }

    function sel_change_pay(){
        tmp_ostype = $("#div_payY").find("select[name='ostype']").val();
        tmp_innerType = $("#div_payY").find("select[name='innerType']").val();
        tmp_payWay = $("#div_payY").find("select[name='payWay']").val();
        dtList_info.reload();
    }

    /*=============엑셀==================*/
    $('#excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("searchText", "");
        formData.append("period", 0);
        formData.append("sDate", sDate);
        formData.append("eDate", eDate);
        formData.append("ostype", -1);
        formData.append("searchPayStatus", -1);
        formData.append("innerType", -1);
        formData.append("payWay", "all");
        formData.append("memberDataType", 99);
        util.excelDownload($(this), "/rest/payment/pay/listExcel", formData, fn_excelSuccess, fn_excelFail);

    });

    function fn_excelSuccess(data){
        alert("다운로드 완료   " + data);
    }
    function fn_excelFail(data){
        alert("다운로드 실패   " + data);
    }

    function click_way(){
        $("#tablist_con li:eq(7) a").tab("show");   // 수단
        getPayWayList();
    }
    function click_age(){
        $("#tablist_con li:eq(6) a").tab("show");   // 회원별
        getPayAgeList();
    }
    function click_code(){
        $("#tablist_con li:eq(8) a").tab("show");   // 상품별
        getPayCodeList();
    }

    function click_popupGender(tmp){
        var popupUrl = "/enter/newPay/popup/history?sDate=" + sDate + "&eDate=" + eDate + "&gender=" + tmp + "&time=null&age=null";
        util.windowOpen(popupUrl,"1550","885","결제목록");
    }
    function click_popupAge(tmp){
        var popupUrl = "/enter/newPay/popup/history?sDate=" + sDate + "&eDate=" + eDate + "&gender=null&time=null&age=" + tmp;
        util.windowOpen(popupUrl,"1550","885","결제목록");
    }

</script>


<script id="tmp_payTableSummary1" type="text/x-handlebars-template">
    <table class="table table-bordered mb0 _tableHeight" data-height="23px">
        <colgroup>
            <col width="7.4%"/><col width="7.1%"/><col width="7.1%"/><col width="7.1%"/><col width="7.1%"/>
            <col width="7.1%"/><col width="7.1%"/><col width="7.1%"/><col width="7.1%"/><col width="7.1%"/>
            <col width="7.1%"/><col width="7.1%"/><col width="7.1%"/><col width="7.1%"/>
        </colgroup>
        <thead>
        <tr>
            <th class="_bgColor" data-bgcolor="#F1E7FB">
                <a href="javascript://" onclick="click_way();" class="_fontColor" data-fontcolor="black">◈ 결제 방법 별</a>
            </th>
            <th>휴대폰</th>
            <th>카드</th>
            <th>가상계좌이체</th>
            <th>인앱결제<br/>(아이폰)</th>
            <th>문화상품권</th>
            <th>해피머니상품권</th>
            <%--<th>스마트문상<br/>(게임)</th>--%>
            <%--<th>도서문화상품권</th>--%>
            <th>티머니</th>
            <th>캐시비</th>
            <th>페이코</th>
            <th>카카오페이(카드)</th>
            <th>카카오페이(머니)</th>
            <th style="color: green;font-weight: bold">총합</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th>결제 건 수</th>
            <td>{{addComma mc_cnt}}</td>
            <td>{{addComma cn_cnt}}</td>
            <td>{{addComma va_cnt}}</td>
            <td>{{addComma inapp_cnt}}</td>
            <td>{{addComma gm_cnt}}</td>
            <td>{{addComma hm_cnt}}</td>
            <%--<td>{{addComma gg_cnt}}</td>--%>
            <%--<td>{{addComma gc_cnt}}</td>--%>
            <td>{{addComma tmoney_cnt}}</td>
            <td>{{addComma cashbee_cnt}}</td>
            <td>{{addComma payco_cnt}}</td>
            <td>{{addComma kakaopay_cnt}}</td>
            <td>{{addComma kakaomoney_cnt}}</td>
            <td><b>{{addComma total_cnt}}</b></td>
        </tr>
        <tr>
            <th>결제수량</th>
            <td>{{addComma mc_cmt}}</td>
            <td>{{addComma cn_cmt}}</td>
            <td>{{addComma va_cmt}}</td>
            <td>{{addComma inapp_cmt}}</td>
            <td>{{addComma gm_cmt}}</td>
            <td>{{addComma hm_cmt}}</td>
            <%--<td>{{addComma gg_cmt}}</td>--%>
            <%--<td>{{addComma gc_cmt}}</td>--%>
            <td>{{addComma tmoney_cmt}}</td>
            <td>{{addComma cashbee_cmt}}</td>
            <td>{{addComma payco_cmt}}</td>
            <td>{{addComma kakaopay_cmt}}</td>
            <td>{{addComma kakaomoney_cmt}}</td>
            <td><b>{{addComma total_cmt}}</b></td>
        </tr>
        <tr  style="color: #66a449">
            <th>부가세 포함 금액</th>
            <td>{{addComma mc_amt}}</td>
            <td>{{addComma cn_amt}}</td>
            <td>{{addComma va_amt}}</td>
            <td>{{addComma inapp_amt}}</td>
            <td>{{addComma gm_amt}}</td>
            <td>{{addComma hm_amt}}</td>
            <%--<td>{{addComma gg_amt}}</td>--%>
            <%--<td>{{addComma gc_amt}}</td>--%>
            <td>{{addComma tmoney_amt}}</td>
            <td>{{addComma cashbee_amt}}</td>
            <td>{{addComma payco_amt}}</td>
            <td>{{addComma kakaopay_amt}}</td>
            <td>{{addComma kakaomoney_amt}}</td>
            <td><b>{{addComma total_amt}}</b></td>
        </tr>

        <tr style="color: #ff5600">
            <th><b>부가세 제외 금액</b></th>
            <td>{{vatMinus mc_amt}}</td>
            <td>{{vatMinus cn_amt}}</td>
            <td>{{vatMinus va_amt}}</td>
            <td>{{vatMinus inapp_amt}}</td>
            <td>{{vatMinus gm_amt}}</td>
            <td>{{vatMinus hm_amt}}</td>
            <%--<td>{{vatMinus gg_amt}}</td>--%>
            <%--<td>{{vatMinus gc_amt}}</td>--%>
            <td>{{vatMinus tmoney_amt}}</td>
            <td>{{vatMinus cashbee_amt}}</td>
            <td>{{vatMinus payco_amt}}</td>
            <td>{{vatMinus kakaopay_amt}}</td>
            <td>{{vatMinus kakaomoney_amt}}</td>
            <td><b>{{vatMinus total_amt}}</b></td>
        </tr>
        <tr>
            <th>결제 비율</th>
            <td>({{payRate mc_cnt total_cnt}}%)<br/><b>{{payRate mc_amt total_amt}}%</b></td>
            <td>({{payRate cn_cnt total_cnt}}%)<br/><b>{{payRate cn_amt total_amt}}%</b></td>
            <td>({{payRate va_cnt total_cnt}}%)<br/><b>{{payRate va_amt total_amt}}%</b></td>
            <td>({{payRate inapp_cnt total_cnt}}%)<br/><b>{{payRate inapp_amt total_amt}}%</b></td>
            <td>({{payRate gm_cnt total_cnt}}%)<br/><b>{{payRate gm_amt total_amt}}%</b></td>
            <td>({{payRate hm_cnt total_cnt}}%)<br/><b>{{payRate hm_amt total_amt}}%</b></td>
            <%--<td>({{payRate gg_cnt total_cnt}}%)<br/><b>{{payRate gg_amt total_amt}}%</b></td>--%>
            <%--<td>({{payRate gc_cnt total_cnt}}%)<br/><b>{{payRate gc_amt total_amt}}%</b></td>--%>
            <td>({{payRate tmoney_cnt total_cnt}}%)<br/><b>{{payRate tmoney_amt total_amt}}%</b></td>
            <td>({{payRate cashbee_cnt total_cnt}}%)<br/><b>{{payRate cashbee_amt total_amt}}%</b></td>
            <td>({{payRate payco_cnt total_cnt}}%)<br/><b>{{payRate payco_amt total_amt}}%</b></td>
            <td>({{payRate kakaopay_cnt total_cnt}}%)<br/><b>{{payRate kakaopay_amt total_amt}}%</b></td>
            <td>({{payRate kakaomoney_cnt total_cnt}}%)<br/><b>{{payRate kakaomoney_amt total_amt}}%</b></td>
            <td>({{payRate total_cnt total_cnt}}%)<br/><b>{{payRate total_amt total_amt}}%</b></td>
        </tr>
        </tbody>
    </table>
</script>

<script id="tmp_payTableSummary2" type="text/x-handlebars-template">
    <table class="table table-bordered mb0 _tableHeight" data-height="23px">
        <colgroup>
            <col width="9%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
            <col width="0.1%"/><col width="9%"/><col width="6%"/><col width="6%"/><col width="6%"/>
            <col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/><col width="8%"/>
        </colgroup>
        <thead>
        <tr>
            <th class="_bgColor" data-bgcolor="#F1E7FB">
                <a href="javascript://" onclick="click_age();" class="_fontColor" data-fontcolor="black">◈ 결제 성별</a>
            </th>
            <th class="_sex_male">{{{sexIcon 'm'}}}</th>
            <th class="_sex_female">{{{sexIcon 'f'}}}</th>
            <th>알수없음</th>
            <th>총 합</th>
            <th style="background-color: white; border-bottom: hidden; border-top: hidden;"></th>
            <th class="_bgColor" data-bgcolor="#F1E7FB">
                <a href="javascript://" onclick="click_age();" class="_fontColor" data-fontcolor="black">◈ 결제 연령대 별</a>
            </th>
            <th>미선택</th>
            <th>10대</th>
            <th>20대</th>
            <th>30대</th>
            <th>40대</th>
            <th>50대</th>
            <th>60대 이상</th>
            <th>총 합</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th>결제 건 수</th>
            <td onclick="click_popupGender('m')"><a href="javascript://"><span class="font-bold" style="color: blue">{{addComma male_cnt}}</span></a></td>
            <td onclick="click_popupGender('f')"><a href="javascript://"><span class="font-bold" style="color: red"> {{addComma female_cnt}}</span></a></td>
            <td onclick="click_popupGender('n')"><a href="javascript://"><span class="font-bold _fontColor" data-fontColor="#555">{{addComma none_cnt}}</span></a></td>
            <td><b>{{addComma total_cnt}}</b></td>
            <td></td>
            <th>결제 건 수</th>
            <td onclick="click_popupAge('00')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age00_cnt}}</span></a></td>
            <td onclick="click_popupAge('10')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age10_cnt}}</span></a></td>
            <td onclick="click_popupAge('20')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age20_cnt}}</span></a></td>
            <td onclick="click_popupAge('30')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age30_cnt}}</span></a></td>
            <td onclick="click_popupAge('40')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age40_cnt}}</span></a></td>
            <td onclick="click_popupAge('50')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age50_cnt}}</span></a></td>
            <td onclick="click_popupAge('60')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age60_cnt}}</span></a></td>
            <td><b>{{addComma total_cnt}}</b></td>
        </tr>
        <tr>
            <th>결제수량</th>
            <td onclick="click_popupGender('m')"><a href="javascript://"><span class="font-bold" style="color: blue">{{addComma male_cmt}}</span></a></td>
            <td onclick="click_popupGender('f')"><a href="javascript://"><span class="font-bold" style="color: red"> {{addComma female_cmt}}</span></a></td>
            <td onclick="click_popupGender('n')"><a href="javascript://"><span class="font-bold _fontColor" data-fontColor="#555">{{addComma none_cmt}}</span></a></td>
            <td><b>{{addComma total_cmt}}</b></td>
            <td></td>
            <th>결제수량</th>
            <td onclick="click_popupAge('00')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age00_cmt}}</span></a></td>
            <td onclick="click_popupAge('10')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age10_cmt}}</span></a></td>
            <td onclick="click_popupAge('20')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age20_cmt}}</span></a></td>
            <td onclick="click_popupAge('30')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age30_cmt}}</span></a></td>
            <td onclick="click_popupAge('40')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age40_cmt}}</span></a></td>
            <td onclick="click_popupAge('50')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age50_cmt}}</span></a></td>
            <td onclick="click_popupAge('60')"><a href="javascript://"><span class="_fontColor" data-fontcolor="#555">{{addComma age60_cmt}}</span></a></td>
            <td><b>{{addComma total_cmt}}</b></td>
        </tr>
        <tr style="color: #66a449;">
            <th>부가세 포함 금액</th>
            <td><label style="color: blue">{{addComma male_amt}}</label></td>
            <td><label style="color: red">{{addComma female_amt}}</label></td>
            <td>{{addComma none_amt}}</td>
            <td><b>{{addComma total_amt}}</b></td>
            <td style="border-bottom: hidden;border-top: hidden"></td>
            <th>부가세 포함 금액</th>
            <td>{{addComma age00_amt}}</td>
            <td>{{addComma age10_amt}}</td>
            <td>{{addComma age20_amt}}</td>
            <td>{{addComma age30_amt}}</td>
            <td>{{addComma age40_amt}}</td>
            <td>{{addComma age50_amt}}</td>
            <td>{{addComma age60_amt}}</td>
            <td><b>{{addComma total_amt}}</b></td>
        </tr>
        <tr style="color: #ff5600;">
            <th><b>부가세 제외 금액</b></th>
            <td style="color: blue;">{{vatMinus male_amt}}</td>
            <td style="color: red;">{{vatMinus female_amt}}</td>
            <td>{{vatMinus none_amt}}</td>
            <td><b>{{vatMinus total_amt}}</b></td>
            <td style="border-bottom: hidden;border-top: hidden"></td>
            <th>부가세 제외 금액</th>
            <td>{{vatMinus age00_amt}}</td>
            <td>{{vatMinus age10_amt}}</td>
            <td>{{vatMinus age20_amt}}</td>
            <td>{{vatMinus age30_amt}}</td>
            <td>{{vatMinus age40_amt}}</td>
            <td>{{vatMinus age50_amt}}</td>
            <td>{{vatMinus age60_amt}}</td>
            <td><b>{{vatMinus total_amt}}</b></td>
        </tr>
        <tr>
            <th>결제 비율</th>
            <td><label style="color: blue">({{payRate male_cnt total_cnt}}%)<br><b>{{payRate male_amt total_amt}}%</b></label></td>
            <td><label style="color: red">({{payRate female_cnt total_cnt}}%)<br><b>{{payRate female_amt total_amt}}%</b></label></td>
            <td>({{payRate none_cnt none_cnt}}%)<br><b>{{payRate none_amt total_amt}}%</b></td>
            <td>({{payRate total_cnt total_cnt}}%)<br><b>{{payRate total_amt total_amt}}%</b></td>
            <td style="border-bottom: hidden;border-top: hidden"></td>
            <th>결제 비율</th>
            <td>({{payRate age00_cnt total_cnt}}%)<br><b>{{payRate age00_amt total_amt}}%</b></td>
            <td>({{payRate age10_cnt total_cnt}}%)<br><b>{{payRate age10_amt total_amt}}%</b></td>
            <td>({{payRate age20_cnt total_cnt}}%)<br><b>{{payRate age20_amt total_amt}}%</b></td>
            <td>({{payRate age30_cnt total_cnt}}%)<br><b>{{payRate age30_amt total_amt}}%</b></td>
            <td>({{payRate age40_cnt total_cnt}}%)<br><b>{{payRate age40_amt total_amt}}%</b></td>
            <td>({{payRate age50_cnt total_cnt}}%)<br><b>{{payRate age50_amt total_amt}}%</b></td>
            <td>({{payRate age60_cnt total_cnt}}%)<br><b>{{payRate age60_amt total_amt}}%</b></td>
            <td>({{payRate total_cnt total_cnt}}%)<br><b>{{payRate total_amt total_amt}}%</b></td>
        </tr>
        </tbody>
    </table>
</script>


<script id="tmp_payTableSummary3" type="text/x-handlebars-template">
    <table class="table table-bordered mb0 _tableHeight" data-height="23px">
        <colgroup>
            <col width="14%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
            <col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
            <col width="7%"/><col width="7%"/>
        </colgroup>
        <tbody>
        <tr>
            <th class="_bgColor" data-bgcolor="#F1E7FB">
                <a href="javascript://" onclick="click_code();" class="_fontColor" data-fontcolor="black">◈ 아이템별 Web, 안드로이드</a>
            </th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0010.png" width="25px" height="25px"> 달 10</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0050.png" width="25px" height="25px"> 달 50</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0100.png" width="25px" height="25px"> 달 100</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0300.png" width="25px" height="25px"> 달 300</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0500.png" width="25px" height="25px"> 달 500</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_1000.png" width="25px" height="25px"> 달 1,000</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_2000.png" width="25px" height="25px"> 달 2,000<br/>(판매종료)</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_3000.png" width="25px" height="25px"> 달 3,000</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_5000.png" width="25px" height="25px"> 달 5,000</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_5000.png" width="25px" height="25px"> 달 11,000</th>
            <th>총합</th>
        </tr>
        <tr>
            <th>결제 건 수</th>
            <td>{{addComma code13_cnt}}</td>
            <td>{{addComma code01_cnt}}</td>
            <td>{{addComma code02_cnt}}</td>
            <td>{{addComma code14_cnt}}</td>
            <td>{{addComma code03_cnt}}</td>
            <td>{{addComma code04_cnt}}</td>
            <td>{{addComma code05_cnt}}</td>
            <td>{{addComma code06_cnt}}</td>
            <td>{{addComma code15_cnt}}</td>
            <td>{{addComma code23_cnt}}</td>
            <td><b>{{addComma android_total_cnt}}</b></td>
        </tr>
        <tr>
            <th>결제수량</th>
            <td>{{addComma code13_cmt}}</td>
            <td>{{addComma code01_cmt}}</td>
            <td>{{addComma code02_cmt}}</td>
            <td>{{addComma code14_cmt}}</td>
            <td>{{addComma code03_cmt}}</td>
            <td>{{addComma code04_cmt}}</td>
            <td>{{addComma code05_cmt}}</td>
            <td>{{addComma code06_cmt}}</td>
            <td>{{addComma code15_cmt}}</td>
            <td>{{addComma code23_cmt}}</td>
            <td><b>{{addComma android_total_cmt}}</b></td>
        </tr>
        <tr  style="color: #66a449;">
            <th>부가세 포함 금액</th>
            <td>{{addComma code13_amt}}</td>
            <td>{{addComma code01_amt}}</td>
            <td>{{addComma code02_amt}}</td>
            <td>{{addComma code14_amt}}</td>
            <td>{{addComma code03_amt}}</td>
            <td>{{addComma code04_amt}}</td>
            <td>{{addComma code05_amt}}</td>
            <td>{{addComma code06_amt}}</td>
            <td>{{addComma code15_amt}}</td>
            <td>{{addComma code23_amt}}</td>
            <td><b>{{addComma android_total_amt}}</b></td>
        </tr>
        <tr style="color: #ff5600;">
            <th>부가세 제외 금액</th>
            <td>{{vatMinus code13_amt}}</td>
            <td>{{vatMinus code01_amt}}</td>
            <td>{{vatMinus code02_amt}}</td>
            <td>{{vatMinus code14_amt}}</td>
            <td>{{vatMinus code03_amt}}</td>
            <td>{{vatMinus code04_amt}}</td>
            <td>{{vatMinus code05_amt}}</td>
            <td>{{vatMinus code06_amt}}</td>
            <td>{{vatMinus code15_amt}}</td>
            <td>{{vatMinus code23_amt}}</td>
            <td><b>{{vatMinus android_total_amt}}</b></td>
        </tr>
        <tr>
            <th>결제 비율</th>
            <td>({{payRate code13_cnt android_total_cnt}}%)<br><b>{{payRate code13_amt android_total_amt}}%</b></td>
            <td>({{payRate code01_cnt android_total_cnt}}%)<br><b>{{payRate code01_amt android_total_amt}}%</b></td>
            <td>({{payRate code02_cnt android_total_cnt}}%)<br><b>{{payRate code02_amt android_total_amt}}%</b></td>
            <td>({{payRate code14_cnt android_total_cnt}}%)<br><b>{{payRate code14_amt android_total_amt}}%</b></td>
            <td>({{payRate code03_cnt android_total_cnt}}%)<br><b>{{payRate code03_amt android_total_amt}}%</b></td>
            <td>({{payRate code04_cnt android_total_cnt}}%)<br><b>{{payRate code04_amt android_total_amt}}%</b></td>
            <td>({{payRate code05_cnt android_total_cnt}}%)<br><b>{{payRate code05_amt android_total_amt}}%</b></td>
            <td>({{payRate code06_cnt android_total_cnt}}%)<br><b>{{payRate code06_amt android_total_amt}}%</b></td>
            <td>({{payRate code15_cnt android_total_cnt}}%)<br><b>{{payRate code15_amt android_total_amt}}%</b></td>
            <td>({{payRate code23_cnt android_total_cnt}}%)<br><b>{{payRate code23_amt android_total_amt}}%</b></td>
            <td>({{payRate android_total_cnt android_total_cnt}}%)<br><b>{{payRate android_total_amt android_total_amt}}%</b></td>
        </tr>
        </tbody>
    </table>
</script>

<script id="tmp_payTotalTable" type="text/x-handlebars-template">
    <table class="table table-bordered mb0 _tableHeight" data-height="23px">
        <colgroup>
            <col width="35%"/><col width="65%"/>
        </colgroup>
        <tr>
            <th colspan="2">총 결제 건/(부가세 제외) 매출</th>
        </tr>
        <tr style="color: #ff5600;">
            <td><b>{{total_cnt}} 건</b></td>
            <td><b>{{vatMinus total_amt}} 원</b></td>
        </tr>
        <tr>
            <th colspan="2">결제 취소(부가세 제외)</th>
        </tr>
        <tr class="font-bold" style="color: #ff5600;">
            <td>{{addComma cancelCnt}}건</td>
            <td>{{vatMinus cancelAmt}}원</td>
        </tr>
    </table>
</script>


<script id="tmp_payTableSummary4" type="text/x-handlebars-template">
    <table class="table table-bordered mb0 _tableHeight" data-height="23px" title="'(판매종료)'는 2020.07.10 이전 결제 아이템 입니다.">
        <colgroup>
            <col width="9%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
            <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
            <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
        </colgroup>
        <tbody>
        <tr>
            <th class="_bgColor" data-bgcolor="#F1E7FB">
                <a href="javascript://" onclick="click_code();" class="_fontColor" data-fontcolor="black">◈ 아이템별 아이폰</a>
            </th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0010.png" width="25px" height="25px"> 달 9</th>
            <th><img src="https://image.dalbitlive.com/store/store_1.png" width="25px" height="25px"> 달 30<br/>(판매종료)</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0050.png" width="25px" height="25px"> 달 45</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_0100.png" width="25px" height="25px"> 달 92</th>
            <th><img src="https://image.dalbitlive.com/store/store_3.png" width="25px" height="25px"> 달 200</th>
            <th><img src="https://image.dalbitlive.com/store/store_3.png" width="25px" height="25px"> 달 300<br/>(판매종료)</th>
            <th><img src="https://image.dalbitlive.com/store/store_4.png" width="25px" height="25px"> 달 500</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_1000.png" width="25px" height="25px"> 달 838</th>
            <th><img src="https://image.dalbitlive.com/store/store_5.png" width="25px" height="25px"> 달 1030<br/>(판매종료)</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_2000.png" width="25px" height="25px"> 달 1,530</th>
            <th><img src="https://image.dalbitlive.com/store/store_6.png" width="25px" height="25px"> 달 2,080<br/>(판매종료)</th>
            <th><img src="https://image.dalbitlive.com/store/store_6.png" width="25px" height="25px"> 달 2,300</th>
            <th><img src="https://image.dalbitlive.com/store/charge/200612/charge_item_5000.png" width="25px" height="25px"> 달 3,770</th>
            <th>총합</th>
        </tr>
        <tr>
            <th>결제 건 수</th>
            <td>{{addComma code16_cnt}}</td>
            <td>{{addComma code07_cnt}}</td>
            <td>{{addComma code17_cnt}}</td>
            <td>{{addComma code18_cnt}}</td>
            <td>{{addComma code08_cnt}}</td>
            <td>{{addComma code09_cnt}}</td>
            <td>{{addComma code10_cnt}}</td>
            <td>{{addComma code19_cnt}}</td>
            <td>{{addComma code11_cnt}}</td>
            <td>{{addComma code20_cnt}}</td>
            <td>{{addComma code12_cnt}}</td>
            <td>{{addComma code21_cnt}}</td>
            <td>{{addComma code22_cnt}}</td>
            <td><b>{{addComma ios_total_cnt}}</b></td>
        </tr>
        <tr>
            <th>결제 수량</th>
            <td>{{addComma code16_cmt}}</td>
            <td>{{addComma code07_cmt}}</td>
            <td>{{addComma code17_cmt}}</td>
            <td>{{addComma code18_cmt}}</td>
            <td>{{addComma code08_cmt}}</td>
            <td>{{addComma code09_cmt}}</td>
            <td>{{addComma code10_cmt}}</td>
            <td>{{addComma code19_cmt}}</td>
            <td>{{addComma code11_cmt}}</td>
            <td>{{addComma code20_cmt}}</td>
            <td>{{addComma code12_cmt}}</td>
            <td>{{addComma code21_cmt}}</td>
            <td>{{addComma code22_cmt}}</td>
            <td><b>{{addComma ios_total_cmt}}</b></td>
        </tr>
        <tr  style="color: #66a449;">
            <th>부가세 포함 금액</th>
            <td>{{addComma code16_amt}}</td>
            <td>{{addComma code07_amt}}</td>
            <td>{{addComma code17_amt}}</td>
            <td>{{addComma code18_amt}}</td>
            <td>{{addComma code08_amt}}</td>
            <td>{{addComma code09_amt}}</td>
            <td>{{addComma code10_amt}}</td>
            <td>{{addComma code19_amt}}</td>
            <td>{{addComma code11_amt}}</td>
            <td>{{addComma code20_amt}}</td>
            <td>{{addComma code12_amt}}</td>
            <td>{{addComma code21_amt}}</td>
            <td>{{addComma code22_amt}}</td>
            <td><b>{{addComma ios_total_amt}}</b></td>
        </tr>
        <tr style="color: #ff5600;">
            <th>부가세 제외 금액</th>
            <td>{{vatMinus code16_amt}}</td>
            <td>{{vatMinus code07_amt}}</td>
            <td>{{vatMinus code17_amt}}</td>
            <td>{{vatMinus code18_amt}}</td>
            <td>{{vatMinus code08_amt}}</td>
            <td>{{vatMinus code09_amt}}</td>
            <td>{{vatMinus code10_amt}}</td>
            <td>{{vatMinus code19_amt}}</td>
            <td>{{vatMinus code11_amt}}</td>
            <td>{{vatMinus code20_amt}}</td>
            <td>{{vatMinus code12_amt}}</td>
            <td>{{vatMinus code21_amt}}</td>
            <td>{{vatMinus code22_amt}}</td>
            <td><b>{{vatMinus ios_total_amt}}</b></td>
        </tr>
        <tr>
            <th>결제 비율</th>
            <td>({{payRate code16_cnt ios_total_cnt}}%)<br><b>{{payRate code16_amt ios_total_amt}}%</b></td>
            <td>({{payRate code07_cnt ios_total_cnt}}%)<br><b>{{payRate code07_amt ios_total_amt}}%</b></td>
            <td>({{payRate code17_cnt ios_total_cnt}}%)<br><b>{{payRate code17_amt ios_total_amt}}%</b></td>
            <td>({{payRate code18_cnt ios_total_cnt}}%)<br><b>{{payRate code18_amt ios_total_amt}}%</b></td>
            <td>({{payRate code08_cnt ios_total_cnt}}%)<br><b>{{payRate code08_amt ios_total_amt}}%</b></td>
            <td>({{payRate code09_cnt ios_total_cnt}}%)<br><b>{{payRate code09_amt ios_total_amt}}%</b></td>
            <td>({{payRate code10_cnt ios_total_cnt}}%)<br><b>{{payRate code10_amt ios_total_amt}}%</b></td>
            <td>({{payRate code19_cnt ios_total_cnt}}%)<br><b>{{payRate code19_amt ios_total_amt}}%</b></td>
            <td>({{payRate code11_cnt ios_total_cnt}}%)<br><b>{{payRate code11_amt ios_total_amt}}%</b></td>
            <td>({{payRate code20_cnt ios_total_cnt}}%)<br><b>{{payRate code20_amt ios_total_amt}}%</b></td>
            <td>({{payRate code12_cnt ios_total_cnt}}%)<br><b>{{payRate code12_amt ios_total_amt}}%</b></td>
            <td>({{payRate code21_cnt ios_total_cnt}}%)<br><b>{{payRate code21_amt ios_total_amt}}%</b></td>
            <td>({{payRate code22_cnt ios_total_cnt}}%)<br><b>{{payRate code22_amt ios_total_amt}}%</b></td>
            <td>({{payRate ios_total_cnt ios_total_cnt}}%)<br><b>{{payRate ios_total_amt ios_total_amt}}%</b></td>
        </tr>
        </tbody>
    </table>
</script>

