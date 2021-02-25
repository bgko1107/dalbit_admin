<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divDalbitSalesRange">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">조회일자</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">구분</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">별</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">선수금</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">미지급</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">매출액</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">충당부채</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">합계</th>
            </tr>
            </thead>
            <tbody id="dalbitSalesRangeTableBody"></tbody>
        </table>
    </div>
</div>

<a type='button' class="btn btn-default print-btn pull-left dalbitSalesRangeExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalbitSalesRange', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>
<a type='button' class="btn btn-default print-btn pull-right dalbitSalesRangeExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalbitSalesRange', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">

    function getDalbitSalesRangeList(){
        $(".dalbitSalesRangeExcel").attr('download' , "달빛Live_수익인식Process(달 매출-기간)_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("dalbitSales", "/rest/enter/pay/dal/sales/range", data, fn_dalbitSalesRange_success);
    }

    function fn_dalbitSalesRange_success(data, response){
        $("#dalbitSalesRangeTableBody").empty();

        response.data.detailList.slctType = slctType;
        var template = $('#tmp_dalbitSalesRangeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#dalbitSalesRangeTableBody").append(html);

        rowspan('dalbitSalesRange');
        ui.tableHeightSet();
        ui.paintColor();
    }

    function rowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }

</script>

<script type="text/x-handlebars-template" id="tmp_dalbitSalesRangeDetailList">
    <%--<tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td></td>
        <td>{{addComma totalInfo.payDal}}</td>
        <td>{{addComma totalInfo.freeDal}}</td>
        <td>{{addComma totalInfo.totalDal}}</td>
        <td>{{addComma totalInfo.totalByeol}}</td>
        <td>{{addComma totalInfo.firstAmt}}</td>
        <td>{{addComma totalInfo.unpaidAmt}}</td>
        <td>{{addComma totalInfo.salesAmt}}</td>
        <td>{{addComma totalInfo.freeSalesAmt}}</td>
    </tr>--%>
    {{#each this.detailList as |data|}}
    <tr>
        <td class="dalbitSalesRange">{{the_date}}
        </td>
        <td>{{{getCommonCodeLabel slctType 'revenueProcess'}}}</td>
        <td>{{addComma payDal 'Y'}}</td>
        <td>{{addComma freeDal 'Y'}}</td>
        <td>{{addComma totalDal 'Y'}}</td>
        <td>{{addComma totalByeol 'Y'}}</td>
        <td>{{addComma firstAmt 'Y'}}</td>
        <td>{{addComma unpaidAmt 'Y'}}</td>
        <td>{{addComma salesAmt 'Y'}}</td>
        <td>{{addComma freeSalesAmt 'Y'}}</td>
    </tr>
    {{/each}}
</script>