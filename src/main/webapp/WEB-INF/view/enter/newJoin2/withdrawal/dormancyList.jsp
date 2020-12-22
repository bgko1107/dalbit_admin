
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="dormancyList">       <!-- 회원 -->
            <div class="widget-content">
                <span class="col-md-1 no-padding" id="dormancyTypeArea"></span>
                <table id="tb_dormancyList" class="table table-sorting table-hover table-bordered">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>

    var dtList_info2;
    function getDormancy() {                 // 검색
        $("#dormancyTypeArea").html(util.getCommonCodeSelect(-1, dormancyType));
        var dtList_info_data2 = function ( data ) {
            data.searchText = $('#searchText').val();
            // data.testid = $('input[name="search_testId"]').prop('checked') ? 1 : -1;
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            data.slctType = $("#dormancyType").val();
        };
        dtList_info2 = new DalbitDataTable($("#tb_dormancyList"), dtList_info_data2, MemberDataTableSource.dormancyList);
        dtList_info2.useCheckBox(false);
        dtList_info2.useIndex(true);
        dtList_info2.useInitReload(false);
        dtList_info2.setPageLength(100);
        dtList_info2.createDataTable(dormancyListSummary);
    }

    function returnMember(data){
        console.log(data);
        if(confirm("휴면해제 하시겠습니까?")){
            var obj = {
                mem_no: data.memno
            };
            console.log(obj);
            util.getAjaxData("month", "/rest/member/join/member/return", obj, fn_memberReturn_success);
        }
    }
    function fn_memberReturn_success(dst_id, response){
        dtList_info2.reload(dormancyListSummary);
    }

</script>

