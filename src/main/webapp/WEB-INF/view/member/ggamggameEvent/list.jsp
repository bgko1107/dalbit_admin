<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <span class="col-lg-8 no-padding" id="ggamggameDate"></span>
    <div class="col-lg-4 no-padding">
        <span id="ggamggameTopArea"></span>
    </div>
    <div class="col-lg-12 no-padding">
        <div class="widget widget-table">
            <div class="widget-content">
                <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
    });

    function newRecord(){
        $("#ggamggameDate").html($('#searchDate').html());
        $("#searchDate").show();

        slctType = 1;
        dateType();

        $("#bt_search").on("click", function(){
            getHistory_newrecord();
        });
        getHistory_newrecord();

    }

    function getHistory_newrecord() {     // 상세보기
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            // data.pageCnt=10;
            data.startDate = $("#startDate").val();
        };
        dtList_info_detail = new DalbitDataTable($("#newrecord").find("#list_info_detail"), dtList_info_detail_data, MemberDataTableSource.recordList);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(getGgamggameTop);
    }

    function getGgamggameTop(response){

        var template = $("#tmp_ggamggameTop").html();
        var templateScript = Handlebars.compile(template);
        var data = response.summary;
        var html = templateScript(data);
        $("#ggamggameTopArea").html(html);

    }

</script>



<script id="tmp_ggamggameTop" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <thead>
        <tr>
            <th class="_bgColor" data-bgcolor="#8faadc">좋아요</th>
            <th class="_bgColor" data-bgcolor="#8faadc">누적 청취자</th>
            <th class="_bgColor" data-bgcolor="#8faadc">받은 별</th>
        </tr>
        </thead>
        <tbody>
            <td>{{addComma topGoodCnt}}</td>
            <td>{{addComma topListenerCnt}}</td>
            <td>{{addComma topByeolCnt}}</td>
        </tbody>
    </table>
</script>
