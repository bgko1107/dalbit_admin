
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="withdrawalList">       <!-- 회원 -->
            <div class="widget-content">
                <div class="col-md-12 no-padding">
                    <div class="col-md-2 no-padding pull-right">
                        <table class="table table-sorting table-hover table-bordered no-margin">
                            <colgroup>
                                <col width="15%"/><col width="65%"/>
                            </colgroup>
                            <tr>
                                <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <table id="tb_withdrawalList" class="table table-sorting table-hover table-bordered">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>

<script>

    var tmp_sDate;
    var tmp_eDate;

    var dtList_info;

    var _testid = -1;
    var tmp_searchText;
    var tmp_joinPath = 0;

    var _memJoinDateSort_withdrawal = -1;
    var _memNickSort_withdrawal = -1;
    var _memLoginIdSort_withdrawal = -1;
    var _memIpSort_withdrawal = -1;
    var _withdrawalDateSort = -1;
    var _serviceDateSort = -1;

    function getUserInfo() {                 // 검색
        // _testid = $('input[name="search_testId"]').prop('checked') ? 1 : -1;
        _testid = -1;
        tmp_searchText = $('#searchText').val();
        tmp_memWithdrawal = 0;
        tmp_sDate = $("#startDate").val();
        tmp_eDate = $("#endDate").val();

        var dtList_info2;
        var dtList_info_data2 = function ( data ) {
            data.searchText = tmp_searchText;                        // 검색명
            data.testid = _testid;
            data.memWithdrawal = 1;
            data.memJoinDateSort_withdrawal = _memJoinDateSort_withdrawal;
            data.memNickSort_withdrawal = _memNickSort_withdrawal;
            data.memLoginIdSort_withdrawal = _memLoginIdSort_withdrawal;
            data.memIpSort_withdrawal = _memIpSort_withdrawal;
            data.memJoinPath = tmp_joinPath;
            data.sDate = tmp_sDate;
            data.eDate = tmp_eDate;
            data.withdrawalDateSort = _withdrawalDateSort;
            data.serviceDateSort = _serviceDateSort;
            data.newSearchType = $("#searchMember").val();
        };
        dtList_info2 = new DalbitDataTable($("#tb_withdrawalList"), dtList_info_data2, MemberDataTableSource.withdrawalList);
        dtList_info2.useCheckBox(false);
        dtList_info2.useIndex(true);
        dtList_info2.useInitReload(false);
        dtList_info2.setPageLength(100);
        dtList_info2.createDataTable(withdrawalListSummary);
        // dtList_info2.reload(withdrawalListSummary);

        var testid_withdrawal = '<span id="withdrawalDateSort" onchange="withdrawalSort();"></span>' +
            '<span id="serviceDateSort" onchange="withdrawalSort();"></span>' +
            '<span id="memJoinDateSort_withdrawal" onchange="withdrawalSort();"></span>' +
            '<span id="memNickSort_withdrawal" onchange="withdrawalSort();"></span>' +
            '<span id="memLoginIdSort_withdrawal" onchange="withdrawalSort();"></span>' +
            '<span id="memIpSort_withdrawal" onchange="withdrawalSort();"></span>';
        $("#withdrawalList").find(".top-left").append(testid_withdrawal);
        $("#withdrawalDateSort").html(util.getCommonCodeSelect(-1, withdrawalDateSort));
        $("#serviceDateSort").html(util.getCommonCodeSelect(-1, serviceDateSort));
        $("#testId_withdrawal").html(util.getCommonCodeRadio(-1, testId_withdrawal));
        $("#memJoinDateSort_withdrawal").html(util.getCommonCodeSelect(-1, memJoinDateSort));
        $("#memNickSort_withdrawal").html(util.getCommonCodeSelect(-1, memNickSort));
        $("#memLoginIdSort_withdrawal").html(util.getCommonCodeSelect(-1, memLoginIdSort));
        $("#memIpSort_withdrawal").html(util.getCommonCodeSelect(-1, memIpSort));

        var withdrawal_excel = '<button class="btn btn-default btn-sm print-btn pull-right" type="button" id="withdrawal_excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>';
        $("#withdrawalList").find(".footer-right").append(withdrawal_excel);


        /*=============엑셀==================*/
        $('#withdrawal_excelDownBtn').on('click', function(){
            var formElement = document.querySelector("form");
            var formData = new FormData(formElement);
            formData.append("searchText", tmp_searchText);
            formData.append("testid", _testid);
            formData.append("memWithdrawal", 1);
            formData.append("sDate", tmp_sDate);
            formData.append("eDate", tmp_eDate);
            formData.append("withdrawalDateSort", $("#withdrawalDateSort").find("select[name='withdrawalDateSort']").val());
            formData.append("serviceDateSort", $("#serviceDateSort").find("select[name='serviceDateSort']").val());
            formData.append("memJoinDateSort", $("#memJoinDateSort_withdrawal").find("select[name='memJoinDateSort']").val());
            formData.append("memNickSort", $("#memNickSort_withdrawal").find("select[name='memNickSort']").val());
            formData.append("memLoginIdSort", $("#memLoginIdSort_withdrawal").find("select[name='memLoginIdSort']").val());
            formData.append("memIpSort", $("#memIpSort_withdrawal").find("select[name='memIpSort']").val());
            formData.append("memJoinPath", tmp_joinPath);

            util.excelDownload($(this), "/rest/member/join/withdrawalListExcel", formData);
        });

        /*==================================*/
    }

    // 가입 --------------------
    function withdrawalSort(){
        _withdrawalDateSort = $("#withdrawalDateSort").find("select[name='withdrawalDateSort']").val();
        _serviceDateSort = $("#serviceDateSort").find("select[name='serviceDateSort']").val();
        _memJoinDateSort_withdrawal = $("#memJoinDateSort_withdrawal").find("select[name='memJoinDateSort']").val();
        _memNickSort_withdrawal = $("#memNickSort_withdrawal").find("select[name='memNickSort']").val();
        _memLoginIdSort_withdrawal = $("#memLoginIdSort_withdrawal").find("select[name='memLoginIdSort']").val();
        _memIpSort_withdrawal = $("#memIpSort_withdrawal").find("select[name='memIpSort']").val();

        getUserInfo();
    }



</script>


<!-- summary -->

