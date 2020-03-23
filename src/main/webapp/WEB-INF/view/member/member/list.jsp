
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <h3 class="title"><i class="fa fa-search"></i> 회원 검색</h3>
                        <div>
                            <span id="searchType"></span>
                            <label><input type="text" class="form-control" id="txt_search"></label>
                            <button type="submit" class="btn btn-success" id="bt_search">검색</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                        <div class="btn-group widget-header-toolbar">
                            <a href="#" title="열기/닫기" class="btn-borderless btn-toggle-expand">
                                <i class="fa fa-chevron-up" id="_searchToggleIcon"></i>
                            </a>
                        </div>
                    </div>
                    <div class="widget-content">
                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                            <thead>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="widget-footer">
                        <span>
                            <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Print</button>
                        </span>
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
</div>
<script type="text/javascript" src="/js/code/member/memberCodeList.js"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js"></script>
<script>
    $(document).ready(function() {
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

    $("#searchType").html(util.getCommonCodeSelect(-1, searchType));

    var dtList_info_data = function ( data ) {
        data.searchType = $("select[name='searchType']").val();          // 검색구분
        data.searchText = $('#txt_search').val();                        // 검색명
        // data.pageCnt = 10;
    };
    dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, MemberDataTableSource.userInfo);
    dtList_info.useCheckBox(true);
    dtList_info.useIndex(true);
    dtList_info.createDataTable();

    var tmp_searchType;
    var tmp_searchText;
    var memNo = "unknown";
    function getUserInfo(){                 // 검색
        if( $('#txt_search').val() == ""){
            alert("검색대상을 입력해 주세요.");
            return;
        }
        dtList_info.reload();

        /* 엑셀저장을 위해 조회조건 임시저장 */
        tmp_searchType = $("select[name='searchType']").val();
        tmp_searchText = $('#txt_search').val();

        /*검색결과 영역이 접혀 있을 시 열기*/
        ui.toggleSearchList()
        $('#tabList').removeClass("show");
    }

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('.getMemberDetail').click();
        }
    });

    function getMemNo_info(index){
        $('#tabList_top').addClass("show");
        var data = dtList_info.getDataRow(index);
        util.getAjaxData("info", "/rest/member/member/info", data, info_sel_success, fn_fail);
    }

    /*=============엑셀==================*/
    $('#excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        formData.append("searchType", tmp_searchType);
        formData.append("searchText", tmp_searchText);
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