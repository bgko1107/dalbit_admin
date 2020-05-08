<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <span id="broad_summaryArea"></span>
        <div class="widget-content">
            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
    });

    function getHistory_broadDetail(tmp) {     // 상세보기
        // console.log("memNo : " + memNo);
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(broadCast_summary_table);
    }

    function broadCast_summary_table(json){
        // dalbitLog(json);
        var template = $("#broad_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : broadCast_summary
            , content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#broad_summaryArea").html(html);
    }
</script>

<script id="broad_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" id="declarationSummary">
        <thead>
        <tr>
            {{#each this.header}}
                <th>{{this.code}}</th>
            {{/each}}
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalListenerCnt}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalGiftCnt}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalByeol}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalGood}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalBooster}}건</td>
        </tbody>
    </table>
</script>
