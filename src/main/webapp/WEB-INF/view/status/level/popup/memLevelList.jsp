<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="col-lg-12 form-inline no-padding">
                <label class="control-inline fancy-checkbox custom-color-green">
                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                    <span>테스트 아이디 제외</span>
                </label>
            </div>
            <!-- //serachBox -->
        </form>
        <div>
            <div class="col-md-12 no-padding" >
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script src="/js/dataTablesSource/status/levelDataTableSource.js?${dummyData}"></script>

<script type="text/javascript">

    init();

    function init(){
        getMemLevelList();
    };

    $("input[name='search_testId']").change(function () {
        dtList_info.reload();
    });

    var dtList_info;
    var lengthCnt = 100;
    function getMemLevelList() {
        var dtList_info_data = function(data) {
            data.searchText = "";
            data.checkLevel = '${param.level}';
            data.inner = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
        };
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, levelDataTableSource.memLevelList);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(lengthCnt);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable(tableRowColor);
    }

    function tableRowColor(){
        $("#list_info th:eq(" + (1) + ")").css("background-color", "#ffe699");
        $("#list_info th:eq(" + (11) + ")").css("background-color", "#ffe699");
        for(var i=-1;i<lengthCnt;i++){
            $("#list_info tr:eq(" + i + ") td:eq(" + (2) + ")").css("background-color", "#fff7e5");
            $("#list_info tr:eq(" + i + ") td:eq(" + (12) + ")").css("background-color", "#fff7e5");
        }

        window.resizeTo(window.outerWidth, $("#list_info").height()+200);
    }
</script>
