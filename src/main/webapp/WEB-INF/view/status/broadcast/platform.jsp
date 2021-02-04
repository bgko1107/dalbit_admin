<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송 > 플랫폼 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="11.2%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                <col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
            </colgroup>
            <thead>
            <tr>
                <th></th>
                <th colspan="4">방송개설</th>
                <th colspan="4">방송시간</th>
            </tr>
            <tr>
                <th></th>
                <th>소계</th>
                <th>PC웹</th>
                <th>안드로이드</th>
                <th>아이폰</th>

                <th>소계</th>
                <th>PC웹</th>
                <th>안드로이드</th>
                <th>아이폰</th>
            </tr>
            </thead>
            <tbody id="platformListBody">
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
        getPlatformList();
    });

    function getPlatformList(){
        util.getAjaxData("memberList", "/rest/status/broadcast/info/platform", $("#searchForm").serialize(), fn_platformList_success);
    }


    function fn_platformList_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#platformListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_platform').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#platformListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        var template = $('#tmp_platformDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#platformListBody").append(html);

        if(isDataEmpty){
            $("#platformListBody td:last").remove();
        }else{
            $("#platformListBody").append(totalHtml);
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_platform">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_totalCreateCnt}}</td>
        <td>{{addComma sum_pcCnt}}</td>
        <td>{{addComma sum_androidCnt}}</td>
        <td>{{addComma sum_iosCnt}}</td>
        <td>{{timeStampMinutes sum_totalBroadcastingTime}}</td>
        <td>{{timeStampMinutes sum_pcTime}}</td>
        <td>{{timeStampMinutes sum_androidTime}}</td>
        <td>{{timeStampMinutes sum_iosTime}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_platformDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCreateCnt}}</td>
        <td>{{addComma pcCnt}}</td>
        <td>{{addComma androidCnt}}</td>
        <td>{{addComma iosCnt}}</td>
        <td>{{timeStampMinutes totalBroadcastingTime}}</td>
        <td>{{timeStampMinutes pcTime}}</td>
        <td>{{timeStampMinutes androidTime}}</td>
        <td>{{timeStampMinutes iosTime}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
        <%--<td colspan="22" class="noData">{{isEmptyData}}<td>--%>
    <%--</tr>--%>
    {{/each}}
</script>