<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <span id="ggamggameDate"></span>
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
        dtList_info_detail.createDataTable();
    }

</script>
