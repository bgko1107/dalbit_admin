<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제/환불 > 결제내역 -->
<div class="widget-table mb10">
    <div class="widget-content mt10">
        <table class="table table-bordered" id="list">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script src="/js/dataTablesSource/menu/recommDataTableSource.js?${dummyData}"></script>

<script>

    $(document).ready( function (){
        list();
    });

    var dtList_info;
    function list() {
        var dtList_info_data = function(data) {
            data.mem_no = '${param.memNo}';
        };

        dtList_info = new DalbitDataTable($("#list"), dtList_info_data, recommDataTableSource.recommFanList);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable();
    }


</script>


