<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="10%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2"></th>
                <th colspan="2">교환</th>
                <th colspan="2">선물</th>
                <%--<th colspan="2">구독</th>--%>
                <th colspan="2">방송 선물</th>
                <th colspan="2">클립 선물</th>
                <th colspan="2">우체통 선물</th>
            </tr>

            <tr>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
                <%--<th>건수</th>--%>
                <%--<th>달수</th>--%>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
                <th>건수</th>
                <th>달수</th>
            </tr>
            </thead>
            <tbody id="tableBody"></tbody>
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
        getTotalList();
    });

    function getTotalList(){
        util.getAjaxData("memberList", "/rest/status/item/total/list", $("#searchForm").serialize(), fn_totalJoin_success);
    }

    function fn_totalJoin_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#tableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableBody").append(totalHtml);

            response.data.detailList.slctType = $('input[name="slctType"]:checked').val()
        }

        var template = $('#tmp_detailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableBody").append(html);

        if(isDataEmpty){
            $("#tableBody td:last").remove();
        }else{
            $("#tableBody").append(totalHtml);
        }
    }
</script>
<script type="text/x-handlebars-template" id="tmp_total">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_changeCnt}}</td>
        <td>{{addComma sum_changeAmt}}</td>
        <td>{{addComma sum_dalgiftCnt}}</td>
        <td>{{addComma sum_dalgiftAmt}}</td>
        <%--<td>{{addComma sum_subsCnt}}</td>--%>
        <%--<td>{{addComma sum_subsAmt}}</td>--%>
        <td>{{addComma sum_broadgiftCnt}}</td>
        <td>{{addComma sum_broadgiftAmt}}</td>
        <td>{{addComma sum_castgiftCnt}}</td>
        <td>{{addComma sum_castgiftAmt}}</td>
        <td>{{addComma sum_mailboxCnt}}</td>
        <td>{{addComma sum_mailboxAmt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_detailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <%--<td>{{^equal changeCnt '0'}} {{addComma changeCnt}} {{/equal}}</td>--%>
        <td>{{addComma changeCnt}}</td>
        <td>{{addComma changeAmt}}</td>
        <td>{{addComma dalgiftCnt}}</td>
        <td>{{addComma dalgiftAmt}}</td>
        <%--<td>{{addComma subsCnt}}</td>--%>
        <%--<td>{{addComma subsAmt}}</td>--%>
        <td>{{addComma broadgiftCnt}}</td>
        <td>{{addComma broadgiftAmt}}</td>
        <td>{{addComma castgiftCnt}}</td>
        <td>{{addComma castgiftAmt}}</td>
        <td>{{addComma mailboxCnt}}</td>
        <td>{{addComma mailboxAmt}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    <%--</tr>--%>
    {{/each}}
</script>