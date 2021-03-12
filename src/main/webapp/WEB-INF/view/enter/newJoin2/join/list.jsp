
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="memberList">       <!-- 회원 -->
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
                <table id="tb_memberList" class="table table-sorting table-hover table-bordered">
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

    var _memJoinDateSort = -1;
    var _memNickSort = -1;
    var _memLoginIdSort = -1;
    var _memIpSort = -1;

    function getUserInfo() {                 // 검색
        _testid = $('input[name="search_testId"]').prop('checked') ? 1 : -1;
        tmp_searchText = $('#searchText').val();
        tmp_memWithdrawal = 0;
        tmp_sDate = $("#startDate").val();
        tmp_eDate = $("#endDate").val();

        var dtList_info_data = function ( data ) {
            data.searchText = tmp_searchText;                        // 검색명
            data.testid = _testid;
            data.memWithdrawal = 0;
            data.memJoinDateSort = _memJoinDateSort;
            data.memNickSort = _memNickSort;
            data.memLoginIdSort = _memLoginIdSort;
            data.memIpSort = _memIpSort;
            data.memJoinPath = tmp_joinPath;
            data.sDate = tmp_sDate;
            data.eDate = tmp_eDate;
            data.newSearchType = $("#searchMember").val();
        };
        dtList_info = new DalbitDataTable($("#tb_memberList"), dtList_info_data, MemberDataTableSource.joinList);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.useInitReload(false);
        dtList_info.setPageLength(100);
        dtList_info.createDataTable(joinListSummary);
        // dtList_info.reload(joinListSummary);

        var testid = '<span id="memJoinDateSort" onchange="joinSort();"></span>' +
            '<span id="memNickSort" onchange="joinSort();"></span>' +
            '<span id="memLoginIdSort" onchange="joinSort();"></span>' +
            '<span id="memIpSort" onchange="joinSort();"></span>';
        $("#memberList").find(".top-left").append(testid);
        $("#memJoinDateSort").html(util.getCommonCodeSelect(-1, memJoinDateSort));
        $("#memNickSort").html(util.getCommonCodeSelect(-1, memNickSort));
        $("#memLoginIdSort").html(util.getCommonCodeSelect(-1, memLoginIdSort));
        $("#memIpSort").html(util.getCommonCodeSelect(-1, memIpSort));

        var excel = '<button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>';
        $("#memberList").find(".footer-right").append(excel);

        /*=============엑셀==================*/
        $('#excelDownBtn').on('click', function(){
            var formElement = document.querySelector("form");
            var formData = new FormData(formElement);
            formData.append("searchText", tmp_searchText);
            formData.append("testid", _testid);
            formData.append("memWithdrawal", 0);
            formData.append("sDate", tmp_sDate);
            formData.append("eDate", tmp_eDate);
            formData.append("memJoinDateSort", _memJoinDateSort);
            formData.append("memNickSort", _memNickSort);
            formData.append("memLoginIdSort", _memLoginIdSort);
            formData.append("memIpSort", _memIpSort);
            formData.append("memJoinPath", tmp_joinPath);

            util.excelDownload($(this), "/rest/member/join/listExcel", formData);
        });
    }
    function memberList(){
        $("#memberList").show();
        $("#withdrawalList").hide();
        getUserInfo();
    }

    // 가입 --------------------
    function joinSort(){
        _memJoinDateSort = $("#memJoinDateSort").find("select[name='memJoinDateSort']").val();
        _memNickSort = $("#memNickSort").find("select[name='memNickSort']").val();
        _memLoginIdSort = $("#memLoginIdSort").find("select[name='memLoginIdSort']").val();
        _memIpSort = $("#memIpSort").find("select[name='memIpSort']").val();

        getUserInfo();
    };

    /*==================================*/
</script>


<!-- summary -->

