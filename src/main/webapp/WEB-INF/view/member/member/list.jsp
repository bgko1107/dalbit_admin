
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String in_tabType = request.getParameter("tabtype");
%>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <%--<span id="searchRadio"></span>--%>
                            <span id="searchMemberArea"></span>
                            <label><input type="text" class="form-control" id="txt_search"></label>
                            <button type="submit" class="btn btn-success" id="bt_search">검색</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- //serachBox -->
        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline">
            <ul class="nav nav-tabs nav-tabs-custom-colored mt5">
                <li><a href="#memberList" role="tab" data-toggle="tab" id="tab_memberList" onclick="memberList();">회원</a></li>
                <li><a href="#withdrawalList" role="tab" data-toggle="tab" id="tab_withdrawalList" onclick="withdrawalList();">탈퇴회원</a></li>
                <li><a href="javascript: window.location.href = window.location.origin + '/customer/restrictions/list?tabtype=1';">경고/정지회원</a></li>
                <li><a href="javascript: window.location.href = window.location.origin + '/customer/restrictions/list?tabtype=2';">방송 강제퇴장 회원</a></li>
            </ul>
        </div>
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table" id="div_memberList">
                <div class="widget-header">
                    <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                </div>
                <div class="tab-content no-padding">
                    <div class="tab-pane fade in active " id="memberList">       <!-- 회원 -->
                        <div class="widget-content">
                            <table id="tb_memberList" class="table table-sorting table-hover table-bordered">
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="withdrawalList">       <!-- 회원 -->
                        <div class="widget-content">
                            <table id="tb_withdrawalList" class="table table-sorting table-hover table-bordered">
                                <thead></thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- DATA TABLE END -->
        <!-- TAB -->
        <div class="no-padding">
            <jsp:include page="memberTab.jsp"></jsp:include>
        </div>
        <!-- TAB END -->
    </div>
</div>

<script>
    var tabType = common.isEmpty(<%=in_tabType%>) ? 1 : <%=in_tabType%>;
    var dtList_info;
    var dtList_info2;

    $(document).ready(function() {

        if(tabType == 1){
            $("#tab_memberList").click();
            ui.checkBoxInit('tb_memberList');

        }else if(tabType == 2){
            $("#tab_withdrawalList").click();
            ui.checkBoxInit('tb_withdrawalList');

        }

        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                getUserInfo();
            };
        });
        <!-- 버튼 -->
        $('#bt_search').click( function() {       //검색
            getUserInfo();
        });
        <!-- 버튼 끝 -->
    });

    // $("#searchRadio").html(util.getCommonCodeRadio(1, searchRadioMember));
    $("#searchType").html(util.getCommonCodeSelect(-1, searchType));
    $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

    // $('#searchRadio').change(function() {
    //     if($('input[name="searchRadio"]:checked').val() == "1"){
    //         $("#searchType").removeClass("hide");
    //     }else{
    //         $("#searchType").addClass("hide");
    //     }
    // });

    function renderMemberList(){

        var dtList_info_data = function ( data ) {
            data.searchType = -1;          // 검색구분
            data.searchText = $('#txt_search').val();                        // 검색명
            data.memWithdrawal = memWithdrawal;
            data.newSearchType = $("#searchMember").val();
            // data.pageCnt = 10;
        };
        dtList_info = new DalbitDataTable($("#tb_memberList"), dtList_info_data, MemberDataTableSource.userInfo);
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.useInitReload(false);
        dtList_info.createDataTable();
    }

    function renderMemberWithdrawalList(){
        var dtList_info_data2 = function ( data ) {
            data.searchType = -1;          // 검색구분
            data.searchText = $('#txt_search').val();                        // 검색명
            data.memWithdrawal = memWithdrawal;
            data.newSearchType = $("#searchMember").val();
            // data.pageCnt = 10;
        };
        dtList_info2 = new DalbitDataTable($("#tb_withdrawalList"), dtList_info_data2, MemberDataTableSource.userInfo);
        dtList_info2.useCheckBox(true);
        dtList_info2.useIndex(true);
        dtList_info2.useInitReload(false);
        dtList_info2.createDataTable();
    }




    var excel = '<button class="btn btn-default btn-sm print-btn pull-right mr10" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>';
    $("#div_memberList").append(excel);

    var tmp_searchText;
    var memNo = "unknown";
    function getUserInfo() {                 // 검색
        if ($('#txt_search').val().length < 1) {
            alert("검색대상을 입력해 주세요.");
            return;
        }
        /* 엑셀저장을 위해 조회조건 임시저장 */
        // if($('input[name="searchRadio"]:checked').val() != "1"){
        //     tmp_searchType = $('input[name="searchRadio"]:checked').val();
        // }else{
        // }
        tmp_searchText = $('#txt_search').val();

        $('#tabList_top').removeClass("show");
        if(memWithdrawal == "0"){
            dtList_info.reload();
            ui.checkBoxInit('tb_memberList');
        }else{
            dtList_info2.reload();
            ui.checkBoxInit('tb_withdrawalList');
        }
    }
    function memberList(){
        memWithdrawal = "0";
        renderMemberList();
    }
    function withdrawalList(){
        memWithdrawal = "1";
        renderMemberWithdrawalList();
    }

    $(document).on('click', '#tb_memberList .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('._openMemberPop').click();
            // $(this).parent().parent().find('.getMemberDetail').click();
        } else {
            $("#tabList_top").removeClass("show");
        }
    });

    $(document).on('click', '#tb_withdrawalList .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('._openMemberPop').click();
            // $(this).parent().parent().find('.getMemberDetail').click();
        }
    });


    function getMemNo_info(index){
        tmp_bt = "";
        $('#tabList_top').addClass("show");
        var obj = new Object();
        if(memWithdrawal == "0"){
            var data = dtList_info.getDataRow(index);
            obj.mem_no = data.mem_no;
        }else{
            var data = dtList_info2.getDataRow(index);
            obj.mem_no = data.mem_no;
        }
        obj.memWithdrawal = memWithdrawal;

        $("#li_broadGift").addClass("active");
        $("#li_chargeGift").removeClass("active");

        util.getAjaxData("info", "/rest/member/member/info", obj, info_sel_success, fn_fail);
    }

    /*=============엑셀==================*/
    $('#excelDownBtn').on('click', function(){
        console.log("------------- 1");
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("searchType", -1);
        formData.append("searchText", tmp_searchText);
        formData.append("memWithdrawal", memWithdrawal);
        util.excelDownload($(this), "/rest/member/member/listExcel", formData, fn_success_excel, fn_fail_excel)
    });

    function fn_success_excel(){
        console.log("fn_success_excel");
    }

    function fn_fail_excel(){
        console.log("fn_fail_excel");
    }
    /*==================================*/
</script>