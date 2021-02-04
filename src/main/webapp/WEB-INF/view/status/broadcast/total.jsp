<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-header">
    </div>
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
                <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
            </colgroup>
            <thead>
            <tr>
                <th></th>
                <th>방송개설 건</th>
                <th>방송시간(분)</th>
                <th>DJ</th>
                <th>청취자</th>
                <%--<th>게스트</th>--%>
                <th>선물 건수</th>
                <th>선물 달수</th>
            </tr>
            </thead>
            <tbody  id="totalListBody">
            </tbody>
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
        util.getAjaxData("memberList", "/rest/status/broadcast/info/total", $("#searchForm").serialize(), fn_totalJoin_success);
    }


    function fn_totalJoin_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#totalListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#totalListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        var template = $('#tmp_detailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#totalListBody").append(html);

        if(isDataEmpty){
            $("#totalListBody td:last").remove();
        }else{
            $("#totalListBody").append(totalHtml);
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_total">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_createCnt}}</td>
        <td>{{timeStampMinutes sum_broadcastingTime}}</td>
        <td>{{addComma sum_djCnt}}</td>
        <td>{{addComma sum_listenerCnt}}</td>
        <%--<td>{{addComma sum_guestCnt}}</td>--%>
        <td>{{addComma sum_giftCnt}}</td>
        <td>{{addComma sum_giftAmount}}</td>
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
        <td>{{addComma createCnt}}</td>
        <td>{{timeStampMinutes broadcastingTime}}</td>
        <td>{{addComma djCnt}}</td>
        <td>{{addComma listenerCnt}}</td>
        <%--<td>{{addComma guestCnt}}</td>--%>
        <td>{{addComma giftCnt}}</td>
        <td>{{addComma giftAmount}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>