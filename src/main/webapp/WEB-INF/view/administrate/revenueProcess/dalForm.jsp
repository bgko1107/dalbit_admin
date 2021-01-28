<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divDalForm">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>
                <col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>
                <col width="7.6%"/><col width="7.6%"/><col width="7.6%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">조회일자</th>
                <th colspan="6" class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선수금</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">별수</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">미지급비용</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">매출액</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">탈퇴</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">Ⅰ. 총달수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">Ⅱ.유료달 금액①</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">Ⅱ.유료달수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">Ⅲ.무료달 금액</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">Ⅲ.무료달수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">
                    금액<br/>
                    (①+②+③)
                </th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">유료달</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">무료달</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">별</th>
            </tr>
            </thead>
            <tbody id="dalFormTableBody"></tbody>
        </table>
    </div>
</div>
<a type='button' class="btn btn-default print-btn pull-left dalFormExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalForm', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>
<a type='button' class="btn btn-default print-btn pull-right dalFormExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalForm', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">

    function getDalFormList(pagingNo){
        $(".dalFormExcel").attr('download' , "달빛Live_수익인식Process(달양식)_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            , startDate : $("#startDate").val()
            , endDate : $("#endDate").val()
        };
        util.getAjaxData("dalForm", "/rest/enter/pay/dalForm", data, fn_dalForm_success);
    }

    function fn_dalForm_success(data, response){
        $("#dalFormTableBody").empty();

        var template = $('#tmp_dalFormDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#dalFormTableBody").append(html);
        ui.tableHeightSet();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_dalFormDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">{{the_date}}</td>
        <td>{{addComma totalDal 'Y'}}</td>
        <td>{{addComma payAmt 'Y'}}</td>
        <td>{{addComma payDal 'Y'}}</td>
        <td>{{addComma freeAmt 'Y'}}</td>
        <td>{{addComma freeDal 'Y'}}</td>
        <td>{{addComma totalAmt 'Y'}}</td>
        <td>{{addComma totalByeol 'Y'}}</td>
        <td>{{addComma unpaidAmt 'Y'}}</td>
        <td>{{addComma salesAmt 'Y'}}</td>
        <td>{{addComma withdrawalPayDal 'Y'}}</td>
        <td>{{addComma withdrawalFreeDal 'Y'}}</td>
        <td>{{addComma withdrawalByeol 'Y'}}</td>
    </tr>
    {{/each}}
</script>