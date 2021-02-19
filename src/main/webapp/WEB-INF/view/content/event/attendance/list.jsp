<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">

            <%@ include file="/WEB-INF/view/content/event/attendance/attendanceTab.jsp"%>
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                    <jsp:include page="../../../searchArea/daySearchFunction.jsp"/>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <span id="attendanceTypeArea"></span>
                                    <span id="searchMemberArea" onchange="btSearchClick();"></span>
                                    <jsp:include page="../../../searchArea/dateRangeSearchArea.jsp"/>
                                    <input type="hidden" name="startDate" id="startDate">
                                    <input type="hidden" name="endDate" id="endDate" />

                                    <%--<input name="startDate" id="startDate">--%>
                                    <%--<input name="endDate" id="endDate" />--%>

                                    <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //searchForm -->

            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table id="attendanceList" class="table table-sorting table-hover table-bordered">
                            <thead></thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- // DATA TABLE -->
        </div> <!-- //container-fluid -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/content/eventDataTableSource.js?${dummyData}"></script>

<script type="text/javascript">

    $(document).ready(function() {
        $('#attendanceTypeArea').html(util.getCommonCodeSelect('-1', attendance_dayType));
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
        slctType = 3;
        dateType();
    });


    $('#bt_search').click(function() {
        getList();

    });

    $('input[id="txt_search"]').keydown(function(e) {
       if(e.keyCode === 13) {
           getList();
       }
    });

    function getList() {
        var dtList_info;
        var dtList_info_data = function (data) {
            data.attendanceType = $('#attendanceTypeArea').val();   // 참여 구분
            data.txt_search = $('#txt_search').val();                   // 검색 창
            data.txt_startSel =  $("#startDate").val().replace(/\./gi,'');
            data.txt_endSel =  $("#endDate").val().replace(/\./gi,'');
            data.newSearchType = $("#searchMember").val();
        };

        dtList_info = new DalbitDataTable($('#attendanceList'), dtList_info_data, EventDataTableSource.attendance, $('#searchForm'));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable();

    }

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>