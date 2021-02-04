<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!-- 로그인 현황 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <thead id="totalTable">
            <tr>
                <th rowspan="2" class="_stateTopTh">구분</th>
                <th rowspan="2" class="_stateTopTh">총합</th>
                <th colspan="3" class="_stateTopTh">PC/모바일WEB</th>
                <th colspan="3" class="_stateTopTh">안드로이드</th>
                <th colspan="3" class="_stateTopTh">아이폰</th>
            </tr>
            <tr>
                <th class="_stateSubTh">회원</th>
                <th class="_stateSubTh">비회원</th>
                <th class="_stateSubTh">소계</th>
                <th class="_stateSubTh">회원</th>
                <th class="_stateSubTh">비회원</th>
                <th class="_stateSubTh">소계</th>
                <th class="_stateSubTh">회원</th>
                <th class="_stateSubTh">비회원</th>
                <th class="_stateSubTh">소계</th>
            </tr>
            </thead>
            <tbody id="platformTableBody"></tbody>
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
        console.log($("#searchForm").serialize());
        util.getAjaxData("platform", "/rest/status/question/platform", $("#searchForm").serialize(), fn_platform_success);
    }

    function fn_platform_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var sum_pcCnt_total = [
            response.data.totalInfo.sum_pcCnt,
            response.data.totalInfo.sum_no_pcCnt,
        ];
        response.data.totalInfo["sum_pcCnt_total"] = common.getListSum(sum_pcCnt_total);
        var sum_androidCnt_total = [
            response.data.totalInfo.sum_androidCnt,
            response.data.totalInfo.sum_no_androidCnt,
        ];
        response.data.totalInfo["sum_androidCnt_total"] = common.getListSum(sum_androidCnt_total);
        var sum_iosCnt_total = [
            response.data.totalInfo.sum_iosCnt,
            response.data.totalInfo.sum_no_iosCnt,
        ];
        response.data.totalInfo["sum_iosCnt_total"] = common.getListSum(sum_iosCnt_total);
        var sum_totalCnt = [
            response.data.totalInfo.sum_pcCnt_total,
            response.data.totalInfo.sum_androidCnt_total,
            response.data.totalInfo.sum_iosCnt_total,
        ];
        response.data.totalInfo["sum_totalCnt"] = common.getListSum(sum_totalCnt);

        for(var i=0;i<response.data.detailList.length;i++){
            var pcCnt_total = [
                response.data.detailList[i].pcCnt,
                response.data.detailList[i].no_pcCnt,
            ];
            response.data.detailList[i]["pcCnt_total"] = common.getListSum(pcCnt_total);
            var androidCnt_total = [
                response.data.detailList[i].androidCnt,
                response.data.detailList[i].no_androidCnt,
            ];
            response.data.detailList[i]["androidCnt_total"] = common.getListSum(androidCnt_total);
            var iosCnt_total = [
                response.data.detailList[i].iosCnt,
                response.data.detailList[i].no_iosCnt,
            ];
            response.data.detailList[i]["iosCnt_total"] = common.getListSum(iosCnt_total);

            var totalCnt = [
                response.data.detailList[i].pcCnt_total,
                response.data.detailList[i].androidCnt_total,
                response.data.detailList[i].iosCnt_total,
            ];
            response.data.detailList[i]["totalCnt"] = common.getListSum(totalCnt);
        }
        $("#platformTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_platform').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data.totalInfo;
            var totalHtml = templateScript(context);
            $("#platformTableBody").append(totalHtml);
            response.data.detailList.slctType = $('input[name="slctType"]:checked').val();
        }

        var template = $('#tmp_detailList_platform').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html=templateScript(context);
        $("#platformTableBody").append(html);

        if(isDataEmpty){
            $("#platformTableBody td:last").remove();
        }else{
            $("#platformTableBody").append(totalHtml);
        }
        ui.tableHeightSet();
        ui.paintColor();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_platform">
    <tr class="font-bold _stateSumTd">
        <td>총계</td>
        <td>{{addComma sum_totalCnt}}</td>
        <td>{{addComma sum_pcCnt}}</td>
        <td>{{addComma sum_no_pcCnt}}</td>
        <td class="_fontColor" data-fontcolor="#ff5600">{{addComma sum_pcCnt_total}}</td>
        <td>{{addComma sum_androidCnt}}</td>
        <td>{{addComma sum_no_androidCnt}}</td>
        <td class="_fontColor" data-fontcolor="#ff5600">{{addComma sum_androidCnt_total}}</td>
        <td>{{addComma sum_iosCnt}}</td>
        <td>{{addComma sum_no_iosCnt}}</td>
        <td class="_fontColor" data-fontcolor="#ff5600">{{addComma sum_iosCnt_total}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_detailList_platform">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCnt}}</td>
        <td>{{addComma pcCnt 'Y'}}</td>
        <td>{{addComma no_pcCnt 'Y'}}</td>
        <td>{{addComma pcCnt_total 'Y'}}</td>
        <td>{{addComma androidCnt 'Y'}}</td>
        <td>{{addComma no_androidCnt 'Y'}}</td>
        <td>{{addComma androidCnt_total 'Y'}}</td>
        <td>{{addComma iosCnt 'Y'}}</td>
        <td>{{addComma no_iosCnt 'Y'}}</td>
        <td>{{addComma iosCnt_total 'Y'}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
    <td colspan="11" class="noData">{{isEmptyData}}<td>
        <%--</tr>--%>
        {{/each}}
</script>