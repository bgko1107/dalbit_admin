<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 현황 > 총계 -->
<table class="table table-bordered _tableHeight no-margin" data-height="23px">
    <colgroup>
        <col width="1%"/><col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
        <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
    </colgroup>
    <thead>
    <tr>
        <th class="_noBorder" style="width: 5px; border-left: hidden"></th>
        <th style="background-color: #ebccd1; color:red;">◈ 연령대 별</th>
        <th>10대</th>
        <th>20~24세</th>
        <th>25~29세</th>
        <th>30~34세</th>
        <th>35~39세</th>
        <th>40대 이상</th>
        <th>합계</th>
    </tr>
    </thead>
    <tbody id="userTotalTableBody"></tbody>
    </tbody>
</table>
<div class="widget-footer">
<span>
    <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
</span>
</div>

<script type="text/javascript">
    $(function(){
        getTotalList();
    });

    function getTotalList(){
        var data = {};
        data.inner = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
        util.getAjaxData("total", "/rest/connect/user/info/total", data, fn_total_success);
    }

    function fn_total_success(data, response){
        $("#userTotalTableBody").empty();

        var template = $('#tmp_userDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#userTotalTableBody").append(html);

        // $("#userTotalTableBody td:last").remove();

        ui.tableHeightSet();
        ui.paintColor()
    }
</script>

<script type="text/x-handlebars-template" id="tmp_userDetailList">
    <tr>
        <th class="_noBorder" style="width: 5px; border-left: hidden"></th>
        <th>{{{sexIcon 'm'}}}</th>
        <td style="color: blue">{{addComma age10_male_cnt}}</td>
        <td style="color: blue">{{addComma age2024_male_cnt}}</td>
        <td style="color: blue">{{addComma age2529_male_cnt}}</td>
        <td style="color: blue">{{addComma age3034_male_cnt}}</td>
        <td style="color: blue">{{addComma age3539_male_cnt}}</td>
        <td style="color: blue">{{addComma ageEtc_male_cnt}}</td>
        <td style="color: blue">{{addComma total_male_cnt}}</td>
    </tr>
    <tr>
        <th class="_noBorder" style="width: 5px; border-left: hidden"></th>
        <th>{{{sexIcon 'f'}}}</th>
        <td style="color: red">{{addComma age10_female_cnt}}</td>
        <td style="color: red">{{addComma age2024_female_cnt}}</td>
        <td style="color: red">{{addComma age2529_female_cnt}}</td>
        <td style="color: red">{{addComma age3034_female_cnt}}</td>
        <td style="color: red">{{addComma age3539_female_cnt}}</td>
        <td style="color: red">{{addComma ageEtc_female_cnt}}</td>
        <td style="color: red">{{addComma total_female_cnt}}</td>
    </tr>
    <tr>
        <th class="_noBorder" style="width: 5px; border-left: hidden"></th>
        <th>알수없음</th>
        <td>{{addComma age10_none_cnt}}</td>
        <td>{{addComma age2024_none_cnt}}</td>
        <td>{{addComma age2529_none_cnt}}</td>
        <td>{{addComma age3034_none_cnt}}</td>
        <td>{{addComma age3539_none_cnt}}</td>
        <td>{{addComma ageEtc_none_cnt}}</td>
        <td>{{addComma total_none_cnt}}</td>
    </tr>
    <tr>
        <th class="_noBorder" style="width: 5px; border-left: hidden"></th>
        <th>합계</th>
        <td>{{addComma age10_total_cnt}}</td>
        <td>{{addComma age2024_total_cnt}}</td>
        <td>{{addComma age2529_total_cnt}}</td>
        <td>{{addComma age3034_total_cnt}}</td>
        <td>{{addComma age3539_total_cnt}}</td>
        <td>{{addComma ageEtc_total_cnt}}</td>
        <td>{{addComma total_cnt}}</td>
    </tr>

</script>