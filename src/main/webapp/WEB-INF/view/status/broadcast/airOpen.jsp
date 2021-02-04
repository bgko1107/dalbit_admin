<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송 > 방송개설 -->
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
            <tbody id="airOpenBody">
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
        getAirOpenList();
    });

    function getAirOpenList(){
        util.getAjaxData("getAirOpenList", "/rest/status/broadcast/info/subject/create", $("#searchForm").serialize(), fn_airOpenList_success);
    }

    function fn_airOpenList_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#airOpenBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_airOpen').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#airOpenBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        var template = $('#tmp_airOpenDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#airOpenBody").append(html);

        if(isDataEmpty){
            $("#airOpenBody td:last").remove();
        }else{
            $("#airOpenBody").append(totalHtml);
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_airOpen">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_totalCreateCnt}}</td>
        <td>{{addComma sum_create03Cnt}}</td>
        <td>{{addComma sum_create00Cnt}}</td>
        <td>{{addComma sum_create01Cnt}}</td>
        <td>{{addComma sum_create02Cnt}}</td>
        <td>{{addComma sum_create04Cnt}}</td>
        <td>{{addComma sum_create05Cnt}}</td>
        <td>{{addComma sum_create06Cnt}}</td>
        <td>{{addComma sum_create09Cnt}}</td>
        <td>{{addComma sum_create13Cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_airOpenDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCreateCnt}}</td>
        <td>{{addComma create03Cnt}}</td>   <!--03	수다/챗 -->
        <td>{{addComma create00Cnt}}</td>   <!--00	일상/소통 -->
        <td>{{addComma create01Cnt}}</td>   <!--01	힐링 -->
        <td>{{addComma create02Cnt}}</td>   <!--02	노래/연주 -->
        <td>{{addComma create04Cnt}}</td>   <!--04	미팅/소개팅 -->
        <td>{{addComma create05Cnt}}</td>   <!--05	고민/사연 -->
        <td>{{addComma create06Cnt}}</td>   <!--06	책/여행 -->
        <td>{{addComma create09Cnt}}</td>   <!--09	ASMR -->
        <td>{{addComma create13Cnt}}</td>   <!--13	성우 -->
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>