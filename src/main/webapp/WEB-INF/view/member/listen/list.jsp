<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <span id="listen_summaryArea"></span>
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

    function getHistory_listenDetail(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(listen_summary_table);
    }

    function Listen(index){
        var data = dtList_info_detail.getDataRow(index);
        var roomNo = data.roomNo;
        console.log('종료된 청취 방송 상세정보 새창 오픈~ roomNo : ' + roomNo);
    }

    function listen_summary_table(json){
        // dalbitLog(json);
        var template = $('#listen_tableSummary').html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : member_listen_summary
            , content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#listen_summaryArea").html(html);
        ui.paintColor();
    }
</script>

<script id="listen_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" id="declarationSummary" style="width: 500px;">
        <thead>
        <tr>
            <th colspan="6" class="_bgColor" data-bgcolor="#8faadc">총 합</th>
        </tr>
        <tr>
            {{#each this.header}}
                <th class="_bgColor" data-bgcolor="#dae3f3">{{this.code}}</th>
            {{/each}}
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalforcedCnt}} 명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalGift}} 건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalDal}} 달</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalGood}} 건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalBooster}} 개</td>
            <td>{{#equal length '0'}}0{{/equal}}{{addComma content.totalCompleteMoonCnt}} 개</td>
        </tbody>
    </table>
</script>