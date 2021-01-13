<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 현재 접속자 > 현재 접속 회원 -->
<div class="widget-table mb10">
    <div class="col-md-12 no-padding">
        <div class="col-md-2 no-padding">
            <span name="currentType" id="currentType" onchange="currentType_sel_change()"></span>
        </div>
        <div class="col-md-2 no-padding pull-right mr10">
            <table class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="15%"/><col width="65%"/>
                </colgroup>
                <tr>
                    <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                </tr>
            </table>
        </div>
        <table id="tableList" class="table table-sorting table-hover table-bordered datatable">
            <thead id="tableTop_detail">
            </thead>
            <tbody id="tableBody_detail">
            </tbody>
        </table>
    </div>
    </span>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript" src="/js/code/connect/connectCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $("#currentType").html(util.getCommonCodeSelect(1, currentType,"Y"));

    $(function(){
        getCurrenList();

        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                getCurrenList();
                getTotalList();
            };
        });
        <!-- 버튼 -->
        $('#bt_search').click( function() {       //검색
            getCurrenList();
            getTotalList();
        });

    });

    // Test-ID 제외 클릭
    $('#search_testId').click( function() {
        dtList_info_detail.reload();
        getTotalList();
    });



    var dtList_info_detail;
    var slctType = 1;
    function getCurrenList(){
        console.log($('input[name="testId"]:checked').val());
        var dtList_data = function (data) {
            data.slctType = slctType;
            data.pageCnt = 10;
            data.searchText = $("#searchText").val();
            data.inner = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
        };
        dtList_info_detail = new DalbitDataTable($("#tableList"), dtList_data, connectDataTableSource.current);
        dtList_info_detail.setPageLength(10);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable();

    }

    function currentType_sel_change(){
        var value = $("select[name='currentType']").val();
        console.log("value : " + value);
        slctType = value;
        dtList_info_detail.reload();
    }

</script>