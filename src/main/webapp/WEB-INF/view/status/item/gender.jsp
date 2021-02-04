<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="11%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2"></th>
                <th colspan="2">소개</th>
                <th colspan="2" class="_sex_male"></th>
                <th colspan="2" class="_sex_female"></th>
                <th colspan="2">알수없음</th>
            </tr>
            <tr>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
            </tr>
            </thead>
            <tbody id="genderTableBody"></tbody>
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
        getGenderList();
    });

    function getGenderList(){
        util.getAjaxData("memberList", "/rest/status/item/gender/list", $("#searchForm").serialize(), fn_genderJoin_success);
    }

    function fn_genderJoin_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#genderTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_genderTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#genderTableBody").append(totalHtml);

            response.data.detailList.slctType = $('input[name="slctType"]:checked').val()
        }

        var template = $('#tmp_genderDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#genderTableBody").append(html);

        if(isDataEmpty){
            $("#genderTableBody td:last").remove();
        }else{
            $("#genderTableBody").append(totalHtml);
        }
    }
</script>
<script type="text/x-handlebars-template" id="tmp_genderTotal">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_totalCnt}}</td>
        <td>{{addComma sum_totalAmt}}</td>
        <td style="color: blue">{{addComma sum_maleCnt}}</td>
        <td style="color: blue">{{addComma sum_maleAmt}}</td>
        <td style="color: red">{{addComma sum_femaleCnt}}</td>
        <td style="color: red">{{addComma sum_femaleAmt}}</td>
        <td>{{addComma sum_noneCnt}}</td>
        <td>{{addComma sum_noneAmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_genderDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCnt}}</td>
        <td>{{addComma totalAmt}}</td>
        <td style="color: blue">{{addComma maleCnt}}</td>
        <td style="color: blue">{{addComma maleAmt}}</td>
        <td style="color: red">{{addComma femaleCnt}}</td>
        <td style="color: red">{{addComma femaleAmt}}</td>
        <td>{{addComma noneCnt}}</td>
        <td>{{addComma noneAmt}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
    <td colspan="11" class="noData">{{isEmptyData}}<td>
        <%--</tr>--%>
        {{/each}}
</script>