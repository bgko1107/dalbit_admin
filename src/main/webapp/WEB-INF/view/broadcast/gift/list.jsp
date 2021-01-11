<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="col-lg-12 no-padding">
            <select id="itemType" name="itemType" class="form-control searchType ml5 mt5" onchange="itemTypeChange();">
                <option value="0" selected="selected">전체</option>
                <option value="1">선물</option>
                <option value="2">부스터</option>
            </select>
            <span id="gift_summaryArea"></span>
        </div>
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

    function getBroadHistory_gift(tmp) {     // 상세보기
        console.log(type);
        if(type == 5){
            $('#itemType').val(1);
        }

        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = BroadcastDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.room_no = room_no;
            data.itemType = $("#itemType").val();
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(gift_summary_table);

    }

    function gift_summary_table(json){
        var template = $("#gift_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#gift_summaryArea").html(html);
    }

    function itemTypeChange(){
        dtList_info_detail.reload(gift_summary_table);
    }

</script>

<script id="gift_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right">
        <thead>
        <tr>
            <th>누적 받은 별 수</th>
            <th>방송 중 선물</th>
            <th>{{{sexIcon 'm'}}}</th>
            <th>{{{sexIcon 'f'}}}</th>
            <th>미지정</th>
        </tr>
        </thead>
        <tbody id="summaryDataTable">
        <td>{{#equal length '0'}}0{{/equal}}{{content.totalByeol}}개</td>
        <td>{{#equal length '0'}}0{{/equal}}{{content.giftCnt}}건</td>
        <td>{{#equal length '0'}}0{{/equal}}{{content.male}}건</td>
        <td>{{#equal length '0'}}0{{/equal}}{{content.female}}건</td>
        <td>{{#equal length '0'}}0{{/equal}}{{content.none}}건</td>
        </tbody>
    </table>
</script>