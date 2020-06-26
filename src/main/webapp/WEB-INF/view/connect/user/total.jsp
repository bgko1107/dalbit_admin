<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 현황 > 총계 -->
<table class="table table-bordered _tableHeight" data-height="23px">
    <colgroup>
        <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
    </colgroup>
    <thead id="userTotalTable">
    <tr>
        <th rowspan="2">시간대</th>
        <th colspan="4">실시간</th>
    </tr>
    <tr>
        <th>소계</th>
        <th class="_sex_male">{{{sexIcon 'm'}}}</th>
        <th class="_sex_female">{{{sexIcon 'm'}}}</th>
        <th>알수없음</th>
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
        util.getAjaxData("total", "/rest/connect/user/info/total", null, fn_total_success);
    }

    function fn_total_success(data, response){
        var isDataEmpty = response.data == null;
        $("#userTotalTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_userTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data;
            var totalHtml = templateScript(totalContext);
            $("#userTotalTableBody").append(totalHtml);
        }

        var template = $('#tmp_userDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#userTotalTableBody").append(html);

        if(isDataEmpty){
            $("#userTotalTableBody td:last").remove();
        }else{
            $("#userTotalTableBody").append(totalHtml);
        }

        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_userTotal">
    <tr class="success font-bold">
        <td>총계</td>
        <td>{{addComma total_cnt}}</td>
        <td style="color: blue">{{addComma total_male_cnt}}</td>
        <td style="color: red">{{addComma total_female_cnt}}</td>
        <td>{{addComma total_none_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_userDetailList">
    <tr>
        <td class="font-bold">10대</td>
        <td>{{addComma age10_total_cnt}}</td>
        <td style="color: blue">{{addComma age10_male_cnt}}</td>
        <td style="color: red">{{addComma age10_female_cnt}}</td>
        <td>{{addComma age10_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">20~24세</td>
        <td>{{addComma age2024_total_cnt}}</td>
        <td style="color: blue">{{addComma age2024_male_cnt}}</td>
        <td style="color: red">{{addComma age2024_female_cnt}}</td>
        <td>{{addComma age2024_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">25~29세</td>
        <td>{{addComma age2529_total_cnt}}</td>
        <td style="color: blue">{{addComma age2529_male_cnt}}</td>
        <td style="color: red">{{addComma age2529_female_cnt}}</td>
        <td>{{addComma age2529_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">30~34세</td>
        <td>{{addComma age3034_total_cnt}}</td>
        <td style="color: blue">{{addComma age3034_male_cnt}}</td>
        <td style="color: red">{{addComma age3034_female_cnt}}</td>
        <td>{{addComma age3034_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">35~39세</td>
        <td>{{addComma age3539_total_cnt}}</td>
        <td style="color: blue">{{addComma age3539_male_cnt}}</td>
        <td style="color: red">{{addComma age3539_female_cnt}}</td>
        <td>{{addComma age3539_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">40~44세</td>
        <td>{{addComma age4044_total_cnt}}</td>
        <td style="color: blue">{{addComma age4044_male_cnt}}</td>
        <td style="color: red">{{addComma age4044_female_cnt}}</td>
        <td>{{addComma age4044_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">45~49세</td>
        <td>{{addComma age4549_total_cnt}}</td>
        <td style="color: blue">{{addComma age4549_male_cnt}}</td>
        <td style="color: red">{{addComma age4549_female_cnt}}</td>
        <td>{{addComma age4549_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">50~54세</td>
        <td>{{addComma age5054_total_cnt}}</td>
        <td style="color: blue">{{addComma age5054_male_cnt}}</td>
        <td style="color: red">{{addComma age5054_female_cnt}}</td>
        <td>{{addComma age5054_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">50~59세</td>
        <td>{{addComma age5459_total_cnt}}</td>
        <td style="color: blue">{{addComma age5459_male_cnt}}</td>
        <td style="color: red">{{addComma age5459_female_cnt}}</td>
        <td>{{addComma age5459_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">60~64세</td>
        <td>{{addComma age6064_total_cnt}}</td>
        <td style="color: blue">{{addComma age6064_male_cnt}}</td>
        <td style="color: red">{{addComma age6064_female_cnt}}</td>
        <td>{{addComma age6064_none_cnt}}</td>
    </tr>
    <tr>
        <td class="font-bold">60세 이상</td>
        <td>{{addComma age65_total_cnt}}</td>
        <td style="color: blue">{{addComma age65_male_cnt}}</td>
        <td style="color: red">{{addComma age65_female_cnt}}</td>
        <td>{{addComma age65_none_cnt}}</td>
    </tr>

</script>