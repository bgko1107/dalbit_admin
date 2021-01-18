<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divDalbitSales">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유저</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유형</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">DJ</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">별</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">선수금(P)</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">미지급</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">매출액(S)</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료(Q)</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료(Q)</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">합계</th>
            </tr>
            </thead>
            <tbody id="dalbitSalesTableBody"></tbody>
        </table>
    </div>
</div>
<a type='button' class="btn btn-default print-btn pull-left dalbitSalesExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalbitSales', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>
<a type='button' class="btn btn-default print-btn pull-right dalbitSalesExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalbitSales', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">

    function getDalbitSalesList(){
        $(".dalbitSalesExcel").attr('download' , "달빛Live_수익인식Process(달매출)_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("dalbitSales", "/rest/enter/pay/dal/sales", data, fn_dalbitSales_success);
    }

    function fn_dalbitSales_success(data, response){
        $("#dalbitSalesTableBody").empty();

        response.data.detailList.slctType = slctType;
        var template = $('#tmp_dalbitSalesDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#dalbitSalesTableBody").append(html);

        ui.tableHeightSet();
    }
    function dateClick(data){
        var popupUrl = "/administrate/revenueProcess/popup/dalAmt?startDate=" + encodeURIComponent(data.thedate);
        util.windowOpen(popupUrl,"1914","968","달 정보 데이터");
    }
</script>

<script type="text/x-handlebars-template" id="tmp_dalbitSalesDetailList">
    {{#each this as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}({{memAge}})
        </td>
        <td>
            {{#dalbit_if slctType '==' 1}}
                방송
            {{else}}
                {{#dalbit_if slctType '==' 2}}
                    클립
                {{else}}
                    우체통
                {{/dalbit_if}}
            {{/dalbit_if}}

        </td>
        <td>
            {{#dalbit_if memType '==' 0}}
                일반
            {{else}}
                스페셜
            {{/dalbit_if}}
        </td>
        <td>{{addComma payDal 'Y'}}</td>
        <td>{{addComma freeDal 'Y'}}</td>
        <td>{{addComma totalDal 'Y'}}</td>
        <td>{{addComma totalByeol 'Y'}}</td>
        <td>{{addComma firstAmt 'Y'}}</td>
        <td>{{addComma unpaidAmt 'Y'}}</td>
        <td>{{addComma salesAmt 'Y'}}</td>
    </tr>
    {{/each}}
</script>