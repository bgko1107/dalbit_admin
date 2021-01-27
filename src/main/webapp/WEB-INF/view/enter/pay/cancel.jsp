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
    <div class="widget-content mt10" id="div_canselY">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <br/>
        <label id="payPlatformArea" onchange="sel_change_pay_cancel();"></label>
        <label id="payWayArea" onchange="sel_change_pay_cancel();"></label>
        <label id="payInnerArea" onchange="sel_change_pay_cancel();" style="border: 1px solid #632beb"></label>

        <div class="pull-right mb5" style="width: 227px">
            <span id="pay_cancel_summaryArea"></span>
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

<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var dtList_info_cancel;

    var tmp_ostype_cansel = -1;
    var tmp_innerType_cansel = 0;
    var tmp_payWay_cansel = "all";

    function getPayCancelList() {
        var sDate;
        var eDate;
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
        var dtList_info_data = function(data) {
            data.searchText = "";                        // 검색명
            data.sDate = sDate;
            data.eDate = eDate;
            if( $('input[name="slctType"]:checked').val() == 0){
                data.period = 4;
            }else{
                data.period = 0;
            }

            data.ostype = tmp_ostype_cansel;
            data.searchPayStatus = 2;
            data.innerType = tmp_innerType_cansel;
            data.payWay = tmp_payWay_cansel;
            data.memberDataType = 99;
            data.slctType = -1;
        };
        dtList_info_cancel = new DalbitDataTable($("#div_canselY").find("#list_info"), dtList_info_data, payDataTableSource.payHistory_cancel);
        dtList_info_cancel.useCheckBox(false);
        dtList_info_cancel.useIndex(true);
        dtList_info_cancel.setPageLength(50);
        dtList_info_cancel.createDataTable(pay_cancel_listSummary);
        dtList_info_cancel.reload();

        $("#div_canselY").find("#payPlatformArea").html(util.getCommonCodeSelect('-1', payPlatform));
        $("#div_canselY").find("#payWayArea").html(util.getCommonCodeSelect('all', payWay));
        $("#div_canselY").find("#payInnerArea").html(util.getCommonCodeSelect('0', innerType));
    }

    function pay_cancel_listSummary(json){
        console.log(json);
        var template = $("#pay_cancel_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#pay_cancel_summaryArea").html(html);
    }

    function sel_change_pay_cancel(){
        tmp_ostype_cansel = $("#div_canselY").find("select[name='ostype']").val();
        tmp_innerType_cansel= $("#div_canselY").find("select[name='innerType']").val();
        tmp_payWay_cansel = $("#div_canselY").find("select[name='payWay']").val();
        dtList_info_cancel.reload(pay_cancel_listSummary);
    }

    /*=============엑셀==================*/
    $('#excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("searchText", "");
        if( $('input[name="slctType"]:checked').val() == 0){
            formData.append("period", 4);
            formData.append("sDate", sDate);
        }else{
            formData.append("period", 0);
            formData.append("sDate", sDate);
            formData.append("eDate", eDate);
        }
        formData.append("ostype", $("#div_canselY").find("select[name='ostype']").val());
        formData.append("searchPayStatus", -1);
        formData.append("innerType", $("#div_canselY").find("select[name='innerType']").val());
        formData.append("payWay", $("#div_canselY").find("select[name='payWay']").val());
        formData.append("memberDataType", 99);
        util.excelDownload($(this), "/rest/payment/pay/listExcel", formData, fn_excelSuccess, fn_excelFail);

    });

    function fn_excelSuccess(){
        alert("다운로드 완료");
    }
    function fn_excelFail(){
        alert("다운로드 실패");
    }

</script>

<script id="pay_cancel_tableSummary" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin" style="margin-right:0px">
        <colgroup>
            <col width="35%"/><col width="65%"/>
        </colgroup>
        <tr>
            <th colspan="2">결제 취소(부가세 포함)</th>
        </tr>
        <tr class="font-bold" style="color: #66a449;">
            <td>{{addComma content.totalPayCancelCnt}}건</td>
            <td>{{addComma content.totalPayCancelAmt}}원</td>
        </tr>
        <tr>
            <th colspan="2">결제 취소(부가세 제외)</th>
        </tr>
        <tr class="font-bold" style="color: #ff5600;">
            <td>{{addComma content.totalPayCancelCnt}}건</td>
            <td>{{vatMinus content.totalPayCancelAmt}}원</td>
        </tr>
    </table>
</script>