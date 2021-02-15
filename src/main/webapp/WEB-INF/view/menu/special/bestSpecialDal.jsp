<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <div class="widget-content">
        <table id="bestAbleSpecialList" class="table table-sorting table-hover table-bordered">
            <thead>
            </thead>
            <tbody id="tableBody">
            </tbody>
        </table>
    </div>
</div>
<!-- // DATA TABLE -->

<div class="mt15">
    <form id="reqDalList"></form>
</div>

<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">레이어팝업오픈버튼</button>
<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<script type="text/javascript" src="/js/dataTablesSource/menu/specialDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">


    function initbestAble() {
        bestAbleSpecialList();
    }

    function bestAbleSpecialList() {
        var dtList_info;
        var dtList_info_data = function(data) {
            data.select_year = common.substr($("#startDate").val(),0,4);
            data.select_month =  common.substr($("#startDate").val(),5,2);
            data.txt_search = $('#searchText').val();
            data.searchType = $('#searchType').val();
        };
        dtList_info = new DalbitDataTable($("#bestAbleSpecialList"), dtList_info_data, specialDataTableSource.bestAbleSpecialList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(20);
        dtList_info.createDataTable();

        ui.checkBoxInit('bestAbleSpecialList');
    }

</script>

