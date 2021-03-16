<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <!-- serachBox -->
    <div class="col-lg-12 no-padding">
        <div class="widget widget-table searchBoxArea">
            <table>
                <tr>
                    <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                        <i class="fa fa-search"></i><br/>검색
                        <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                    </th>
                    <th id="th_bottonList">
                        <div>
                            <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                        </div>
                    </th>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <input id="monthDate" type="text" class="form-control"/>
                        <input class="hide" name="startDate" id="startDate" style="width: 100px">
                        <input class="hide" name="endDate" id="endDate" style="width: 100px">
                        <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                        <%--<input name="endDate" id="endDate" style="width: 100px">--%>

                        <button type="button" class="btn btn-success" id="bt_search">검색</button>

                        <a href="javascript://" class="_prevSearch">[이전]</a>
                        <a href="javascript://" class="_todaySearch">[오늘]</a>
                        <a href="javascript://" class="_nextSearch">[다음]</a>
                    </td>
                </tr>
            </table>
        </div>
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
        slctType = 1;
        $("#bt_search").on("click", function(){
            getHistory_newrecord();
        });
    });


    function newRecord(){
        dateType();
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
