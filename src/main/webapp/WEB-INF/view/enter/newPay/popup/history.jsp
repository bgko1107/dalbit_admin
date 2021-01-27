<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_sDate = request.getParameter("sDate");
    String in_eDate = request.getParameter("eDate");
    String in_gender = request.getParameter("gender");
    String in_time = request.getParameter("time");
    String in_age = request.getParameter("age");
%>

<!-- 결제/환불 > 결제내역 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="div_payY">
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
    var dtList_info;

    var tmp_ostype = -1;
    var tmp_innerType = 0;
    var tmp_payWay = "all";
    var sDate = '<%=in_sDate%>';
    var eDate = '<%=in_eDate%>';
    var gender = '<%=in_gender%>';
    var time = '<%=in_time%>';
    var age = '<%=in_age%>';

    getPayHistoryList();
    function getPayHistoryList() {
        var dtList_info_data = function(data) {
            data.searchText = $('#txt_search').val();                        // 검색명
            data.sDate = sDate;
            data.eDate = eDate;
            data.ostype = tmp_ostype;
            data.searchPayStatus = 1;
            data.innerType = tmp_innerType;
            data.payWay = tmp_payWay;
            data.genderStr = (gender == "undefined" ? "null" : gender);
            data.timeStr = (time == "undefined" ? "null" :  common.lpad(time,2,"0"));
            data.ageStr = (age == "undefined" ? "null" : age);
            data.success = "Y";
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
        formData.append("ostype", $("#div_payY").find("select[name='ostype']").val());
        formData.append("searchPayStatus", -1);
        formData.append("innerType", $("#div_payY").find("select[name='innerType']").val());
        formData.append("payWay", $("#div_payY").find("select[name='payWay']").val());
        formData.append("gender", gender);
        formData.append("time", time);
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