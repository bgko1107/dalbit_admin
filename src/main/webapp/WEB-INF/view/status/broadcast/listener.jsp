<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송 > 청취자 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="5.4%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/>
                <col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/>
                <col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/>
                <col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/><col width="4.3%"/>
                <col width="4.3%"/><col width="4.3%"/><col width="4.3%"/>
            </colgroup>
            <thead>
            <tr>
                <th></th>
                <th>소계</th>
                <th>수다/챗</th>
                <th>일상/소통</th>
                <th>힐링</th>
                <th>노래/연주</th>
                <th>미팅/소개팅</th>
                <th>고민/사연</th>
                <th>책/여행</th>
                <th>ASMR</th>
                <th>성우</th>
            </tr>
            </thead>
            <tbody id="listenerListBody">
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
        broadcastListener();
    });

    function broadcastListener(){
        util.getAjaxData("broadcastListener", "/rest/status/broadcast/info/listener/subject", $("#searchForm").serialize(), fn_broadcastListener_success);
    }

    function fn_broadcastListener_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#listenerListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_listenerTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#listenerListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        var template = $('#tmp_listenerDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#listenerListBody").append(html);

        if(isDataEmpty){
            $("#listenerListBody td:last").remove();
        }else{
            $("#listenerListBody").append(totalHtml);
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_listenerTotal">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_totalJoinCnt}}</td>
        <td>{{addComma sum_join03Cnt}}</td>
        <td>{{addComma sum_join00Cnt}}</td>
        <td>{{addComma sum_join01Cnt}}</td>
        <td>{{addComma sum_join02Cnt}}</td>
        <td>{{addComma sum_join04Cnt}}</td>
        <td>{{addComma sum_join05Cnt}}</td>
        <td>{{addComma sum_join06Cnt}}</td>
        <td>{{addComma sum_join09Cnt}}</td>
        <td>{{addComma sum_join13Cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_listenerDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalJoinCnt}}</td>
        <td>{{addComma join03Cnt}}</td>
        <td>{{addComma join00Cnt}}</td>
        <td>{{addComma join01Cnt}}</td>
        <td>{{addComma join02Cnt}}</td>
        <td>{{addComma join04Cnt}}</td>
        <td>{{addComma join05Cnt}}</td>
        <td>{{addComma join06Cnt}}</td>
        <td>{{addComma join09Cnt}}</td>
        <td>{{addComma join13Cnt}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>