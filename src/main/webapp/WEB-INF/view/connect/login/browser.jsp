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
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="12%"/><col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
                <col width="11%"/><col width="11%"/><col width="11%"/><col width="11%"/>
            </colgroup>
            <thead id="browserTable">
            <tr style="background-color: #b4c7e7">
                <th rowspan="2"></th>
                <th colspan="4" id="th_befor">전월</th>
                <th colspan="4" id="th_after" style="background-color: #ffe699">금월</th>
            </tr>
            <tr style="background-color: #dae3f3">
                <th>소계</th>
                <th>안드로이드</th>
                <th>아이폰</th>
                <th>PC</th>

                <th style="background-color: #fff2cc">소계</th>
                <th style="background-color: #fff2cc">안드로이드</th>
                <th style="background-color: #fff2cc">아이폰</th>
                <th style="background-color: #fff2cc">PC</th>
            </tr>
            </thead>
            <tbody id="browserTableBody"></tbody>
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

    function getBrowserList(){
        var data = {};
        data.startDate = $("#startDate").val();
        data.endDate = $("#endDate").val();
        data.slctType = slctType;
        util.getAjaxData("browser", "/rest/connect/login/info/browser", data, fn_browser_success);
    }

    function fn_browser_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#browserTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_browserTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#browserTableBody").append(totalHtml);

            response.data.detailList.slctType = slctType;

        }

        for(var i=0;i<response.data.detailList.length;i++){
            if(response.data.detailList[i].androidCnt == 0){
                response.data.detailList[i].androidCnt = "null";
            }
            if(response.data.detailList[i].iosCnt == 0){
                response.data.detailList[i].iosCnt = "null";
            }
            if(response.data.detailList[i].pcCnt == 0){
                response.data.detailList[i].pcCnt = "null";
            }
            if(response.data.detailList[i].bAndroidCnt == 0){
                response.data.detailList[i].bAndroidCnt = "null";
            }
            if(response.data.detailList[i].bIosCnt == 0){
                response.data.detailList[i].bIosCnt = "null";
            }
            if(response.data.detailList[i].bPcCnt == 0){
                response.data.detailList[i].bPcCnt = "null";
            }
            if(response.data.detailList[i].totalCnt == 0){
                response.data.detailList[i].totalCnt = "null";
            }
            if(response.data.detailList[i].bTotalCnt == 0){
                response.data.detailList[i].bTotalCnt = "null";
            }
        }
        dalbitLog(response.data.detailList);
        var template = $('#tmp_browserDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#browserTableBody").append(html);

        if(isDataEmpty){
            $("#browserTableBody td:last").remove();
        }else{
            $("#browserTableBody").append(totalHtml);
        }

        $("#browserTable").find("#th_after").text("금월");
        $("#browserTable").find("#th_befor").text("전월");


        var tmp_date = new Date();
        tmp_date = moment(tmp_date).format("YYYY.MM.DD HH:mm:SS");
        var tmp_day = tmp_date.split(" ")[0];
        var tmp_time = tmp_date.split(" ")[1];

        for(var j = 0; j < response.data.detailList.length ; j ++) {
            if (Number(tmp_day.split(".")[2]) == response.data.detailList[j].day) {
                for (var i = 1; i < 9; i++) {
                    $("#browserTableBody tr:eq(" + (response.data.detailList.length - response.data.detailList[j].day + 1) + ") td:eq(" + (i) + ")").css("background-color", "#e3ecfb");
                    $("#browserTableBody tr:eq(" + (response.data.detailList.length - response.data.detailList[j].day + 1) + ") td:eq(" + (i) + ")").css("font-weight", "bold");
                }
            }
        }

        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_browserTotal">
    <tr class="font-bold" style="color: #ff5600;background-color: #f2f2f2">
        <td>총계</td>
        <td>{{addComma sum_bTotalCnt}}</td>
        <td>{{addComma sum_bAndroidCnt}}</td>
        <td>{{addComma sum_bIosCnt}}</td>
        <td>{{addComma sum_bPcCnt}}</td>

        <td>{{addComma sum_totalCnt}}</td>
        <td>{{addComma sum_androidCnt}}</td>
        <td>{{addComma sum_iosCnt}}</td>
        <td>{{addComma sum_pcCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_browserDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold" style="background-color: #dae3f3">
            {{data.day}}일
        </td>
        <td>{{addComma bTotalCnt}}</td>
        <td>{{addComma bAndroidCnt}}</td>
        <td>{{addComma bIosCnt}}</td>
        <td>{{addComma bPcCnt}}</td>

        <td>{{addComma totalCnt}}</td>
        <td>{{addComma androidCnt}}</td>
        <td>{{addComma iosCnt}}</td>
        <td>{{addComma pcCnt}}</td>
    </tr>
    {{else}}

    <td colspan="10" class="noData">{{isEmptyData}}<td>

    {{/each}}
</script>