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
                <th colspan="3" class="_stateTopTh">회원정보</th>
                <th colspan="3" class="_stateTopTh">방송하기</th>
                <th colspan="3" class="_stateTopTh">청취하기</th>
                <th colspan="3" class="_stateTopTh">결제</th>
                <th colspan="3" class="_stateTopTh">건의하기</th>
                <th colspan="3" class="_stateTopTh">장애/버그</th>
                <th colspan="3" class="_stateTopTh">선물/아이템</th>
                <th colspan="3" class="_stateTopTh">기타</th>
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
                <th class="_stateSubTh">회원</th>
                <th class="_stateSubTh">비회원</th>
                <th class="_stateSubTh">소계</th>
                <th class="_stateSubTh">회원</th>
                <th class="_stateSubTh">비회원</th>
                <th class="_stateSubTh">소계</th>
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
            <tbody id="slctTableBody"></tbody>
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
        getSlctList();
    });

    function getSlctList(){
        util.getAjaxData("slct", "/rest/status/question/slct", $("#searchForm").serialize(), fn_slct_success);
    }

    function fn_slct_success(data, response){

        var sum_type01Cnt_total = [
            response.data.totalInfo.sum_type01Cnt,
            response.data.totalInfo.sum_no_type01Cnt,
        ];
        response.data.totalInfo["sum_type01Cnt_total"] = common.getListSum(sum_type01Cnt_total);
        var sum_type02Cnt_total = [
            response.data.totalInfo.sum_type02Cnt,
            response.data.totalInfo.sum_no_type02Cnt,
        ];
        response.data.totalInfo["sum_type02Cnt_total"] = common.getListSum(sum_type02Cnt_total);
        var sum_type03Cnt_total = [
            response.data.totalInfo.sum_type03Cnt,
            response.data.totalInfo.sum_no_type03Cnt,
        ];
        response.data.totalInfo["sum_type03Cnt_total"] = common.getListSum(sum_type03Cnt_total);
        var sum_type04Cnt_total = [
            response.data.totalInfo.sum_type04Cnt,
            response.data.totalInfo.sum_no_type04Cnt,
        ];
        response.data.totalInfo["sum_type04Cnt_total"] = common.getListSum(sum_type04Cnt_total);
        var sum_type05Cnt_total = [
            response.data.totalInfo.sum_type05Cnt,
            response.data.totalInfo.sum_no_type05Cnt,
        ];
        response.data.totalInfo["sum_type05Cnt_total"] = common.getListSum(sum_type05Cnt_total);
        var sum_type06Cnt_total = [
            response.data.totalInfo.sum_type06Cnt,
            response.data.totalInfo.sum_no_type06Cnt,
        ];
        response.data.totalInfo["sum_type06Cnt_total"] = common.getListSum(sum_type06Cnt_total);
        var sum_type07Cnt_total = [
            response.data.totalInfo.sum_type07Cnt,
            response.data.totalInfo.sum_no_type07Cnt,
        ];
        response.data.totalInfo["sum_type07Cnt_total"] = common.getListSum(sum_type07Cnt_total);
        var sum_type99Cnt_total = [
            response.data.totalInfo.sum_type99Cnt,
            response.data.totalInfo.sum_no_type99Cnt,
        ];
        response.data.totalInfo["sum_type99Cnt_total"] = common.getListSum(sum_type99Cnt_total);
        var sum_totalCnt = [
            response.data.totalInfo.sum_type01Cnt_total,
            response.data.totalInfo.sum_type02Cnt_total,
            response.data.totalInfo.sum_type03Cnt_total,
            response.data.totalInfo.sum_type04Cnt_total,
            response.data.totalInfo.sum_type05Cnt_total,
            response.data.totalInfo.sum_type06Cnt_total,
            response.data.totalInfo.sum_type07Cnt_total,
            response.data.totalInfo.sum_type99Cnt_total,
        ];
        response.data.totalInfo["sum_totalCnt"] = common.getListSum(sum_totalCnt);




        for(var i=0;i<response.data.detailList.length;i++){
            var type01Cnt_total = [
                response.data.detailList[i].type01Cnt,
                response.data.detailList[i].no_type01Cnt,
            ];
            response.data.detailList[i]["type01Cnt_total"] = common.getListSum(type01Cnt_total);
            var type02Cnt_total = [
                response.data.detailList[i].type02Cnt,
                response.data.detailList[i].no_type02Cnt,
            ];
            response.data.detailList[i]["type02Cnt_total"] = common.getListSum(type02Cnt_total);
            var type03Cnt_total = [
                response.data.detailList[i].type03Cnt,
                response.data.detailList[i].no_type03Cnt,
            ];
            response.data.detailList[i]["type03Cnt_total"] = common.getListSum(type03Cnt_total);
            var type04Cnt_total = [
                response.data.detailList[i].type04Cnt,
                response.data.detailList[i].no_type04Cnt,
            ];
            response.data.detailList[i]["type04Cnt_total"] = common.getListSum(type04Cnt_total);
            var type05Cnt_total = [
                response.data.detailList[i].type05Cnt,
                response.data.detailList[i].no_type05Cnt,
            ];
            response.data.detailList[i]["type05Cnt_total"] = common.getListSum(type05Cnt_total);
            var type06Cnt_total = [
                response.data.detailList[i].type06Cnt,
                response.data.detailList[i].no_type06Cnt,
            ];
            response.data.detailList[i]["type06Cnt_total"] = common.getListSum(type06Cnt_total);
            var type07Cnt_total = [
                response.data.detailList[i].type07Cnt,
                response.data.detailList[i].no_type07Cnt,
            ];
            response.data.detailList[i]["type07Cnt_total"] = common.getListSum(type07Cnt_total);
            var type99Cnt_total = [
                response.data.detailList[i].type99Cnt,
                response.data.detailList[i].no_type99Cnt,
            ];
            response.data.detailList[i]["type99Cnt_total"] = common.getListSum(type99Cnt_total);

            var totalCnt = [
                response.data.detailList[i].type01Cnt_total,
                response.data.detailList[i].type02Cnt_total,
                response.data.detailList[i].type03Cnt_total,
                response.data.detailList[i].type04Cnt_total,
                response.data.detailList[i].type05Cnt_total,
                response.data.detailList[i].type06Cnt_total,
                response.data.detailList[i].type07Cnt_total,
                response.data.detailList[i].type99Cnt_total,
            ];
            response.data.detailList[i]["totalCnt"] = common.getListSum(totalCnt);
        }

        var isDataEmpty = response.data.detailList == null;
        $("#slctTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_slct').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data.totalInfo;
            var totalHtml = templateScript(context);
            $("#slctTableBody").append(totalHtml);
            response.data.detailList.slctType = $('input[name="slctType"]:checked').val();
        }

        var template = $('#tmp_detailList_slct').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html=templateScript(context);
        $("#slctTableBody").append(html);

        if(isDataEmpty){
            $("#slctTableBody td:last").remove();
        }else{
            $("#slctTableBody").append(totalHtml);
        }
        ui.tableHeightSet();
        ui.paintColor();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_slct">
    <tr class="font-bold">
        <td class="_stateSumTd">총계</td>
        <td class="_stateSumTd">{{addComma sum_totalCnt}}</td>
        <td class="_stateSumTd">{{addComma sum_type01Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type01Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type01Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type02Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type02Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type02Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type03Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type03Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type03Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type04Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type04Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type04Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type05Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type05Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type05Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type06Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type06Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type06Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type07Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type07Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type07Cnt_total}}</td>
        <td class="_stateSumTd">{{addComma sum_type99Cnt}}</td>
        <td class="_stateSumTd">{{addComma sum_no_type99Cnt}}</td>
        <td class="_stateSumTd _fontColor" data-fontcolor="#ff5600">{{addComma sum_type99Cnt_total}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_detailList_slct">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold _stateSubTh">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCnt}}</td>
        <td>{{addComma type01Cnt 'Y'}}</td>
        <td>{{addComma no_type01Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type01Cnt_total 'Y'}}</td>
        <td>{{addComma type02Cnt 'Y'}}</td>
        <td>{{addComma no_type02Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type02Cnt_total 'Y'}}</td>
        <td>{{addComma type03Cnt 'Y'}}</td>
        <td>{{addComma no_type03Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type03Cnt_total 'Y'}}</td>
        <td>{{addComma type04Cnt 'Y'}}</td>
        <td>{{addComma no_type04Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type04Cnt_total 'Y'}}</td>
        <td>{{addComma type05Cnt 'Y'}}</td>
        <td>{{addComma no_type05Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type05Cnt_total 'Y'}}</td>
        <td>{{addComma type06Cnt 'Y'}}</td>
        <td>{{addComma no_type06Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type06Cnt_total 'Y'}}</td>
        <td>{{addComma type07Cnt 'Y'}}</td>
        <td>{{addComma no_type07Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type07Cnt_total 'Y'}}</td>
        <td>{{addComma type99Cnt 'Y'}}</td>
        <td>{{addComma no_type99Cnt 'Y'}}</td>
        <td class="font-bold">{{addComma type99Cnt_total 'Y'}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    <%--</tr>--%>
    {{/each}}
</script>