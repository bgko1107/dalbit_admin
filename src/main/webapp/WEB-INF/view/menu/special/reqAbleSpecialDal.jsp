<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <%--<div class="widget-header">--%>
        <%--<h3><i class="fa fa-desktop"></i> 검색결과</h3>--%>
    <%--</div>--%>
        <div class="row col-lg-12 mt15">
            <div class="pull-left ml5">
                ㆍ 스페셜 DJ 신청 가능한 회원 목록입니다.<br />
                ㆍ 신청 완료된 회원은 목록에 노출되지 않습니다.
            </div>
        </div>

        <div class="widget-content">
            <table id="reqAbleSpecialList" class="table table-sorting table-hover table-bordered">
                <thead>
                </thead>
                <tbody id="tableBody">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <span>
                <button type="button" class="btn btn-default btn-sm print-btn pull-right" id="reqAbleExcelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
            </span>
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


    function initReqAble() {
        reqAbleSpecialList();
    }

    function reqAbleSpecialList() {
        var dtList_info;
        var dtList_info_data = function(data) {
            data.select_year = common.substr($("#startDate").val(),0,4);
            data.select_month =  common.substr($("#startDate").val(),5,2);
            data.txt_search = $('#searchText').val();
            data.searchType = $('#searchType').val();
            data.newSearchType = $("#searchMember").val();
        };
        dtList_info = new DalbitDataTable($("#reqAbleSpecialList"), dtList_info_data, specialDataTableSource.reqAbleSpecialList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(20);
        dtList_info.createDataTable();

        ui.checkBoxInit('reqAbleSpecialList');
        //dtList_info.reload();
    }

    // /*=---------- 엑셀 ----------*/
    $('#reqAbleExcelDownBtn').on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        formData.append("txt_search", $("#searchText").val());
        formData.append("select_year", common.substr($("#startDate").val(),0,4));
        formData.append("select_month", common.substr($("#startDate").val(),5,2));
        formData.append("searchType", $('#searchType').val());

        util.excelDownload($(this), "/rest/menu/special/reqAbleDalListExcel", formData);
    });

</script>

