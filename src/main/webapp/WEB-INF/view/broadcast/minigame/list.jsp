<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-8 no-padding">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#minigameMemberList" role="tab" data-toggle="tab">게임 참여내역</a></li>
                <li><a href="#minigameEditHistory" role="tab" data-toggle="tab" >정보수정내역</a></li>
            </ul>
        </div>
        <div class="col-md-4 no-padding">
            <span id="minigame_summaryArea"></span>
        </div>
        <div class="tab-content">
            <div class="tab-pane fade in active" id="minigameMemberList">
                <div class="col-lg-12 no-padding">
                    <div class="widget widget-table">
                        <div class="widget-content">
                            <table id="tb_minigameMemberlist" class="table table-sorting table-hover table-bordered datatable">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="minigameEditHistory">
                <div class="col-lg-12 no-padding">
                    <div class="widget widget-table">
                        <div class="widget-content">
                            <table id="tb_minigameEditHistory" class="table table-sorting table-hover table-bordered datatable">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
    });

    function getBroadHistory_minigame(tmp) {     // 상세보기
        var dtList_info_detail_data = function (data) {
            data.searchText = room_no;
            data.slctType = 2;
            data.startDate = '1900.01.01';
            data.endDate = '2999.12.31';

        };
        dtList_info_detail = new DalbitDataTable($("#tb_minigameMemberlist"), dtList_info_detail_data, BroadcastDataTableSource.minigameMemberList);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(minigame_summary_table);
        // dtList_info_detail.createDataTable();

        var dtList_info_detail_data = function (data) {
            data.searchText = room_no;
            data.slctType = 2;
            data.startDate = '1900.01.01';
            data.endDate = '2999.12.31';
            data.newSearchType = 8;
        };
        dtList_info_detail2 = new DalbitDataTable($("#tb_minigameEditHistory"), dtList_info_detail_data, BroadcastDataTableSource.minigameEditHistory);
        dtList_info_detail2.useCheckBox(false);
        dtList_info_detail2.useIndex(true);
        dtList_info_detail2.setPageLength(50);
        dtList_info_detail2.createDataTable();
    }

    function minigame_summary_table(json){
        var template = $("#minigame_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = json.summary;
        var html = templateScript(data);
        $("#minigame_summaryArea").html(html);
    }

</script>

<script id="minigame_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin">
        <thead>
        <tr>
            <th>게임 진행/참여 총합</th>
            <th>차감 달 총합</th>
        </tr>
        </thead>
        <tbody>
            <td>{{totalGoCnt}} / {{totalCnt}} 회</td>
            <td>{{totalPayAmt}} 달</td>
        </tbody>
    </table>
</script>